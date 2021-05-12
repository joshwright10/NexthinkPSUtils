
function Get-NxtRemoteActionUsageInMetrics {
    <#
.SYNOPSIS
    Checks for references to a Remote Action within Nexthink Metrics.

.DESCRIPTION
    Checks for references to a Remote Action within Metrics.
    Both the MetricTree (export of all Metrics) and Remote Action must be exported from the Finder and provided to this function.

    The following places are checked within the Metric:
        - Compute
        - Conditions
        - Output Fields

.PARAMETER MetricTreeXMLPath
    Specifies the XML file containing an export of Metrics from the Nexthink Finder.
    The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

.PARAMETER RemoteActionXMLPath
    Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.

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
        [ValidateXMLFileExists()]
        $MetricTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $RemoteActionXMLPath
    )

    # Import data from XML
    [xml]$xmlContent = Import-XMLFile -Path $MetricTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.MetricTree)) {
        throw "XML file is not a an export of the MetricTree. "
    }

    # Get Remote Action info from XML
    [xml]$remoteActionXmlContent = Import-XMLFile -Path $RemoteActionXMLPath -ErrorAction Stop
    $remoteActions = Get-RemoteActionObject -XML $remoteActionXmlContent
    if ($null -eq $remoteActions) {
        Write-Error -Message "Unable to find any Remote Action in '$RemoteActionXMLPath'"
    }

    # Find matching values in the metric
    $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    foreach ($remoteAction in $remoteActions) {
        $uidsToCheck = @()
        $uidsToCheck += Format-RemoteActionUID -Value $remoteAction.UID
        $uidsToCheck += $remoteAction.OutputUids | ForEach-Object { Format-RemoteActionUID -Value $_ }

        foreach ($uid in $uidsToCheck) {

            # Check Compute
            $xmlContent.SelectNodes("//Compute/Activity[starts-with(@AggregateName, '$uid')]") | ForEach-Object { $metricsToCheck.Add($_) }

            # Check Object Conditions
            $xmlContent.SelectNodes("//ObjectCondition/Field[starts-with(text(), '$uid')]") | ForEach-Object { $metricsToCheck.Add($_) }

            # Check Output Fields
            $xmlContent.SelectNodes("//Fields/Field[@Type='field' and starts-with(text(), '$uid')]") | ForEach-Object { $metricsToCheck.Add($_) }

        }

    }

    return Get-RelatedMetric -Metrics $metricsToCheck
}
