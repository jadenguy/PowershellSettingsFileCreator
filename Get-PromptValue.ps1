function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$secureString = $false
    )
    $ret = ($currentValue -as $wantedTypeString)
    $wantedTypeStringDisplay = $wantedTypeString
    if ($wantedTypeString -eq "System.Security.SecureString") {
        $secureString = $true        
        $wantedTypeString = "System.String"
    }
    if ($wantedTypeString -eq "System.Management.Automation.PSCredential") {
        $cred = Get-Credential -Message "Enter a $wantedTypeStringDisplay for $wantedName"
        $ret = [PSCustomObject]@{
            pscredential = $cred
            username = $cred.username
            password = $cred.password|ConvertFrom-SecureString
        }
    } 
    while (!$ret) {
        $promptArgList = @{
            Prompt = "Enter a $wantedTypeStringDisplay for $wantedName"
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