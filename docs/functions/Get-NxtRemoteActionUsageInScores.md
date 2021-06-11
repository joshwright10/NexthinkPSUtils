---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInScores.md
schema: 2.0.0
---

# Get-NxtRemoteActionUsageInScores

## SYNOPSIS
Checks for references to a Remote Action within Nexthink Scores.

## SYNTAX

```
Get-NxtRemoteActionUsageInScores [-ScoreTreeXMLPath] <String> [-RemoteActionXMLPath] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Remote Action within Scores.
Both the ScoreTree (Export of all Scores) and the Remote Action must be exported from the Finder and provided to this function.

The following places are checked within the Score:
    - Scope Query
    - Computation Query
    - Input Field
    - Document Content for Remote Action Trigger

## EXAMPLES

### EXAMPLE 1
```
Get-NxtRemoteActionUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"
```

Look in the 'scores.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.

## PARAMETERS

### -ScoreTreeXMLPath
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

### You cannot pipe input to Get-NxtRemoteActionUsageInScores.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInScores.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInScores.md)

