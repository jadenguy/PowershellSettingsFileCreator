function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$wantedCustomSecureString = $false
    )
    $ret = ($currentValue -as $wantedTypeString)
    if ($wantedCustomSecureString) {
        
    }
    while (!$ret) {
        $promptArgList = @{
            Prompt = "Enter a $wantedTypeString for $wantedName"
        }
        if  ($currentValue)
        {$promptArgList.Prompt += " (Was $currentValue)"}
        $prompt = (Read-Host @promptArgList ) 
        if (!$prompt) {$prompt = $currentValue} else {$currentValue = $prompt}
        $ret = ($prompt -as $wantedTypeString)
    }
    return $ret    
}