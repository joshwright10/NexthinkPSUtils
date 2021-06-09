function Get-ScoreUIDs {
    [CmdletBinding()]
    param (
        $XML
    )

    $uidList = [System.Collections.Generic.List[System.String]]::new()
    $XML.SelectNodes("//ScoreDef/@UID")."#text" | ForEach-Object { $uidList.Add($_) }
    $XML.SelectNodes("//LeadScore/@UID")."#text" | ForEach-Object { $uidList.Add($_) }
    $XML.SelectNodes("//CompositeScore/@UID")."#text" | ForEach-Object { $uidList.Add($_) }
    $XML.SelectNodes("//ScoreDef/@UID")."#text" | ForEach-Object { $uidList.Add($_) }
    $uidList = $uidList | Where-Object { (-not ([string]::IsNullOrEmpty($_))) }
    $uidList = $uidList | Sort-Object -Unique
    if ($null -eq $uidList) {
        return
    }
    return $uidList
}
