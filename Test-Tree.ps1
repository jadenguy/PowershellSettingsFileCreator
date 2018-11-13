function Test-Tree {
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
    Update-Tree -wantedObject $wantInt -givenObject $int -wantedObjectName "int"
    Update-Tree -wantedObject $wantInt -givenObject $string -wantedObjectName "string"
    Update-Tree -wantedObject $wantInt -givenObject $missingKeyObject -wantedObjectName "missingKeyObject"
    Update-Tree -wantedObject $wantedObject -givenObject $validObject -wantedObjectName "valid"
    Update-Tree -wantedObject $wantedObject -givenObject $invalidObject -wantedObjectName "invalid"
    Update-Tree -wantedObject $wantedObject -givenObject $intClobber -wantedObjectName "intClobber"
    Update-Tree -wantedObject $wantedObject -givenObject $missingKeyObject -wantedObjectName "missing"
    Update-Tree -wantedObject $wantedNestedObject -givenObject $validNextedObject -wantedObjectName "nest"
    Update-Tree -wantedObject $wantedNestedObject -givenObject $invalidNextedObject -wantedObjectName "badNest"
    return
}