. ( join-path $PSScriptRoot "Get-SettingsFile")
. ( join-path $PSScriptRoot "Expand-Tree")
. ( join-path $PSScriptRoot "Compare-Trees")


$settingsRequired = Get-SettingsFile "required.json"
$settingsFile = Get-SettingsFile "settings.json"
$settingsDescription = expand-tree $settingsRequired '$settings' | Sort-Object stringPath
$settings = Compare-Trees $settingsDescription $settingsFile
$settings | ConvertTo-Json -Depth 100