function Get-PromptValue {
    [CmdletBinding()]
    param ($wantedTypeString,
        $currentValue,
        $wantedName,
        [bool]$secureString = $false
    )
    $wantedTypeStringDisplay = $wantedTypeString
    if ($wantedTypeString.split(".") -contains "SecureString") {
        $secureString = $true        
        $wantedTypeString = "System.String"
    }
    $ret = ($currentValue -as $wantedTypeString)
    if ($wantedTypeString.split(".") -contains "PSCredential") {
        if ($currentValue.PSCredential.psobject.typenames -contains "System.Management.Automation.PSCredential") {
            $cred = $currentValue.PSCredential
        }
        elseif ($currentValue.Username -and $($currentValue.Password|ConvertTo-SecureString -ErrorAction SilentlyContinue)) {
            $cred = (New-Object pscredential $currentValue.Username, $($currentValue.Password|ConvertTo-SecureString))
        }
        if (!$cred) {
            $cred = Get-Credential -Message "Enter credentials for $wantedName" -UserName $currentValue.Username
        }
        $ret = [PSCustomObject]@{
            PSCredential = $cred
            Username     = $cred.username
            Password     = $cred.password|ConvertFrom-SecureString
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