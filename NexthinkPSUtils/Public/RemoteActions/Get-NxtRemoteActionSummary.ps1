function Get-NxtRemoteActionSummary {
    <#
.SYNOPSIS
    Get a summary about all Remote Actions in a ActionTree export.

.DESCRIPTION
    Get a summary of the Remote Actions contained in the export of an ActionTree export.

.PARAMETER ActionTreeXMLPath
    Specifies the XML file containing an export of ActionTree from the Nexthink Finder.
    The ActionTree can be exported by right clicking on the Remote Actions section and then exporting to file.

.EXAMPLE
    Get-NxtRemoteActionSummary -ActionTreeXMLPath "C:\Temp\remoteactions.xml"

    Provide a summary of the Remote Actions contained in the 'scores.xml' file.

.INPUTS
   You cannot pipe input to Get-NxtRemoteActionSummary.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionSummary.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ActionTreeXMLPath
    )

    # Import data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ActionTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.ActionTree)) {
        throw "XML file is not a an export of the ActionTree. "
    }

    $actionsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $xmlContent.SelectNodes("//Action[@UID]") | ForEach-Object { $actionsToCheck.Add($_) }

    return Get-RelatedRemoteAction -RemoteActions $actionsToCheck
}
