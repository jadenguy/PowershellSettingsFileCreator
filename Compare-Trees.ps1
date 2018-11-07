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
        write-host "********$leafType $leafPathString********"
        $leafBranch = @( [ref]$retObject)
        for ($i = 0; $i -lt $leafpath.length; $i++) {
            $pathPart = $leafPath[$i]
            $value = ($leafBranch[$i].Value.$pathPart)
            if (!$value) {               
                $leafValue.Value | add-member -notepropertyname $pathPart -NotePropertyValue $null
                write-host "new value added for $leafPathString"
            }
            $leafBranch += [ref]($leafBranch[$i].Value).$pathpart
            write-host $pathPart
        }
        write-host "done adding leaves"
        # write-host $leafPathString, $leafValue.value
        <# VALDATING RESULTS BELOW #>
        
        # while (!$leafValue.Value) {
        #     write-host "No leaf value exists"
        #     $hostValue = ((Read-Host) -as $leafType)
        #     $leafValue.Value = $hostValue
        #     $leafValue
        # }
        # if ($leafValue.Value) {
        #     $valueType = $leafValue.Value.psobject.typenames
        #     $rightType = ( $valueType -contains $leafType )
        #     if ($rightType) {
        #         $isLeaf = ($leafType -ne "System.Management.Automation.PSCustomObject")
        #         if ($isLeaf) {
        #             write-host "$($leafValue.value) is leaf"
        #         }
        #     }
        #     else {
        #         Write-Host "$($leafValue.value) is wrong type $valueType, should be $leafType"
        #     }
        # }
    }
    return $retObject
}