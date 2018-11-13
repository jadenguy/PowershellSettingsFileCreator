function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$wantedCustomSecureString = $false
    )
    do {
        $prompt = (Read-Host -Prompt "Enter a $wantedTypeString for $wantedName (Was $currentValue)") 
        if (!$prompt){$prompt = $currentValue} else {$currentValue = $prompt}
        $ret = ($prompt -as $wantedTypeString)
    } until ($ret)
    return $ret    
}