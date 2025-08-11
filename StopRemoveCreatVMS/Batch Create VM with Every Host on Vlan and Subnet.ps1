Import-Module Hyper-V
#$HostsName = (Get-ADComputer -Filter * -Properties name -SearchBase "OU=Hosts,DC=vm,DC=local" | select name).name | Sort-Object
$HostsName = "Host01","Host02","Host03","Host04","Host05"
$VMTotal = 1 .. 5
$n = 1
$Subid = 1
$Vlanid = 11
foreach($Hosts in $HostsName)
{
foreach ($VM in $VMTotal)
{

    if($n -le 9)
    {
    $VMName = "PC00"
	$VMs = "$VMName" + "$n"
	Write-Progress -Activity "Batch create VM" -Status "Creating $VMs on $Hosts" -PercentComplete ($VM/($VMTotal).count * 100)`
	-CurrentOperation "$VMs"
    New-Item -Path "D:\VM\$VMs" -ItemType directory
    Copy-Item -Path "D:\VM\Template\hy-1.vhdx" -Destination "D:\VM\$VMs"
    New-VM -Generation 1 -Path "D:\VM"  -Name $VMs -MemoryStartupBytes 16GB -VHDPath "D:\VM\$VMs\hy-1.vhdx" -SwitchName "192.168.$Subid"
    Set-VM -Name $VMs -ProcessorCount 8
    Set-VMNetworkAdapterVlan -VMName $VMs -Access -VlanId $Vlanid
    Start-VM -Name $VMs
    #write-host "$VMs on Vlan$Vlanid and subnet is $Subid on $Hosts"
    #sleep 1
	}
    else
    {
    $VMName = "PC0"
	$VMs = "$VMName" + "$n"
	Write-Progress -Activity "Batch create VM" -Status "Creating $VMs on $Hosts" -PercentComplete ($VM/($VMTotal).count * 100)`
	-CurrentOperation "$VMs"
    New-Item -Path "D:\VM\$VMs" -ItemType directory
    Copy-Item -Path "D:\VM\Template\hy-1.vhdx" -Destination "D:\VM\$VMs"
    New-VM -Generation 1 -Path "D:\VM"  -Name $VMs -MemoryStartupBytes 16GB -VHDPath "D:\VM\$VMs\hy-1.vhdx" -SwitchName "192.168.$Subid"
    Set-VM -Name $VMs -ProcessorCount 8
    Set-VMNetworkAdapterVlan -VMName $VMs -Access -VlanId $Vlanid
    Start-VM -Name $VMs
    #write-host "$VMs on Vlan$Vlanid and subnet is $Subid on $Hosts"
    #sleep 1
    }
    $n++
    $Subid++
    $Vlanid++
    }
}
