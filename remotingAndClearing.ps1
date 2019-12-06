# Script to remove profiles that haven't been logged into in over a year
# Input the computer you want to run the script on when running, automagically
#   remotes into the comptuer and finds all old profiles.  

# Run this chunk separately, this just remotes you in. 
$cred = Get-Credential
$computerName = read-host -prompt 'Input computer name'
New-PSSession -ComputerName $computerName -Credential $cred | Enter-PSSession

# This chunk can be run remotely or locally
# Change this to set the threshold for how recently a user should have logged in default 1 year
$numDays = 365 


$cutoff = (get-date).addDays(-$numDays)
$oldUsers = (get-childitem C:\users) | where-object {$_.lastwritetime -le $cutoff -and $_.name -notlike "admin*" -and $_.name -notlike "public" -and $_.name -notlike "default" -and $_.name -notlike "temp" -and $_.name -notlike "guest"} | Select-Object name
foreach($user in $oldUsers){
    $userString = $user.name
    write-output $userString
    Get-WMIObject -class Win32_UserProfile | Where-Object {
        ($_.localpath -eq "C:\Users\$userString")
    } | remove-wmiobject    
}

cleanmgr.exe /AUTOCLEAN
Exit-PSSession