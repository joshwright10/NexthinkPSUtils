---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryScoreUsage.md
schema: 2.0.0
---

# Get-NxtCategoryUsageInScores

## SYNOPSIS
Checks for references to a Category within Nexthink Scores.

## SYNTAX

```
Get-NxtCategoryUsageInScores [-ScoreTreeXMLPath] <String> [-CategoryName] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Category within Scores.
The ScoreTree (export of all scores) must be exported from the Finder and provided to this function.

The following places are checked within the Score:
    - Scope Query
    - Computation Query
    - Input Field

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCategoryUsageInScores -MetricTreeXMLPath "C:\Temp\scores.xml" -CategoryName "Hardware type"
```

Look in the 'scores.xml' file for any references to the Category name 'Hardware type'.

## PARAMETERS

### -ScoreTreeXMLPath
Specifies the XML file containing an export of Scores from the Nexthink Finder.
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

### -CategoryName
Specifies the name of the category to search for.
This must be the name of the category without any tags appended to it.
For example "Hardware type/Laptop" would not return any results.

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

### You cannot pipe input to Get-NxtCategoryUsageInScores.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryScoreUsage.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryScoreUsage.md)

