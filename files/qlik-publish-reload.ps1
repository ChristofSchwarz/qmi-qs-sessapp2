# by Christof Schwarz
Write-Host "Publishing and reloading EnergyData app"
$streamid = (get-QlikStream | where {$_.name -eq "Everyone" }).id
$qapp = get-QlikApp | where {$_.name -like "EnergyData*" }
publish-qlikapp -id $qapp.id -stream $streamid
$qtask = New-QlikTask -appId $qapp.id -name "Reload of $($qapp.name)"
Start-QlikTask -id $qtask.id
