
# Get base production image file
mkdir ./scripts/downloads/ -ErrorAction SilentlyContinue | Out-Null

if (!(Test-Path "./scripts/downloads/k3os.iso")) {
    Write-Host "Downloading k3s iso"
    wget -o ./scripts/downloads/k3os.iso https://github.com/rancher/k3os/releases/download/v0.2.0-rc2/k3os.iso
}

Get-FileHash .\scripts\downloads\k3os.iso -Algorithm md5

packer build .\k3os-base.json 
