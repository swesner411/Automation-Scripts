# Check if NuGet provider is installed
$nuget = Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue

if (-not $nuget) {
    Write-Host "NuGet provider not found. Installing..."
    
    # Install NuGet provider
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser

    # Re-import the provider to ensure it's available
    Import-PackageProvider -Name NuGet -Force

    Write-Host "NuGet provider installed successfully."
} else {
    Write-Host "NuGet provider is already installed."
}