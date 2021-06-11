
function Get-NxtCategoryUsageInScores {
    <#
.SYNOPSIS
    Checks for references to a Category within Nexthink Scores.

.DESCRIPTION
    Checks for references to a Category within Scores.
    The ScoreTree (export of all scores) must be exported from the Finder and provided to this function.

    The following places are checked within the Score:
        - Scope Query
        - Computation Query
        - Input Field

.PARAMETER ScoreTreeXMLPath
    Specifies the XML file containing an export of Scores from the Nexthink Finder.
    The ScoreTree can be exported by right clicking on the Scores section and then exporting to file.

.PARAMETER CategoryName
    Specifies the name of the category to search for.
    This must be the name of the category without any tags appended to it.
    For example "Hardware type/Laptop" would not return any results.

.PARAMETER CategoryType
    Specifies the type of the category to search for.
    Possible values: Device, User, Binary, Application, Package, Executable, Binary, Printer, Port, Destination,Domain

.EXAMPLE
    Get-NxtCategoryUsageInScores -MetricTreeXMLPath "C:\Temp\scores.xml" -CategoryName "Hardware type" -CategoryType Device

    Look in the 'scores.xml' file for any references to the device category with the name 'Hardware type'

.INPUTS
   You cannot pipe input to Get-NxtCategoryUsageInScores.

.OUTPUTS
    PSObject

.NOTES
    None

.LINK
    https://nexthinkpsutils.readthedocs.io/en/latest/functions/Get-NxtCategoryScoreUsage.md

#>
    [CmdletBinding()]
    param (
        [string]
        [Parameter(Mandatory)]
        [ValidateXMLFileExists()]
        $ScoreTreeXMLPath,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $CategoryName,

        [string]
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet(
            "Device", "User",
            "Binary", "Application",
            "Package", "Executable",
            "Binary", "Printer",
            "Port", "Destination",
            "Domain" )]
        $CategoryType

    )

    $CategoryType = $CategoryType.ToLower()

    # Import data from XML
    [xml]$xmlContent = Import-XMLFile -Path $ScoreTreeXMLPath -ErrorAction Stop

    $scoresToCheck = [System.Collections.Generic.List[System.Xml.XmlElement]]::new()

    # Check Computation Query
    $xmlContent.SelectNodes("//Computation/Query[contains(text(), '#`"$CategoryName`"')]") | ForEach-Object {
        if ($_.'#text' -match "\(\s*where\s*$CategoryType\s*\(\s*(ne|eq|lt|le|gt|ge)\s*#`"$CategoryName`"") { $scoresToCheck.Add($_) }
    }

    # Check Scope Query
    $xmlContent.SelectNodes("//ScopeQuery/Filtering[contains(text(), '#`"$CategoryName`"')]") | ForEach-Object {
        if ($_.'#text' -match "\(\s*where\s*$CategoryType\s*\(\s*(ne|eq|lt|le|gt|ge)\s*#`"$CategoryName`"") { $scoresToCheck.Add($_) }
    }

    # Check Input Field
    $xmlContent.SelectNodes("//Input/Field[@Name='#$CategoryName']") | ForEach-Object { $scoresToCheck.Add($_) }

    return Get-RelatedScore -Scores $scoresToCheck
}
