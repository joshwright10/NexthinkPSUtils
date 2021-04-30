#Get public and private function definition files.
$public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -File -Recurse -ErrorAction SilentlyContinue )
$private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -File -Recurse -ErrorAction SilentlyContinue )

#Dot source the files
foreach ($import in @($public + $private)) {
    try {
        . $import.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Export Public functions
Export-ModuleMember -Function $public.Basename
