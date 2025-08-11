cd $PSScriptRoot
Import-Module ActiveDirectory
#$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name
$VMClients = Get-Content .\VMClients.txt
foreach ($VM in $VMClients)
{
$VMConn = New-PSSession -ComputerName $VM
write-host "Process on $VM"
icm -Session $VMConn { 
cd c:\DragonSlayerH6
Get-Process node | Stop-Process -Force
.\dragonslayerh6-kill.bat
}
Get-PSSession | Remove-PSSession
}
<#
Import-Module ActiveDirectory
$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name
#$VMClients = Get-Content .\VMClients.txt
#$ClientConn = New-PSSession -ComputerName "test"
foreach ($VM in $VMClients)
{
if (Test-Path "\\$VM\c$\test")
{
write-host "process on $VM"
Remove-Item \\$VM\c$\test -Recurse
}
}
#>
