Describe "Get-RelatedCampaign" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Campaigns"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        # Load required Private functions
        . "$modulePath\Private\Import-XMLFile.ps1"
        . "$modulePath\Private\Get-RelatedCampaign.ps1"
    }

    It "should resolve to a single Campaign" {

        $path = "$samplePath\Single Campaign Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $campaignToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//Publication/Definition/Questions") | ForEach-Object { $campaignToCheck.Add($_) }

        $result = Get-RelatedCampaign -Campaigns $campaignToCheck

        $result.Name | Should -Be 'Example Campaign 1'
        $result.UID | Should -Be "d884f407-24cd-4d91-b2ca-a871aa297970"
        $result.Status | Should -Be "published"
        $result.Description | Should -Be "This is a sample campaign"
        $result.Folder | Should -BeNullOrEmpty
        $result | Should -HaveCount 1
    }

    It "should resolve multiple Campaign" {

        $path = "$samplePath\Multi Campaign Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $campaignToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//Publication/Definition/Questions") | ForEach-Object { $campaignToCheck.Add($_) }

        $results = Get-RelatedCampaign -Campaigns $campaignToCheck
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
