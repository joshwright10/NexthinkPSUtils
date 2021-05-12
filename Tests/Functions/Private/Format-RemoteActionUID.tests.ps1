Describe "Format-RemoteActionUID" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"
    }

    It "should process value already in correct format" {
        $value = "action_688c9b96f11140ceae290a8a46c8935d"
        Format-RemoteActionUID -Value $value | Should -BeExactly $value
    }

    It "should process a standard GUID value" {
        $value = "9cfc23d8-2f58-4efc-9434-e9d24a7c6ddd"
        $expectedValue = "action_9cfc23d82f584efc9434e9d24a7c6ddd"
        Format-RemoteActionUID -Value $value | Should -BeExactly $expectedValue
    }

    It "should be of output type 'System.String'" {
        $value = "action_688c9b96f11140ceae290a8a46c8935d"
        Format-RemoteActionUID -Value $value -ErrorAction Stop | Should -BeOfType "System.String"
    }

    It "should return a single output" {
        $value = "action_688c9b96f11140ceae290a8a46c8935d"
        Format-RemoteActionUID -Value $value -ErrorAction Stop | Should -HaveCount 1
    }

    It "should return a in the required format" {
        $value = "action_688c9b96f11140ceae290a8a46c8935d"
        Format-RemoteActionUID -Value $value -ErrorAction Stop | Should -Match "^action_[0-9a-fA-F]{32}$"
    }

    It "should throw non-GUID value" {
        {
            $value = "t688a9b96f11140ceae290a8a46c8935"
            Format-RemoteActionUID -Value $value -ErrorAction Stop
        } | Should -Throw
    }

    It 'should throw for null "$Value" input parameter' {
        {
            $value = $null
            Format-RemoteActionUID -Value $value -ErrorAction Stop
        } | Should -Throw
    }
}
