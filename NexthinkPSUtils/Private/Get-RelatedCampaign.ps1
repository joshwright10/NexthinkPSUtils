function Get-RelatedCampaign {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $Campaigns
    )

    if ($null -eq $Campaigns) {
        return
    }

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($campaign in $Campaigns) {

        $index = 0
        $foundCampaign = $null
        $recordPath = $false
        $fullPath = $null
        $tempElement = $campaign
        do {
            if ($index -ne 0) {
                $tempElement = $tempElement.ParentNode
            }

            if ($recordPath -eq $true) {
                $fullPath = $tempElement.Name, $fullPath -join "/"
            }

            # Grab the campaign and then trigger the search for the path
            if ($null -eq $foundCampaign) {
                if ($tempElement.PSObject.Properties["UID"] -and $tempElement.PSObject.Properties["Name"] -and $tempElement.PSObject.Properties["Status"]) {
                    $foundCampaign = $tempElement
                    $recordPath = $true
                }
            }
            $index++
        } until ($tempElement.NodeType -eq [System.Xml.XmlNodeType]::Document)


        if ($foundCampaign) {
            # Clean up folder path
            $path = $fullPath -replace "#document/PublicationTree/campaigns/", ""
            $path = $path -replace "#document/", ""
            $path = $path -replace "\/$", ""

            $result = [PSCustomObject]@{
                Name        = $foundCampaign.Name
                UID         = $foundCampaign.UID
                Status      = $foundCampaign.Status
                Description = $foundCampaign.Description
                Folder      = $path
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique UID
}