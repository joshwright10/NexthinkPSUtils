function Get-RelatedRemoteAction {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $RemoteActions
    )

    if ($null -eq $RemoteActions) {
        return
    }

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($remoteAction in $RemoteActions) {

        $index = 0
        $foundRemoteAction = $null
        $outputUIDs = $null
        $recordPath = $false
        $fullPath = $null
        $tempElement = $remoteAction
        do {
            if ($index -ne 0) {
                $tempElement = $tempElement.ParentNode
            }

            if ($recordPath -eq $true) {
                $fullPath = $tempElement.Name, $fullPath -join "/"
            }

            # Grab the Remote Action and then trigger the search for the path
            if ($null -eq $foundRemoteAction) {
                if ($tempElement.PSObject.Properties["UID"] -and $tempElement.PSObject.Properties["Name"]) {
                    $foundRemoteAction = $tempElement
                    $outputUIDs = $foundRemoteAction.SelectNodes(".//Outputs/Output") | Select-Object -ExpandProperty UID
                    $recordPath = $true
                }
            }
            $index++
        } until ($tempElement.NodeType -eq [System.Xml.XmlNodeType]::Document)

        if ($foundRemoteAction) {
            # Clean up folder path
            $path = $fullPath -replace "#document/ActionTree/remote actions/", ""
            $path = $path -replace "#document/", ""
            $path = $path -replace "\/$", ""

            # SerializedScript is the legacy Syntax before Mac scripts were introduced.
            if ($null -ne $foundRemoteAction.Script.SerializedScript) {
                # Check if contains Mac or Windows Script.
                $isWindowsScript = $true
                $isMacScript = $false

                $runAsContext = $foundRemoteAction.Script.RunAs

                $countInputs = ($foundRemoteAction.Script.Inputs.Input | Measure-Object).Count
                $countOutputs = ($foundRemoteAction.Script.Outputs.Output | Measure-Object).Count
            }
            else {
                $isWindowsScript = ($null -ne $foundRemoteAction.ScriptInfo.WindowsScript)
                $isMacScript = ($null -ne $foundRemoteAction.ScriptInfo.MacScript)

                $runAsContext = $foundRemoteAction.ScriptInfo.RunAs

                $countInputs = ($foundRemoteAction.ScriptInfo.Inputs.Input | Measure-Object).Count
                $countOutputs = ($foundRemoteAction.ScriptInfo.Outputs.Output | Measure-Object).Count
            }

            $result = [PSCustomObject]@{
                Name                    = $foundRemoteAction.Name
                UID                     = $foundRemoteAction.UID
                AutomaticScheduling     = $foundRemoteAction.AutomaticScheduling
                ManualTriggerStatus     = $foundRemoteAction.ManualTrigger.Status
                Description             = $foundRemoteAction.Description
                OutputUids              = $outputUIDs
                Folder                  = $path
                RunAsContext            = $runAsContext
                WindowsScript           = $isWindowsScript
                MacScript               = $isMacScript
                NumberOfInputParameters = $countInputs
                NumberOfOutputs         = $countOutputs
            }
            $results.Add($result)
        }
    }
    return $results | Sort-Object -Unique UID
}
