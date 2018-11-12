. ( join-path $PSScriptRoot "Get-SettingsFile")
#. ( join-path $PSScriptRoot "Expand-Tree")
#. ( join-path $PSScriptRoot "Compare-Trees")
. ( join-path $PSScriptRoot "Update-Tree")
. ( join-path $PSScriptRoot "Test-Tree")
. ( join-path $PSScriptRoot "Get-PromptValue")

Write-Host starting
Test-Tree
$settingsRequired = Get-SettingsFile "required.json"
$settingsFileIn = Get-SettingsFile "settings.json"
Update-Tree $settingsRequired ([ref]$settingsFileIn) "settings"
$settingsFileOut = $settingsFileIn | ConvertTo-Json -Depth 100
$settingsFileOut