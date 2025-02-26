# Check-DiskSpace.ps1
# This script checks the disk space on all fixed (local) drives and displays total, used, free space, and percentage used.

# Get disk information using CIM
$drives = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"

foreach ($drive in $drives) {
    $device = $drive.DeviceID
    $totalGB = [math]::Round($drive.Size / 1GB, 2)
    $freeGB  = [math]::Round($drive.FreeSpace / 1GB, 2)
    $usedGB  = [math]::Round(($drive.Size - $drive.FreeSpace) / 1GB, 2)
    $percentUsed = if ($drive.Size -eq 0) { 0 } else { [math]::Round((($drive.Size - $drive.FreeSpace) / $drive.Size) * 100, 2) }
    
    Write-Host "Drive ${device}:" -ForegroundColor Cyan
    Write-Host "  Total Size     : $totalGB GB"
    Write-Host "  Used Space     : $usedGB GB"
    Write-Host "  Free Space     : $freeGB GB"
    Write-Host "  Percentage Used: $percentUsed%`n"
}
