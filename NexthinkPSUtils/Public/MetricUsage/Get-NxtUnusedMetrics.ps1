
function Get-NxtUnusedMetrics {
    <#
.SYNOPSIS
    Checks for Metrics that are not used in Nexthink Dashboard Modules.

.DESCRIPTION
    Checks for Metrics that are not used in Nexthink Dashboard Modules.

.PARAMETER ModuleXMLPath
    Specifies the XML file containing an export of Nexthink Dashboard Modules.
    The file must be in the style of a Content Pack.
    See the documentation for advice on bulk exporting Dashboard Modules.

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of Metrics from the Nexthink Finder.
    The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

.PARAMETER DisabledOnly
    Specifies if only disabled metrics should be returned.

.EXAMPLE
    Get-NxtUnusedMetrics -ModuleXMLPath "C:\Temp\dashboard.xml" -MetricTreeXMLPath "C:\Temp\metrics.xml"

    Checks if any Metrics in the 'metrics.xml' are NOT used in the 'dashboard.xml' file.

.INPUTS
   You cannot pipe input to Get-NxtUnusedMetrics.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtUnusedMetrics.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ModuleXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $MetricTreeXMLPath,

        [switch]$DisabledOnly
    )

    [xml]$xmlModuleContent = Import-XMLFile -Path $ModuleXMLPath -ErrorAction Stop
    if (-not ($xmlModuleContent.Pack)) {
        throw "XML file is not a an export of a Module Pack. "
    }

    [xml]$xmlMetricContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop
    if (-not ($xmlMetricContent.MetricTree)) {
        throw "XML file is not a an export of a MetricTree. "
    }
    $allMetrics = Get-MetricObject -XML $xmlMetricContent

    $unusedMetrics = [System.Collections.Generic.List[PSObject]]::new()
    foreach ($metric in $allMetrics) {
        $references = $null
        $references = $xmlModuleContent.SelectNodes("//metrics/metric[@uid='$($metric.UID)']")
        if ([string]::IsNullOrEmpty($references)) {
            $unusedMetrics.Add($metric)
        }
    }

    if ($PSBoundParameters.ContainsKey('DisabledOnly')) {
        $unusedMetrics = $unusedMetrics | Where-Object { $_.Status -eq "enabled" }
    }

    return $unusedMetrics
}
