. ( join-path $PSScriptRoot "Get-SettingsFile")
#. ( join-path $PSScriptRoot "Expand-Tree")
#. ( join-path $PSScriptRoot "Compare-Trees")
. ( join-path $PSScriptRoot "Update-Tree")

$wantInt = "System.Int32"
$int = 1
$string = 'a'
$wantedObject = [PSCustomObject]@{
    IntValue = "System.Int32"
    StrValue = "System.String"
}
$validObject = [PSCustomObject]@{
    IntValue = 1
    StrValue = 'a'
}
$invalidObject = [PSCustomObject]@{
    IntValue = 'a'
    StrValue = 'a'
}
$missingKeyObject = [PSCustomObject]@{
    StrValue = 'a'
}
Write-Host starting
function TestABunch {
    
    
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$int) -passes $true
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$string)
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$missingKeyObject)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$validObject) -passes $true
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$int)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$invalidObject)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$missingKeyObject)
}

$settingsRequired = Get-SettingsFile "required.json"
$settingsFileIn = Get-SettingsFile "settings.json"
Update-Tree $settingsRequired ([ref]$settingsFileIn)
$settingsFileOut = $settingsFileIn | ConvertTo-Json -Depth 100
$settingsFileOut