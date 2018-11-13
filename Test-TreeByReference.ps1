function Test-TreeByReference {
    $wantInt = "System.Int32"
    $int = 1
    $intClobber = 1
    $string = 'a'
    $wantedObject = [PSCustomObject]@{
        IntValue = "System.Int32"
        StrValue = "System.String"
    }
    $wantedNestedObject = [PSCustomObject]@{
        x =
        [PSCustomObject]@{
            IntValue = "System.Int32"
            StrValue = "System.String"
        }
    }
    $validObject = [PSCustomObject]@{
        IntValue = 1
        StrValue = 'a'
    }
    $invalidNextedObject = $null
    $validNextedObject = [PSCustomObject]@{
        x =
        [PSCustomObject]@{
        
            IntValue = 1
            StrValue = 'a'
        }
    }
    $invalidObject = [PSCustomObject]@{
        IntValue = 'a'
        StrValue = 'a'
    }
    $missingKeyObject = [PSCustomObject]@{
        StrValue = 'a'
    }
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$int) -wantedObjectName "int"
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$string) -wantedObjectName "string"
    Update-Tree -wantedObject $wantInt -givenObject ([ref]$missingKeyObject) -wantedObjectName "missingKeyObject"
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$validObject) -wantedObjectName "valid"
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$invalidObject) -wantedObjectName "invalid"
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$intClobber) -wantedObjectName "intClobber"
    Update-Tree -wantedObject $wantedObject -givenObject ([ref]$missingKeyObject) -wantedObjectName "missing"
    Update-Tree -wantedObject $wantedNestedObject -givenObject ([ref]$validNextedObject) -wantedObjectName "nest"
    Update-Tree -wantedObject $wantedNestedObject -givenObject ([ref]$invalidNextedObject) -wantedObjectName "badNest"
    return
}