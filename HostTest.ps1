cd $PSScriptRoot
Import-Module ActiveDirectory
$Hosts = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name | Sort-Object -Descending
Test-Connection -ComputerName $Hosts -Count 1 -ErrorVariable HostsError | Out-File .\HostTest.txt
$HostsError | Out-File .\HostErrorTest.txt

cd $PSScriptRoot
Import-Module ActiveDirectory
$Hosts = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name | Sort-Object
Test-Connection -ComputerName $Hosts -Count 1 -ErrorVariable HostsError
($HostsError).count
$HostsError | Out-File .\HostErrorTest.txt