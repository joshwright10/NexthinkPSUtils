---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInCampaigns.md
schema: 2.0.0
---

# Get-NxtCategoryUsageInCampaigns

## SYNOPSIS
Checks for references to a Category within Nexthink Campaigns.

## SYNTAX

```
Get-NxtCategoryUsageInCampaigns [-PublicationTreeXMLPath] <String> [-CategoryName] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Category within Campaigns.
The PublicationTree (export of all campaigns) must be exported from the Finder and provided to this function.

The following places are checked within the Campaign:
    - Trigger Query

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCategoryUsageInCampaigns -PublicationTreeXMLPath "C:\Temp\campaigns.xml" -CategoryName "IT satisfaction recipient"
```

Look in the 'campaigns.xml' file for any references to the category name 'IT satisfaction recipient'.

## PARAMETERS

### -PublicationTreeXMLPath
Specifies the XML file containing an export of metrics from the Nexthink Finder.
The PublicationTree can be exported by right clicking on the Campaigns section and then exporting to file.

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

### You cannot pipe input to Get-NxtCategoryUsageInCampaigns.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInCampaigns.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInCampaigns.md)

