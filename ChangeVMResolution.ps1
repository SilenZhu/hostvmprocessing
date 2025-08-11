cd $PSScriptRoot
Import-Module ActiveDirectory
#$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name | Sort-Object
$VMClients = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Temp,DC=vm,DC=local" | select name).name | Sort-Object
#$VMClients = "PC071","PC072","PC073","PC074","PC075","PC092","PC169","PC194"
foreach ($VM in $VMClients)
{
$VMconn = New-PSSession -ComputerName $VM
icm -Session $VMConn{
write-host "Process on $env:COMPUTERNAME"
if (!(Test-Path C:\Set-ScreenResolution.ps1))
{
net use \\host50\ipc$ /user:vm\administrator 123QWEasd
Copy-Item \\host50\D$\filestation\Resolution\Set-ScreenResolution.PS1 c:\ -Recurse
Copy-Item \\host50\D$\filestation\Resolution\Resolution.bat "c:\Users\Win7\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Recurse
net use \\host50\ipc$ /delete
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Restart-Computer -Force
#Remove-Item -Path C:\Activation -Recurse
}
else {write-host "Set-ScreenResolution file is exsite"}
}
Get-PSSession | Remove-PSSession
}