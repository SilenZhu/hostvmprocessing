cd $PSScriptRoot
Import-Module ActiveDirectory
$Cred = Get-Credential
$AllVM = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Temp,DC=vm,DC=local" | select name).name | Sort-Object -Descending
$VMHosts = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name | Sort-Object -Descending
foreach ($VMHost in $VMHosts)
{
$GetVMNames = (Get-VM -ComputerName $VMHost | select *).name
foreach ($VMName in $GetVMNames)
{
$GetVMMac = (Get-VM -ComputerName $VMHost -VMName $VMName | select -ExpandProperty NetworkAdapters | select *).macaddress
foreach ($VM in $AllVM)
{
$GuestOSMac = (Get-WmiObject -ComputerName $VM -Class Win32_NetworkAdapter | ? {$_.NetEnabled -eq "True"} | select *).macaddress
$GuestOSMacResult = $GuestOSMac.replace(':','')
if ($GuestOSMacResult -eq $GetVMMac)
{
Rename-Computer -ComputerName $VM -NewName $VMName -DomainCredential $Cred -Restart -Force
}
}
}
}


