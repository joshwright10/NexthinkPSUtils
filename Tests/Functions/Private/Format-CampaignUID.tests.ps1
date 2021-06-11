Describe "Format-CampaignUID" {
    BeforeAll {
        $Script:moduleName = $env:BHProjectName
        $Script:modulePath = $env:BHModulePath

        Get-ChildItem -Path "$modulePath\Private" -File -Recurse | ForEach-Object { . $_.FullName }
        Get-ChildItem -Path "$modulePath\Classes" -File -Recurse | ForEach-Object { . $_.FullName }
    }

    It "should process value already in correct format" {
        $value = "euf_688c9b96f11140ceae290a8a46c8935d"
        Format-CampaignUID -Value $value | Should -BeExactly $value
    }

    It "should process a standard GUID value" {
        $value = "9cfc23d8-2f58-4efc-9434-e9d24a7c6ddd"
        $expectedValue = "euf_9cfc23d82f584efc9434e9d24a7c6ddd"
        Format-CampaignUID -Value $value | Should -BeExactly $expectedValue
    }

    It "should be of output type 'System.String'" {
        $value = "euf_688c9b96f11140ceae290a8a46c8935d"
        Format-CampaignUID -Value $value -ErrorAction Stop | Should -BeOfType "System.String"
    }

    It "should return a single output" {
        $value = "euf_688c9b96f11140ceae290a8a46c8935d"
        Format-CampaignUID -Value $value -ErrorAction Stop | Should -HaveCount 1
    }

    It "should return a in the required format" {
        $value = "euf_688c9b96f11140ceae290a8a46c8935d"
        Format-CampaignUID -Value $value -ErrorAction Stop | Should -Match "^euf_[0-9a-fA-F]{32}$"
    }

    It "should throw non-GUID value" {
        {
            $value = "t688a9b96f11140ceae290a8a46c8935"
            Format-CampaignUID -Value $value -ErrorAction Stop
        } | Should -Throw
    }

    It 'should throw for null "$Value" input parameter' {
        {
            $value = $null
            Format-CampaignUID -Value $value -ErrorAction Stop
        } | Should -Throw
    }
}
