$VMName = "k3os-buildtest"
$VMDefaultStorage = Resolve-Path "D:\vms\HyperV"
$VMBaseImage = "./output-hyperv-iso/Virtual Hard Disks/k3os-base.vhdx"
$VMDefaultSwitch = "External Switch"
$VMMemorySize=2GB
$Force=$true

Write-Host "Setting up VM $VMName"
$existing = Get-VM -Name $VMName -ErrorAction SilentlyContinue
if($existing -and $Force) {
    Write-Warning "Removing existing VM: $VMName"
    $existing | Stop-VM -ErrorAction SilentlyContinue
    $existing | Remove-VM -Force
}

Write-Information "Setting up VM storage: $VMName"
$VMDestPath = "$VMDefaultStorage/$VMName"
$VMDestFolder = New-Item -ItemType Directory -Path $VMDestPath -ErrorAction SilentlyContinue
$VMOSImageFile = "$VMDestPath/k3os-osdrive-$VMName.vhdx"

Copy-Item $VMBaseImage $VMOSImageFile -Force:$Force

$vm = New-VM -Name $VMName -VHDPath $VMOSImageFile  -SwitchName $VMDefaultSwitch -MemoryStartupBytes $VMMemorySize -Path $VMDestPath 
$vm | Start-VM

Write-Host "VM $VMName started"
