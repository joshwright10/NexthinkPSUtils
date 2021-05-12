function Format-CampaignUID {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [string]
        $Value
    )

    if ($Value -match "^euf_[0-9a-fA-F]{32}$") {
        return $Value
    }

    if (-not ($Value -as [guid])) {
        Write-Error -Message "Campaign UID is not a valid GUID. " -ErrorAction Stop
    }
    return "euf_" + ($Value -replace "\-", "")
}