BeforeDiscovery {
    $Script:manifestTestResult = Test-ModuleManifest -Path $Env:BHPSModuleManifest
    $Script:publicScriptFiles = Get-ChildItem -Path "$modulePath\Public" -Recurse -File
}

Describe "Core Module Validation" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath

        Remove-Module -Name $moduleName -Force -ErrorAction SilentlyContinue
    }

    It "should cleanly import Module '$ENV:BHProjectName'" {
        { Import-Module -Name $modulePath -Force } | Should -Not -Throw
    }

    It "should export one or more functions" {
        Import-Module -Name $modulePath -Force
        Get-Command -Module $moduleName | Measure-Object | Select-Object -ExpandProperty Count | Should -BeGreaterThan 0
    }

    It "should have a valid PSD1 Module Manifest" {
        { Test-ModuleManifest -Path $ENV:BHPSModuleManifest } | Should -Not -Throw
    }

    Context "<_>" -ForEach $publicScriptFiles.BaseName {
        BeforeAll {
            $Script:script = $_
        }

        It "should be exported '$($_)'" {
            $script | Should -BeIn $manifestTestResult.ExportedFunctions.Values.Name -Because "The function '$($script)' cannot be found in the list of exported functions."
        }
    }

    Context "<_>" -ForEach $manifestTestResult.ExportedFunctions.Values.Name {
        BeforeAll {
            $Script:exportedFunction = $_
        }
        It "should be have a script file in the Public directory named '$($_).ps1'" {
            $exportedFunction | Should -BeIn $publicScriptFiles.BaseName -Because "A ps1 script file cannot be found for the function '$($exportedFunction)' in the Public directory."
        }
    }
}