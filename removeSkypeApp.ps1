$removestring = get-appxprovisionedpackage -online | select packagename | out-string -stream | select-string -pattern "skype"
$removestring = $removestring -replace '\s',''
remove-appxprovisionedpackage -packagename $removestring -online
