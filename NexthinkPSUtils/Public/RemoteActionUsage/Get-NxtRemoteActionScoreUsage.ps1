
function Get-NxtRemoteActionUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a remote action within Nexthink Scores.

.DESCRIPTION
    Checks for references to a remote action within the computation fields and the Document Content section of the scores.
    Both the the ScoreTree (Export of all Scores) and Remote Action must be exported from the Finder and provided to this function.

    The Remote Action XML export is used, as it contains the UIDs for the output fields.

.PARAMETER ScoreTreeXMLPath
    Specifies the XML file containing an export of ScoreTree from the Nexthink Finder.
    Note that the ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER RemoteActionXMLPath
    Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.
    This must be a single Remote Action in a single XML file.

.EXAMPLE
    Get-NxtRemoteActionUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"

    Look in the 'scores.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.

.INPUTS
   You cannot pipe input to Get-NxtRemoteActionUsageInScores.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInScores.md

#>
    [CmdletBinding()]
    param (
        [string]
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
        [ValidateScript( {
                if ( -Not ($_ | Test-Path) ) {
                    throw "File or folder does not exist"
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "The RemoteActionXMLPath argument must be a file. Folder paths are not allowed."
                }
                if ($_ -notmatch "\.xml$") {
                    throw "The file specified in the path argument must be either of type xml"
                }
                return $true
            })]
        $RemoteActionXMLPath
    )

    $remoteAction = Get-RemoteActionUIDS -Path $RemoteActionXMLPath
    $remoteActionName = $remoteAction.Name
    $remoteActionUID = $remoteAction.UID

    # Import Metrics data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.ScoreTree)) {
        throw "XML file is not a an export of the ScoreTree. "
    }

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    ## Find matching values in the Score Scope Query
    $xmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), '#`"action:$remoteActionName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Input Field
    $xmlContent.SelectNodes("//Input/Field[starts-with(@Name, '#action:$remoteActionName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Document Section
    $xmlContent.SelectNodes("//Document/Sections/Section/RemoteAction[@UID='$remoteActionUID']") | ForEach-Object { $scoresToCheck.Add($_) }

    # Find matching values in the Score Computation Query
    $xmlContent.SelectNodes("//Computation/Query[contains(text(), '#`"action:$remoteActionName/')]") | ForEach-Object { $scoresToCheck.Add($_) }

    return Get-RelatedScore -Scores $scoresToCheck
}
