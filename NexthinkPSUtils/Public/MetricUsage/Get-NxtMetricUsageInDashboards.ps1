
function Get-NxtMetricUsageInDashboards {
    <#
.SYNOPSIS
    Checks for references to a metric within a Nexthink Dashboard Modules.

.DESCRIPTION
    Checks for references to a metric in Nexthink Dashboards.

.PARAMETER ModuleXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    Note that the MetricTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER MetricUID
    Specifies the UID of the metric to search for.
    This must be the name of the category without any tags appended to it.

.EXAMPLE
    Get-NxtMetricUsageInDashboards -ModuleXMLPath "C:\Temp\dashboard.xml" -MetricUID "af95692e-b1d9-489b-8ef3-aaed3b5dcee9"

    Look in the 'dashboard.xml' file for any references to the metric 'af95692e-b1d9-489b-8ef3-aaed3b5dcee9'.

.INPUTS
   You cannot pipe input to Get-NxtMetricUsageInDashboards.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtMetricUsageInDashboards.md

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
                    throw "The ModuleXMLPath argument must be a file. Folder paths are not allowed."
                }
                if ($_ -notmatch "\.xml$") {
                    throw "The file specified in the path argument must be either of type xml"
                }
                return $true
            })]
        $ModuleXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [ValidateScript( {
                if ( -not ($_ -as [guid]) ) {
                    throw "MetricUID must be in the format of a Guid."
                }
                return $true
            })]
        $MetricUID
    )

    [xml]$xmlContent = Import-XMLFile -Path $ModuleXMLPath -ErrorAction Stop

    if (-not ($xmlContent.Pack)) {
        throw "XML file is not a an export of a Module Pack. "
    }

    $widgetsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    $xmlContent.SelectNodes("//metrics/metric[@uid='$MetricUID']")  | ForEach-Object { $widgetsToCheck.Add($_) }

    return Get-DashboardFromMetric -Widgets $widgetsToCheck
}
