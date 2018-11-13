function Update-Tree {
    [CmdletBinding()]
    param ($wantedObject
        , $givenObject
        , $wantedObjectName
        , [bool]$wasComplete = $true
        , [int]$depth
    )
    $returnObject = $null
    $givenType = $givenObject.psobject.typenames
    $wantLeaf = ($wantedObject.psobject.typenames -notcontains "System.Management.Automation.PSCustomObject")
    $wantCustomSecureString = ($wantedObject -eq "Custom.SecureString")
    if ($wantCustomSecureString) {
        $wantedObject = "System.String"
    }
    $rightType = ($givenType -contains $wantedObject)
    if ($rightType) {
        $returnObject = $givenObject
    }
    else {
        if (!$wantLeaf) {
            $returnObject = [PSCustomObject]@{}
        }
        else {
            $wasComplete = $false
            $promtArgs = @{
                wantedTypeString         = $wantedObject
                wantedName               = $wantedObjectName
                currentValue             = $givenObject
                wantedCustomSecureString = $wantCustomSecureString
            }
            $returnObject = Get-PromptValue @promtArgs
        }
    }
    Write-Host $returnObject.gettype()
    return $returnObject
}