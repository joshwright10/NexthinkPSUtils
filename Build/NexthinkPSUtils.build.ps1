<#
Build script used by Invoke-Build
Build task names are defined and the individual build tasks are dot sourced
#>

# Define InvokeBuild Tasks
task Default TestPester
task Test TestPester
task Docs DocsBuildFunctionHelp, DocsBuild
task Publish TestPester, Publish

# Import individual Tasks
foreach ($file in (Get-ChildItem "$PSScriptRoot\Tasks\*.tasks.ps1")) { . $file.FullName }