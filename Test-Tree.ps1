function Test-Tree {
    $wantInt = "System.Int32"
    $wantString = "System.String"
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
    Update-Tree -wantedObject $wantInt -givenObject $int -wantedObjectName "hwint"
    Update-Tree -wantedObject $wantInt -givenObject $string -wantedObjectName "hstringwint"
    Update-Tree -wantedObject $wantString -givenObject $string -wantedObjectName "hwstring"
    Update-Tree -wantedObject $wantString -givenObject $int -wantedObjectName "hintwstring"
    Update-Tree -wantedObject $wantInt -givenObject $missingKeyObject -wantedObjectName "hobjwint"
    Update-Tree -wantedObject $wantedObject -givenObject $validObject -wantedObjectName "hwobj"
    Update-Tree -wantedObject $wantedObject -givenObject $invalidObject -wantedObjectName "hwobjInv"
    Update-Tree -wantedObject $wantedObject -givenObject $intClobber -wantedObjectName "hobjwint"
    Update-Tree -wantedObject $wantedObject -givenObject $missingKeyObject -wantedObjectName "hwobjMissing"
    Update-Tree -wantedObject $wantedNestedObject -givenObject $validNextedObject -wantedObjectName "hwnext"
    Update-Tree -wantedObject $wantedNestedObject -givenObject $invalidNextedObject -wantedObjectName "hwbadNest"
    return
}