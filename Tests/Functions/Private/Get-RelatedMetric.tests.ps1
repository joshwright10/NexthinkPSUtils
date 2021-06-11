Describe "Get-RelatedMetric" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Metrics"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        # Load required Private functions
        . "$modulePath\Private\Import-XMLFile.ps1"
    }

    It "should resolve to a single Metric" {

        $path = "$samplePath\Single Metric Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//Platforms/Platform[starts-with(text(), 'windows')]") | ForEach-Object { $metricsToCheck.Add($_) }

        # Select only the first metric to check.
        $metricsToCheck = $metricsToCheck | Select-Object -First 1

        $result = Get-RelatedMetric -Metrics $metricsToCheck

        $result.Name | Should -Be 'Single Metric Example'
        $result.UID | Should -Be "8a9e8b7e-bd6b-4f68-9305-c1008b409f51"
        $result.Status | Should -Be "enabled"
        $result.Description | Should -Be "Example Description"
        $result.Folder | Should -BeNullOrEmpty
        $result | Should -HaveCount 1
    }

    It "should resolve multiple Metrics" {

        $path = "$samplePath\Multi Metric Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $metricsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//Platforms/Platform[starts-with(text(), 'windows')]") | ForEach-Object { $metricsToCheck.Add($_) }

        # Select only the first 3 metric to check.
        $metricsToCheck = $metricsToCheck | Select-Object -First 3

        $results = Get-RelatedMetric -Metrics $metricsToCheck
        $results | Should -HaveCount 3

        $results[0].Name | Should -Be 'Number of devices running the "old" application'
        $results[0].UID | Should -Be "94535826-94b0-4065-a808-6c989664b439"
        $results[0].Status | Should -Be "enabled"
        $results[0].Description | Should -BeNullOrEmpty
        $results[0].Folder | Should -Be "Nexthink Library/Pester Samples/Example Sub-Folder 1"

        $results[1].Name | Should -Be '"Without change" devices'
        $results[1].UID | Should -Be "9c63efe6-94da-49be-b65b-661e4918409b"
        $results[1].Status | Should -Be "enabled"
        $results[1].Description | Should -BeNullOrEmpty
        $results[1].Folder | Should -Be "Nexthink Library/Pester Samples/Example Folder 1"

        $results[2].Name | Should -Be '"With change" devices'
        $results[2].UID | Should -Be "d051a1e7-4230-4685-969f-affe0a22d0c7"
        $results[2].Status | Should -Be "disabled"
        $results[2].Description | Should -Be 'This is a demo metric'
        $results[2].Folder | Should -Be "Nexthink Library/Pester Samples/Example Folder 1"
    }
}
