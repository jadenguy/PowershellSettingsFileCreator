function Update-Tree {
    [CmdletBinding()]
    param ($wantedObject
        , $givenObject
        , $wantedObjectName
        , [bool]$wasComplete = $true
        , [int]$depth
    )
    $givenType = $givenObject.psobject.typenames
    
    return $givenObject, ($givenType -contains $wantedObject)
}