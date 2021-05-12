
function Get-NxtCampaignUsageInMetrics {
    <#
.SYNOPSIS
    Checks for references to a Campaign within Nexthink Metrics.

.DESCRIPTION
    Checks for references to a Campaign within Metrics.
    The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

    The following places are checked within the Metric:
        - Compute
        - Breakdowns
        - Conditions
        - Output Fields

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

.PARAMETER CampaignUID
    Specifies the UID of the Campaign to search for.

.EXAMPLE
    Get-NxtCampaignUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CampaignUID "bf573024-c7cc-4885-9ce5-2d22535467d8"

    Look in the 'metrics.xml' file for any Campaign references to the UID 'bf573024-c7cc-4885-9ce5-2d22535467d8'.

.INPUTS
   You cannot pipe input to Get-NxtCampaignUsageInMetrics.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInMetrics.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $MetricTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateCampaignUID()]
        $CampaignUID
    )

    # Import Metrics data from XML
    [xml]$metricXmlContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop

    $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $uid = Format-CampaignUID -Value $CampaignUID

    # Check Compute
    $metricXmlContent.SelectNodes("//Compute/Activity[starts-with(@AggregateName, '$($uid)')]")  | ForEach-Object { $metricsToCheck.Add($_) }

    # Check Breakdowns
    $xmlContent.SelectNodes("//Breakdowns/Breakdown[Type='field' and starts-with(text(), '$($uid)')]") | ForEach-Object { $metricsToCheck.Add($_) }

    # Check Conditions
    $metricXmlContent.SelectNodes("//ObjectConditionList/ObjectCondition/Field[starts-with(text(), '$($uid)')]")  | ForEach-Object { $metricsToCheck.Add($_) }

    # Check Fields
    $metricXmlContent.SelectNodes("//Fields/Field[@Type='field' and starts-with(text(), '$($uid)')]")  | ForEach-Object { $metricsToCheck.Add($_) }

    return Get-RelatedMetric -Metrics $metricsToCheck
}
