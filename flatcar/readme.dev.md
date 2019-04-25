

Provisioners testing
{
      "type": "shell",
      "environment_vars": [
         "RANCHEROS_VERSION={{user `rancheros_version`}}",
         "VERSION={{user `rancheros_version`}}"
      ],
      "script": "./scripts/install2disk"
    }
    