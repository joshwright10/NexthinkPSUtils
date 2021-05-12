
function Get-NxtMetricUsageInDashboards {
    <#
.SYNOPSIS
    Checks for references to a Metric within Nexthink Dashboard Modules.

.DESCRIPTION
    Checks for references to a Metric within Nexthink Dashboard Modules.
    The Module Xml must be exported from the Portal of CLI and provided to this function.

    The following places are checked within the Module:
        - Dashboard Widgets

.PARAMETER ModuleXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    The individual Dashboard Modules can be exported from the Portal. Bulk exports must be done via the CLI.
    See the documentation for advice on bulk exporting Dashboard Modules.

.PARAMETER MetricUID
    Specifies the UID of the Metric to search for.

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
        [ValidateXMLFileExists()]
        $ModuleXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
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

    [string]$uid = ($MetricUID -as [guid]).Guid

    $widgetsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    $xmlContent.SelectNodes("//metrics/metric[@uid='$uid']")  | ForEach-Object { $widgetsToCheck.Add($_) }

    return Get-DashboardFromMetric -Widgets $widgetsToCheck
}
