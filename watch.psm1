#############################################
# Author: ricepancakes                      #
# GitHub: github.com/catsandpancakes        #
# Contact: ricepancakes@protonmail.com      #
#                                           #
# Licensed under the MIT license.           #
#############################################

function watch($Command, $Wait, [switch]$Cumulative){
    $global:Error.Clear()

    try{
        if($Command -eq $null){
            Write-Host "Error: Please enter a command using the -Command flag." -BackgroundColor Red -ForegroundColor White
        }
        elseif($Wait -eq $null -or $Wait -eq 0){
            Write-Host "Error: Please enter a valid wait time (in seconds) using the -Wait flag." -BackgroundColor Red -ForegroundColor White
        }
        elseif($Wait -isnot [Double] -and $Wait -isnot [int]){
            Write-Host "Error: Please enter a valid wait time (in seconds) using the -Wait flag." -BackgroundColor Red -ForegroundColor White
        }
        else{
            if(-not($Cumulative)){    
                while(1){
                    Clear-Host
                    Write-Host "Watching: '$Command' every $Wait second(s)."
                    Write-Host "Press Ctrl+C to break.`n"
                    Invoke-Expression "$Command"
                    Start-Sleep -Seconds $Wait
                }
            }
            else{
                Clear-Host
                Write-Host "Watching (Cumulative): '$Command' every $Wait seconds(s)."
                Write-Host "Press Ctrl+C to break.`n"
                while(1){
                    Invoke-Expression "$Command"
                    Start-Sleep -Seconds $Wait
                }
            }
        }
    }catch{
        Write-Host "Unspecified error caught. Please see the following for more details:"
        Write-Host $global:Error -BackgroundColor Red -ForegroundColor White
    }
}
