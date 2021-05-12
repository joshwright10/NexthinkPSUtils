Describe "Get-DashboardFromMetric" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:metricSamplePath = "$env:BHProjectPath\Tests\Samples\Get-DashboardFromMetric"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        $importXMLFunctionPath = Join-Path -Path $modulePath -ChildPath "Private\Import-XMLFile.ps1"
        . "$importXMLFunctionPath"
    }

    It "should resolve dependency for one metric" {

        $path = "$metricSamplePath\BasicModule-DexV2.xml"
        $xmlContent = Import-XMLFile -Path $path

        $metricUID = "ecdec241-3518-44e4-a5a4-889216f5b6b3"
        $widgetsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//metrics/metric[@uid='$metricUID']") | ForEach-Object { $widgetsToCheck.Add($_) }

        $result = Get-DashboardFromMetric -Widgets $widgetsToCheck

        $result | Should -HaveCount 1
        $result.ModuleName | Should -Be 'Digital Experience Score v2'
        $result.DashboardName | Should -Be "Productivity & collaboration"
        $result.ModuleUID | Should -Be "77ad6163-4f9a-45dd-8d6c-d74a3476c4d8"
        $result.DashboardUID | Should -Be "f147514a-6717-42ca-ad0b-f25ca5f0dea9"
        $result.References | Should -Be 3
    }

    It "should resolve dependency for a metric referenced across multiple dashboards" {

        $path = "$metricSamplePath\BasicModule-DexV2.xml"
        $xmlContent = Import-XMLFile -Path $path

        $metricUID = "05b6ff78-0fbf-47a7-bd62-c6d79eb486c1"
        $widgetsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//metrics/metric[@uid='$metricUID']") | ForEach-Object { $widgetsToCheck.Add($_) }

        $result = Get-DashboardFromMetric -Widgets $widgetsToCheck

        $result | Should -HaveCount 2
        $result[0].ModuleName | Should -Be 'Digital Experience Score v2'
        $result[0].DashboardName | Should -Be "Overview"
        $result[0].ModuleUID | Should -Be "77ad6163-4f9a-45dd-8d6c-d74a3476c4d8"
        $result[0].DashboardUID | Should -Be "0dfdc926-574e-4d09-8b93-c275b3083e09"
        $result[0].References | Should -Be 1

        $result[1].ModuleName | Should -Be 'Digital Experience Score v2'
        $result[1].DashboardName | Should -Be "Device"
        $result[1].ModuleUID | Should -Be "77ad6163-4f9a-45dd-8d6c-d74a3476c4d8"
        $result[1].DashboardUID | Should -Be "f0a62b06-f450-4bd9-8c4c-6e5b7d801729"
        $result[1].References | Should -Be 4
    }
}
