# Must be pasted into a non-elevated powershell window
# Must be logged into the afflicted user's account

$keyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
$keys = get-item $keyPath | select-object -expandproperty property

foreach ($item in $keys) {
    
    $value = (get-itemproperty "$keypath").$item
    if($value -like("*csmc-fs03\home*")){
        $value = $value -Replace("csmc-fs03\\home", "sp-smf-fs01\datastore-fs03\home")
        #$value
        Set-ItemProperty -Path $keyPath -Name $item -Value $value
        }
    }

gpupdate /force