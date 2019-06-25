
#$POWERSHELL_VERSION="6.1.0"
$POWERSHELL_VERSION="6.2.0"
$SEQCLI_VERSION="5.1.213"

# Get base production image file
# TODO: Test hash for e.g. newer version
if (!(Test-Path "./scripts/files/flatcar_production_image.bin.bz2")) {
    Write-Host "Downloading Flatcar binary image"
    wget -o ./scripts/files/flatcar_production_image.bin.bz2 https://stable.release.flatcar-linux.net/amd64-usr/current/flatcar_production_image.bin.bz2
}

# Get powershell if it's missing
if (!(Test-Path "./scripts/files/powershell.tar.gz")) {
    Write-Host "Downloading PowerShell binary install"
    wget -o ./scripts/files/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v$POWERSHELL_VERSION/powershell-$POWERSHELL_VERSION-linux-x64.tar.gz
}

# Get SeqCli if it's missing
if (!(Test-Path "./scripts/files/seqcli.tar.gz")) {
    Write-Host "Downloading Seq CLI binary install"
    wget -o ./scripts/files/seqcli.tar.gz https://github.com/datalust/seqcli/releases/download/v$SEQCLI_VERSION/seqcli-$SEQCLI_VERSION-linux-x64.tar.gz
}

# HyperV Tools
if (!(Test-Path "./scripts/files/hv_kvp_daemon")) {
    Write-Host "Downloading hv_kvp_daemon"
    docker build -f .\Prerequisites.Dockerfile -t docker-hyperv-tools .
    docker run -v ${PWD}/scripts/files:/mnt/ docker-hyperv-tools cp /usr/lib/linux-tools-4.4.0-151/hv_kvp_daemon /mnt
}

Write-Host "Building Flatcar image"
packer build -force .\containeros-base.json
