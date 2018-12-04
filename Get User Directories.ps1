$userpath = get-childitem C:\users | select name | out-string -stream | select-string -pattern "name","----" -notmatch
