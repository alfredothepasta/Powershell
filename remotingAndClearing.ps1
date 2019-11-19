# Script to remove profiles that haven't been logged into in over a year
# Input the computer you want to run the script on when running, automagically
#   remotes into the comptuer and finds all old profiles.  

# Run this chunk separately
$cred = Get-Credential
$computerName = read-host -prompt 'Input computer name'
New-PSSession -ComputerName $computerName -Credential $cred | Enter-PSSession


$cutoff = (get-date).addDays(-322)
$oldUsers = (get-childitem C:\users) | where-object {$_.lastwritetime -le $cutoff -and $_.name -notlike "admin*" -and $_.name -notlike "public"} | select name
foreach($user in $oldUsers){
    $userString = $user.name
    write-output $userString
    Get-WMIObject -class Win32_UserProfile | Where {
        ($_.localpath -eq "C:\Users\$userString")
    } | remove-wmiobject       
}

cleanmgr.exe /AUTOCLEAN
Exit-PSSession