function Expand-Tree ($leaf, [string]$currentRoot) {
    $type = $leaf.psobject.typenames
    if ($type -eq "System.Management.Automation.PSCustomObject") {
        $value = 'PSCustomObject'
        $contains = $leaf.psobject.properties
        $contains|ForEach-Object {
            $branch = $_
            $branchName = $branch.name
            $branchValue = $branch.value
            if ($currentRoot) {
                $branchPath = "$currentRoot.$branchName"
            }
            else {$branchPath = $branchName}
            Expand-Tree $branchValue $branchPath
        }
        
    }
    else {
        $value = $leaf
    }
    $ret = [PSCustomObject]@{
        path  = $currentRoot
        value = $value
    }    
    return $ret
}