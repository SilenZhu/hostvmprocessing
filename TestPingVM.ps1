cd $PSScriptRoot
Import-Module ActiveDirectory
#$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name
$VMClients = Get-Content .\VMList.txt
foreach ($VM in $VMClients)
{
$VMConn = New-PSSession -ComputerName $VM
write-host "Process on $VM"
$PingResult = icm -Session $VMConn { 
Test-Connection www.baidu.com -Count 1
}
$PingResult | Out-File .\VMPintTestResult.txt -Append
Get-PSSession | Remove-PSSession
}
<#
$VMConn = New-PSSession -ComputerName PC0990
write-host "Process on PC0990"
icm -Session $VMConn { 
Test-Connection www.baidu.com -Count 2
}
Get-PSSession | Remove-PSSession
#>