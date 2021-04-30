
function Get-NxtRemoteActionUsageInMetrics {
    <#
.SYNOPSIS
    Checks for references to a remote action within Nexthink Metrics.

.DESCRIPTION
    Checks for references to a remote action within conditions and the output fields of metrics.
    Both the MetricTree (export of all Metrics) and Remote Action must be exported from the Finder and provided to this function.

    The Remote Action XML export is used, as it contains the UIDs for the output fields.

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    Note that the MetricTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER RemoteActionXMLPath
    Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.
    This must be a single Remote Action in a single XML file.

.EXAMPLE
    Get-NxtRemoteActionUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"

    Look in the 'metrics.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.
    References to the Remote Action UID and any outputs are checked.

.INPUTS
   You cannot pipe input to Get-NxtRemoteActionUsageInMetrics.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInMetrics.md

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
                    throw "The MetricXMLPath argument must be a file. Folder paths are not allowed."
                }
                if ($_ -notmatch "\.xml$") {
                    throw "The file specified in the path argument must be either of type xml"
                }
                return $true
            })]
        $MetricTreeXMLPath,

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

    # Import Metrics data from XML
    [xml]$xmlContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.MetricTree)) {
        throw "XML file is not a an export of the MetricTree. "
    }

    # Find matching values in the metric
    $remoteActionValue = Format-RemoteActionUID -Value $remoteAction.UID
    $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    $xmlContent.SelectNodes("//*/Field[starts-with(text(), '$remoteActionValue')]") | ForEach-Object { $metricsToCheck.Add($_) }

    foreach ($uid in $remoteAction.OutputUIDs) {
        $remoteActionValue = Format-RemoteActionUID -Value $uid
        $xmlContent.SelectNodes("//*/Field[starts-with(text(), '$remoteActionValue')]") | ForEach-Object { $metricsToCheck.Add($_) }
    }

    return Get-RelatedMetric -Metrics $metricsToCheck
}
