
function Get-NxtCategoryUsageInCampaigns {
    <#
.SYNOPSIS
    Checks for references to a Category within Nexthink Campaigns.

.DESCRIPTION
    Checks for references to a Category within Campaigns.
    The PublicationTree (export of all campaigns) must be exported from the Finder and provided to this function.

    The following places are checked within the Campaign:
        - Trigger Query

.PARAMETER PublicationTreeXMLPath
    Specifies the XML file containing an export of metrics from the Nexthink Finder.
    The PublicationTree can be exported by right clicking on the Campaigns section and then exporting to file.

.PARAMETER CategoryName
    Specifies the name of the category to search for.
    This must be the name of the category without any tags appended to it.
    For example "Hardware type/Laptop" would not return any results.

.EXAMPLE
    Get-NxtCategoryUsageInCampaigns -PublicationTreeXMLPath "C:\Temp\campaigns.xml" -CategoryName "IT satisfaction recipient"

    Look in the 'campaigns.xml' file for any references to the category name 'IT satisfaction recipient'.

.INPUTS
   You cannot pipe input to Get-NxtCategoryUsageInCampaigns.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryUsageInCampaigns.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $PublicationTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $CategoryName
    )

    [xml]$xmlContent = Import-XMLFile -Path $PublicationTreeXMLPath -ErrorAction Stop

    if (-not ($xmlContent.PublicationTree)) {
        throw "XML file is not a an export of a PublicationTree. "
    }

    $campaignsToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    # Find matching values in the campaign selector
    $xmlContent.SelectNodes("//Trigger/Selector[contains(text(),'tags = `"$($CategoryName):')]") | ForEach-Object { $campaignsToCheck.Add($_) }

    return Get-RelatedCampaign -Campaigns $campaignsToCheck
}
