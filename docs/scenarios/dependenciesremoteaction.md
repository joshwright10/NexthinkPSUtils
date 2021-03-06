# Remote Action Dependencies

The following functions can be used to identify references to a Remote Action in Nexthink:

  * Get-NxtRemoteActionSummary
  * Get-NxtRemoteActionUsageInRemoteActions
  * Get-NxtRemoteActionUsageInScores
  * Get-NxtRemoteActionUsageInMetrics

## Usage Locations
Locations where a Remote Action may be referenced.
### Remote Actions
  * Investigation
### Metrics
  * Compute
  * Conditions
  * Output Fields
### Scores
  * Scope Query
  * Computation Query
  * Input Field
  * Document Content for Remote Action Trigger
### Investigations
  * Output Fields
  * Conditions
  * Order By
### Alerts
  * Output Fields
  * Conditions

# Searching for dependencies

## Looking in Remote Actions
The following explains how to check in Remote Actions for references to a Remote Action.
This might a occur if the investigation used by one Remote Action references a field from another Remote Action.

1. Export the ActionTree from the Finder.
2. Export the Remote Action that needs to be checked for to an xml file.
3. Execute the following, specifying the exported ActionTree file and the Remote Action file:

       Get-NxtRemoteActionUsageInRemoteActions -ActionTreeXMLPath "C:\Temp\remoteactions.xml" -RemoteActionXMLPath "C:\Temp\Get BitLocker Information.xml"

This example searches for references to the 'Get BitLocker Information' Remote Action within the exported Remote Actions. An XML file is used for the Remote Action as the function needs to know the Remote Action UID and the UIDs of all output fields.

## Looking in Scores
The following explains how to check in Scores for references to a Remote Action.

1. Export the ScoreTree from the Finder.
2. Export the Remote Action that needs to be checked for to an xml file.
3. Execute the following, specifying the exported ScoreTree file and the Remote Action file:

       Get-NxtRemoteActionUsageInScores -ScoreTreeXMLPath "C:\Temp\scores.xml" -RemoteActionXMLPath "C:\Temp\Get BitLocker Information.xml"

This example searches for references to the 'Get BitLocker Information' Remote Action within the exported Scores. An XML file is used for the Remote Action as the function needs to know the Remote Action name and the UID.

## Looking in Metrics
The following explains how to check in Metrics for references to a Remote Action.

1. Export the MetricTree from the Finder.
2. Export the Remote Action that needs to be checked for to an xml file.
3. Execute the following, specifying the exported MetricTree file and the Remote Action file:

       Get-NxtRemoteActionUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -RemoteActionXMLPath "C:\Temp\Get BitLocker Information.xml"

This example searches for references to the 'Get BitLocker Information' Remote Action within the exported Metrics. An XML file is used for the Remote Action as the function needs to know the Remote Action UID and the UIDs of all output fields.


# Pending Development
The following dependency checks have not yet been implemented:
* Investigations
* Alerts
