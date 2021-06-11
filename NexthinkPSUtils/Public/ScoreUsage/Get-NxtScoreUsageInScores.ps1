
function Get-NxtScoreUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a Score within other Nexthink Scores.

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

.PARAMETER ScoreName
    Specifies the name of the score to search for.
    This must be the name of the parent score without any of the composite score names.

.EXAMPLE
    Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoreName "DEX - Device"

    Look in the 'allscores.xml' file for any references to the score named 'DEX - Device'.

.EXAMPLE
    Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoreName "DEX - Device","DEX - Business apps"

    Look in the 'allscores.xml' file for any references to the scores named 'DEX - Device' and 'DEX - Business apps'.

.INPUTS
   You cannot pipe input to Get-NxtScoreUsageInScores.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInScores.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ScoreTreeXMLPath,

        [string[]]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $ScoreName
    )

    # Import data from XML
    [xml]$scoreTreeXmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    foreach ($score in $ScoreName) {

        # Check Computation Query
        $scoreTreeXmlContent.SelectNodes("//Computation/Query[contains(text(), 'score:$score/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        # Check Scope Query
        $scoreTreeXmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), 'score:$score/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        # Check Input Field
        $scoreTreeXmlContent.SelectNodes("//Input/Field[contains(@Name, 'score:$score/')]") | ForEach-Object { $scoresToCheck.Add($_) }
    }

    return = Get-RelatedScore -Scores $scoresToCheck
}
