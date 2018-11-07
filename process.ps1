. ( join-path $PSScriptRoot "Get-SettingsFile")
. ( join-path $PSScriptRoot "Expand-Tree")
. ( join-path $PSScriptRoot "Expand-Tree2")
. ( join-path $PSScriptRoot "Compare-Trees")
. ( join-path $PSScriptRoot "Compare-Trees2")

$int = 1
$string = 'a'
$object = [PSCustomObject]@{
    Name = "ObjectNameInt"
    Type = "Sys.Int32"
}

Compare-Trees2 -wantedObject $int -givenObject $int
Compare-Trees2 -wantedObject $string -givenObject $int
Compare-Trees2 -wantedObject $object -givenObject $int
#$settingsRequired = Get-SettingsFile "required.json"
#$settingsFile = Get-SettingsFile "settings.json"
#$x = Compare-Trees2 $settingsRequired $settingsFile
#$settingsDescription = Expand-Tree $settingsRequired '$settings' | Sort-Object stringPath
# $settings = Compare-Trees $settingsDescription $settingsFile
# $settings.prod