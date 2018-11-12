function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        [bool]$wantedCustomSecureString = $false
    )
    do {
    $prompt = (Read-Host)    
    $ret =  ($prompt -as $wantedTypeString)
    } until ($ret)
    
    return $ret    
}