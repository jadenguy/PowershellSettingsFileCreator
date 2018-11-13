function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$wantedCustomSecureString = $false
    )
    do {
        $prompt = (Read-Host -Prompt "Enter a $wantedTypeString for $wantedName (Was $currentValue)") 
        if (!$Prompt){$prompt = $currentValue}
        $ret = ($prompt -as $wantedTypeString)
    } until ($ret)
    return $ret    
}