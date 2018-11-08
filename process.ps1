. ( join-path $PSScriptRoot "Get-SettingsFile")
#. ( join-path $PSScriptRoot "Expand-Tree")
#. ( join-path $PSScriptRoot "Compare-Trees")
. ( join-path $PSScriptRoot "Compare-Trees2")

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
Compare-Trees2 -wantedObject $wantInt -givenObject $int -passes $true
Compare-Trees2 -wantedObject $wantInt -givenObject ([ref]$string)
Compare-Trees2 -wantedObject $wantInt -givenObject ([ref]$missingKeyObject)
Compare-Trees2 -wantedObject $wantedObject -givenObject ([ref]$validObject) -passes $true
Compare-Trees2 -wantedObject $wantedObject -givenObject ([ref]$int)
Compare-Trees2 -wantedObject $wantedObject -givenObject ([ref]$invalidObject)
Compare-Trees2 -wantedObject $wantedObject -givenObject ([ref]$missingKeyObject)
write-host done