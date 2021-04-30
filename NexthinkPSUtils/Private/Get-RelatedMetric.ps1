function Get-RelatedMetric {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $Metrics
    )

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($metric in $Metrics) {

        $index = 0
        $metricFound = $false
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
            if ($metricFound -eq $false) {
                if ($tempElement.UID -and $tempElement.Name) {
                    $metric = $tempElement
                    $metricFound = $true
                    $recordPath = $true
                }
            }
            $index++
        } until ($tempElement.NodeType -eq [System.Xml.XmlNodeType]::Document)


        if ($metricFound) {
            # Clean up folder path
            $path = $fullPath -replace "#document/MetricTree/metrics/", ""
            $path = $path -replace "\/$", ""

            $result = [PSCustomObject]@{
                Name        = $metric.Name
                UID         = $metric.UID
                Status      = $metric.Status
                Description = $metric.Description
                Folder      = $path
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique UID
}