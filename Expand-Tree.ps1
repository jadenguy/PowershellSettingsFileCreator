function Expand-Tree ($leaf, $currentRootString, $currentRoot) {
    $type = $leaf.psobject.typenames
    if ($type -contains "System.Management.Automation.PSCustomObject") {
        $value = "System.Management.Automation.PSCustomObject"
        $contains = $leaf.psobject.properties
        $contains | ForEach-Object {
            $branch = $_
            $branchName = $branch.name
            $branchValue = $branch.value
            if ( $currentRoot) {
                $nextPathObject= @($currentRoot)
            }
            $nextPathObject+= @($branchName)
            $newCursor = $cursor * $contains.length + $i
            $nextPath = "$currentRootString.$branchName"
            Expand-Tree $branchValue $nextPath $nextPathObject
        }
    }
    else {
        $value = $leaf
    }
    $ret += [PSCustomObject]@{
        path  = $currentRoot
        value = $value
        stringPath = $currentRootString
    }    
    return $ret
}