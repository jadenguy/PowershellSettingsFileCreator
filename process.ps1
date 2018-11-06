. ( join-path $PSScriptRoot "Get-SettingsFile")
. ( join-path $PSScriptRoot "Expand-Tree")
. ( join-path $PSScriptRoot "Compare-Trees")

$settingsRequired = [PSCustomObject]@{
    prod = [PSCustomObject]@{ 
        cred     = [PSCustomObject]@{
            this = [PSCustomObject]@{
                user = 'System.String'; 
                pass = 'System.String'; 
            }; 
        };
        settings = [PSCustomObject]@{
            count = 'System.Int32';
            times = 'System.Int32'; 
        }; 
        n = 'System.Int32';
    }; 
};

$settingsFile = Get-SettingsFile "settings.json"
$settingsDescription = expand-tree $settingsRequired | Sort-Object stringPath
Compare-Trees $settingsDescription $settingsFile