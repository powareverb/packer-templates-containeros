
# Get base production image file

if (!(Test-Path "./scripts/files/flatcar_production_image.bin.bz2")) {
    Write-Host "Downloading Flatcar binary image"
    wget -o ./scripts/files/flatcar_production_image.bin.bz2 https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_image.bin.bz2
}

# Get powershell if it's missing
if (!(Test-Path "./scripts/files/powershell.tar.gz")) {
    Write-Host "Downloading PowerShell binary install"
    wget -o ./scripts/files/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-linux-x64.tar.gz
}

packer build .\containeros-base.json 
