

https://releases.rancher.com/os/v1.5.1/iso-checksums.txt

Due to non availability of hyperv tools, can't get IP address so SSH provisioning doesn't work :/
https://github.com/rancher/os/issues/2058


 ros config set mounts '[["/dev/fd/0","/mnt/floppy","fat",""]]'


Get-VM | ?{$_.ReplicationMode -ne “Replica”} | Select -ExpandProperty NetworkAdapters | Select VMName, IPAddresses, Status
