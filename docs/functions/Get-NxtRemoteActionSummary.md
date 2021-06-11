---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionSummary.md
schema: 2.0.0
---

# Get-NxtRemoteActionSummary

## SYNOPSIS
Get a summary about all Remote Actions in a ActionTree export.

## SYNTAX

```
Get-NxtRemoteActionSummary [-ActionTreeXMLPath] <String> [<CommonParameters>]
```

## DESCRIPTION
Get a summary of the Remote Actions contained in the export of an ActionTree export.

## EXAMPLES

### EXAMPLE 1
```
Get-NxtRemoteActionSummary -ActionTreeXMLPath "C:\Temp\remoteactions.xml"
```

Provide a summary of the Remote Actions contained in the 'scores.xml' file.

## PARAMETERS

### -ActionTreeXMLPath
Specifies the XML file containing an export of ActionTree from the Nexthink Finder.
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### You cannot pipe input to Get-NxtRemoteActionSummary.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionSummary.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionSummary.md)

