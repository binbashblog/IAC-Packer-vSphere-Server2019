$ErrorActionPreference = "Stop"
Start-Sleep -s 10
# Switch network connection to private mode for WinRM
$profile = Get-NetConnectionProfile
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private
# Disable Windows Firewall
# Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Enable Remote Desktop
#Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Type DWord -Value 0
#Enable-NetFirewallRule -DisplayName 'Remote Desktop - User Mode (TCP-in)'

# Enable WinRM service
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Set power plan to High Performance
#$powerPlan = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter "ElementName = 'High Performance'"
#$powerPlan.Activate()

# Reset auto logon count
# https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-logoncount#logoncount-known-issue
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0

# Clear all windows event logs
#wevtutil el | Foreach-Object {wevtutil cl "$_"}