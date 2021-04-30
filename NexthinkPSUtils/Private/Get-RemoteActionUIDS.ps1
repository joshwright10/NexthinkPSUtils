function Get-RemoteActionUIDS {
    [CmdletBinding()]
    param (
        [string]
        $Path
    )

    if (-not (Test-Path -Path $Path)) {
        Write-Error -Message "Unable to find XML file '$Path'. " -ErrorAction Stop
    }
    if (-not (Test-Path -Path $Path -PathType Leaf)) {
        Write-Error -Message "The Path argument must be a file. Folder paths are not allowed." -ErrorAction Stop
    }
    if ($Path -notmatch "\.xml$") {
        Write-Error -Message "The file specified in the path argument must be either of type xml" -ErrorAction Stop
    }
    [xml]$xmlContent = Get-Content -Path $Path -ErrorAction Stop

    # Get UID of the Remote Action
    $actionUID = $xmlContent.SelectNodes("//Action[@UID]") | Select-Object -ExpandProperty UID
    if ($null -eq $actionUID) {
        throw "Unable to find Action UID. "
    }
    if ($actionUID.Count -gt 1) {
        throw "More than 1 Action UID found. "
    }

    # Get Remote Action Name
    $name = $xmlContent.SelectNodes("//Action[@Name]") | Select-Object -ExpandProperty Name
    if ($null -eq $name) {
        throw "Unable to find Action Name. "
    }

    # Get UID of the Remote Action Outputs
    $outputUIDs = $xmlContent.SelectNodes("//Outputs/Output[@UID]") | Select-Object -ExpandProperty UID
    if ($null -eq $outputUIDs) {
        throw "Unable to find Output UIDs. "
    }

    return [PSCustomObject]@{
        Name       = $name
        UID        = $actionUID
        OutputUIDs = $outputUIDs
    }
}