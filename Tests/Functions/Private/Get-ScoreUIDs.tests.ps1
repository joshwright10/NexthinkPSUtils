Describe "Get-ScoreUIDs" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\Scores"

        Get-ChildItem -Path "$modulePath\Private" -File -Recurse | ForEach-Object { . $_.FullName }
        Get-ChildItem -Path "$modulePath\Classes" -File -Recurse | ForEach-Object { . $_.FullName }
    }

    It "should find the expected UIDs a single Score file" {

        $path = "$samplePath\Single Score Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $expectedUIDs = @(
            '66b46dbf-9b45-4841-9cb5-cde3cb936d41',
            'aa6af607-7588-49a1-b57f-5e434a5771d6'
        )

        $result = Get-ScoreUIDs -XML $xmlContent
        $result | Should -HaveCount 2

        $expectedUIDs | ForEach-Object {
            $result | Should -Contain $_
        }
    }

    It "should find UIDs a multi Score file" {

        $path = "$samplePath\Multi Score Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $expectedUIDs = @(
            '1739959d-5665-4781-b0fe-30fb000a87af',
            '1798afa8-13ec-4cc1-82c0-116f60da639b',
            '66b46dbf-9b45-4841-9cb5-cde3cb936d41',
            '938d8eb6-f98e-4da0-83c5-1148b5330364',
            'aa6af607-7588-49a1-b57f-5e434a5771d6',
            'bd341661-5c6c-4488-8591-9c0e3a9bb4fb',
            'e6e2cd6f-b198-4333-9ab2-1ed40e4ce0ce'
        )

        $result = Get-ScoreUIDs -XML $xmlContent
        $result | Should -HaveCount 7

        $expectedUIDs | ForEach-Object {
            $result | Should -Contain $_
        }
    }
}
