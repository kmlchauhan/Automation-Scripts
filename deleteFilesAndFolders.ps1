﻿#----- Define parameters -----#
#----- Get current date ----#
$Now = Get-Date
$Days = "30" #----- define amount of days ----#
$Targetfolder = "E:\out\PreviousDesktopData_1" #----- define folder where files are located ----#
$Extension = "*.log" #----- define extension ----#
$Lastwrite = $Now.AddDays(-$Days)

#----- Get files based on lastwrite filter and specified folder ---#
$Files = Get-ChildItem $Targetfolder -Recurse | where {$_.LastwriteTime -le "$Lastwrite"}

foreach ($File in $Files)
{
    if ($File -ne $Null)
    {
        write-host "Deleting File $File" backgroundcolor "DarkRed"
        Remove-item $File.Fullname | out-null
        $File.FullName | Out-File E:\deletedObjectslog.txt -Append
    }
    else
    {
        write-host "No more files to delete" -forgroundcolor "Green"
    }
}