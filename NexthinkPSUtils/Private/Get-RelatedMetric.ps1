function Get-RelatedMetric {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $Metrics
    )

    if ($null -eq $Metrics) {
        return
    }

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($metric in $Metrics) {

        $index = 0
        $foundMetric = $null
        $recordPath = $false
        $fullPath = $null
        $tempElement = $metric
        do {
            if ($index -ne 0) {
                $tempElement = $tempElement.ParentNode
            }

            if ($recordPath -eq $true) {
                $fullPath = $tempElement.Name, $fullPath -join "/"
            }

            # Grab the metric and then trigger the search for the path
            if ($null -eq $foundMetric) {
                if ($tempElement.PSObject.Properties["UID"] -and $tempElement.PSObject.Properties["Name"]) {
                    $foundMetric = $tempElement
                    $recordPath = $true
                }
            }
            $index++
        } until ($tempElement.NodeType -eq [System.Xml.XmlNodeType]::Document)


        if ($foundMetric) {
            # Clean up folder path
            $path = $fullPath -replace "#document/MetricTree/metrics/", ""
            $path = $path -replace "#document/", ""
            $path = $path -replace "\/$", ""

            $result = [PSCustomObject]@{
                Name        = $foundMetric.Name
                UID         = $foundMetric.UID
                Status      = $foundMetric.Status
                Description = $foundMetric.Description
                Folder      = $path
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique UID
}