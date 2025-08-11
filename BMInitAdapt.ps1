[int]$ipAmount = 3
[int]$PCPerRoute = 20
[int]$hostNum = Read-Host "记得确认已经手动清空默认网关
脚本机位数量:$ipAmount,每个路由服务器数量:$PCPerRoute 请输入服务器编号"
$adaptName = $hostNum
$adaptNum = ($hostNum * $ipAmount - $ipAmount + 1)
#这样可以清掉默认网关参数但是由于windows bug 没有重启的情况下 之后设置时会报默认网关已存在导致无法设置故增加禁用启用操作
$Adapter = Get-WmiObject -Class Win32_NetworkAdapter -Filter "NetConnectionID='$adaptName'"
$Nic = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "Index=$($Adapter.Index)"
$Nic.EnableDhcp() | Out-Null
Disable-NetAdapter -Name $adaptName -Confirm:$false
Enable-NetAdapter -Name $adaptName -Confirm:$false
Disable-NetAdapter -Name $adaptName -Confirm:$false
$curAdapts = (Get-NetAdapter|select name).name
foreach($adapt in $curAdapts){
if($adapt -ne $adaptName){
Disable-NetAdapter $adapt -Confirm:$false
}else{
Enable-NetAdapter $adapt -Confirm:$false
}
}
$routeNum = [math]::Floor(($hostNum-1) / $PCPerRoute)
$primaryIP = "10."+ $routeNum + "." + $adaptNum + ".10"
$gatewayIP = ("10."+ $routeNum + ".0.1")
$newAdaptName = "$adaptNum-"+($adaptNum + $ipAmount -1)
$adapt = Get-NetAdapter -name $adaptName
$adapt | Rename-NetAdapter -NewName $newAdaptName
$adapt = Get-NetAdapter -name $newAdaptName
$adapt | Disable-NetAdapterBinding -ComponentID ms_tcpip6
$adapt | Remove-NetIPAddress -IPAddress * -Confirm:$False
$adapt | New-NetIPAddress -IPAddress $primaryIP -PrefixLength 16 -DefaultGateway $gatewayIP
Set-DnsClientServerAddress -InterfaceIndex ($adapt.ifIndex) -ServerAddresses $gatewayIP,'114.114.114.114'
for([int]$i = 1;$i -lt $ipAmount;$i++){
$attendIP = "10.$routeNum."+($adaptNum+$i)+".10"
$adapt | New-NetIPAddress -IPAddress $attendIP -PrefixLength 16
}