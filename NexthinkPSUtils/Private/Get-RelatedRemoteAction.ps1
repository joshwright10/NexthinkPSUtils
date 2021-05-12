function Get-RelatedRemoteAction {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $RemoteActions
    )

    if ($null -eq $RemoteActions) {
        return
    }

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($remoteAction in $RemoteActions) {

        $index = 0
        $foundRemoteAction = $null
        $outputUIDs = $null
        $recordPath = $false
        $fullPath = $null
        $tempElement = $remoteAction
        do {
            if ($index -ne 0) {
                $tempElement = $tempElement.ParentNode
            }

            if ($recordPath -eq $true) {
                $fullPath = $tempElement.Name, $fullPath -join "/"
            }

            # Grab the Remote Action and then trigger the search for the path
            if ($null -eq $foundRemoteAction) {
                if ($tempElement.PSObject.Properties["UID"] -and $tempElement.PSObject.Properties["Name"]) {
                    $foundRemoteAction = $tempElement
                    $outputUIDs = $tempElement.SelectNodes("//Outputs/Output[@UID]") | Select-Object -ExpandProperty UID
                    $recordPath = $true
                }
            }
            $index++
        } until ($tempElement.NodeType -eq [System.Xml.XmlNodeType]::Document)

        if ($foundRemoteAction) {
            # Clean up folder path
            $path = $fullPath -replace "#document/MetricTree/metrics/", ""
            $path = $path -replace "#document/", ""
            $path = $path -replace "\/$", ""

            $result = [PSCustomObject]@{
                Name                = $foundRemoteAction.Name
                UID                 = $foundRemoteAction.UID
                AutomaticScheduling = $foundRemoteAction.AutomaticScheduling
                Description         = $foundRemoteAction.Description
                OutputUids          = $outputUIDs
                Folder              = $path
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique UID
}
