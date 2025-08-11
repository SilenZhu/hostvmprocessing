$HostsList= Get-Content .\HostList.txt 
foreach($HostsNum in $HostsList){
#$NetAdapterNum = ($HostsNum - 16) * 9
$i = [System.Convert]::ToInt32( $HostsNum )
$NetAdapterNum = $i * 6 + 26
$PCName = "host" + $HostsNum
for($j = 0 ; $j -lt 6 ; $j ++){
$NetAdapter =$NetAdapterNum - $j 
write-host "Process on $PCName $NetAdapter"
New-VMSwitch $NetAdapter -NetAdapterName $NetAdapter -ComputerName $PCName -AllowManagementOS $false
}
}