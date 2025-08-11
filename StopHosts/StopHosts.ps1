cd $PSScriptRoot
$HostList = Get-Content .\HostList.txt
foreach($hosts in $HostList){
Stop-Computer -ComputerName $hosts -force
Write-Host 
}