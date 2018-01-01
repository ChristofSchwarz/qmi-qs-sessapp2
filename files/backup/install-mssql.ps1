#By Christof Schwarz
#-----------------------------------------------------------------------
Write-Host ":-) Installing SQL Server Express (ca 450 MB)"
choco install sql-server-express -y -ia "/IACCEPTSQLSERVERLICENSETERMS /Q /ACTION=install /INSTANCENAME=SQLExpress /TCPENABLED=1 /SECURITYMODE=SQL /SAPWD=Qlik1234"
Write-Host ":-) Done installing SQL Server Express"
#-----------------------------------------------------------------------
#Write-Host ":-) Installing SQL Server Management Studio (ca 850 MB)"
#this package is too big. using lightweight heidisql instead
#choco install mssqlservermanagementstudio2014express
#start-Sleep -s 3

# Getting energy database
if (Test-Path C:\installation\energy.zip) {
  Write-Host ":-)Energy Database Zip file was downloaded before. Not downloading again."
} else {  
  Write-Host ":-)Downloading Energy Database - MS-SQL Backup File (zipped 63 MB)"
  Invoke-WebRequest "https://www.dropbox.com/sh/a1e8g7my3n9h10d/AACn7WOu1SBJ1XcQ1hDtlUNOa?dl=1" -OutFile "C:\installation\energy.zip"
  #https://www.dropbox.com/sh/a1e8g7my3n9h10d/AACn7WOu1SBJ1XcQ1hDtlUNOa?dl=0
} 
Write-Host ":-)Extracting .bak file from energy.zip"
if (Test-Path C:\installation\energy.bak) { del "c:\installation\energy.bak" }
$shell = New-Object -ComObject shell.application
$zip = $shell.NameSpace("C:\installation\energy.zip")
foreach ($item in $zip.items()) {
  $shell.Namespace("c:\installation\").CopyHere($item)
}
# choco install sqlserver-cmdlineutils
# C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD ???
Write-Host ":-)Restoring energy database in MS-SQL Server"
mkdir "c:\mssql"
$sqlcmdpath = (dir -Path "C:\Program Files\Microsoft SQL Server" -Filter SQLCMD.EXE -Recurse).Directory.FullName #find location of SQLCMD.EXE
Write-Host "SQLCMD.EXE found in $sqlcmdpath"
cd "$sqlcmdpath"
.\SQLCMD -E -S .\SQLEXPRESS -Q "RESTORE DATABASE energy FROM DISK='c:\installation\energy.bak' WITH MOVE 'energy' TO 'c:\mssql\energy.mdf', MOVE 'energy_log' TO 'c:\mssql\energy_log.ldf'"
Write-Host ":-)Done mounting energy database in MS-SQL Server"
