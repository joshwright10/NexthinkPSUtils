
function Get-NxtScoreUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a Scores within other Nexthink Scores.

.DESCRIPTION
    Checks for references to a score within other scores.
    The ScoreTree (export of all scores) must be exported from the Finder and provided to this function.

    The following places are checked within the score:
        - Score Scope Query
        - Computation Query
        - Score Input Field

.PARAMETER ScoreTreeXMLPath
    Specifies the XML file containing an export of scores from the Nexthink Finder.
    Note that the ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER ScoresXMLPath
    Specifies the XML file containing an export of the scores to be checked for.
    This file should be an export of only the scores that are to be looked for within the ScoreTree.

.PARAMETER ScoreName
    Specifies the name of the score to search for.
    This must be the name of the parent score without any of the composite score names.

.EXAMPLE
    Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoresXMLPath "C:\Temp\dexv2scores.xml"

    Look in the 'allscores.xml' file for any references to the scores in the "dexv2scores.xml" file.

.EXAMPLE
    Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoreName "DEX - Device"

    Look in the 'allscores.xml' file for any references to the score named 'DEX - Device'.

.INPUTS
   You cannot pipe input to Get-NxtScoreUsageInScores.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInScores.md

#>
    [CmdletBinding(DefaultParameterSetName = 'ScoreFile')]
    param (
        [string]
        [Parameter(Mandatory,
            ParameterSetName = "ScoreFile"
        )]
        [Parameter(Mandatory,
            ParameterSetName = "ScoreName"
        )]
        [ValidateXMLFileExists()]
        $ScoreTreeXMLPath,

        [string]
        [Parameter(Mandatory,
            ParameterSetName = "ScoreFile"
        )]
        [ValidateXMLFileExists()]
        $ScoresXMLPath,

        [string]
        [Parameter(Mandatory,
            ParameterSetName = "ScoreName"
        )]
        [ValidateNotNullOrEmpty()]
        $ScoreName
    )

    # Import data from XML
    [xml]$scoreTreeXmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop


    if ($PSBoundParameters.ContainsKey("ScoresXMLPath")) {
        [xml]$scoreXmlContent = Import-XMLFile -Path $ScoresXMLPath -ErrorAction Stop

        # Get Score UIDs in order to exclude the scores from the results
        $scoreUids = Get-ScoreUIDs -XML $scoreXmlContent
        if ($null -eq $scoresUids) {
            Write-Error -Message "Unable to find and UIDs in '$ScoresXMLPath'"
        }

        $scores = Get-ScoreNames -XML $scoreXmlContent
        if ($null -eq $scores) {
            Write-Error -Message "Unable to find any Score Names in '$ScoresXMLPath'"
        }

    }
    else {
        $scores = $ScoreName
    }

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    foreach ($score in $scores) {

        # Check Computation Query
        $scoreTreeXmlContent.SelectNodes("//Computation/Query[contains(text(), 'score:$score/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        # Check Scope Query
        $scoreTreeXmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), 'score:$score/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        # Check Input Field
        $scoreTreeXmlContent.SelectNodes("//Input/Field[contains(@Name, 'score:$score/')]") | ForEach-Object { $scoresToCheck.Add($_) }
    }

    $relatedScores = Get-RelatedScore -Scores $scoresToCheck
    $results = $relatedScores | Where-Object { $_.ScoreUID -notin $scoreUids }
    return $results
}
