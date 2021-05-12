---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInMetrics.md
schema: 2.0.0
---

# Get-NxtScoreUsageInMetrics

## SYNOPSIS
Checks for references to a metric within a Nexthink Dashboard Modules.

## SYNTAX

```
Get-NxtScoreUsageInMetrics [-MetricTreeXMLPath] <String> [-ScoresXMLPath] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Score within Metrics.
The MetricTree (export of all Metrics) and the Scores must be exported from the Finder and provided to this function.

The following places are checked within the Metric:
    - Compute
    - Conditions
    - Output Fields

## EXAMPLES

### EXAMPLE 1
```
Get-NxtScoreUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -ScoresXMLPath "C:\Temp\dexv2scores.xml"
```

Look in the 'metrics.xml' file for any references to the Scores contained in the 'dexv2scores.xml' file.

## PARAMETERS

### -MetricTreeXMLPath
Specifies the XML file containing an export of Metrics from the Nexthink Finder.
The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

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

### -ScoresXMLPath
Specifies the XML file containing an export of Scores to be looked for within the MetricTree.
The Scores can be exported by right clicking on the required scores and exporting to file.

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

### You cannot pipe input to Get-NxtScoreUsageInMetrics.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInMetrics.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtScoreUsageInMetrics.md)

