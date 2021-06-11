Describe "Get-DashboardFromMetric" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\DashboardModules"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        # Load required Private functions
        . "$modulePath\Private\Import-XMLFile.ps1"
    }

    It "should resolve dependency for one metric" {

        $path = "$samplePath\Single Module Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $metricUID = "b12da91a-70bb-4edf-9e05-f6fe322deed7"
        $widgetsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//metrics/metric[@uid='$metricUID']") | ForEach-Object { $widgetsToCheck.Add($_) }

        $result = Get-DashboardFromMetric -Widgets $widgetsToCheck
        $result | Should -HaveCount 1

        $result.ModuleName | Should -Be 'Example Module'
        $result.DashboardName | Should -Be "Overview"
        $result.ModuleUID | Should -Be "9c3339a3-9e6c-4d5a-ba63-7f43c13aac77"
        $result.DashboardUID | Should -Be "4f3a3b49-4074-44a8-afe3-7ea46efd5c56"
    }
}
