$AllHosts = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name | Sort-Object #| Out-File c:\Hosts.txt
#$AllHosts = Get-Content .\Hosts.txt
foreach ($Hosts in $AllHosts)
{
$HostsConn = New-PSSession -ComputerName $Hosts
icm -Session $HostsConn {
Get-VM -Name PC* | Stop-VM -Force
#Get-VM -Name PC* | Start-VM
Get-VM -Name PC* | Remove-VM -Force
Get-ChildItem -Path "D:\VM\PC*" | Remove-Item -Recurse
Get-ChildItem -Path "C:\VM\PC*" | Remove-Item -Recurse
}
}