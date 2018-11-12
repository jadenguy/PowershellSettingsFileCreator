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
    $wantCustomSecureString = ($wantedObject -eq "Custom.SecureString")
    if ($wantCustomSecureString) {
        $wantedObject = "System.String"
    }
    $rightType = ($givenType -contains $wantedObject)
    if (!$rightType) {
        $wasComplete = $false
    }
    <# If leaf node
    make comparisons #>
    if (!$wantBranch) { 
        IF (!$rightType) {
            $args = @{wantedTypeString   = $wantedObject
                wantedObjectName = $wantedObjectName
                wantedCustomSecureString = $wantCustomSecureString
            }
            #$givenObject.Value = Get-PromptValue @args
            write-host "prompt for new $wantedType $wantedObjectName"
        }
    }
    <# If branch node
    verify/create branch
    verify/create nodes off of branch
    recurse by sending each node into comparison #>
    else {
        $haveBranch = ($givenType -contains "System.Management.Automation.PSCustomObject")
        if (!$haveBranch) {
            $givenObject.Value = [PSCustomObject]@{}
            # Write-Host "Created branch"
        }
        $wantedPropertyList = $wantedObject.psobject.Properties
        $havePropertyList = $givenObject.Value.psobject.Properties
        foreach ($prop in $WantedPropertyList) {
            $wantedPropertyName = $prop.Name
            $wantedPropertyType = $prop.Value 
            $propertyExists = ($havePropertyList.Name -contains $wantedPropertyName)
            if (!$propertyExists) {
                $givenObject.Value | Add-Member -NotePropertyName $wantedPropertyName -NotePropertyValue $null
                # Write-Host "Created node $wantedPropertyName"
            }
            $havePropertyValue = [ref]$givenObject.Value.$wantedPropertyName
            $wasComplete = Update-Tree -wantedObject  $wantedPropertyType -wantedObjectName $wantedPropertyName -givenObject $havePropertyValue -depth ($depth + 1) -wasComplete $wasComplete
        }
        # Write-Host "branch"
    }
    return $wasComplete
}