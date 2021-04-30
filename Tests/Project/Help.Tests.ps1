BeforeDiscovery {
    $Script:moduleName = $ENV:BHProjectName
    $Script:modulePath = $ENV:BHModulePath

    Import-MyModule
    $Script:functions = Get-Command -Module $moduleName
    $Script:help = foreach ($function in $functions) {
        Get-Help -Name $function.Name
    }
}
Describe "Public functions have comment-based help" {

    Context "<_.Name>" -Foreach $help {
        BeforeAll {
            $Script:helpNode = $_
        }

        It "Should have a Synopsis" {
            $helpNode.Synopsis | Should -Not -BeNullOrEmpty
        }

        It "Should have an Example" {
            $helpNode.Examples | Should -Not -BeNullOrEmpty
            $helpNode.Examples | Out-String | Should -Match ($helpNode.Name)
        }

        It "should have a Description for each Parameter" {
            foreach ($parameter  in $helpNode.Parameters.Parameter) {
                $parameter.Description.Text | Should -Not -BeNullOrEmpty
            }
        }
    }
}