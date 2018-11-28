function Get-SettingsJsonFile ($filename) {
    $return = [PSCustomObject]@{}
    try {
        $file = Get-Item $filename 
        $file_content = Get-Content $file
        $return = $file_content | ConvertFrom-Json
    }
    catch {
        Write-Output "An appropriate file did not exist"
    }
    return $return
}
function Out-SettingsJsonFile ($settings, $filename) {
    $return = $false
    try {
        $jsonSettings = $settings | ConvertTo-Json -Depth 100
        Set-Content $filename $jsonSettings
        $return = get-item $filename
    }
    catch {
        Write-Output "Failed to write file"
    }
    return $return
}