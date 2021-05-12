Describe "Get-RemoteActionUIDS" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:remoteActionSamplePath = "$env:BHProjectPath\Tests\Samples\Get-RemoteActionUIDS"

        $functionName = (Split-Path -Path $PSCommandPath -Leaf) -replace "\.tests.ps1$", ""
        $functionPath = Join-Path -Path $modulePath -ChildPath "Private\$functionName.ps1"
        . "$functionPath"

        $importXMLFunctionPath = Join-Path -Path $modulePath -ChildPath "Private\Import-XMLFile.ps1"
        . "$importXMLFunctionPath"
    }

    It "should return the expected values" {

        $path = "$remoteActionSamplePath\Get BitLocker Information.xml"
        $expectedOutputUIDs = @(
            'b55d6199-89ba-cd77-705b-ba980ec3c581',
            '6a042ed1-9894-86fb-9faa-34546cdc473a',
            'f6a68c50-539d-1eea-34c8-4b0e56a623c6',
            'ac791bfc-d105-eddb-d6e4-0556d90e4205',
            'e270b707-0a7f-d480-974a-26dc079c99b7',
            '72140485-bc2d-27b0-949b-22e36538b2d1',
            '6cdcaaa4-4764-a5c3-66aa-a6d77c5dd683',
            'd863d505-6da3-e2c6-0fa1-5349f117cba5',
            'de9ab004-4181-1d78-a1f8-2a0285ea37cf',
            '9a0d7357-85bd-7241-71a9-59bbff0dc699')

        $result = Get-RemoteActionUIDS -Path $path
        $result.Name | Should -Be "Get BitLocker Information"
        $result.UID | Should -Be "fcde32f9-b0f6-b48b-f084-7bf81a26093b"
        $result.OutputUIDs | Should -HaveCount 10

        $expectedOutputUIDs | ForEach-Object {
            $result.OutputUIDs | Should -Contain $_
        }
    }

    It "should return a single output" {
        $path = "$remoteActionSamplePath\Get BitLocker Information.xml"
        $result = Get-RemoteActionUIDS -Path $path -ErrorAction Stop
        $result | Should -HaveCount 1
    }

    It "should throw for missing file" {
        {
            $path = "$remoteActionSamplePath\Dummy Missing Remote Action.xml"
            Get-RemoteActionUIDS -Path $path -ErrorAction Stop
        } | Should -Throw
    }

    It "should throw for wrong file type" {
        {
            $path = "$remoteActionSamplePath\Get BitLocker Information.txt"
            Get-RemoteActionUIDS -Path $path -ErrorAction Stop
        } | Should -Throw
    }
}
