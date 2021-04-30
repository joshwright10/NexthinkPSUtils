---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionScoreUsage.md
schema: 2.0.0
---

# Get-NxtRemoteActionScoreUsage

## SYNOPSIS
Checks for references to a remote action within Nexthink Scores.

## SYNTAX

```
Get-NxtRemoteActionScoreUsage [[-ScoreTreeXMLPath] <String>] [-RemoteActionXMLPath] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a remote action within the computation fields and the Document Content section of the scores.
Both the the ScoreTree (Export of all Scores) and Remote Action must be exported from the Finder and provided to this function.

The Remote Action XML export is used, as it contains the UIDs for the output fields.

## EXAMPLES

### EXAMPLE 1
```
Get-NxtRemoteActionScoreUsage -ScoreTreeXMLPath "C:\Temp\scores.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"
```

Look in the 'scores.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.

## PARAMETERS

### -ScoreTreeXMLPath
Specifies the XML file containing an export of ScoreTree from the Nexthink Finder.
Note that the ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteActionXMLPath
Specifies the XML file containing an export of the Remote Action from the Nexthink Finder.
This must be a single Remote Action in a single XML file.

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

### You cannot pipe input to Get-NxtRemoteActionScoreUsage.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionScoreUsage.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionScoreUsage.md)

