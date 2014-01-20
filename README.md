ODBC.DSN.Tools
==============

PowerShell ODBC.DSN.Tools

Examples
--------

###Adding a System DSN
```powershell
Import-Module ODBC.DSN.Tools -force

Add-SystemDSN -DSNName "vCenter" -DBName "vCenterDB" -DBSrvIP "192.168.1.21" -SQLver 2012 -DSN64bit $true
```
###Remove a System DSN
```powershell
Import-Module ODBC.DSN.Tools -force

Remove-SystemDSN -DSNName "vCenter" -DSN64bit $true
```
