---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtUnusedMetrics.md
schema: 2.0.0
---

# Get-NxtUnusedMetrics

## SYNOPSIS
Checks for Metrics that are not used in Nexthink Dashboard Modules.

## SYNTAX

```
Get-NxtUnusedMetrics [-ModuleXMLPath] <String> [-MetricTreeXMLPath] <String> [-DisabledOnly]
 [<CommonParameters>]
```

## DESCRIPTION
Checks for Metrics that are not used in Nexthink Dashboard Modules.

## EXAMPLES

### EXAMPLE 1
```
Get-NxtUnusedMetrics -ModuleXMLPath "C:\Temp\dashboard.xml" -MetricTreeXMLPath "C:\Temp\metrics.xml"
```

Checks if any Metrics in the 'metrics.xml' are NOT used in the 'dashboard.xml' file.

## PARAMETERS

### -ModuleXMLPath
Specifies the XML file containing an export of Nexthink Dashboard Modules.
The file must be in the style of a Content Pack.
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

### -MetricTreeXMLPath
Specifies the XML file containing an export of Metrics from the Nexthink Finder.
The MetricTree can be exported by right clicking on the Metrics section and then exporting to file.

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

### -DisabledOnly
Specifies if only disabled metrics should be returned.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### You cannot pipe input to Get-NxtUnusedMetrics.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtUnusedMetrics.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtUnusedMetrics.md)

