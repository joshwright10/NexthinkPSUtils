Describe "Get-MetricObject" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Metrics"

        Get-ChildItem -Path "$modulePath\Private" -File -Recurse | ForEach-Object { . $_.FullName }
        Get-ChildItem -Path "$modulePath\Classes" -File -Recurse | ForEach-Object { . $_.FullName }
    }

    It "should identify 1 Metric" {

        $path = "$samplePath\Single Metric Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-MetricObject -XML $xmlContent
        $result | Should -HaveCount 1

        $result.Name | Should -Be 'Single Metric Example'
        $result.UID | Should -Be "8a9e8b7e-bd6b-4f68-9305-c1008b409f51"
        $result.Status | Should -Be "enabled"
        $result.Description | Should -Be "Example Description"
        $result.Folder | Should -BeNullOrEmpty
    }

    It "should identify 3 Metrics in a single file" {

        $path = "$samplePath\Multi Metric Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-MetricObject -XML $xmlContent
        $result | Should -HaveCount 3

        $result[0].Name | Should -Be 'Number of devices running the "old" application'
        $result[0].UID | Should -Be "94535826-94b0-4065-a808-6c989664b439"
        $result[0].Status | Should -Be "enabled"
        $result[0].Description  | Should -BeNullOrEmpty
        $result[0].Folder | Should -Be "Nexthink Library/Pester Samples/Example Sub-Folder 1"

        $result[1].Name | Should -Be '"Without change" devices'
        $result[1].UID | Should -Be "9c63efe6-94da-49be-b65b-661e4918409b"
        $result[1].Status | Should -Be "enabled"
        $result[1].Description  | Should -BeNullOrEmpty "This is a demo metric"
        $result[1].Folder | Should -Be "Nexthink Library/Pester Samples/Example Folder 1"

        $result[2].Name | Should -Be '"With change" devices'
        $result[2].UID | Should -Be "d051a1e7-4230-4685-969f-affe0a22d0c7"
        $result[2].Status | Should -Be "disabled"
        $result[2].Description  | Should -Be "This is a demo metric"
        $result[2].Folder | Should -Be "Nexthink Library/Pester Samples/Example Folder 1"
    }
}
