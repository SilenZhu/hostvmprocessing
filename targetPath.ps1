cd $PSScriptRoot
Import-Module ActiveDirectory
$Cred = Get-Credential
$AllVM = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name
#$AllVM = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Temp,DC=vm,DC=local" | select name).name | Sort-Object -Descending
#$AllVM = "PC001"
foreach ($VM in $AllVM)
{
$VMConn = New-PSSession -ComputerName $VM
icm -Session $VMConn {
param ($Cred)
$DragonSources = (Get-ChildItem -Path C:\Dragon*).name
if ($DragonSources -ne "target")
{
Rename-Item -Path c:\$DragonSources -NewName "target"
}
}

}
#Test-Connection -ComputerName $Hosts -Count 1 | Out-File .\VMIPList.txt


