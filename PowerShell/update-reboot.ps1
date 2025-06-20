# Check if PSWindowsUpdate module is installed, if not install it
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "Installing PSWindowsUpdate module..."
    Install-Module -Name PSWindowsUpdate -Force -Confirm:$false
}

# Import the module
Import-Module PSWindowsUpdate

# Get available updates
Write-Host "Checking for available updates..."
$updates = Get-WindowsUpdate

if ($updates) {
    Write-Host "The following updates will be installed:"
    $updates | Format-Table -Property KB, Title

    # Install updates
    Install-WindowsUpdate -AcceptAll -AutoReboot -Confirm:$false
} else {
    Write-Host "Your system is up to date."
}