. ( join-path $PSScriptRoot "Get-SettingsFile")
. ( join-path $PSScriptRoot "Update-Tree2")
. ( join-path $PSScriptRoot "Get-PromptValue")

Write-Host starting

$settingsFile = "settings.json"
$settingsRequired = Get-SettingsJsonFile "required.json"
$settingsFileIn = Get-SettingsJsonFile $settingsFile 
$settings = Update-Tree $settingsRequired $settingsFileIn 'settings'
Export-Clixml -Path "outfile.config" -InputObject $settings 
write-host 'should be clean'
$settingsFileIn2 = Import-Clixml -Path "outfile.config" 
$settings2 = Update-Tree $settingsRequired $settingsFileIn2 'settings2'
Out-SettingsJsonFile $settings "outfile.json" | Out-Null
Export-Clixml -Path "outfile.config" -InputObject $settings 

Write-Host done