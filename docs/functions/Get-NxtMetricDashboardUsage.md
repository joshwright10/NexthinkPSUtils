---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryMetricUsage.md
schema: 2.0.0
---

# Get-NxtMetricDashboardUsage

## SYNOPSIS
Checks for references to a metric within a Nexthink Dashboard Modules.

## SYNTAX

```
Get-NxtMetricDashboardUsage [-ModuleXMLPath] <String> [-MetricUID] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a metric in Nexthink Dashboards.

## EXAMPLES

### EXAMPLE 1
```
Get-NxtMetricDashboardUsage -ModuleXMLPath "C:\Temp\dashboard.xml" -MetricUID "af95692e-b1d9-489b-8ef3-aaed3b5dcee9"
```

Look in the 'dashboard.xml' file for any references to the metric 'af95692e-b1d9-489b-8ef3-aaed3b5dcee9'.

## PARAMETERS

### -ModuleXMLPath
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

### -MetricUID
Specifies the UID of the metric to search for.
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

### You cannot pipe input to Get-NxtMetricDashboardUsage.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryMetricUsage.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryMetricUsage.md)

