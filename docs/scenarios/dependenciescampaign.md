# Campaign Dependencies

The following functions can be used to identify references to a Campaign in Nexthink:
* `Get-NxtCampaignUsageInRemoteActions`
* `Get-NxtCampaignUsageInMetrics`
* `Get-NxtCampaignUsageInScores`

## Usage Locations
Locations where a Campaign may be referenced.
* **Remote Actions**
  * Investigation
* **Metrics**
  * Compute
  * Breakdowns
  * Conditions
  * Output Fields
* **Scores**
  * Scope Query
  * Computation Query
  * Input Field
* **Investigations**
  * Conditions
  * Output Fields
* **Alerts**
  * Conditions
  * Output Fields

# Searching for dependencies

## Looking in Remote Actions
The following explains how to check in Remote Actions for references to a Campaign.

1. Export the ActionTree from the Finder.
2. Find the Campaign UID to be searched for.
3. Execute the following, specifying the exported ActionTree file and the Campaign UID:

       Get-NxtCampaignUsageInRemoteActions -ActionTreeXMLPath "C:\Temp\remoteactions.xml" -CampaignUID "bf573024-c7cc-4885-9ce5-2d22535467d8"

This example searches for references to the Campaign UID in the exported Remote Actions.

## Looking in Metrics
The following explains how to check in Metrics for references to a Campaign.

1. Export the MetricTree from the Finder.
2. Find the Campaign UID to be searched for.
3. Execute the following, specifying the exported MetricTree file and the Campaign UID:

       Get-NxtCampaignUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -CampaignUID "bf573024-c7cc-4885-9ce5-2d22535467d8"

This example searches for references to the Campaign UID in the exported Metrics.

## Looking in Scores
The following explains how to check in Scores for references to a Campaign.

1. Export the ScoreTree from the Finder.
2. Execute the following, specifying the exported ScoreTree file and the name of the Campaign to check for:

       Get-NxtCampaignUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -CampaignName "DEX - Employee sentiment"

This example searches for references to the Campaign named 'DEX - Employee sentiment' in the exported Scores. The Campaign name should not contain any forward slashes, for example "DEX - Employee sentiment/Satisfaction" would not return any results.

# Pending Development
The following dependency checks have not yet been implemented:
* Investigations
* Alerts
