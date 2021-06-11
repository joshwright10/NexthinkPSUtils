function Get-RelatedScore {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $Scores
    )

    if ($null -eq $Scores) {
        return
    }

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($score in $Scores) {

        $index = 0
        $tempElement = $score
        $mainScore = $null
        $leafScore = $null
        $compositeScore = $null
        do {
            if ($index -ne 0) {
                $tempElement = $tempElement.ParentNode
            }

            # Grab the Leaf Score name
            if ($null -eq $leafScore) {
                if ($tempElement.LocalName -eq "LeafScore") {
                    $leafScore = $tempElement
                }
            }

            if ($null -eq $compositeScore) {
                # Grab the Composite Score name
                if ($tempElement.LocalName -eq "CompositeScore") {
                    $compositeScore = $tempElement
                }
            }

            if ($null -eq $mainScore) {
                # Grab the score name
                if ($tempElement.LocalName -eq "ScoreDef") {
                    $mainScore = $tempElement
                }
            }
            $index++
        } until ((($tempElement.LocalName) -eq "#document") -or ($index -ge 250))

        if ($null -ne $mainScore) {
            $scorePath = $null
            if ($mainScore.Name -and ($compositeScore.Name -or $leafScore.Name)) {
                $scorePath = (Join-Path -Path $mainScore.Name -ChildPath $compositeScore.Name) | Join-Path -ChildPath $leafScore.Name
            }

            $result = [PSCustomObject]@{
                ScoreName          = $mainScore.Name
                ScoreUID           = $mainScore.UID
                CompositeScoreName = $compositeScore.Name
                CompositeScoreUID  = $compositeScore.UID
                LeafScoreName      = $leafScore.Name
                LeafScoreUID       = $leafScore.UID
                Status             = $mainScore.Status
                ScorePath          = $scorePath
                ObjectScope        = $mainScore.Object
                InObjectView       = [bool]$mainScore.InObjectView
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique ScoreUID, CompositeScoreUID, LeafScoreUID
}