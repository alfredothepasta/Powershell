# Fix the broken


$keyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
$keys = get-item $keyPath | select-object -expandproperty property

foreach ($item in $keys) {
    
    $value = (get-itemproperty "$keypath").$item
    if($value -like("*sp-smf-fs01\home-fs03*")){
        $value = $value -Replace("sp-smf-fs01\\home-fs03", "sp-smf-fs01\datastore-fs03\home")
        #$value
        Set-ItemProperty -Path $keyPath -Name $item -Value $value
        }
    }

gpupdate /force