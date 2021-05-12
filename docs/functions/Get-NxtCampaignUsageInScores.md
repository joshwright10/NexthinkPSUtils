---
external help file: NexthinkPSUtils-help.xml
Module Name: NexthinkPSUtils
online version: https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInScores.md
schema: 2.0.0
---

# Get-NxtCampaignUsageInScores

## SYNOPSIS
Checks for references to a Campaign within Nexthink Scores.

## SYNTAX

```
Get-NxtCampaignUsageInScores [-ScoreTreeXMLPath] <String> [-CampaignName] <String> [<CommonParameters>]
```

## DESCRIPTION
Checks for references to a Campaign within Scores.
The ScoreTree (export of all scores) must be exported from the Finder and provided to this function.

The following places are checked within the Score:
    - Scope Query
    - Computation Query
    - Input Field

## EXAMPLES

### EXAMPLE 1
```
Get-NxtCampaignUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -CampaignName "DEX - Employee sentiment"
```

Look in the 'scores.xml' file for any references to the campaign name 'DEX - Employee sentiment'.

## PARAMETERS

### -ScoreTreeXMLPath
Specifies the XML file containing an export of Scores from the Nexthink Finder.
The ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

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

### -CampaignName
Specifies the name of the Campaign to search for.
This must be the name of the Campaign without any question names appended to it.
For example "DEX - Employee sentiment/Satisfaction" would not return any results.

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

### You cannot pipe input to Get-NxtCampaignUsageInScores.
## OUTPUTS

### PSObject
## NOTES
None

## RELATED LINKS

[https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInScores.md](https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCampaignUsageInScores.md)

