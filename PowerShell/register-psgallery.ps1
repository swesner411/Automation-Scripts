# Register the PSGallery repository if not already registered
if (-not (Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue)) {
    Write-Host "Registering PSGallery repository..."
    Register-PSRepository -Default
}