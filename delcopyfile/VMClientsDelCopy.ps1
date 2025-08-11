cd $PSScriptRoot
Import-Module ActiveDirectory
#(Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name | out-file .\VMClients.txt
#$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name
$VMClients = Get-Content .\VMClients.txt
#$VMClients = "PC084"
#$ClientConn = New-PSSession -ComputerName "test"
foreach ($VM in $VMClients)
{
if (Test-Path "\\$VM\c$")
{
write-host "process on $VM"
Remove-Item \\$VM\c$-Recurse
Copy-Item c:\conf \\$VM\c$\ -Recurse
}
else
{
write-host "process on $VM"
Copy-Item c:\conf \\$VM\c$\ -Recurse
}
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
