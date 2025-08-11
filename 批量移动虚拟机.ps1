cd "c:\windows\system32"
for ($i=30; $i -lt 35; $i++ ){
move-vmstorage PC0$i "c:\vm\PC0$i"}
pause