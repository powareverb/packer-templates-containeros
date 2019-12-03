$vmbaseFolder="D:\vms\HyperV\"
$vmbaseName="rostest"
$vmtestName="$vmbaseName-1"
$vmtestSwitch="External Switch"
$buildout = "./output-hyperv-iso/Virtual Hard Disks/rancheros-base.vhdx"

$vmDestDir = Join-Path $vmbaseFolder $vmtestName
$nope = mkdir ($vmDestDir) -ErrorAction SilentlyContinue
$vmDestFile = Join-Path $vmDestDir "rancheros-$vmtestName.vhdx"
Write-Host "Copying to VM dir: $vmDestDir"
cp $buildout $vmDestFile

# Create a basic VM and get it started
$vms = (Get-VM)
$testvm = $vms | ?{ $_.Name -eq $vmtestName }
if($testvm)
{
    Write-Host "Stopping and removing existing VM: $vmtestName"
}

# 
Write-Host "Setting up new VM: $vmtestName"
$vm = New-VM -Name $vmtestName -SwitchName $vmtestSwitch -VHDPath $vmDestFile

