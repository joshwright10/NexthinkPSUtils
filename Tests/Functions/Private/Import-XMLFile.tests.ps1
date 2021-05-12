Describe "Import-XMLFile" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:testSamplePath = "$env:BHProjectPath\Tests\Samples\ImportXMLFileSamples"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"
    }

    It "should not have errors" {
        { Import-XMLFile -Path "$Script:testSamplePath\BasicMetrics.xml" -ErrorAction Stop }  | Should -Not -Throw
    }

    It "should throw for missing file" {
        { Import-XMLFile -Path "$Script:testSamplePath\filedoesnotexist.xml" -ErrorAction Stop } | Should -Throw
    }

    It "should throw for wrong file type" {
        { Import-XMLFile -Path "$Script:testSamplePath\BasicMetrics.txt" -ErrorAction Stop } | Should -Throw
    }

    It "should be of output type 'System.Xml.XmlDocument'" {
        $content = Import-XMLFile -Path "$Script:testSamplePath\BasicMetrics.xml" -ErrorAction Stop
        $content | Should -BeOfType System.Xml.XmlDocument
    }

    It "should return a single output" {
        $content = Import-XMLFile -Path "$Script:testSamplePath\BasicMetrics.xml" -ErrorAction Stop
        $content | Should -HaveCount 1
    }
}
