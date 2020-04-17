Get-WMIObject -class Win32_UserProfile | Where {
     ($_.localpath -eq "C:\Users\120442")
} | remove-wmiobject