function test-prompt() {
    $hwint = @{
        wantedTypeString         = "System.Int32"
        currentValue             = 9999
        wantedName               = 'hwint'
        secureString = $false
    }
    $hstringwint = @{
        wantedTypeString         = "System.Int32"
        currentValue             = 'asdf'
        wantedName               = 'hstringwint'
        secureString = $false
    }
    $password = @{
        wantedTypeString         = "System.String"
        currentValue             = ''
        wantedName               = 'password'
        secureString = $true
    }
    Get-PromptValue @hwint
    Get-PromptValue @hstringwint
    Get-PromptValue @password
}