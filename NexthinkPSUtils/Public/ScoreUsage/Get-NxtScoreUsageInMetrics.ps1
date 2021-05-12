
function Get-NxtScoreUsageInMetrics {
    <#
.SYNOPSIS
    Checks for references to a metric within a Nexthink Dashboard Modules.

.DESCRIPTION
    Checks for references to a Score within Metrics.
    The MetricTree (export of all Metrics) and the Scores must be exported from the Finder and provided to this function.

    The following places are checked within the Metric:
        - Compute
        - Conditions
        - Output Fields

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of Metrics from the Nexthink Finder.
    The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

.PARAMETER ScoresXMLPath
    Specifies the XML file containing an export of Scores to be looked for within the MetricTree.
    The Scores can be exported by right clicking on the required scores and exporting to file.

.EXAMPLE
    Get-NxtScoreUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -ScoresXMLPath "C:\Temp\dexv2scores.xml"

    Look in the 'metrics.xml' file for any references to the Scores contained in the 'dexv2scores.xml' file.

.INPUTS
   You cannot pipe input to Get-NxtScoreUsageInMetrics.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInMetrics.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $MetricTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ScoresXMLPath
    )

    [xml]$metricXmlContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop

    if (-not ($metricXmlContent.MetricTree)) {
        throw "XML file is not a an export of a MetricTree. "
    }

    [xml]$scoreXmlContent = Import-XMLFile -Path $ScoresXMLPath -ErrorAction Stop
    $scores = Get-ScoreObject -XML $scoreXmlContent
    if ($null -eq $scores) {
        Write-Error -Message "Unable to find any Scores in '$ScoresXMLPath'"
    }

    $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    foreach ($uid in $scores) {

        $uid = Format-ScoreUID -Value $uid

        # Check Compute
        $metricXmlContent.SelectNodes("//Compute/Activity[starts-with(@AggregateName, '$($uid)')]")  | ForEach-Object { $metricsToCheck.Add($_) }

        # Check Conditions
        $metricXmlContent.SelectNodes("//ObjectConditionList/ObjectCondition/Field[starts-with(text(), '$($uid)')]")  | ForEach-Object { $metricsToCheck.Add($_) }

        # Check Fields
        $metricXmlContent.SelectNodes("//Fields/Field[@Type='field' and starts-with(text(), '$($uid)')]")  | ForEach-Object { $metricsToCheck.Add($_) }

    }

    return Get-RelatedMetric -Metrics $metricsToCheck
}
