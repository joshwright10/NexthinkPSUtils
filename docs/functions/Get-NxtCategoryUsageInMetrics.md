---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInMetrics.md
schema: 2.0.0
---

# Get-NxtCategoryUsageInMetrics

## SYNOPSIS
Checks for references to a Category within Nexthink Metrics.

## SYNTAX

```
Get-NxtCategoryUsageInMetrics [-MetricTreeXMLPath] <String> [-CategoryName] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Campaign within Metrics.
The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

The following places are checked within the Metric:
    - Breakdowns
    - Conditions
    - Output Fields

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCategoryUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CategoryName "Hardware type"
```

Look in the 'metrics.xml' file for any references to the Category name 'Hardware type'.

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

### -CategoryName
Specifies the name of the Category to search for.
This must be the name of the Category without any tags appended to it.
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

### You cannot pipe input to Get-NxtCategoryUsageInMetrics.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInMetrics.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInMetrics.md)

