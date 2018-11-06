function Compare-Trees ($description, $root) {
    $description | ForEach-Object {
        $leaf = $_
        $leafPath = $leaf.path
        $leafPathString = $leaf.stringPath
        $leafType = $leaf.value
        $leafValue = $root
        if ($leafPath) {
            foreach ($pathPart in $leafPath) {
                $leafValue = $leafValue.$pathPart
            }
        }
        $isContainer = ($leafType -eq "System.Management.Automation.PSCustomObject")
        if (!$isContainer) {
            write-host "********$leafPathString********"
            if ($leafValue) {
                $valueType = $leafValue.psobject.typenames
                $rightType = ( $valueType -contains $leafType )
                if ($rightType) {
                    write-host $leafValue
                }
                else {
                    Write-Host "$leafValue is wrong type, should be $leafType"
                }
            }
            ELSE {
                write-host "No leaf value exists"
            }
        }
    }
}