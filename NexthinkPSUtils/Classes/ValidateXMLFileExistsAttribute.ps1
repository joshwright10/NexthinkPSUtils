class ValidateXMLFileExistsAttribute : System.Management.Automation.ValidateArgumentsAttribute {

    [void]Validate([object]$path, [System.Management.Automation.EngineIntrinsics]$engineIntrinsics) {

        if ([string]::IsNullOrWhiteSpace($path)) {
            throw [System.ArgumentNullException]::new()
        }

        if ($path -notmatch "\.xml$") {
            throw "The file specified in the path argument must be either of type xml"
        }

        if (-not (Test-Path -Path $path)) {
            throw [System.IO.FileNotFoundException]::new()
        }

        if (-not (Test-Path -Path $path)) {
            throw [System.IO.FileNotFoundException]::new()
        }

        if (-not (Test-Path -Path $path -PathType Leaf) ) {
            throw "The argument must be a file. Folder paths are not allowed."
        }

    }
}
