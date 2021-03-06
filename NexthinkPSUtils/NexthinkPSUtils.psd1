@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'NexthinkPSUtils.psm1'

    # Version number of this module.
    ModuleVersion        = '0.0.1'

    # Supported PSEditions
    CompatiblePSEditions = 'Desktop'

    # ID used to uniquely identify this module
    GUID                 = '65340940-6d6a-47ba-a625-0620e448543b'

    # Author of this module
    Author               = 'Josh Wright'

    # Company or vendor of this module
    CompanyName          = ''

    # Copyright statement for this module
    Copyright            = '(c) 2021 Joshua Wright. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'Unofficial PowerShell module to help work with Nexthink.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    ScriptsToProcess     = @(
        'Classes\ValidateCampaignUIDAttribute.ps1',
        'Classes\ValidateRemoteActionUIDAttribute.ps1',
        'Classes\ValidateScoreUIDAttribute.ps1',
        'Classes\ValidateXMLFileExistsAttribute.ps1'
    )

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @(
        'Get-NxtCampaignUsageInMetrics',
        'Get-NxtCampaignUsageInRemoteActions',
        'Get-NxtCampaignUsageInScores',
        'Get-NxtCategoryUsageInCampaigns',
        'Get-NxtCategoryUsageInMetrics',
        'Get-NxtCategoryUsageInScores',
        'Get-NxtMetricUsageInDashboards',
        'Get-NxtUnusedMetrics',
        'Get-NxtRemoteActionUsageInScores',
        'Get-NxtRemoteActionUsageInRemoteActions',
        'Get-NxtRemoteActionUsageInMetrics',
        'Get-NxtScoreUsageInMetrics',
        'Get-NxtScoreUsageInScores',
        'Get-NxtRemoteActionSummary'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = '*'

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('Nexthink')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/joshwright10/NexthinkPSUtils/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/joshwright10/NexthinkPSUtils'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = 'https://github.com/joshwright10/NexthinkPSUtils/blob/master/docs/RELEASE.md'

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    HelpInfoURI          = 'https://nexthinkpsutils.readthedocs.io/'
}
