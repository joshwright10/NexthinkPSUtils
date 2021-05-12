function Get-CampaignObject {
    [CmdletBinding()]
    param (
        $XML
    )

    $campaignList = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $XML.SelectNodes("//Publication[@UID]") | ForEach-Object { $campaignList.Add($_) }

    return Get-RelatedCampaign -Campaigns $campaignList
}
