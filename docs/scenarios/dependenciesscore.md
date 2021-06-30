# Score Dependencies

The following functions can be used to identify references to a Scores in Nexthink:
* Get-NxtScoreUsageInMetrics
* Get-NxtScoreUsageInScores

## Usage References
Locations where a Scores may be referenced.
### Metrics
  * Compute
  * Conditions
  * Output Fields
### Scores
  * Scope Query
  * Computation Query
  * Input Field
### Investigations
  * Conditions
  * Output Fields
  * Order By
### Alerts
  * Output Fields
  * Conditions

# Searching for dependencies

## Looking in Metrics
The following explains how to check in Metrics for references to Scores

1. Export the MetricTree from the Finder.
2. Export the Scores that need to be checked for to an xml file.
3. Execute the following, specifying the exported MetricTree file and the Scores file:

       Get-NxtScoreUsageInMetrics -MetricTreeXMLPath "C:\Temp\metrics.xml" -ScoresXMLPath "C:\Temp\dexv2scores.xml"

This example searches for references to the DeX v2 Scores within the exported Metrics.

## Looking in Scores
One Score may reference another Score.
The following explains how to check in Scores for references to other Scores.

1. Export the ScoreTree from the Finder.
2. Export the Scores that need to be checked for to an xml file.
3. Execute the following, specifying the exported ScoreTree file and the Scores file:

       Get-NxtScoreUsageInScores -ScoreTreeXMLPath "C:\Temp\allscores.xml" -ScoresXMLPath "C:\Temp\dexv2scores.xml"

This example searches for references to the DeX v2 Scores within any other Scores. If the DeX v2 Scores are still in the 'allscores.xml' file, these will be excluded from the final result.

# Pending Development
The following dependency checks have not yet been implemented:
* Investigations
* Alerts