Describe "Get-RelatedMetric" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:metricSamplePath = "$env:BHProjectPath\Tests\Samples\Get-RelatedMetric"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        $importXMLFunctionPath = Join-Path -Path $modulePath -ChildPath "Private\Import-XMLFile.ps1"
        . "$importXMLFunctionPath"
    }

    It "should resolve to a single metric with the correct details" {

        $path = "$metricSamplePath\GetRelatedMetricsTest.xml"
        $xmlContent = Import-XMLFile -Path $path
        $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//ObjectCondition[Field='tags' and starts-with(Value, '`"Client change management:pilot')]") | ForEach-Object { $metricsToCheck.Add($_) }

        # Select only the first metric to check.
        $metricsToCheck = $metricsToCheck | Select-Object -First 1

        $result = Get-RelatedMetric -Metrics $metricsToCheck

        $result.Name | Should -Be '"Pilot" devices'
        $result.UID | Should -Be "15d67999-c506-4790-9bcc-64e533921e51"
        $result.Status | Should -Be "enabled"
        $result.Folder | Should -Be "Nexthink Library/Client Change Management/Device level"
        $result | Should -HaveCount 1
    }

    It "should resolve multiple metrics with the correct details" {

        $path = "$metricSamplePath\GetRelatedMetricsTest.xml"
        $xmlContent = Import-XMLFile -Path $path
        $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//*[Field='tags' and starts-with(Value, '`"Client change management:with change')]") | ForEach-Object { $metricsToCheck.Add($_) }

        # Select only the first 3 metric to check.
        $metricsToCheck = $metricsToCheck | Select-Object -First 3

        $results = Get-RelatedMetric -Metrics $metricsToCheck
        $results | Should -HaveCount 3

        $results[0].Name | Should -Be 'High CPU time of "with change" devices'
        $results[0].UID | Should -Be "218bf2ed-de09-4f1f-90ec-de855e21eaaf"
        $results[0].Status | Should -Be "enabled"
        $results[0].Description | Should -BeNullOrEmpty
        $results[0].Folder | Should -Be "Nexthink Library/Client Change Management/Device level"

        $results[1].Name | Should -Be '"With change" devices'
        $results[1].UID | Should -Be "d051a1e7-4230-4685-969f-affe0a22d0c7"
        $results[1].Status | Should -Be "enabled"
        $results[1].Description | Should -BeNullOrEmpty
        $results[1].Folder | Should -Be "Nexthink Library/Client Change Management/Device level"

        $results[2].Name | Should -Be 'High memory time of "with change" devices'
        $results[2].UID | Should -Be "e6742427-02cb-4b9a-891c-958932e76a51"
        $results[2].Status | Should -Be "enabled"
        $results[2].Description | Should -BeNullOrEmpty
        $results[2].Folder | Should -Be "Nexthink Library/Client Change Management/Device level"
    }
}
