. ( join-path $PSScriptRoot "Get-SettingsFile")
# . ( join-path $PSScriptRoot "Expand-Tree")
# . ( join-path $PSScriptRoot "Compare-Trees")
# . ( join-path $PSScriptRoot "Test-TreeByReference")
# . ( join-path $PSScriptRoot "Update-Tree")
. ( join-path $PSScriptRoot "Update-Tree2")
. ( join-path $PSScriptRoot "Test-Tree")
. ( join-path $PSScriptRoot "Test-Prompt")
. ( join-path $PSScriptRoot "Get-PromptValue")

Write-Host starting
# Test-Tree
# test-prompt
$settingsRequired = Get-SettingsFile "required.json"
$settingsFileIn = Get-SettingsFile "settings.json"
$settingsFileOut = Update-Tree $settingsRequired $settingsFileIn | ConvertTo-Json -Depth 100
$settingsFileOut