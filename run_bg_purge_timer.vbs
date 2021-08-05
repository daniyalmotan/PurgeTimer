Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c C:\Users\dmotan\Documents\scriptest\PurgeTimer3.1\purge_timer_v3.1.bat"
oShell.Run strArgs, 0, false