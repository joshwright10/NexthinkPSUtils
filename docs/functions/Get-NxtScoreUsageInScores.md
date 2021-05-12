---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInScores.md
schema: 2.0.0
---

# Get-NxtScoreUsageInScores

## SYNOPSIS
Checks for references to a Scores within other Nexthink Scores.

## SYNTAX

### ScoreFile (Default)
```
Get-NxtScoreUsageInScores -ScoreTreeXMLPath <String> -ScoresXMLPath <String> [<CommonParameters>]
```

### ScoreName
```
Get-NxtScoreUsageInScores -ScoreTreeXMLPath <String> -ScoreName <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a score within other scores.
The ScoreTree (export of all scores) must be exported from the Finder and provided to this function.

The following places are checked within the score:
    - Score Scope Query
    - Computation Query
    - Score Input Field

## EXAMPLES

### EXAMPLE 1
```
Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoresXMLPath "C:\Temp\dexv2scores.xml"
```

Look in the 'allscores.xml' file for any references to the scores in the "dexv2scores.xml" file.

### EXAMPLE 2
```
Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoreName "DEX - Device"
```

Look in the 'allscores.xml' file for any references to the score named 'DEX - Device'.

## PARAMETERS

### -ScoreTreeXMLPath
Specifies the XML file containing an export of scores from the Nexthink Finder.
Note that the ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScoresXMLPath
Specifies the XML file containing an export of the scores to be checked for.
This file should be an export of only the scores that are to be looked for within the ScoreTree.

```yaml
Type: System.String
Parameter Sets: ScoreFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ScoreName
Specifies the name of the score to search for.
This must be the name of the parent score without any of the composite score names.

```yaml
Type: System.String
Parameter Sets: ScoreName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### You cannot pipe input to Get-NxtScoreUsageInScores.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInScores.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInScores.md)

