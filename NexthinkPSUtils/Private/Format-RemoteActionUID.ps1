function Format-RemoteActionUID {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [string]
        $Value
    )

    if ($Value -match "^action_[0-9a-fA-F]{32}$") {
        return $Value
    }

    if (-not ($Value -as [guid])) {
        Write-Error -Message "Remote Action UID is not a valid GUID. " -ErrorAction Stop
    }
    return "action_" + ($Value -replace "\-", "")
}