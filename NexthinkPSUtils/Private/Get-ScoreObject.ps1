function Get-ScoreObject {
    [CmdletBinding()]
    param (
        $XML
    )

    $scoreList = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $XML.SelectNodes("//ScoreDef[@UID]") | ForEach-Object { $scoreList.Add($_) }

    return Get-RelatedScore -Scores $scoreList
}
