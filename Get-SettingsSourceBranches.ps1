function Get-SettingsDescriptorBranches ($settingsFileDescriptor) {
    return expand-tree $settingsFileDescriptor | Sort-Object path
}