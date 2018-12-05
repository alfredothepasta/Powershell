function invoke-bulk {

    param(
        [parameter(Mandatory)]
        [string]$computerListPath,
        [parameter(Mandatory,ValueFromPipeline)]
        [System.Management.Automation.ScriptBlock]$script
        )
    Begin {    
        $computername = get-content -path $computerListPath
        $conFail = @()
        $cred = get-credential
    }

    Process {

        foreach ($computer in $computername) {
            
            $r = Test-WSMan $Computer -ErrorAction SilentlyContinue


            if ($r){
            
                

                invoke-command -computername $computer -credential $cred -scriptblock $script
            } else {
                
                $conFail += $computer 

            }            
        }
    }
    
    End {
        
        # 
        $confail = $conFail | out-string -stream
        $confail | convertto-html | out-file -FilePath C:\psstuff\ConnectionTest.csv
        
    }
}
