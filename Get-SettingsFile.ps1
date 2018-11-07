function Get-SettingsFile ($filename) {
    try {
        $file = Get-Item $filename 
        $file_content = Get-Content $file
        $return = $file_content | ConvertFrom-Json
    }
    catch{
        Write-Output "An appropriate file did not exist"
    }
    finally {
    }
    return $return
}