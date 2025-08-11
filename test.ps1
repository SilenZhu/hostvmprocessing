if (Test-Path "\\test\c$\DragonSlayerH6\conf")
{
write-host "process on test"
Remove-Item \\test\c$\DragonSlayerH6\conf -Recurse
Copy-Item c:\conf \\test\c$\DragonSlayerH6\ -Recurse
}
else
{
write-host "process on test"
Copy-Item c:\conf \\test\c$\DragonSlayerH6 -Recurse
}