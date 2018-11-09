function Test-Tree {
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
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$int)
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$string)
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$missingKeyObject)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$validObject)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$int)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$invalidObject)
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$missingKeyObject)
}