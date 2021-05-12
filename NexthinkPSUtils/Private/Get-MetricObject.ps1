function Get-MetricObject {
    [CmdletBinding()]
    param (
        $XML
    )

    $metricList = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $XML.SelectNodes("//Metric[@UID]") | ForEach-Object { $metricList.Add($_) }

    return Get-RelatedMetric -Metrics $metricList
}
