Describe "Get-RemoteActionObject" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\RemoteActions"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        # Load required Private functions
        . "$modulePath\Private\Import-XMLFile.ps1"
        . "$modulePath\Private\Get-RelatedRemoteAction"
    }

    It "should resolve to a single Remote Action" {

        $path = "$samplePath\Single ActionTree Sample.xml"
        $xmlContent = Import-XMLFile -Path $path

        $result = Get-RemoteActionObject -XML $xmlContent
        $result | Should -HaveCount 1

        $result.Name | Should -Be 'Skype for Business Diagnostics'
        $result.UID | Should -Be "02c0f46a-cdbb-99d7-8bd3-2c36692f790e"
        $result.AutomaticScheduling | Should -Be "disabled"
        $result.ManualTriggerStatus | Should -Be "enabled"
        $result.Description | Should -Be "Creates files with information about Skype calls and calculates metrics of the last 24h."
        $result.OutputUids | Should -HaveCount 50
        $result.Folder | Should -Be "Examples"
        $result.RunAsContext | Should -Be "interactiveUser"
        $result.WindowsScript | Should -BeTrue
        $result.MacScript | Should -BeFalse
        $result.NumberOfInputParameters | Should -Be 2
        $result.NumberOfOutputs | Should -Be 50
    }

    It "should resolve multiple Remote Actions" {

        $path = "$samplePath\Multi ActionTree Sample.xml"
        $xmlContent = Import-XMLFile -Path $path
        $results = Get-RemoteActionObject -XML $xmlContent
        $results | Should -HaveCount 2

        $results[0].Name | Should -Be 'Skype for Business Diagnostics'
        $results[0].UID | Should -Be "02c0f46a-cdbb-99d7-8bd3-2c36692f790e"
        $results[0].AutomaticScheduling | Should -Be "disabled"
        $results[0].ManualTriggerStatus | Should -Be "enabled"
        $results[0].Description | Should -Be "Creates files with information about Skype calls and calculates metrics of the last 24h."
        $results[0].OutputUids | Should -HaveCount 50
        $results[0].Folder | Should -Be "Examples"
        $results[0].RunAsContext | Should -Be "interactiveUser"
        $results[0].WindowsScript | Should -BeTrue
        $results[0].MacScript | Should -BeFalse
        $results[0].NumberOfInputParameters | Should -Be 2
        $results[0].NumberOfOutputs | Should -Be 50

        $results[1].Name | Should -Be 'Get Apple Unified Logging'
        $results[1].UID | Should -Be "afbc0e32-f5c5-97b3-5fbb-fcb9e1ccc742"
        $results[1].AutomaticScheduling | Should -Be "disabled"
        $results[1].ManualTriggerStatus | Should -Be "disabled"
        $results[1].Description | Should -Be "Returns a list of entries from the 'Apple Unified Log' which match the provided inputs supplied in the Remote Action."
        $results[1].OutputUids | Should -Be "f86f078d-ccb1-5381-9978-4589c3683e30"
        $results[1].Folder | Should -Be "Samples"
        $results[1].RunAsContext | Should -Be "localSystem"
        $results[1].WindowsScript | Should -BeFalse
        $results[1].MacScript | Should -BeTrue
        $results[1].NumberOfInputParameters | Should -Be 9
        $results[1].NumberOfOutputs | Should -Be 1
    }
}
