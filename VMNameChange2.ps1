cd $PSScriptRoot
Import-Module ActiveDirectory
$Cred = Get-Credential
#$AllVM = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=VMs,DC=vm,DC=local" | select name).name | Out-File .\vmoklist.txt Sort-Object -Descending
$AllVM = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Temp,DC=vm,DC=local" | select name).name | Sort-Object -Descending
#$AllVM = Get-Content .\VMNameChange.txt
#$AllVM = "WIN7-OG8BPSTH78"
foreach ($VM in $AllVM)
{
$VMConn = New-PSSession -ComputerName $VM
icm -Session $VMConn {
param ($Cred)
$IP = [System.Net.Dns]::GetHostAddresses($env:COMPUTERNAME).IPAddressToString
[int]$VMNum = ($IP[0].split("."))[2]
[int]$169 = ($IP[0].split("."))[1]
if ($169 -eq 168)
{
if($VMNum -le 9)
    {
    $VMName = "PC00$VMNum"
	Rename-Computer -NewName $VMName -DomainCredential $Cred -Restart -Force
    sleep 5
	}
    elseif ($VMNum -le 99)
    {
    $VMName = "PC0$VMNum"
	Rename-Computer -NewName $VMName -DomainCredential $Cred -Restart -force
sleep 5
    }
    else
    {
    $VMName = "PC$VMNum"
	Rename-Computer -NewName $VMName -DomainCredential $Cred -Restart -force
    }
}
else
{
$VMNum += 254
if($VMNum -le 9)
    {
    $VMName = "PC00$VMNum"
	Rename-Computer -NewName $VMName -DomainCredential $Cred -Restart -Force
	}
    elseif ($VMNum -le 99)
    {
    $VMName = "PC0$VMNum"
	Rename-Computer -NewName $VMName -DomainCredential $Cred -Restart -force
    }
    else
    {
    $VMName = "PC$VMNum"
	Rename-Computer -NewName $VMName -DomainCredential $Cred -Restart -force
    }
}
} -ArgumentList $Cred
}
#Test-Connection -ComputerName $Hosts -Count 1 | Out-File .\VMIPList.txt


