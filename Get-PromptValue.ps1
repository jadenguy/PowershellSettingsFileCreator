function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$wantedCustomSecureString = $false
    )
    do {
        
        $prompt = (Read-Host -Prompt "$wantedType $wantedObjectName")    
        $ret = ($prompt -as $wantedTypeString)
    } until ($ret)
    return $ret    
}