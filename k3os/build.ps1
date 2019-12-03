
# Get base production image file
mkdir ./scripts/downloads/ -ErrorAction SilentlyContinue | Out-Null

$k3osversion="0.7.1"

# Done as part of the packer provision anyhow
# New-Item -Path "./scripts/downloads/$k3osversion/" -ItemType Directory -Force | Out-Null
# if (!(Test-Path "./scripts/downloads/$k3osversion/k3os.iso")) {
#     Write-Host "Downloading k3s iso"
#     # wget -o ./scripts/downloads/k3os.iso https://github.com/rancher/k3os/releases/download/v0.2.0-rc2/k3os.iso
#     wget https://github.com/rancher/k3os/releases/download/v0.7.1/k3os-amd64.iso
#     Move-Item k3os-amd64.iso ./scripts/downloads/$k3osversion/k3os.iso
# }

# # Compare hashes

# $currentHash = Get-FileHash .\scripts\downloads\k3os.iso -Algorithm md5
# $versionHash = Get-FileHash .\scripts\downloads\$k3osversion\k3os.iso -Algorithm md5

# if($currentHash -ne $versionHash) {
#     Copy-Item ".\scripts\downloads\$k3osversion\k3os.iso" ".\scripts\downloads\k3os.iso" -Force
# }

# TODO: Look at a fully automated install usning cmdline
# https://github.com/rancher/k3os/blob/master/README.md
# k3os.install.config_url

packer build -force .\k3os-base.json
