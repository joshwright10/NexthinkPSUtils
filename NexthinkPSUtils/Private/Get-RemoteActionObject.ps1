function Get-RemoteActionObject {
    [CmdletBinding()]
    param (
        $XML
    )

    $remoteActionList = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()
    $XML.SelectNodes("//Action[@UID]") | ForEach-Object { $remoteActionList.Add($_) }

    return Get-RelatedRemoteAction -RemoteAction $remoteActionList
}
