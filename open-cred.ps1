function Get-CredFile ($filename) {
    try {
        $file = Get-Item $filename 
        $file_content = Get-Content $file
        $return = $file_content | ConvertFrom-Json
    }
    finally {
    }
    return $return
}

$settingFileDescriptor = [PSCustomObject]@{ prod = [PSCustomObject]@{ 
        cred        = [PSCustomObject]@{
            this = [PSCustomObject]@{
                user = 'String'; 
                pass = 'String'; 
            }; 
        }; settings = [PSCustomObject]@{
            count = 'Int';
            times = 'Int'; 
        }; 
    }; 
}

$settingFile = Get-CredFile "creds.json"

function branches ($tree) {
    $tree.psobject.properties | ForEach-Object {
        $_
    }
    
}
branches $settingFileDescriptor
branches $settingFile