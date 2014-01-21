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

###Adding a System DSN using JSON
```powershell
Import-Module ODBC.DSN.Tools -force

Add-SystemDSNJSON -JSONFilePath "C:\scripts\JSON\DSN-Add.json"
```
###Remove a System DSN using JSON
```powershell
Import-Module ODBC.DSN.Tools -force

Remove-SystemDSNJSON -JSONFilePath "C:\scripts\JSON\DSN-Remove.json"
```
###Example JSON File
```JSON
{
	"DSN": [
		{ "DSNName": "vCenter", "DBName": "vCenter", "DBSrvIP": "192.168.1.31", "SQLver": "2012", "DSN64bit": true },
		{ "DSNName": "VUM", "DBName": "VUM", "DBSrvIP": "192.168.1.31", "SQLver": "2012", "DSN64bit": false }
	]
}
```
