function Get-SettingsDescriptorBranches ($settingsFileDescriptor) {
    return expand-tree $settingsFileDescriptor 
}