#By Christof Schwarz
#-----------------------------------------------------------------------
Write-Host ":-) Installing MongoDB"
#-----------------------------------------------------------------------
choco install mongodb.install --version 3.4.5 
#The mashup didn't work with version 3.6 
mkdir "c:\data"
mkdir "c:\data\db"

# this gets the (only) children of folder c:\Program Files\MongoDB\Server which is "3.4" 
$mongoversion = (get-Childitem "c:\Program Files\MongoDB\Server").Name

#Pin MongoD.exe to Windows Taskbar
#cmd /c c:\installation\syspin.exe "C:\Program Files\MongoDB\Server\$mongoversion\bin\mongod.exe" c:5386

#adding the mongo path to the environment variable PATH 
$oldPath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "PATH").Path
$newPath = ($oldPath + ";C:\Progra~1\MongoDB\Server\$mongoversion\bin").Replace(";;", ";")
Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "PATH" -Value $newPath
Write-Host ":-) Making MongoDB a Windows Service"
cd "C:\Progra~1\MongoDB\Server\$mongoversion\bin"
.\mongod.exe --dbpath=C:\data --logpath=C:\data\log.txt --install
#start cmd  "/c C:\Progra~1\MongoDB\Server\$mongoversion\bin\mongod.exe"
Set-Service -Name "MongoDB" -StartupType automatic
net start MongoDB
Write-Host ":-) Done installing MongoDB"
