function Get-SettingsFile ($filename) {
    try {
        $file = Get-Item $filename 
        $file_content = Get-Content $file
        $return = $file_content | ConvertFrom-Json
    }
    finally {
    }
    return $return
}
