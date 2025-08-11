cd $PSScriptRoot
$Group1 = Get-Content .\VMList.txt
$switch = 246
$vlanid = 256
foreach ($VM in $Group1)
{
New-Item -Path "D:\VM\$VM" -ItemType directory
Copy-Item -Path ".\hy-1.vhdx" -Destination "D:\VM\$VM"
New-VM -Name $VM -Path "D:\VM\" -Generation 1 -MemoryStartupBytes 2GB -VHDPath "D:\VM\$VM\hy-1.vhdx" -SwitchName $switch
Set-VMNetworkAdapterVlan -VMName $VM -Access -VlanId $vlanid
$VMCount = Get-ChildItem -Path "d:\vm"
if(($VMCount.count -eq "6") -or ($VMCount.count -eq "12") -or ($VMCount.count -eq "18") -or ($VMCount.count -eq "24") -or ($VMCount.count -eq "30"))
{
$switch++
$vlanid++
}
}
