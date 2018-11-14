$hwint = @{
    wantedTypeString         = "System.Int32"
    currentValue             = '1'
    wantedName               = 'hwint'
    wantedCustomSecureString = $false
}
$hstringwint = @{
    wantedTypeString         = "System.Int32"
    currentValue             = 'asdf'
    wantedName               = 'hstringwint'
    wantedCustomSecureString = $false
}
$password = @{
    wantedTypeString         = "System.String"
    currentValue             = ''
    wantedName               = 'password'
    wantedCustomSecureString = $true
}

Get-PromptValue @hwint

Get-PromptValue @hstringwint
Get-PromptValue @password