function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$secureString = $false
    )
    $ret = ($currentValue -as $wantedTypeString)
    if ($secureString) {
        
    }
    while (!$ret) {
        $promptArgList = @{
            Prompt = "Enter a $wantedTypeString for $wantedName"
        }
        if ($currentValue) {
            $promptArgList.Prompt += " (Was $currentValue)"
        }
        if ($secureString) {
            $promptArgList += @{
                assecurestring = $true
            }
        }
        $prompt = (Read-Host @promptArgList ) 
        if (!$prompt) {
            $prompt = $currentValue
        }
        else {
            $currentValue = $prompt
        }
        if ($secureString) {
            $ret = $prompt| ConvertFrom-SecureString
        }
        else {
            $ret = ($prompt -as $wantedTypeString)
        }
    }
    return $ret
}