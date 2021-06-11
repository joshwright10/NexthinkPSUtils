Describe "Import-XMLFile" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\ImportXMLFileSamples"

        Get-ChildItem -Path "$modulePath\Private" -File -Recurse | ForEach-Object { . $_.FullName }
        Get-ChildItem -Path "$modulePath\Classes" -File -Recurse | ForEach-Object { . $_.FullName }
    }

    It "should not have errors" {
        { Import-XMLFile -Path "$Script:samplePath\BasicMetrics.xml" -ErrorAction Stop } | Should -Not -Throw
    }

    It "should throw for missing file" {
        { Import-XMLFile -Path "$Script:samplePath\filedoesnotexist.xml" -ErrorAction Stop } | Should -Throw
    }

    It "should throw for wrong file type" {
        { Import-XMLFile -Path "$Script:samplePath\BasicMetrics.txt" -ErrorAction Stop } | Should -Throw
    }

    It "should be of output type 'System.Xml.XmlDocument'" {
        $content = Import-XMLFile -Path "$samplePath\BasicMetrics.xml" -ErrorAction Stop
        $content | Should -BeOfType System.Xml.XmlDocument
    }

    It "should return a single output" {
        $content = Import-XMLFile -Path "$samplePath\BasicMetrics.xml" -ErrorAction Stop
        $content | Should -HaveCount 1
    }
}
