
function Get-NxtCampaignUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a Campaign within Nexthink Scores.

.DESCRIPTION
    Checks for references to a Campaign within conditions and the output fields of metrics.
    The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

.PARAMETER ScoreTreeXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    Note that the MetricTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER CampaignName
    Specifies the name of the category to search for.
    This must be the name of the category without any tags appended to it.

.EXAMPLE
    Get-NxtCampaignUsageInScores -MetricTreeXMLPath "C:\Temp\scores.xml" -CampaignName "Hardware type"

    Look in the 'scores.xml' file for any references to the category name 'Hardware type'.

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
        [ValidateScript( {
                if ( -Not ($_ | Test-Path) ) {
                    throw "File or folder does not exist"
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "The ScoreTreeXMLPath argument must be a file. Folder paths are not allowed."
                }
                if ($_ -notmatch "\.xml$") {
                    throw "The file specified in the path argument must be either of type xml"
                }
                return $true
            })]
        $ScoreTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        $CampaignName
    )

    # Import Metrics data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    # Find matching values in the Score Computation Query
    $xmlContent.SelectNodes("//Computation/Query[contains(text(), '#campaign:$CampaignName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Scope Query
    $xmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), '#campaign:$CampaignName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Input Field
    $xmlContent.SelectNodes("//Input/Field[contains(@Name, '#campaign:$CampaignName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    return Get-RelatedScore -Scores $scoresToCheck
}
