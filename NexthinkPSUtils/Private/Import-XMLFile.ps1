function Import-XMLFile {
    [CmdletBinding()]
    param (
        [string]
        $Path
    )

    if ($Path -notmatch "\.xml$") {
        Write-Error -Message "The file specified in the path argument must be either of type xml" -ErrorAction Stop
    }
    if (-not (Test-Path -Path $Path -PathType Leaf)) {
        Write-Error -Message "The Path argument must be a file. Folder paths are not allowed." -ErrorAction Stop
    }
    if (-not (Test-Path -Path $Path)) {
        Write-Error -Message "Unable to find XML file '$Path'. " -ErrorAction Stop
    }
    [xml]$xmlContent = Get-Content -Path $Path -ErrorAction Stop
    return $xmlContent
}