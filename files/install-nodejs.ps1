#By Christof Schwarz

#-----------------------------------------------------------------------
Write-Host ":-) Installing NodeJS"
#-----------------------------------------------------------------------
choco install nodejs


Write-Host ":-) Download Node application from github.com"

Invoke-WebRequest "https://github.com/kreta99/sessionapps/archive/master.zip" -OutFile "C:\installation\downloadcache\nodeapp.zip"

#unzipping the file including subfolders
$shell = New-Object -ComObject shell.application
$zip = $shell.NameSpace("C:\installation\downloadcache\nodeapp.zip")
foreach ($item in $zip.items()) {
  $shell.Namespace("c:\").CopyHere($item)
}
# now the zip folder is unpacked into c:\sessionapps-master
copy "c:\installation\nodeapp_cfg\config.json" "c:\sessionapps-master\public"

Write-Host ":-) Loading depending packages using npm"
cmd /c "c:\Program Files\nodejs\npm" install --prefix "c:\sessionapps-master" "c:\sessionapps-master"

Write-Host ":-) Starting NodeJS app"
cd "c:\sessionapps-master"
start "c:\Program Files\nodejs\node" "c:\sessionapps-master\app.js" 

#Create Desktop shortcut
#$Favorite = (New-Object -ComObject ("WScript.Shell")).CreateShortcut($env:USERPROFILE + "\Desktop\Session App.url")
#$Favorite.TargetPath = "http://qmi-qs-sessapp2:4000"
#$Favorite.Save()
Write-Host ":-) Done installing NodeJS and app"
#-----------------------------------------------------------------------

#Pinning Task Manager to Windows Taskbar
cmd /c c:\installation\syspin.exe "C:\Windows\System32\Taskmgr.exe" c:5386

