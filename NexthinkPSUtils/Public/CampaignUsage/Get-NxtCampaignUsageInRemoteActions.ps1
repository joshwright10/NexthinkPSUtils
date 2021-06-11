
function Get-NxtCampaignUsageInRemoteActions {
    <#
.SYNOPSIS
    Checks for references to a Campaign within Remote Actions.

.DESCRIPTION
    Checks for references to a Campaign within Remote Action.
    The ActionTree (export of all Remote Action) must be exported from the Finder and provided to this function.

    The following places are checked within the Remote Actions:
        - Investigation
        - Input Parameter Values

.PARAMETER ActionTreeXMLPath
    Specifies the XML file containing an export of Remote Action from the Nexthink Finder.
    The ActionTree can be exported by right clicking on the Remote Actions section and then exporting to file.

.PARAMETER CampaignUID
    Specifies the UID of the Campaign to search for.

.EXAMPLE
    Get-NxtCampaignUsageInRemoteActions -ActionTreeXMLPath "C:\Temp\remoteactions.xml" -CampaignUID "d884f407-24cd-4d91-b2ca-a871aa297970"

    Look in the 'remoteactions.xml' file for any references to the Campaign with UID 'd884f407-24cd-4d91-b2ca-a871aa297970'.

.INPUTS
   You cannot pipe input to Get-NxtCampaignUsageInRemoteActions.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInRemoteActions.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ActionTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateCampaignUID()]
        $CampaignUID
    )

    # Import Remote Action data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ActionTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.ActionTree)) {
        throw "XML file is not a an export of the ActionTree. "
    }

    $remoteActionToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $uid = Format-CampaignUID -Value $CampaignUID

    # Check Investigation
    $xmlContent.SelectNodes("//InvestigationRaw[contains(text(), '$uid')]") | ForEach-Object { $remoteActionToCheck.Add($_) }

    # Check Input parameters
    $xmlContent.SelectNodes("//Inputs/Input[contains(@Value,'$CampaignUID')]") | ForEach-Object { $remoteActionToCheck.Add($_) }

    return Get-RelatedRemoteAction -RemoteActions $remoteActionToCheck
}
