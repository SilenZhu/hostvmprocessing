cd $PSScriptRoot
Import-Module ActiveDirectory
#$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name
$VMClients = Get-Content .\VMList.txt
foreach ($VM in $VMClients)
{
$VMconn = New-PSSession -ComputerName $VM
icm -Session $VMConn{
write-host "Process on $env:COMPUTERNAME"
net use \\dc\ipc$ /user:vm\administrator 123QWEasd
Copy-Item c:\DragonSlayerH6\log \\dc\c$\426VMLogAll2\ -Recurse
Copy-Item c:\DragonSlayerH6\screenshots \\dc\c$\426VMSCAll2\ -Recurse
net use \\dc\ipc$ /delete
}
Get-PSSession | Remove-PSSession
}
