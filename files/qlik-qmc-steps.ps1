#By Christof Schwarz
#-----------------------------------------------------------------------
# Administration changes to Qlik Sense QMC 

Write-Host ":-) Creating new Qlik Sense data connection 'energydata'"
#--------------------------------------------------------------------
$qsconn = new-qlikdataconnection -name "energydata" -connectionstring 'CUSTOM CONNECT TO "provider=QvOdbcConnectorPackage.exe;driver=postgres;host=localhost;port=4432;db=postgres;FetchTSWTZasTimestamp=1;MaxVarcharSize=262144;"' -type "QvOdbcConnectorPackage.exe" -username "qliksenserepository" -password "Qlik1234"
Write-Host ":-) created new Qlik Sense data connection $($qsconn.id)"
$qsrule = New-QlikRule -category Security -name "Access to lib connection energydata" -rule '((user.userId like "*"))' -action 2 -ruleContext both -resourceFilter "DataConnection_$($qsconn.id)"
Write-Host ":-) created new Security Role for above connection $($qsrule.id)"


Write-Host ":-) Exporting client certificate to the node app's folder"
#---------------------------------------------------------------------
Export-QlikCertificates qmi-qs-sessapp2
copy "C:\ProgramData\Qlik\Sense\Repository\Exported Certificates\qmi-qs-sessapp2\client.*" "c:\sessionapps-master"


Write-Host ":-) Updating Central Virtual Proxy settings"
#-------------------------------------------------------
$vproxy = get-QlikVirtualProxy | where {$_.description -like "Central*" }
Update-QlikVirtualProxy -id $vproxy.id -additionalResponseHeaders "Access-Control-Allow-Origin: http://qmi-qs-sessapp2:4000`nAccess-Control-Allow-Credentials: true" -websocketCrossOriginWhiteList {qmi-qs-sessapp2} 
Write-Host ":-) Virtual Proxy $($vproxy.id) updated"


Write-Host ":-) Publishing and reloading EnergyData app"
#-------------------------------------------------------
$streamid = (get-QlikStream | where {$_.name -eq "Everyone" }).id
$qapp = get-QlikApp | where {$_.name -like "EnergyData*" }
publish-qlikapp -id $qapp.id -stream $streamid
$qtask = New-QlikTask -appId $qapp.id -name "Reload of $($qapp.name)"
Start-QlikTask -id $qtask.id
