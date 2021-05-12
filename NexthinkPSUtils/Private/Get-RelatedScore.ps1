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

            if (($index -eq 0) -and (($tempElement.PSObject.Properties.Name) -eq "Object")) {
                $mainScore = $tempElement
                continue
            }

            # Grab the Leaf Score name
            if ($null -eq $leafScore) {
                if ($tempElement.UID -and $tempElement.Name) {
                    $leafScore = $tempElement
                }
            }
            elseif ($null -eq $compositeScore) {
                # Grab the Composite Score name
                if ($tempElement.UID -and $tempElement.Name) {
                    $compositeScore = $tempElement
                }
            }
            elseif ($null -eq $mainScore) {
                # Grab the score name
                if ($tempElement.UID -and $tempElement.Name) {
                    $mainScore = $tempElement
                }
            }
            $index++
        } until (($tempElement.PSObject.Properties.Name) -eq "Object" -or ($index -ge 250))

        if ($null -ne $mainScore) {
            $scorePath = $null
            if ($mainScore.Name -and $compositeScore.Name -and $leafScore.Name) {
                $scorePath = $mainScore.Name + "/" + $compositeScore.Name + "/" + $leafScore.Name
            }

            $result = [PSCustomObject]@{
                ScoreName          = $mainScore.Name
                ScoreUID           = $tempElement.UID
                CompositeScoreName = $compositeScore.Name
                CompositeScoreUID  = $compositeScore.UID
                LeafScoreName      = $leafScore.Name
                LeafScoreUID       = $leafScore.UID
                Status             = $mainScore.Status
                ScorePath          = $scorePath
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique ScoreUID, CompositeScoreUID, LeafScoreUID
}