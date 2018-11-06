function Compare-Trees ($description, $root) {
    $description | ForEach-Object {
        $branch = $_
        $branchPath = $branch.path
        $branchPathString = $branch.stringPath
        $branchType = $branch.value
        $branchValue = $root
        if ($branchPath) {
            foreach ($pathPart in $branchPath) {
                $branchValue = $branchValue.$pathPart
            }
        }
        
        <#
        
        HERE I DO SOMETHING WITH THE VALUE
        
        #>
        
        
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
        }
    }
}