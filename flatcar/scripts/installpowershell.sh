#!/bin/sh

set pfx=/mnt

# Download the powershell '.tar.gz' archive
#curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-linux-x64.tar.gz

# Create the target folder where powershell will be placed
mkdir -p /opt/microsoft/powershell/6.1.0

# Expand powershell to the target folder
tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/6.1.0

# Set execute permissions
chmod +x /opt/microsoft/powershell/6.1.0/pwsh

# Create the symbolic link that points to pwsh
# Doesn't work as /usr/bin is readonly...
#ln -s /opt/microsoft/powershell/6.1.0/pwsh /usr/bin/pwsh
# Instead, add this as an alias in user file...

# Set alias for core user
# DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

exit
