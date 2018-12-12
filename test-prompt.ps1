function test-prompt() {
    $hwint = @{
        wantedTypeString = "System.Int32"
        currentValue     = 9999
        wantedName       = 'hwint'
    }
    $hstringwint = @{
        wantedTypeString = "System.Int32"
        currentValue     = 'asdf'
        wantedName       = 'hstringwint'
    }
    $password = @{
        wantedTypeString = "System.String"
        currentValue     = ''
        wantedName       = 'password'
        secureString     = $true
    }
    $secureString = @{
        wantedTypeString = "System.Security.SecureString"
        currentValue     = ''
        wantedName       = 'password'
    }
    $creds = @{
        wantedTypeString = "System.Management.Automation.PSCredential"
        currentValue     = ''
        wantedName       = 'freshCredentials'
        secureString     = $false
    }
    $pscreds = @{
        wantedTypeString = "System.Management.Automation.PSCredential"
        currentValue     = @{
            PSCredential = (New-Object pscredential "asdfasdf", $("01000000d08c9ddf0115d1118c7a00c04fc297eb010000004f1c81dac33ff54a989fed091dd7498f0000000002000000000003660000c00000001000000091d9ed4f1d8cb60fa507ebaea7ddd8a10000000004800000a000000010000000da68444584d70ba6a68dbfcb0ecac4dc1800000067995daf78386b69af814e4cfac4b9ef2c4a759ae5274fd114000000d59d928bec11b109add4388b62b1bbce75efbe61"|ConvertTo-SecureString))
            username     = "asdfasdf"
            password     = "01000000d08c9ddf0115d1118c7a00c04fc297eb010000004f1c81dac33ff54a989fed091dd7498f0000000002000000000003660000c00000001000000091d9ed4f1d8cb60fa507ebaea7ddd8a10000000004800000a000000010000000da68444584d70ba6a68dbfcb0ecac4dc1800000067995daf78386b69af814e4cfac4b9ef2c4a759ae5274fd114000000d59d928bec11b109add4388b62b1bbce75efbe61"
        }
        wantedName       = 'providedCredentials'
        secureString     = $false
    }
    $pscreds2 = @{
        wantedTypeString = "System.Management.Automation.PSCredential"
        currentValue     = @{
            username = "asdfasdfasdf"
            password = "01000000d08c9ddf0115d1118c7a00c04fc297eb010000004f1c81dac33ff54a989fed091dd7498f0000000002000000000003660000c000000010000000322daab9b159aa368fbaf7aa8ce5fcee0000000004800000a000000010000000902e81bf32ba565f4fd01d1bdabbfa25080000004ba426c58fd74f1f14000000a6b3868c968465f1c706a5f7f149637df2e33e0d"
        }
        wantedName       = 'cred'
        secureString     = $false
    }
    $pscreds3 = @{
        wantedTypeString = "System.Management.Automation.PSCredential"
        currentValue     = @{
            username = "asdfasdfasdfasdfasdf"
        }
        wantedName       = 'cred'
        secureString     = $false
    }
    $pscreds4 = @{
        wantedTypeString = "System.Management.Automation.PSCredential"
        currentValue     = @{
            username = "asdfasdfasdfasdfasdf"
        }
        wantedName       = 'cred'
        secureString     = $false
    }
    Get-PromptValue @hwint
    Get-PromptValue @hstringwint
    Get-PromptValue @password
    Get-PromptValue @secureString
    Get-PromptValue @creds
    Get-PromptValue @pscreds
    Get-PromptValue @pscreds2
    Get-PromptValue @pscreds3
    Get-PromptValue @pscreds4
}