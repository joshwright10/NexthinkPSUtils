<#
Update mkdocs.yml file used to make docs
#>
task DocsBuild {

    #Build YAML file starting with the header
    $ymlText = (Get-Content "$env:BHProjectPath\header-mkdocs.yml") -join "`n"
    $ymlText = "$ymlText`n"

    # Add Release Notes
    $releaseNotesText = (Get-Content -Path "$env:BHProjectPath\docs\RELEASE.md" -ErrorAction SilentlyContinue) -join "`n"
    if ($releaseNotesText) {
        $releaseNotesText | Set-Content "$env:BHProjectPath\docs\RELEASE.md" -Force
        $ymlText = "$ymlText  - Release Notes: RELEASE.md`n"
    }

    # Start Functions section
    $ymlText = "$ymlText  - Functions:`n"

    # Create an item for each function markdown file
    $functions = Get-ChildItem -Path "$env:BHProjectPath\docs\functions" -Recurse -File
    foreach ($function in $functions) {
        $functionName = $function.Name -replace "\.md", ""
        $ymlText = "$ymlText      - $($functionName): functions/$($function.Name)`n"
    }

    $ymlText | Set-Content -Path "$env:BHProjectPath\mkdocs.yml" -Force
}