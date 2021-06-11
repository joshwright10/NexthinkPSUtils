# Category Dependencies

The following functions can be used to identify references to a Category in Nexthink:
* `Get-NxtCategoryUsageInCampaigns`
* `Get-NxtCategoryUsageInMetrics`
* `Get-NxtCategoryUsageInScores`

## Usage Locations
Locations where a Category may be referenced.
* **Metrics**
  * Breakdowns
  * Conditions
  * Output Fields
* **Scores**
  * Scope Query
  * Computation Query
  * Input Field
* **Campaigns**
  * Trigger Query
* **Investigations**
  * Conditions
  * Output Fields
* **Alerts**
  * Conditions
  * Output Fields

# Searching for dependencies

## Looking in Metrics
The following explains how to check in Metrics for references to a Category.

1. Export the MetricTree from the Finder.
2. Execute the following, specifying the exported MetricTree file and the name of the Category to check for:

       Get-NxtCategoryUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CategoryName "Hardware type"

This example searches for references to the Category named 'Hardware type' in the exported Metrics. The Category name should not contain any tags, for example "Hardware type/Laptop" would not return any results.

## Looking in Scores
The following explains how to check in Scores for references to a Category.

1. Export the ScoreTree from the Finder.
2. Execute the following, specifying the exported ScoreTree file and the name of the Category to check for:

       Get-NxtCategoryUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -CategoryName "Hardware type" -CategoryType Device

This example searches for references to the Device Category named 'Hardware type' in the exported Scores. The Category name should not contain any tags, for example "Hardware type/Laptop" would not return any results.

## Looking in Campaigns
The following explains how to check in Campaigns for references to a Category.

1. Export the PublicationTree from the Finder.
2. Execute the following, specifying the exported PublicationTree file and the name of the Category to check for:

       Get-NxtCategoryUsageInCampaigns -PublicationTreeXMLPath "C:\Temp\campaigns.xml" -CategoryName "Hardware type"

This example searches for references to the Category named 'Hardware type' in the exported Campaigns. The Category name should not contain any tags, for example "Hardware type/Laptop" would not return any results.

# Pending Development
The following dependency checks have not yet been implemented:
* Investigations
* Alerts

