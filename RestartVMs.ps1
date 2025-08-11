cd $PSScriptRoot
Import-Module ActiveDirectory
$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name | Sort-Object
#$VMClients = Get-Content .\TempVMsList.txt
foreach ($VM in $VMClients)
{
$VMconn = New-PSSession -ComputerName $VM
icm -Session $VMConn{
write-host "Process on $env:COMPUTERNAME"
Restart-Computer -Force
}
Get-PSSession | Remove-PSSession
}
