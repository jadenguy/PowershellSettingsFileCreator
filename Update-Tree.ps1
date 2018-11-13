function Update-Tree {
    [CmdletBinding()]
    param ($wantedObject
        , [ref]$givenObject
        , $wantedObjectName
        , [bool]$wasComplete = $true
        , [int]$depth
    )
    $givenType = $givenObject.Value.psobject.TypeNames
    $wantedType = $wantedObject.psobject.TypeNames
    $wantBranch = ($wantedType -contains "System.Management.Automation.PSCustomObject")
    <# If leaf node
    make comparisons #>
    if (!$wantBranch) { 
        $wantCustomSecureString = ($wantedObject -eq "Custom.SecureString")
        if ($wantCustomSecureString) {
            $wantedObject = "System.String"
        }
        $rightType = ($givenType -contains $wantedObject)
        IF (!$rightType) {
            $wasComplete = $false
            $promtArgs = @{wantedTypeString   = $wantedObject
                wantedName = $wantedObjectName
                currentValue = $givenObject.Value
                wantedCustomSecureString = $wantCustomSecureString
            }
            #$prompt = Get-PromptValue @promtArgs
            $givenObject.Value =9
            write-host "Prompted For Value"
        }
        Write-Host "done with leaf $wantedObjectName"
    }
    <# If branch node
    verify/create branch
    verify/create nodes off of branch
    recurse by sending each node into comparison #>
    else {
        $haveBranch = ($givenType -contains "System.Management.Automation.PSCustomObject")
        if (!$haveBranch) {
            $givenObject.Value = [PSCustomObject]@{}
            Write-Host "Created branch"
        }
        $wantedPropertyList = $wantedObject.psobject.Properties
        $havePropertyList = $givenObject.Value.psobject.Properties
        foreach ($prop in $WantedPropertyList) {
            $wantedPropertyName = $prop.Name
            $wantedPropertyType = $prop.Value 
            $propertyExists = ($havePropertyList.Name -contains $wantedPropertyName)
            if (!$propertyExists) {
                $givenObject.Value | Add-Member -NotePropertyName $wantedPropertyName -NotePropertyValue 0
                Write-Host "Created node $wantedPropertyName"
            }
            #$havePropertyValue = [ref]$givenObject.Value.$wantedPropertyName
            $nextLevelArgs = @{
                wantedObject =  $wantedPropertyType 
                wantedObjectName = "$wantedObjectName.$wantedPropertyName"
                givenObject = [ref]($givenObject.Value.$wantedPropertyName) 
                depth = ($depth + 1) 
                wasComplete = $wasComplete
            }
            $wasComplete = Update-Tree @nextLevelArgs
        }
        Write-Host "done with branch $wantedObjectName"
    }
    return $wasComplete
}