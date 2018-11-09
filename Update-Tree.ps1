function Update-Tree {
    [CmdletBinding()]
    param ($wantedObject
        , [ref]$givenObject
        , [bool]$wasComplete = $true
        , [int]$depth
    )
    $givenType = $givenObject.Value.psobject.TypeNames
    $wantedType = $wantedObject.psobject.TypeNames
    $wantBranch = ($wantedType -contains "System.Management.Automation.PSCustomObject")
    $rightType = ($givenType -contains $wantedObject)
    if (!$rightType) {
        $wasComplete = $false
    }
    <# If leaf node
    make comparisons #>
    if (!$wantBranch) { 
        
    }
    <# If branch node
    verify/create branch
    verify/create nodes off of branch
    recurse by sending each node into comparison
    #>
    else {
        $haveBranch = ($givenType -contains "System.Management.Automation.PSCustomObject")
        if (!$haveBranch) {
            $givenObject.Value = [PSCustomObject]@{}
        }
        $wantedPropertyList = $wantedObject.psobject.Properties
        $havePropertyList = $givenObject.Value.psobject.Properties
        foreach ($prop in $WantedPropertyList) {
            $wantedPropertyName = $prop.Name
            $wantedPropertyType = $prop.Value 
            $propertyExists=($havePropertyList.Name -contains $wantedPropertyName)
            if (!$propertyExists) {
                $givenObject.Value | Add-Member -NotePropertyName $wantedPropertyName -NotePropertyValue $null
                # Write-Host "Created property"
            }
            $havePropertyValue = [ref]$givenObject.Value.$wantedPropertyName
            Compare-Trees2 -wantedObject  $wantedPropertyType -givenObject $havePropertyValue -depth ($depth + 1) -wasComplete $wasComplete
        }
        # Write-Host "branch"
    }
    return $wasComplete
}