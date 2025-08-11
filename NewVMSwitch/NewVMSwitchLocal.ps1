$NetAdapterNum = 194
for($j = 0 ; $j -lt 6 ; $j ++){
$NetAdapter =$NetAdapterNum - $j 
write-host "Process on $PCName $NetAdapter"
New-VMSwitch $NetAdapter -NetAdapterName $NetAdapter -AllowManagementOS $false
sleep 20
}