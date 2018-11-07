function Compare-Trees ($description, $root) {
    $ret = $root
    $containers = $description | Where-Object {$_.value -eq "System.Management.Automation.PSCustomObject" }
    foreach ($container in $containers) {
        $path = $container.path
        $x = $ret
        foreach ($step in $path) {
            if (!$x.$step) {
                $x|Add-Member -NotePropertyName $step -NotePropertyValue ([PSCustomObject]@{})
            }
            $x = $x.$step
        }
    }
    $description | ForEach-Object {
        $branch = $_
        $branchPath = $branch.path
        $branchPathString = $branch.stringPath
        $branchType = $branch.value
        $branchValue = $ret
        if ($branchPath) {
            foreach ($pathPart in $branchPath) {
                if (!$branchValue.$pathPart) {               
                    Write-Host "please provide a $branchPathString of $branchType"
                    $branchValue | add-member -notepropertyname $pathPart -NotePropertyValue ((read-host)  -as $branchType )
                }
                $branchValue = $branchValue.$pathPart
            }
        }
        <# VALDATING RESULTS BELOW #>
        write-host "********$branchPathString********"
        if ($branchValue) {
            $valueType = $branchValue.psobject.typenames
            $rightType = ( $valueType -contains $branchType )
            if ($rightType) {
                $isLeaf = ($branchType -ne "System.Management.Automation.PSCustomObject")
                if ($isLeaf) {
                    write-host "$branchValue is leaf"
                }
            }
            else {
                Write-Host "$branchValue is wrong type $valueType, should be $branchType"
            }
        }
        ELSE {
            write-host "No leaf value exists"
            $hostValue = Read-Host
            $branchValue += $hostValue
            write-host $hostValue
        }
    }
    return $ret
}