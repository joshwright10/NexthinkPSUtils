function Get-DashboardFromMetric {
    [CmdletBinding()]
    param (
        [System.Xml.XmlElement[]]
        $Widgets
    )

    $results = [System.Collections.Generic.List[Object]]::new()
    foreach ($widget in $Widgets) {

        $index = 0
        $widgetUid = $null
        $tempElement = $widget
        $dashboard = $null
        $module = $null
        do {
            if ($index -ne 0) {
                $tempElement = $tempElement.ParentNode
            }

            # Grab the Widget Uid and then trigger find where the widget is used
            if ($null -eq $widgetUid) {
                if ($tempElement.UID -and $tempElement.type) {
                    $widgetUid = $tempElement.uid
                    # Search for the dashboard where the widget is used
                    $tempElement = $tempElement.OwnerDocument.SelectNodes("//child/data[@widgetID='$widgetUid']")
                }
            }

            # Look for the name of the dashboard
            if ($null -eq $dashboard) {
                if (($tempElement.PSObject.Properties.Name -eq "description") -and
                    ($tempElement.PSObject.Properties.Name -eq "index") -and
                    ($tempElement.PSObject.Properties.Name -eq "name") -and
                    ($tempElement.PSObject.Properties.Name -eq "uid")
                ) {
                    $dashboard = $tempElement
                }
            }

            # Look for the module name after the dashboard has been found
            if ($null -ne $dashboard) {
                if (($tempElement.PSObject.Properties.Name -eq "index") -and
                    ($tempElement.PSObject.Properties.Name -eq "name") -and
                    ($tempElement.PSObject.Properties.Name -eq "uid") -and
                    ($tempElement.PSObject.Properties.Name -eq "dashboards")
                ) {
                    $module = $tempElement
                }
            }

            $index++
        } until (($null -ne $module) -or ($index -ge 250))


        if ($null -ne $dashboard) {
            $result = [PSCustomObject]@{
                ModuleName    = $module.name
                DashboardName = $dashboard.name
                ModuleUID     = $module.uid
                DashboardUID  = $dashboard.uid
                References    = 1
            }
            $results.Add($result)
        }
    }

    $groups = $results | Group-Object -Property ModuleUID, DashboardUID
    foreach ($group in $groups) {
        $group.Group | ForEach-Object { $_.References = $group.Count }
    }

    return $results | Sort-Object -Unique ModuleUID, DashboardUID
}
