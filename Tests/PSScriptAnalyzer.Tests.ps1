BeforeDiscovery {
    $Script:moduleName = $ENV:BHProjectName
    $Script:modulePath = $ENV:BHModulePath

    $params = @{
        Path          = $Script:modulePath
        Severity      = @('Error', 'Warning')
        Recurse       = $true
        Verbose       = $false
        ErrorVariable = 'ErrorVariable'
        ErrorAction   = 'SilentlyContinue'
    }
    $Script:violations = Invoke-ScriptAnalyzer @params

    $Global:Scripts = Get-ChildItem -Path $Script:modulePath -Include *.ps1, *.psm1 -Recurse
}
Describe "PSScriptAnalyzer Tests" {

    # Displays the results for each script file.
    foreach ($script in $scripts) {
        $relPath = $script.FullName.Replace($modulePath, '') -replace '^\\', ''
        Context "$relPath" {
            $scriptViolations = $violations | Where-Object { $_.ScriptPath -eq $script.FullName }
            if ($scriptViolations) {
                foreach ($rule in $scriptViolations) {
                    It "should pass $($rule.RuleName)" {
                        $false | Should -BeTrue
                    }
                }
            }
            else {
                It "should pass PSScriptAnalyzer" {
                    $true | Should -BeTrue
                }
            }
        }
    }
}