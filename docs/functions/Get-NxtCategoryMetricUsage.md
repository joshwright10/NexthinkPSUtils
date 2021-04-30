---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryMetricUsage.md
schema: 2.0.0
---

# Get-NxtCategoryMetricUsage

## SYNOPSIS
Checks for references to a category within Nexthink Metrics.

## SYNTAX

```
Get-NxtCategoryMetricUsage [-MetricTreeXMLPath] <String> [-CategoryName] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a category within conditions and the output fields of metrics.
The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCategoryMetricUsage -MetricTreeXMLPath "C:\Temp\metrics.xml" -CategoryName "Hardware type"
```

Look in the 'metrics.xml' file for any references to the category name 'Hardware type'.

## PARAMETERS

### -MetricTreeXMLPath
Specifies the XML file containing an export of metrics from the Nexthink Finder.
Note that the MetricTree can be exported by right clicking on the Scores section and then exporting to file.

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

### You cannot pipe input to Get-NxtCategoryMetricUsage.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryMetricUsage.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryMetricUsage.md)

