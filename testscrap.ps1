
Import-Module "C:\Users\jwright\Git\GitHub\NexthinkPS\NexthinkPSUtils" -Force


Get-ChildItem -Path "C:\Users\jwright\Git\GitHub\NexthinkPS\NexthinkPSUtils\Private\" -File -Recurse | ForEach-Object { . $_.FullName }
Get-ChildItem -Path "C:\Users\jwright\Git\GitHub\NexthinkPS\NexthinkPSUtils\Public\" -File -Recurse | ForEach-Object { . $_.FullName }


###
# Remote Action Metric Usage
##
$testMetricPath = "C:\Users\jwright\Git\GitHub\NexthinkPS\Tests\Samples\Demo-AllMetrics.xml"
Get-NxtRemoteActionMetricUsage -MetricTreeXMLPath $testMetricPath -RemoteActionXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Samples\Get OST Individual File Size & Dates.xml"

Get-NxtRemoteActionMetricUsage -MetricTreeXMLPath $testMetricPath -RemoteActionXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Samples\Get BitLocker Information.xml"

###
# Metric Score Usage
##
$testScorePath = "C:\Users\jwright\Git\GitHub\NexthinkPS\Tests\Samples\Demo-AllScores.xml"
Get-NxtRemoteActionScoreUsage -ScoreTreeXMLPath $testScorePath -RemoteActionXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Tests\Samples\Remote Actions\Get Startup Impact.xml"

Get-NxtRemoteActionScoreUsage -ScoreTreeXMLPath $testScorePath -RemoteActionXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Tests\Samples\Remote Actions\Get Startup Impact.xml"

Get-NxtRemoteActionScoreUsage -ScoreTreeXMLPath $testScorePath -RemoteActionXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Tests\Samples\Remote Actions\Get Startup Impact.xml"

Get-NxtCampaignScoreUsage -ScoreTreeXMLPath $testScorePath -CampaignName "Remote Worker Experience - Well-being"



###
# Dashboard Metric Usage
##
Get-NxtMetricDashboardUsage -ModuleXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Samples\Dashboard Module - DEX.xml" -MetricUID "ab95863d-30a0-4937-8b6a-ef436917458a"

Get-NxtMetricDashboardUsage -ModuleXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Samples\Dashboard Module - DEX.xml" -MetricUID "af95692e-b1d9-489b-8ef3-aaed3b5dcee9"

Get-NxtMetricDashboardUsage -ModuleXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Samples\Content Pack - DEXv2.xml" -MetricUID "b12da91a-70bb-4edf-9e05-f6fe322deed7"

###
# Metric Category Usage
##
Get-NxtMetricCategoryUsage -MetricTreeXMLPath "C:\Users\jwright\Git\GitHub\NexthinkPS\Samples\2021-04-16 - AllEYMetrics.xml" -CategoryName "EY Service Line Desc"

