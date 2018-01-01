#-----------------------------------------------------------------------
Write-Host ":-) Installing HeidiSQL Management Studio"

# Getting heidisql portable
if (Test-Path C:\installation\downloadcache\heidisql.zip) {
  Write-Host ":-)HeidiSQL was downloaded before. Not downloading again."
} else {  
  Write-Host ":-)Downloading HeidiSQL"
  Invoke-WebRequest "https://www.heidisql.com/downloads/releases/HeidiSQL_9.4_Portable.zip" -OutFile "C:\installation\downloadcache\heidisql.zip"
} 
md "c:\heidisql"

#unzipping the file including subfolders
$shell = New-Object -ComObject shell.application
$zip = $shell.NameSpace("C:\installation\downloadcache\heidisql.zip")
foreach ($item in $zip.items()) {
  $shell.Namespace("c:\heidisql").CopyHere($item)
}
#not using choco install since this version of heidisql was not working with Progres SQl when I tested it (01-Dec-2017)
#choco install heidisql
#del "$env:USERPROFILE\Desktop\HeidiSQL*.lnk"
#Pin Heidisql.exe to Windows Taskbar
#cmd /c c:\installation\syspin.exe "C:\Program Files\heidisql\heidisql.exe" c:5386

Write-Host ":-) Done installing HeidiSQL"
#-----------------------------------------------------------------------