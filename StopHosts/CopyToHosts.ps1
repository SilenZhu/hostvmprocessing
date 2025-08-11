$HostList = Get-Content .\HostList.txt
foreach($hosts in $HostList){
Copy-Item c:\aida64 \\$hosts\c$\ -Recurse
}