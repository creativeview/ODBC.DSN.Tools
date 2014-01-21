ODBC.DSN.Tools
==============

PowerShell ODBC.DSN.Tools to add a 64bit or 32bit System DSN for Microsoft SQL 2008 or Microsoft SQL 2012. 

Usage
--------

###### Add-SystemDSN cmdlet 

| Parameter   | Usage                        | 
| ----------- | ---------------------------- | 
| DSNName     | DSN Name                     |
| DBName      | SQL DB Name                  |
| DBSrvIP     | Database Server Address      |
| SQLver      | MS SQL version. 2008 or 2012 |
| DSN64bit    | 64 bit or 32 bit DSN         |

###### Remove-SystemDSN cmdlet 

| Parameter   | Usage                        | 
| ----------- | ---------------------------- | 
| DSNName     | DSN Name                     |
| DSN64bit    | 64 bit or 32 bit DSN         |


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
