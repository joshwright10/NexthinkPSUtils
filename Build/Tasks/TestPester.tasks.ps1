<#
Run Pester Tests
#>
task TestPester {

    $config = [PesterConfiguration]@{
        Run        = @{
            Path     = "$env:BHProjectPath\Tests"
            PassThru = $true
        }
        TestResult = @{
            Enabled      = $true
            OutputPath   = "$env:BHProjectPath\pester-tests.xml"
            OutputFormat = "NUnitXml"
        }
    }

    $result = Invoke-Pester -Configuration $config
    if ($result.FailedCount -gt 0) {
        throw 'Pester tests failed'
    }
}