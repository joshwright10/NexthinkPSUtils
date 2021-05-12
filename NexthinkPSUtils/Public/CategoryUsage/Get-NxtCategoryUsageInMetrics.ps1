
function Get-NxtCategoryUsageInMetrics {
    <#
.SYNOPSIS
    Checks for references to a Category within Nexthink Metrics.

.DESCRIPTION
    Checks for references to a Campaign within Metrics.
    The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

    The following places are checked within the Metric:
        - Breakdowns
        - Conditions
        - Output Fields

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of Metrics from the Nexthink Finder.
    The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

.PARAMETER CategoryName
    Specifies the name of the Category to search for.
    This must be the name of the Category without any tags appended to it.
    For example "Hardware type/Laptop" would not return any results.

.EXAMPLE
    Get-NxtCategoryUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CategoryName "Hardware type"

    Look in the 'metrics.xml' file for any references to the Category name 'Hardware type'.

.INPUTS
   You cannot pipe input to Get-NxtCategoryUsageInMetrics.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInMetrics.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $MetricTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $CategoryName
    )

    [xml]$xmlContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.MetricTree)) {
        throw "XML file is not a an export of a MetricTree. "
    }

    $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    # Check Breakdowns
    $xmlContent.SelectNodes("//Breakdowns/Breakdown[Type='category' and text()='$CategoryName']") | ForEach-Object { $metricsToCheck.Add($_) }

    # Check Condition
    $xmlContent.SelectNodes("//ObjectCondition[Field='tags' and starts-with(Value, '`"$($CategoryName):')]") | ForEach-Object { $metricsToCheck.Add($_) }

    # Check Fields
    $xmlContent.SelectNodes("//Field[@Type='category' and text()='$CategoryName']") | ForEach-Object { $metricsToCheck.Add($_) }

    return Get-RelatedMetric -Metrics $metricsToCheck
}
