---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionMetricUsage.md
schema: 2.0.0
---

# Get-NxtRemoteActionMetricUsage

## SYNOPSIS
Checks for references to a remote action within Nexthink Metrics.

## SYNTAX

```
Get-NxtRemoteActionMetricUsage [-MetricTreeXMLPath] <String> [-RemoteActionXMLPath] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a remote action within conditions and the output fields of metrics.
Both the MetricTree (export of all Metrics) and Remote Action must be exported from the Finder and provided to this function.

The Remote Action XML export is used, as it contains the UIDs for the output fields.

## EXAMPLES

### EXAMPLE 1
```
Get-NxtRemoteActionMetricUsage -MetricTreeXMLPath "C:\Temp\metrics.xml" -RemoteActionXMLPath "C:\Temp\Get Wi-Fi Information.xml"
```

Look in the 'metrics.xml' file for any references to the Remote Action in the 'Get Wi-Fi Information.xml' file.
References to the Remote Action UID and any outputs are checked.

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

### You cannot pipe input to Get-NxtRemoteActionMetricUsage.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionMetricUsage.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtRemoteActionMetricUsage.md)

