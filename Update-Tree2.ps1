function Update-Tree {
    [CmdletBinding()]
    param ($wantedObject
        , $givenObject
        , $wantedObjectName = "tree"
        , [bool]$wasComplete = $true
        , [int]$depth
    )
    $returnObject = $null
    $givenType = $givenObject.psobject.typenames
    $wantBranch = ($wantedObject.psobject.typenames.split(".") -contains "PSCustomObject")
    if ($wantBranch) {
        $haveBranch = ($givenObject -and $givenType.split(".") -contains 'PSCustomObject') 
        if ($haveBranch ) {
            $returnObject = $givenObject
        }
        else {
            $returnObject = [PSCustomObject]@{}
        }            
        $wantedPropertyList = $wantedObject.psobject.Properties
        $havePropertyList = $returnObject.psobject.Properties
        foreach ($prop in $WantedPropertyList) {
            $wantedPropertyName = $prop.Name
            $wantedPropertyType = $prop.Value 
            $propertyNeeded = ($havePropertyList.Name -notcontains $wantedPropertyName)
            if ($propertyNeeded) {
                $returnObject | Add-Member -NotePropertyName $wantedPropertyName -NotePropertyValue $null
            }
            $nextLevelArgs = @{
                wantedObject     = $wantedPropertyType 
                wantedObjectName = "$wantedObjectName.$wantedPropertyName"
                givenObject      = $returnObject.$wantedPropertyName
                depth            = ($depth + 1) 
                wasComplete      = $wasComplete
            }
            $returnObject.$wantedPropertyName = Update-Tree @nextLevelArgs
        }
    }
    else {
        $rightType = ($givenType -contains $wantedObject)
        if ($rightType) {
            $returnObject = $givenObject
        }
        else {
            $wasComplete = $false
            $promtArgs = @{
                wantedTypeString = $wantedObject
                wantedName       = $wantedObjectName
                currentValue     = $givenObject
            }
            $returnObject = Get-PromptValue @promtArgs
        }
    }
    return $returnObject
}