

$VMName = "flatcar-buildtest"
$VMDefaultStorage = Resolve-Path "D:\vms\HyperV"
$VMBaseImage = "./output-hyperv-iso/Virtual Hard Disks/flatcar-base.vhdx"
$VMConfigDriveBase = "./scripts/files/config2_base.vhdx"
$VMConfigDriveSourceFile = "./scripts/files/user_data"
$VMDefaultSwitch = "External Switch"
$VMMemorySize=2GB
$Force=$true

# TODO: Generate user_data

if(!(Test-Path $VMConfigDriveBase)) {
    $configDriveSizeBytes = 50MB
    $cfgVHD = New-VHD -Path $VMConfigDriveBase -SizeBytes $configDriveSizeBytes
    $tempDisk = Mount-DiskImage (Resolve-Path $VMConfigDriveBase)
    if($tempDisk) {
        $tempDisk | Initialize-Disk -PartitionStyle GPT
        $disk = $tempDisk | Get-Disk
        $part = $disk | New-Partition -UseMaximumSize
        $part | Format-Volume -FileSystem FAT32
        $tempDisk | Dismount-DiskImage
    }
}

$existing = Get-VM -Name $VMName -ErrorAction SilentlyContinue
if($existing -and $Force) {
    Write-Warning "Removing existing VM: $VMName"
    $existing | Stop-VM
    $existing | Remove-VM -Force
}

Write-Information "Setting up VM storage: $VMName"
$VMDestPath = "$VMDefaultStorage/$VMName"
$VMDestFolder = New-Item -ItemType Directory -Path $VMDestPath -ErrorAction SilentlyContinue
$VMConfigImageFile = "$VMDestPath/config2-$VMName.vhdx"
$VMOSImageFile = "$VMDestPath/flatcar-os-$VMName.vhdx"
$VMConfigDriveFile = "$VMDestPath/user_data"
Copy-Item $VMBaseImage $VMOSImageFile -Force:$Force
Copy-Item $VMConfigDriveBase $VMConfigImageFile -Force:$Force
Copy-Item $VMConfigDriveSourceFile $VMConfigDriveFile -Force:$Force

# Got to be run as admin
$tempDrive = Mount-DiskImage $VMConfigImageFile
$volume = $tempDrive | Get-Disk | Get-Partition | Get-Volume
$driveLetter = $volume | Select-Object -ExpandProperty DriveLetter
if(!($driveLetter)) {
    # Write-Warning "Assigning missing drive letter"
    $diskNumber = ($tempDrive |Get-Disk).Number
    $partitionNumber = (Get-Partition -DiskNumber $diskNumber | Select -f 1).PartitionNumber
    if($diskNumber -and $partitionNumber) {
        Add-PartitionAccessPath -DiskNumber $diskNumber -PartitionNumber $partitionNumber -AssignDriveLetter
        $driveLetter = (Get-Partition -DiskNumber $diskNumber | Select -f 1).DriveLetter
    } else {
        throw "Error"
    }
}
$drivePath = "$($driveLetter):/"
# gci $drivePath
$destPath = New-Item -ItemType Directory -Path "$drivePath/openstack/latest/" -ErrorAction SilentlyContinue
Copy-Item $VMConfigDriveFile $destPath
$tempDrive | Dismount-DiskImage | Out-Null

$vm = New-VM -Name $VMName -VHDPath $VMOSImageFile  -SwitchName $VMDefaultSwitch -MemoryStartupBytes $VMMemorySize -Path $VMDestPath 
# Mount config drive
$vm | Add-VMHardDiskDrive -Path $VMConfigImageFile
$vm | Start-VM

