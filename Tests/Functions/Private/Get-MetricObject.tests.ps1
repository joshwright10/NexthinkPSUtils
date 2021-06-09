Describe "Get-MetricObject" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Metrics"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        # Load required Private functions
        . "$modulePath\Private\Import-XMLFile.ps1"
        . "$modulePath\Private\Get-RelatedCampaign.ps1"
    }

    It "should identify 1 Campaign" {

        $path = "$samplePath\Demo-DEX - Employee sentiment.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-CampaignObject -XML $xmlContent

        $result | Should -HaveCount 1
        $result.Name | Should -Be 'DEX - Employee sentiment'
        $result.UID | Should -Be "bf573024-c7cc-4885-9ce5-2d22535467d8"
        $result.Status | Should -Be "draft"
        $result.Description | Should -Be "DEX version: 2.0.2"
        $result.Folder | Should -BeNullOrEmpty
    }

    It "should identify 3 Campaigns in a single file" {

        $path = "$samplePath\Demo-Multi-file Campaigns.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-CampaignObject -XML $xmlContent
        $result | Should -HaveCount 3

        $result[0].Name | Should -Be 'Win10 - Users ready for replacement'
        $result[0].UID | Should -Be "34c0d3e4-9632-4ec2-87c2-7d6a444d3927"
        $result[0].Status | Should -Be "draft"
        $result[0].Description  | Should -BeNullOrEmpty
        $result[0].Folder | Should -Be "Nexthink Library/Win10: Migration"

        $result[1].Name | Should -Be 'Win10 - Pre-migration satisfaction'
        $result[1].UID | Should -Be "e82f64ec-8f71-4fec-8e10-6bb85e4443ce"
        $result[1].Status | Should -Be "draft"
        $result[1].Description  | Should -BeNullOrEmpty
        $result[1].Folder | Should -Be "Nexthink Library/Win10: Migration"

        $result[2].Name | Should -Be 'Win10 - Users ready for migration'
        $result[2].UID | Should -Be "fa7710be-8d31-4d79-a377-e42507e81de7"
        $result[2].Status | Should -Be "draft"
        $result[2].Description  | Should -BeNullOrEmpty
        $result[2].Folder | Should -Be "Nexthink Library/Win10: Migration"
    }

    It "should identify 83 Campaigns in a PublicationTree export" {

        $path = "$samplePath\Demo-Campaigns.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-CampaignObject -XML $xmlContent
        $result | Should -HaveCount 83
    }
}
