Describe "Get-RelatedScore" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Scores"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        # Load required Private functions
        . "$modulePath\Private\Import-XMLFile.ps1"
    }

    It "should resolve to a single Score" {

        $path = "$samplePath\Single Score Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//LeafScore/Input") | ForEach-Object { $scoresToCheck.Add($_) }

        $result = Get-RelatedScore -Scores $scoresToCheck
        $result | Should -HaveCount 1

        $result.ScoreName | Should -Be 'Overall experience'
        $result.ScoreUID | Should -Be "aa6af607-7588-49a1-b57f-5e434a5771d6"
        $result.CompositeScoreName | Should -BeNullOrEmpty
        $result.CompositeScoreUID | Should -BeNullOrEmpty
        $result.LeafScoreName | Should -Be "Email Crashes"
        $result.LeafScoreUID | Should -Be "66b46dbf-9b45-4841-9cb5-cde3cb936d41"
        $result.Status | Should -Be "enabled"
        $result.ScorePath | Should -Be "Overall experience\Email Crashes"
        $result.ObjectScope | Should -Be "device"
        $result.InObjectView | Should -BeTrue
    }

    It "should resolve multiple Scores" {

        $path = "$samplePath\Multi Score Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
        $xmlContent.SelectNodes("//LeafScore/Input") | ForEach-Object { $scoresToCheck.Add($_) }

        $results = Get-RelatedScore -Scores $scoresToCheck
        $results | Should -HaveCount 4

        $results[0].ScoreName | Should -Be 'Application Auto-Start Impact'
        $results[0].ScoreUID | Should -Be "1798afa8-13ec-4cc1-82c0-116f60da639b"
        $results[0].CompositeScoreName | Should -Be "Application Auto-Start Impact Composite"
        $results[0].CompositeScoreUID | Should -Be "1739959d-5665-4781-b0fe-30fb000a87af"
        $results[0].LeafScoreName | Should -Be "Applications with HIGH impact"
        $results[0].LeafScoreUID | Should -Be "938d8eb6-f98e-4da0-83c5-1148b5330364"
        $results[0].Status | Should -Be "enabled"
        $results[0].ScorePath | Should -Be "Application Auto-Start Impact\Application Auto-Start Impact Composite\Applications with HIGH impact"
        $results[0].ObjectScope | Should -Be "device"
        $results[0].InObjectView | Should -BeTrue

        $results[1].ScoreName | Should -Be 'Application Auto-Start Impact'
        $results[1].ScoreUID | Should -Be "1798afa8-13ec-4cc1-82c0-116f60da639b"
        $results[1].CompositeScoreName | Should -Be "Application Auto-Start Impact Composite"
        $results[1].CompositeScoreUID | Should -Be "1739959d-5665-4781-b0fe-30fb000a87af"
        $results[1].LeafScoreName | Should -Be "Applications with LOW impact"
        $results[1].LeafScoreUID | Should -Be "bd341661-5c6c-4488-8591-9c0e3a9bb4fb"
        $results[1].Status | Should -Be "enabled"
        $results[1].ScorePath | Should -Be "Application Auto-Start Impact\Application Auto-Start Impact Composite\Applications with LOW impact"
        $results[1].ObjectScope | Should -Be "device"
        $results[1].InObjectView | Should -BeTrue

        $results[2].ScoreName | Should -Be 'Application Auto-Start Impact'
        $results[2].ScoreUID | Should -Be "1798afa8-13ec-4cc1-82c0-116f60da639b"
        $results[2].CompositeScoreName | Should -Be "Application Auto-Start Impact Composite"
        $results[2].CompositeScoreUID | Should -Be "1739959d-5665-4781-b0fe-30fb000a87af"
        $results[2].LeafScoreName | Should -Be "Applications with MEDIUM impact"
        $results[2].LeafScoreUID | Should -Be "e6e2cd6f-b198-4333-9ab2-1ed40e4ce0ce"
        $results[2].Status | Should -Be "enabled"
        $results[2].ScorePath | Should -Be "Application Auto-Start Impact\Application Auto-Start Impact Composite\Applications with MEDIUM impact"
        $results[2].ObjectScope | Should -Be "device"
        $results[2].InObjectView | Should -BeTrue

        $results[3].ScoreName | Should -Be 'Overall experience'
        $results[3].ScoreUID | Should -Be "aa6af607-7588-49a1-b57f-5e434a5771d6"
        $results[3].CompositeScoreName | Should -BeNullOrEmpty
        $results[3].CompositeScoreUID | Should -BeNullOrEmpty
        $results[3].LeafScoreName | Should -Be "Email Crashes"
        $results[3].LeafScoreUID | Should -Be "66b46dbf-9b45-4841-9cb5-cde3cb936d41"
        $results[3].Status | Should -Be "enabled"
        $results[3].ScorePath | Should -Be "Overall experience\Email Crashes"
        $results[3].ObjectScope | Should -Be "device"
        $results[3].InObjectView | Should -BeTrue
    }
}
