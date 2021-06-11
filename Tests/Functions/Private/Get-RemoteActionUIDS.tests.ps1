Describe "Get-RemoteActionUIDS" {
    BeforeAll {
        $Script:moduleName = $ENV:BHProjectName
        $Script:modulePath = $ENV:BHModulePath
        $Script:samplePath = "$env:BHProjectPath\Tests\Samples\RemoteActions"

        Get-ChildItem -Path "$modulePath\Private" -File -Recurse | ForEach-Object { . $_.FullName }
        Get-ChildItem -Path "$modulePath\Classes" -File -Recurse | ForEach-Object { . $_.FullName }
    }

    It "should find the expected expected UIDs a single Remote Action file" {

        $path = "$samplePath\Single ActionTree Sample.xml"
        $expectedOutputUIDs = @(
            '7c08cae9-9653-a0bd-747f-7577a0e5eadb',
            '0cc8fcb8-a5f1-1dc3-2721-f11a21877f2d',
            'dec841b4-de9c-075c-6b56-44ec45810d4a',
            '4e336fd3-43ab-7504-ef9a-dd4c86ba9b67',
            'f9b4296e-20e3-9dd8-1330-b63bc0544dac',
            '729c1f74-107d-f190-881a-912ac3213973',
            'dc310e0a-011a-ba60-fe7d-8fbe70bf1612',
            'e8548bb0-1ff2-6a1c-35f5-c1dce99dc363',
            'e32178b1-8c38-f10e-0e69-d61459fd1b26',
            '866afd19-8f5b-b7f6-06b1-4738a0c39ac1',
            'e3da3af1-f848-862d-b5b5-3fb907548c9d',
            'f729cc72-717a-3e67-3f91-1834437828ed',
            'c12e4b3d-5d30-dd90-9744-9809efe879f3',
            '1b67a31a-96fb-9e4e-8458-1cf1e6d54ad4',
            '857fd6e2-e9dc-e6d8-001a-035816ce2435',
            'a20419f3-cd06-cf4e-0f9a-1717ac2b0b5a',
            'cc82d77a-07f6-584c-5807-89c7753c61ee',
            '72342625-0c2d-5629-8728-f4f9d1205734',
            'fcf848e0-25d6-8e75-fdc1-22819fc3eb70',
            'dc2e9873-dbca-dd98-22e9-51fa91e51db2',
            '8a48998d-18a8-7334-8938-98a27f40bf47',
            '95b0b05b-9cc3-32d4-8f75-1cef7a187943',
            '365ea0a8-a31c-6666-5b08-6916af25c44f',
            'd64aa8ea-7cf2-48c9-4182-95b0f39156e5',
            '0deee543-5448-5ba2-2f27-c698cb1c7c57',
            'cddf1a90-4c7f-4a5e-347d-418909fe9d7e',
            '8eee3043-7dd5-c38c-dbdd-410a7d254e3c',
            'db7e42e4-c8ec-bb62-91e4-086147d96f45',
            'bcd8f6be-9b36-a52f-dcc9-c8bb30c32498',
            '1c729715-72fd-56f7-8897-f9f1c6d67327',
            '9622e724-afc8-a887-e869-53982f08137d',
            '3344b5fe-b243-b629-db86-c9ae7ed3068f',
            '89ee44d6-4274-19a6-5022-58f605688ac1',
            '421fb493-3588-0456-7122-0e957f249afd',
            '7e5ca15a-0177-9062-7f11-c6f6180a1238',
            '75639170-1396-721d-58d9-f8534dbfcd20',
            '30aa29fb-e185-5c56-7afe-a97ca12cc61f',
            '4ce86094-c234-7409-cd08-b743063359fe',
            '6d7004fb-16ee-154e-0560-360ead6025fe',
            '56a10be2-6f6c-aa8b-7e9c-bc1c0f6c7c67',
            '73b91cce-8b77-ae40-ac45-a719b9f87a84',
            '9b6cabc5-c9b4-9ca3-1bdd-3a4b9977a404',
            '990efb5c-8541-bf95-88d4-fabe1e65f5cc',
            '083ec17e-e397-b607-b595-9a2650108526',
            '343bae99-ed04-ef7b-0fa2-ce2c49a4f5cf',
            '439d062f-f5f7-4a3f-b320-79ad2de79728',
            '725a4d46-648d-47dc-068f-3332baa8a8d9',
            '08f06dfc-2af1-b6ea-a6af-8e0072be14be',
            '643a47b3-78a0-2b4d-3f13-f6764ed1994a',
            'c17e0200-8e3d-61f8-daff-db9fc89e922e'
        )

        $result = Get-RemoteActionUIDS -Path $path
        $result.Name | Should -Be "Skype for Business Diagnostics"
        $result.UID | Should -Be "02c0f46a-cdbb-99d7-8bd3-2c36692f790e"
        $result.OutputUIDs | Should -HaveCount 50

        $expectedOutputUIDs | ForEach-Object {
            $result.OutputUIDs | Should -Contain $_
        }
    }
}
