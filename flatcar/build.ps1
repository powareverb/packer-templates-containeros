
# Get base production image file
# TODO: Test hash for e.g. newer version
if (!(Test-Path "./scripts/files/flatcar_production_image.bin.bz2")) {
    Write-Host "Downloading Flatcar binary image"
    wget -o ./scripts/files/flatcar_production_image.bin.bz2 https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_image.bin.bz2
}

# Get powershell if it's missing
if (!(Test-Path "./scripts/files/powershell.tar.gz")) {
    Write-Host "Downloading PowerShell binary install"
    wget -o ./scripts/files/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-linux-x64.tar.gz
}

# Get SeqCli if it's missing
if (!(Test-Path "./scripts/files/seqcli.tar.gz")) {
    Write-Host "Downloading Seq CLI binary install"
    wget -o ./scripts/files/seqcli.tar.gz https://github.com/datalust/seqcli/releases/download/v5.1.213/seqcli-5.1.213-linux-x64.tar.gz
}

Write-Host "Building Flatcar image"
packer build -force .\containeros-base.json
