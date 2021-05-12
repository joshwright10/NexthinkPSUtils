---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtMetricUsageInDashboards.md
schema: 2.0.0
---

# Get-NxtMetricUsageInDashboards

## SYNOPSIS
Checks for references to a Metric within Nexthink Dashboard Modules.

## SYNTAX

```
Get-NxtMetricUsageInDashboards [-ModuleXMLPath] <String> [-MetricUID] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Metric within Nexthink Dashboard Modules.
The Module Xml must be exported from the Portal of CLI and provided to this function.

The following places are checked within the Module:
    - Dashboard Widgets

## EXAMPLES

### EXAMPLE 1
```
Get-NxtMetricUsageInDashboards -ModuleXMLPath "C:\Temp\dashboard.xml" -MetricUID "af95692e-b1d9-489b-8ef3-aaed3b5dcee9"
```

Look in the 'dashboard.xml' file for any references to the metric 'af95692e-b1d9-489b-8ef3-aaed3b5dcee9'.

## PARAMETERS

### -ModuleXMLPath
Specifies the XML file containing an export of metrics from the Nexthink Finder.
The individual Dashboard Modules can be exported from the Portal.
Bulk exports must be done via the CLI.
See the documentation for advice on bulk exporting Dashboard Modules.

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
Specifies the UID of the Metric to search for.

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

### You cannot pipe input to Get-NxtMetricUsageInDashboards.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtMetricUsageInDashboards.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtMetricUsageInDashboards.md)

