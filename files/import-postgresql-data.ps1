#By Christof Schwarz
#-----------------------------------------------------------------------

# Getting energy database
if (Test-Path C:\installation\downloadcache\postgres.pgdump) {
  Write-Host ":-)Energy Database dump was downloaded before. Not downloading again."
} else {  
  Write-Host ":-)Downloading Energy Database dump from dropbox (25 MB)"
  Invoke-WebRequest "https://www.dropbox.com/s/avjkxs8z8onx74s/postgres.pgdump?dl=1" -OutFile "C:\installation\downloadcache\postgres.pgdump"
  # https://www.dropbox.com/sh/crz4xibocca9hxy/AABDzDGY5rG_nwdOqPWe2blMa?dl=0
} 

Write-Host ":-) importing energy data dump"
#find path where pg_restore.exe is found 
$pgcmdpath = (dir -Path "C:\Program Files\Qlik\Sense\Repository" -Filter pg_restore.EXE -Recurse).Directory.FullName 
cd "$pgcmdpath"

#using pg_restore.exe to get table energydata from a postgres dump 
cmd /c "SET PGPASSWORD=Qlik1234&&pg_restore.exe -h localhost -p 4432 -U qliksenserepository -t energydata -d postgres C:\installation\downloadcache\postgres.pgdump"

# to produce a new dump call from CMD: (this will export entire "postgres" public database)
# pg_dump.exe -h localhost -p 4432 -U qliksenserepository -Fc -f "C:\installation\downloadcache\postgres.pgdump" postgres


