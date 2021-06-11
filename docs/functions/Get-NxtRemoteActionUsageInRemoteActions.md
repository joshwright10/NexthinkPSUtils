---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInRemoteActions.md
schema: 2.0.0
---

# Get-NxtRemoteActionUsageInRemoteActions

## SYNOPSIS
Checks for references to a Remote Action within the Investigations of other Remote Actions.

## SYNTAX

```
Get-NxtRemoteActionUsageInRemoteActions [-ActionTreeXMLPath] <String> [-RemoteActionXMLPath] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Remote Action within the Investigations of other Remote Actions.
The ActionTree (Export of all Remote Action) and the individual Remote Action must be exported from the Finder and provided to this function.

The following places are checked within the Remote Action:
    - Investigation

## EXAMPLES

### EXAMPLE 1
```
Get-NxtRemoteActionUsageInRemoteActions -ActionTreeXMLPath "C:\Temp\remoteactions.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"
```

Look in the 'remoteaction.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.

## PARAMETERS

### -ActionTreeXMLPath
Specifies the XML file containing an export of ScoreTree from the Nexthink Finder.
The ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteActionXMLPath
Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### You cannot pipe input to Get-NxtRemoteActionUsageInRemoteActions.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInRemoteActions.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInRemoteActions.md)

