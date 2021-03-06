<# 
    Author: David Balharrie twitter: @creativeview web: creativeview.co.uk
    A set of tools to manage ODBC DSN. 
    Version: 1.0
    Any comments/feedback welcome
#>

function Add-SystemDSNJSON {
  
<#
    .Synopsis
        Adds a ODBC System DSN with values from a JSON data file.
    .Description
        
    .Example
     Import-Module ODBC.DSN.Tools -force
     Add-SystemDSNJSON -JSONFilePath "C:\scripts\DSN.json"
#>
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$JSONFilePath
        )

        if(Test-Path($JSONFilePath))
        {
            [System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
            $json = [IO.File]::ReadAllText($JSONFilePath)
            $ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
            $JSONobj = $ser.DeserializeObject($json)

            foreach ($node in $JSONobj.DSN)
            {   
                Add-SystemDSN -DSNName $node.DSNName -DBName $node.DBName -DBSrvIP $node.DBSrvIP -SQLver $node.SQLver -DSN64bit $node.DSN64bit   
            }
        }   
}

function Remove-SystemDSNJSON {
  
<#
    .Synopsis
        Removes a ODBC System DSN with values from a JSON data file.
    .Description
        
    .Example
      
#>
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$JSONFilePath
        )

        if(Test-Path($JSONFilePath))
        {
            [System.Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
            $json = [IO.File]::ReadAllText($JSONFilePath)
            $ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
            $JSONobj = $ser.DeserializeObject($json)

            foreach ($node in $JSONobj.DSN)
            {   
                Remove-SystemDSN -DSNName $node.DSNName -DSN64bit $node.DSN64bit   
            }
        }   
}

function Add-SystemDSN {
  
<#
    .Synopsis
        Adds a ODBC System DSN
    .Description
        
    .Example
      
#>
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$DSNName,
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$DBName,
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$DBSrvIP,
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$SQLver,
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [Bool]$DSN64bit

    )
    
    if ($DSN64bit -eq $true)
    {
        $SystemFolder = "system32"
        $HKLMPath1 = “HKLM:SOFTWARE\ODBC\ODBC.INI\” + $DSNName
        $HKLMPath2 = “HKLM:SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources”
    }
    else
    {
        $SystemFolder = "SysWOW64"
        $HKLMPath1 = “HKLM:SOFTWARE\Wow6432Node\ODBC\ODBC.INI\” + $DSNName
        $HKLMPath2 = “HKLM:SOFTWARE\Wow6432Node\ODBC\ODBC.INI\ODBC Data Sources”
    }
    
    if ($SQLver -eq 2012)
    {
        $Driver = “C:\Windows\"+$SystemFolder+"\sqlncli11.dll”
        $SQLClientName = "SQL Server Native Client 11.0"
    }
    else
    {
        $Driver = “C:\Windows\"+$SystemFolder+"\sqlncli10.dll”
        $SQLClientName = "SQL Server Native Client 10.0"
    }
    
    Try
    {
    
    Write-host ("Adding the System DSN " + $DSNName + " connecting to the database " + $DBName + " on the server " + $DBSrvIP) -foregroundcolor green
    
    $md = md $HKLMPath1 -ErrorAction silentlycontinue
    set-itemproperty -path $HKLMPath1 -name Driver -value $Driver
    set-itemproperty -path $HKLMPath1 -name Description -value $DSNName
    set-itemproperty -path $HKLMPath1 -name Server -value $DBSrvIP
    set-itemproperty -path $HKLMPath1 -name LastUser -value “”
    set-itemproperty -path $HKLMPath1 -name Trusted_Connection -value “Yes”
    set-itemproperty -path $HKLMPath1 -name Database -value $DBName
    $md = md $HKLMPath2 -ErrorAction silentlycontinue
    set-itemproperty -path $HKLMPath2 -name $DSNName -value $SQLClientName
    
    Write-host ("System DSN added.") -foregroundcolor green
    }
    Catch [system.exception]
    {
      Write-host "Failed to add the ODBC System DSN" -foregroundcolor red
    }   
}


function Remove-SystemDSN {
  
<#
    .Synopsis
        Adds a ODBC System DSN
    .Description
        
    .Example
      
#>
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$DSNName,
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [Bool]$DSN64bit

    )
    
    Try
    { 
        if ($DSN64bit -eq $true)
        {
            $HKLMPath1 = “HKLM:SOFTWARE\ODBC\ODBC.INI\” + $DSNName
            $HKLMPath2 = “HKLM:SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources”
        }
        else
        {
            $HKLMPath1 = “HKLM:SOFTWARE\Wow6432Node\ODBC\ODBC.INI\” + $DSNName
            $HKLMPath2 = “HKLM:SOFTWARE\Wow6432Node\ODBC\ODBC.INI\ODBC Data Sources”
        } 
        
        Remove-Item -path $HKLMPath1 -Force -Recurse
        Remove-ItemProperty -path $HKLMPath2 -name $DSNName
    }
    Catch [system.exception]
    {
      Write-host "Failed to remove the ODBC System DSN" -foregroundcolor red
    }   
}    
    
Export-ModuleMember -Function Add-SystemDSN, Remove-SystemDSN, Add-SystemDSNJSON, Remove-SystemDSNJSON