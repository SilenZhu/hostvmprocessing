cd $PSScriptRoot
[int]$AdName = Read-Host "输入起始网卡名"
$i=($AdName+6)
for(;$AdName -lt $i;$AdName++){
$IpAdd = "192.168."+$AdName+".10"
[ipaddress]$DNSAdd ="192.168."+$AdName+".1"
Set-NetAdapter -Name $AdName -VlanID ($AdName+10) -Confirm:0
Set-NetAdapterAdvancedProperty -Name $AdName -RegistryKeyword "*PriorityVlanTag" -RegistryValue 2
Remove-NetIPAddress -InterfaceAlias $AdName -Confirm:0
New-NetIPAddress -InterfaceAlias $AdName -IPAddress $IpAdd -PrefixLength "24" 
Set-DnsClientServerAddress -InterfaceAlias $AdName -ServerAddresses ($DNSAdd.IPAddressToString,"114.114.114.114")
}



