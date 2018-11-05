. ( join-path $PSScriptRoot "Get-SettingsFile")
. ( join-path $PSScriptRoot "Expand-Tree")
. ( join-path $PSScriptRoot "Get-SettingsSourceBranches")

$settingsFileDescriptor = [PSCustomObject]@{
    prod = [PSCustomObject]@{ 
        cred     = [PSCustomObject]@{
            this = [PSCustomObject]@{
                user = 'String'; 
                pass = 'String'; 
            }; 
        };
        settings = [PSCustomObject]@{
            count = 'Int';
            times = 'Int'; 
        }; 
        n = 'Int';
    }; 
}
$settingsFile = Get-SettingsFile "settings.json"
Get-SettingsDescriptorBranches $settingsFileDescriptor