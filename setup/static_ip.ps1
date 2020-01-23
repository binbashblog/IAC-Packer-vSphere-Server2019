New-NetIPAddress -IPAddress 10.0.0.10 -DefaultGateway 10.0.0.5 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex
Set-DNSClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses "10.0.0.1 10.0.0.2"

$DNSSuffix = @("internal.int.com"),@("hosted.eu.int.com"),@("london.int.com"),@("us.int.com"),@("eu.int.com"),@("int.com")
Invoke-WmiMethod -path Win32_NetworkAdapterConfiguration -Name SetDNSSuffixSearchOrder -ArgumentList $DNSSuffix
