# Metric Dependencies

The following functions can be used to identify references to a Metric in Nexthink:
* `Get-NxtMetricUsageInDashboards`
* `Get-NxtUnusedMetrics`

## Usage Locations
Locations where a Metric may be referenced.
* **Dashboards**
  * Widgets

# Searching for dependencies

## Looking in Dashboards
The following explains how to check in Dashboard Modules for references to Metrics

## Individual Module

1. Export the a Dashboard Module to xml from the Nexthink Portal.
2. Find the Metric UID to be searched for.
3. Execute the following, specifying the exported module file and the Metric UID:

       Get-NxtMetricUsageInDashboards -ModuleXMLPath "C:\Temp\office365.xml" -MetricUID "e1f783a7-1c7d-4314-a365-6140428bfbc7"

This example searches for the specified Metric UID within the XML export of the Dashboard Module.


## Unused Metrics
To search for unused Metrics, a full export of all Dashboard Modules and all Metrics must be done.
The export of Dashboard Modules is best done through the CLI, and then manually merged into a single XML file in the style of a Content Pack.

    Get-NxtUnusedMetrics -ModuleXMLPath "C:\Temp\dashboard.xml" -MetricTreeXMLPath "C:\Temp\metrics.xml"

This example gets all metrics in the 'metrics.xml' file and then looks in the dashboard.xml module for a reference. If no reference is found, the function returns the name Metric as a result.
