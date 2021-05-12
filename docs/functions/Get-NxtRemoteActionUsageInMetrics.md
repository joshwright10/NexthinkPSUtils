---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInMetrics.md
schema: 2.0.0
---

# Get-NxtRemoteActionUsageInMetrics

## SYNOPSIS
Checks for references to a Remote Action within Nexthink Metrics.

## SYNTAX

```
Get-NxtRemoteActionUsageInMetrics [-MetricTreeXMLPath] <String> [-RemoteActionXMLPath] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Remote Action within Metrics.
Both the MetricTree (export of all Metrics) and Remote Action must be exported from the Finder and provided to this function.

The following places are checked within the Metric:
    - Compute
    - Conditions
    - Output Fields

## EXAMPLES

### EXAMPLE 1
```
Get-NxtRemoteActionUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"
```

Look in the 'metrics.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.
References to the Remote Action UID and any outputs are checked.

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

### You cannot pipe input to Get-NxtRemoteActionUsageInMetrics.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInMetrics.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionUsageInMetrics.md)

