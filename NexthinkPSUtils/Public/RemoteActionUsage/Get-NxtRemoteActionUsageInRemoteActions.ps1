
function Get-NxtRemoteActionUsageInRemoteActions {
    <#
.SYNOPSIS
    Checks for references to a Remote Action within the Investigations of other Remote Actions.

.DESCRIPTION
    Checks for references to a Remote Action within the Investigations of other Remote Actions.
    The ActionTree (Export of all Remote Action) and the individual Remote Action must be exported from the Finder and provided to this function.

    The following places are checked within the Remote Action:
        - Investigation

.PARAMETER ActionTreeXMLPath
    Specifies the XML file containing an export of ScoreTree from the Nexthink Finder.
    The ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER RemoteActionXMLPath
    Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.

.EXAMPLE
    Get-NxtRemoteActionUsageInRemoteActions -ActionTreeXMLPath "C:\Temp\remoteactions.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"

    Look in the 'remoteaction.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.

.INPUTS
   You cannot pipe input to Get-NxtRemoteActionUsageInRemoteActions.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInRemoteActions.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ActionTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $RemoteActionXMLPath
    )

    # Import data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ActionTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.ActionTree)) {
        throw "XML file is not a an export of the ActionTree. "
    }

    # Get Remote Action info from XML
    [xml]$remoteActionXmlContent = Import-XMLFile -Path $RemoteActionXMLPath -ErrorAction Stop
    $remoteActions = Get-RemoteActionObject -XML $remoteActionXmlContent
    if ($null -eq $remoteActions) {
        Write-Error -Message "Unable to find any Remote Action in '$RemoteActionXMLPath'" -ErrorAction Stop
    }

    $remoteActionToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    foreach ($remoteAction in $remoteActions) {
        $uidsToCheck = @()
        $uidsToCheck += Format-RemoteActionUID -Value $remoteAction.UID
        $uidsToCheck += $remoteAction.OutputUids | ForEach-Object { Format-RemoteActionUID -Value $_ }

        foreach ($uid in $uidsToCheck) {
            $xmlContent.SelectNodes("//InvestigationRaw[contains(text(), '$uid')]") | ForEach-Object { $remoteActionToCheck.Add($_) }
        }
    }

    return Get-RelatedRemoteAction -RemoteActions $remoteActionToCheck
}
