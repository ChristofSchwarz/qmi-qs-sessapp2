& c:\shared-content\scripts\modules\q-user-setup.ps1
& c:\shared-content\scripts\modules\qs-getBinary.ps1
& c:\shared-content\scripts\modules\qs-initial-cfg.ps1
& c:\shared-content\scripts\modules\qs-install.ps1
& c:\shared-content\scripts\modules\qs-post-cfg.ps1
& c:\shared-content\scripts\modules\qs-update.ps1
#& c:\installation\install-mssql.ps1
& c:\installation\import-postgresql-data.ps1
& c:\installation\install-heidisql.ps1
& c:\installation\install-mongo.ps1
& c:\installation\install-nodejs.ps1
& c:\installation\qlik-qmc-steps.ps1
copy "c:\installation\add2desktop\*.*" "$env:USERPROFILE\Desktop"
copy "c:\installation\add2desktop\*start node*.lnk" "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
& c:\shared-content\scripts\modules\q-provisioned.ps1


