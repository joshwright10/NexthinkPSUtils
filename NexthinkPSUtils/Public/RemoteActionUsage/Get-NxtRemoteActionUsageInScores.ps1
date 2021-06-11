
function Get-NxtRemoteActionUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a Remote Action within Nexthink Scores.

.DESCRIPTION
    Checks for references to a Remote Action within Scores.
    Both the ScoreTree (Export of all Scores) and the Remote Action must be exported from the Finder and provided to this function.

    The following places are checked within the Score:
        - Scope Query
        - Computation Query
        - Input Field
        - Document Content for Remote Action Trigger

.PARAMETER ScoreTreeXMLPath
    Specifies the XML file containing an export of ScoreTree from the Nexthink Finder.
    The ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER RemoteActionXMLPath
    Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.

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
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ScoreTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $RemoteActionXMLPath
    )

    # Import data from XML
    [xml]$scoreXmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop

    if (-not ($scoreXmlContent.ScoreTree)) {
        throw "XML file is not a an export of the ScoreTree. "
    }

    # Get Remote Action info from XML
    [xml]$remoteActionXmlContent = Import-XMLFile -Path $RemoteActionXMLPath -ErrorAction Stop
    $remoteActions = Get-RemoteActionObject -XML $remoteActionXmlContent
    if ($null -eq $remoteActions) {
        Write-Error -Message "Unable to find any Remote Action in '$RemoteActionXMLPath'"
    }

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    foreach ($remoteAction in $remoteActions) {

        # Check Computation Query
        $scoreXmlContent.SelectNodes("//Computation/Query[contains(text(), 'action:$($remoteAction.Name)/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        #Check Scope Query
        $scoreXmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), 'action:$($remoteAction.Name)/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        # Check Input Field
        $scoreXmlContent.SelectNodes("//Input/Field[contains(@Name, 'action:$($remoteAction.Name)/')]") | ForEach-Object { $scoresToCheck.Add($_) }

        if ($null -ne $remoteAction.UID) {
            # Find matching values in the Document Section
            $scoreXmlContent.SelectNodes("//Document/Sections/Section/RemoteAction[@UID='$($remoteAction.UID)']") | ForEach-Object { $scoresToCheck.Add($_) }
        }
    }

    return Get-RelatedScore -Scores $scoresToCheck
}
