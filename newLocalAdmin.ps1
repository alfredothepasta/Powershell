$UserName = Read-Host
$Password = Read-Host -AsSecureString
New-LocalUser $username -Password $Password
Add-LocalGroupMember -Group "Administrators" -Member $username