$UserDataLocal = $env:LOCALAPPDATA 
$UserDataRoaming = $env:APPDATA
$UserFolder = $env:USERPROFILE
$BrowserCleanLog = 'C:\Users\username\Desktop\BrowserCleanLog.txt'
$EDGERegKey = 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge'

Write-Host 
"Internet Explorer (1), EDGE (2), Firefox (3), Chrome (4), Exit (5)"
Write-Host " "
$BrowserClean = Read-Host -Prompt 'Please select the browser you would like to clean or select Option 5 to exit.'

do {
if ($BrowserClean -eq 1) {

Write-Host "Cleaning Internet Explorer..."

# Can be Uncommented to Backup User Data

#New-Item -Path "$UserFolder\Desktop" -Name "Browser_Archives" -ItemType "directory"
#$compress = @{
#  Path = "$UserDataLocal\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
#  CompressionLevel = "Fastest"
#  DestinationPath = "$UserFolder\Desktop\Browser_Archives\EDGE-Browser-Backup.Zip"
#}


Write-Host "Deleting Temporary Internet Files"

Remove-Item -path "$UserDataLocal\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Start-Sleep -s 2

Write-Host "Deleting INetCache"

Remove-Item -path "$UserDataLocal\Microsoft\Windows\INetCache\*" -Recurse -Force -EA SilentlyContinue -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Start-Sleep -s 2

Write-Host "Reseting IE Files and Settings stored by Add-ons"

rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 4351

Start-Sleep -s 10

Write-Host "Complete"

Write-Host 
"Internet Explorer (1), EDGE (2), Firefox (3), Chrome (4), Exit (5)"
Write-Host " "
$BrowserClean = Read-Host -Prompt 'Please select the browser you would like to clean or select Option 5 to exit.'

} 

Elseif ($BrowserClean -eq 2) 

{
	
# Can be Uncommented to Backup User Data

#Stop-Service -Name "cryptsvc"

#New-Item -Path "$UserFolder\Desktop" -Name "Browser_Archives" -ItemType "directory"

#$compress = @{
#  Path = "$UserDataLocal\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe"
#  CompressionLevel = "Fastest"
#  DestinationPath = "$UserFolder\Desktop\Browser_Archives\EDGE-Browser-Backup.Zip"
#}
#Compress-Archive @compress

Write-Host "Deleting Edge Package Files"

Remove-Item -Path "$UserDataLocal\Packages\Microsoft.MicrosoftEdge_*" -Recurse -Force -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Start-Sleep -s 2

Write-Host "Deleting EDGE Registry Key"

Remove-Item -Path "$EDGERegKey" -Recurse -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Start-Sleep -s 2

#Start-Service -Name "cryptsvc"

Write-Host "Reinstalling EDGE Browser"
 
Get-AppXPackage -AllUsers -Name Microsoft.MicrosoftEdge | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Start-Sleep -s 10

Write-Host "Reinstall Complete"

Write-Host 
"Internet Explorer (1), EDGE (2), Firefox (3), Chrome (4), Exit (5)"
Write-Host " "
$BrowserClean = Read-Host -Prompt 'Please select the browser you would like to clean or select Option 5 to exit.'

} 

Elseif ($BrowserClean -eq 3) 

{
Write-Host "Deleting Firefox Profiles"

# Can be Uncommented to Backup User Data

#New-Item -Path "$UserFolder\Desktop" -Name "Browser_Archives" -ItemType "directory"
#$compress = @{
#  Path = "$UserDataLocal\Mozilla\Firefox\Profiles\*"
#  CompressionLevel = "Fastest"
#  DestinationPath = "$UserFolder\Desktop\Browser_Archives\Firefox-Browser-Backup.Zip"
#}
#Compress-Archive @compress


Remove-Item -Path "$UserDataLocal\Mozilla\Firefox\Profiles\*"  -Recurse -Force -EA SilentlyContinue -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Remove-Item -Path "$UserDataRoaming\Mozilla\Firefox\Profiles\*" -Recurse -Force -EA SilentlyContinue -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Write-Host 
"Internet Explorer (1), EDGE (2), Firefox (3), Chrome (4), Exit (5)"
Write-Host " "
$BrowserClean = Read-Host -Prompt 'Please select the browser you would like to clean or select Option 5 to exit.'

} 

Elseif ($BrowserClean -eq 4) 

{

Write-Host "Deleting Chrome User Data.."

# Can be Uncommented to Backup User Data

#New-Item -Path "$UserFolder\Desktop" -Name "Browser_Archives" -ItemType "directory"
#$compress = @{
#  Path = "$$UserDataLocal\Google\Chrome\User Data\Default\*"
#  CompressionLevel = "Fastest"
#  DestinationPath = "$UserFolder\Desktop\Browser_Archives\Chrome-Browser-Backup.Zip"
#}
#Compress-Archive @compress

Remove-Item -Path "$UserDataLocal\Google\Chrome\User Data\Default\*" -Recurse -Force -EA SilentlyContinue -Verbose 4>&1 | Out-File $BrowserCleanLog -Append

Write-Host 
"Internet Explorer (1), EDGE (2), Firefox (3), Chrome (4), Exit (5)"
Write-Host " "
$BrowserClean = Read-Host -Prompt 'Please select the browser you would like to clean or select Option 5 to exit.'

}

Elseif ($BrowserClean -eq 5)

{
Write-Host "Exiting...."
Start-sleep -s 2
exit
}

} until ($BrowserClean -eq '5')

Write-Host "Exiting...."
Start-sleep -s 2
