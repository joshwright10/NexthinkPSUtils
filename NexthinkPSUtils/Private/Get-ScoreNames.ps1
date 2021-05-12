function Get-ScoreNames {
    [CmdletBinding()]
    param (
        $XML
    )

    $scores = $XML.SelectNodes("//CompositeScore/@Name")."#text"
    if ($null -eq $scores) {
        return
    }
    return $scores
}
