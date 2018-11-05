function Expand-Tree ($leaf, $currentRoot) {
    $type = $leaf.psobject.typenames
    if ($type -eq "System.Management.Automation.PSCustomObject") {
        $contains = $leaf.psobject.properties
        $contains|ForEach-Object {
            $branch = $_
            $branchName = $branch.name
            $branchValue = $branch.value
            $branchPath = "$currentRoot.$branchName"
            Expand-Tree $branchValue $branchPath
        }
        $value = 'PSCustomObject'
    }
    else {
        $value = $leaf
    }
    return     [PSCustomObject]@{
        path = $currentRoot
        value = $value
    }
}