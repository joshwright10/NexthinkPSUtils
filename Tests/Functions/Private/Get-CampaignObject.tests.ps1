Describe "Get-CampaignObject" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Campaigns"

        Get-ChildItem -Path "$modulePath\Private" -File -Recurse | ForEach-Object { . $_.FullName }
        Get-ChildItem -Path "$modulePath\Classes" -File -Recurse | ForEach-Object { . $_.FullName }
    }

    It "should resolve to a single Campaign" {

        $path = "$samplePath\Single Campaign Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-CampaignObject -XML $xmlContent
        $result | Should -HaveCount 1

        $result.Name | Should -Be 'Example Campaign 1'
        $result.UID | Should -Be "d884f407-24cd-4d91-b2ca-a871aa297970"
        $result.Status | Should -Be "published"
        $result.Description | Should -Be "This is a sample campaign"
        $result.Folder | Should -BeNullOrEmpty
    }

    It "should resolve multiple Campaign" {

        $path = "$samplePath\Multi Campaign Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $results = Get-CampaignObject -XML $xmlContent
        $results | Should -HaveCount 2

        $results[0].Name | Should -Be 'Microsoft Teams removal'
        $results[0].UID | Should -Be "1b609b0e-da02-4217-b23e-54f7546514fe"
        $results[0].Status | Should -Be "retired"
        $results[0].Description | Should -BeNullOrEmpty
        $results[0].Folder | Should -Be "Demo/Microsoft Teams"

        $results[1].Name | Should -Be 'Toolbar removal'
        $results[1].UID | Should -Be "24eb902a-b59f-46be-a4bf-c7b3a01963a4"
        $results[1].Status | Should -Be "draft"
        $results[1].Description | Should -Be "Ask user to remove toolbar"
        $results[1].Folder | Should -Be "Demo/Ask Toolbar"
    }
}
