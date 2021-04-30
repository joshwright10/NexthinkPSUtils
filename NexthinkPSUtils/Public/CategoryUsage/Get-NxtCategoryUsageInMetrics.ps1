
function Get-NxtCategoryUsageInMetrics {
    <#
.SYNOPSIS
    Checks for references to a category within Nexthink Metrics.

.DESCRIPTION
    Checks for references to a category within conditions and the output fields of metrics.
    The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    Note that the MetricTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER CategoryName
    Specifies the name of the category to search for.
    This must be the name of the category without any tags appended to it.

.EXAMPLE
    Get-NxtCategoryUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CategoryName "Hardware type"

    Look in the 'metrics.xml' file for any references to the category name 'Hardware type'.

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
        [ValidateScript( {
                if ( -Not ($_ | Test-Path) ) {
                    throw "File or folder does not exist"
                }
                if (-Not ($_ | Test-Path -PathType Leaf) ) {
                    throw "The MetricTreeXMLPath argument must be a file. Folder paths are not allowed."
                }
                if ($_ -notmatch "\.xml$") {
                    throw "The file specified in the path argument must be either of type xml"
                }
                return $true
            })]
        $MetricTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        $CategoryName
    )

    [xml]$xmlContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop

    $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    # Find matching values in the metric Condition
    $xmlContent.SelectNodes("//*[Field='tags' and starts-with(Value, '`"$($CategoryName):')]") | ForEach-Object { $metricsToCheck.Add($_) }

    # Find for categories used in Fields
    $xmlContent.SelectNodes("//Field[@Type='category' and text()='$CategoryName']") | ForEach-Object { $metricsToCheck.Add($_) }

    return Get-RelatedMetric -Metrics $metricsToCheck
}
