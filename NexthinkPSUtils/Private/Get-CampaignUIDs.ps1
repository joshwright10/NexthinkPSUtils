function Get-CampaignUIDs {
    [CmdletBinding()]
    param (
        $XML
    )

    $scoreUids = $scoreXmlContent.SelectNodes("//ScoreDef/@UID")."#text"
    if ($null -ne $scoreUids) {
        return $scoreUids
    }
}
