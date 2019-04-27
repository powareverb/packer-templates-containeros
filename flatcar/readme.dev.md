

Provisioners testing
{
      "type": "shell",
      "environment_vars": [
         "RANCHEROS_VERSION={{user `rancheros_version`}}",
         "VERSION={{user `rancheros_version`}}"
      ],
      "script": "./scripts/install2disk"
    }

https://docs.flatcar-linux.org/os/migrating-to-clcs/
https://docs.flatcar-linux.org/ignition/network-configuration/

TODO Ignition:
- Powershell aliases?
- Set IP Address
- Set hostname

Further:
- Seed vs cluster setup
- Bootstrap configs?
