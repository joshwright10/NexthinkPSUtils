function Get-ScoreUIDs {
    [CmdletBinding()]
    param (
        $XML
    )

    $scoreUids = $scoreXmlContent.SelectNodes("//ScoreDef/@UID")."#text"
    if ($null -eq $scoreUids) {
        return
    }
    return $scoreUids
}
