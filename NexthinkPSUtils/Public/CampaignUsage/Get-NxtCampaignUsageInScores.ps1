
function Get-NxtCampaignUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a Campaign within Nexthink Scores.

.DESCRIPTION
    Checks for references to a Campaign within Scores.
    The ScoreTree (export of all scores) must be exported from the Finder and provided to this function.

    The following places are checked within the Score:
        - Scope Query
        - Computation Query
        - Input Field

.PARAMETER ScoreTreeXMLPath
    Specifies the XML file containing an export of Scores from the Nexthink Finder.
    The ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER CampaignName
    Specifies the name of the Campaign to search for.
    This must be the name of the Campaign without any question names appended to it.
    For example "DEX - Employee sentiment/Satisfaction" would not return any results.

.EXAMPLE
    Get-NxtCampaignUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -CampaignName "DEX - Employee sentiment"

    Look in the 'scores.xml' file for any references to the campaign name 'DEX - Employee sentiment'.

.INPUTS
   You cannot pipe input to Get-NxtCampaignUsageInScores.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInScores.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ScoreTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $CampaignName
    )

    # Import Metrics data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    # Find matching values in the Score Computation Query
    $xmlContent.SelectNodes("//Computation/Query[contains(text(), 'campaign:$CampaignName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Scope Query
    $xmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), 'campaign:$CampaignName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Input Field
    $xmlContent.SelectNodes("//Input/Field[contains(@Name, 'campaign:$CampaignName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    return Get-RelatedScore -Scores $scoresToCheck
}
