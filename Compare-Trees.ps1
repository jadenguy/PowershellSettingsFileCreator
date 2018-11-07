function Compare-Trees ($description, $root) {
    $retObject = $root
    $branchs = $description | Where-Object {$_.propertyType -eq "System.Management.Automation.PSCustomObject" }
    foreach ($branch in $branchs) {
        $path = $branch.path
        $x = [ref]$retObject
        foreach ($step in $path) {
            if (!$x.value.$step) {
                $x.Value|Add-Member -NotePropertyName $step -NotePropertyValue ([PSCustomObject]@{})
            }
            $x = [ref]$x.Value.$step
        }
    }
    $leaves = $description | Where-Object {$_.propertyType -ne "System.Management.Automation.PSCustomObject" }
    foreach ($leaf in $leaves) {        
        $leafPath = $leaf.path
        $leafPathString = $leaf.stringPath
        $leafType = $leaf.propertyType
        $leafValue = [ref]$retObject
        if ($leafPath) {
            foreach ($pathPart in $leafPath) {
                if (!$leafValue.Value.$pathPart) {               
                    $leafValue.Value | add-member -notepropertyname $pathPart -NotePropertyValue $null
                    write-host "new value added for $leafPathString"
                }
                $leafValue = [ref]($leafValue.Value).$pathPart
            }
        }
        write-host $leafPathString, $leafValue.value
        #     <# VALDATING RESULTS BELOW #>
        #     write-host "********$leafPathString********"
        #     $leafValue.Value=1
        #     write-host $leafValue.Value
        #     # if ($leafValue.Value) {
        #     #     $valueType = $leafValue.Value.psobject.typenames
        #     #     $rightType = ( $valueType -contains $leafType )
        #     #     if ($rightType) {
        #     #         $isLeaf = ($leafType -ne "System.Management.Automation.PSCustomObject")
        #     #         if ($isLeaf) {
        #     #             write-host "$($leafValue.value) is leaf"
        #     #         }
        #     #     }
        #     #     else {
        #     #         Write-Host "$($leafValue.value) is wrong type $valueType, should be $leafType"
        #     #     }
        #     # }
        #     # ELSE {
        #     #     write-host "No leaf value exists"
        #     #     $hostValue = ((Read-Host) -as $leafType)
        #     #     $leafValue.Value = $hostValue
        #     #     write-host $hostValue
        #     # }
    }
    return $retObject
}