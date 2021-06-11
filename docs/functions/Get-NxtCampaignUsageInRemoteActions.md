---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInRemoteActions.md
schema: 2.0.0
---

# Get-NxtCampaignUsageInRemoteActions

## SYNOPSIS
Checks for references to a Campaign within Remote Actions.

## SYNTAX

```
Get-NxtCampaignUsageInRemoteActions [-ActionTreeXMLPath] <String> [-CampaignUID] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Campaign within Remote Action.
The ActionTree (export of all Remote Action) must be exported from the Finder and provided to this function.

The following places are checked within the Remote Actions:
    - Investigation
    - Input Parameter Values

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCampaignUsageInRemoteActions -ActionTreeXMLPath "C:\Temp\remoteactions.xml" -CampaignUID "d884f407-24cd-4d91-b2ca-a871aa297970"
```

Look in the 'remoteactions.xml' file for any references to the Campaign with UID 'd884f407-24cd-4d91-b2ca-a871aa297970'.

## PARAMETERS

### -ActionTreeXMLPath
Specifies the XML file containing an export of Remote Action from the Nexthink Finder.
The ActionTree can be exported by right clicking on the Remote Actions section and then exporting to file.

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

### -CampaignUID
Specifies the UID of the Campaign to search for.

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

### You cannot pipe input to Get-NxtCampaignUsageInRemoteActions.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInRemoteActions.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInRemoteActions.md)

