class ValidateCampaignUIDAttribute : System.Management.Automation.ValidateArgumentsAttribute {

    [void]Validate([object]$value, [System.Management.Automation.EngineIntrinsics]$engineIntrinsics) {

        if ([string]::IsNullOrWhiteSpace($value)) {
            throw [System.ArgumentNullException]::new()
        }

        if (-not
            ($value -match "^euf_[0-9a-fA-F]{32}$") -or
            ($value -as [guid])) {
            throw "Not a valid Campaign UID format."
        }
    }
}
