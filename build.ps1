[cmdletbinding()]
param (
    [Parameter(Position = 0)]
    [ValidateSet("Test", "Docs", "Publish", "PublishDocs")]
    [string]$Task,

    [string[]]$PowerShellModules = @('Pester', 'PSScriptAnalyzer', 'InvokeBuild', 'BuildHelpers', 'platyPS'),

    [string[]]$PackageProviders = @('NuGet', 'PowerShellGet')
)

Set-StrictMode -Version Latest

# Install package providers for PowerShell Modules
foreach ($provider in $PackageProviders) {
    if (-not (Get-PackageProvider -Name $provider -ErrorAction SilentlyContinue)) {
        Install-PackageProvider -Name $provider -Force -ForceBootstrap -Scope CurrentUser
    }
}

# Install the PowerShell Modules
foreach ($module in $PowerShellModules) {
    if (-not (Get-Module -ListAvailable $module -ErrorAction SilentlyContinue)) {
        Install-Module $Module -Scope CurrentUser -Force -Repository 'PSGallery'
    }
    Import-Module $Module -Force
}

Push-Location $PSScriptRoot
Get-ChildItem -Path ENV:\BH* | Remove-Item
Set-BuildEnvironment

Import-Module -Name "$Env:BHProjectPath\Build\build.psm1" -Global -ErrorAction Stop

Invoke-Build -Task $Task -Result 'InvokeBuildResult' -File "$Env:BHProjectPath\Build\NexthinkPSUtils.build.ps1"
Remove-Item -Path Env:\BH*

if ($InvokeBuildResult.Error) {
    $Error[-1].ScriptStackTrace | Out-String
    exit 1
}
