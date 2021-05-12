---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInMetrics.md
schema: 2.0.0
---

# Get-NxtCampaignUsageInMetrics

## SYNOPSIS
Checks for references to a Campaign within Nexthink Metrics.

## SYNTAX

```
Get-NxtCampaignUsageInMetrics [-MetricTreeXMLPath] <String> [-CampaignUID] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Campaign within Metrics.
The MetricTree (export of all metrics) must be exported from the Finder and provided to this function.

The following places are checked within the Metric:
    - Compute
    - Breakdowns
    - Conditions
    - Output Fields

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCampaignUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CampaignUID "bf573024-c7cc-4885-9ce5-2d22535467d8"
```

Look in the 'metrics.xml' file for any Campaign references to the UID 'bf573024-c7cc-4885-9ce5-2d22535467d8'.

## PARAMETERS

### -MetricTreeXMLPath
Specifies the XML file containing an export of metrics from the Nexthink Finder.
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

### -CampaignUID
Specifies the UID of the Campaign to search for.

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

### You cannot pipe input to Get-NxtCampaignUsageInMetrics.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInMetrics.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInMetrics.md)

