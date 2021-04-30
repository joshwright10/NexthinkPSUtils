<#
Create and update help documentation
#>
task DocsBuildFunctionHelp {

    if (-not (Test-Path -Path "$env:BHProjectPath\docs\functions")) {
        [void](New-Item -Path "$env:BHProjectPath\docs\functions" -ItemType Directory -Force)
    }

    Import-Module -Name $env:BHPSModuleManifest -Force

    [void](New-MarkdownHelp -Module $env:BHProjectName -OutputFolder "$env:BHProjectPath\docs\functions" -UseFullTypeName -Force)
}