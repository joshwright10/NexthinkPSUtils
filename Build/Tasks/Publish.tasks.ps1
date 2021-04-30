<#
Publish module to PowerShell Gallery
#>
task Publish -If (${env:BUILDRELEASE} -eq "Release") {
    try {
        $params = @{
            Path        = "$env:BHProjectPath\$Env:BHProjectName"
            NuGetApiKey = ${env:PSGALLERYKEY}
            ErrorAction = 'Stop'
        }
        Publish-Module @params
        Write-Output -InputObject "$($env:BHProjectName) PowerShell Module version published to the PowerShell Gallery!"
    }
    catch {
        throw $_
    }
}