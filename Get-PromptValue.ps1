function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$wantedCustomSecureString = $false
    )
    do {
        
        $prompt = (Read-Host -Prompt "$wantedTypeString $wantedName")    
        $ret = ($prompt -as $wantedTypeString)
    } until ($ret)
    return $ret    
}