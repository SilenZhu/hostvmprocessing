Import-Module ActiveDirectory
$HostsName = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name #| Out-File .\HostList.txt
Get-WmiObject -Class win32_bios -ComputerName $HostsName | select PSComputerName,SMBIOSBIOSVersion,name | Sort-Object SMBIOSBIOSVersion | Out-File .\HostBios.txt 