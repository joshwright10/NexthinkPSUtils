function Format-ScoreUID {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [string]
        $Value
    )

    if ($Value -match "^score_[0-9a-fA-F]{32}$") {
        return $Value
    }

    if (-not ($Value -as [guid])) {
        Write-Error -Message "Score UID is not a valid GUID. " -ErrorAction Stop
    }
    return "score_" + ($Value -replace "\-", "")
}
