<#
.SYNOPSIS
    Helper functions to assist with the build process of the module.
    Includes functions to set global variables, and also get testing data.
#>

function Import-MyModule {
    param([switch]$Force)
    if (Get-Module -Name $Env:BHProjectName) {
        Remove-Module -Name $Env:BHProjectName -Force -ErrorAction Stop
    }
    Import-Module -Name "$Env:BHPSModuleManifest" -Global -Force:$($Force.IsPresent)
}