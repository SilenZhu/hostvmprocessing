$AllHosts = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name | Sort-Object #| Out-File c:\Hosts.txt
#$AllHosts = "HOST50"
#$AllHosts = Get-Content .\Hosts.txt
foreach ($Hosts in $AllHosts)
{
$HostsConn = New-PSSession -ComputerName $Hosts
    icm -Session $HostsConn {
        Get-VM -Name PC* | Stop-VM -force
        Get-PSSession | Remove-PSSession
    }
}