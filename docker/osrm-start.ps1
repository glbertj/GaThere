# Always resolve paths relative to this script
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$DataPath   = Join-Path $ScriptPath "..\osrm-data"

# Docker image
$DockerImage = "osrm/osrm-backend"

# Find the latest .osrm file in osrm-data
$OsrmFile = Get-ChildItem -Path $DataPath -Filter *.osrm | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $OsrmFile) {
    Write-Host "!!! No .osrm file found in $DataPath. Run osrm-build.ps1 first." -ForegroundColor Red
    exit 1
}

Write-Host "=== Starting OSRM Server ===" -ForegroundColor Yellow
Write-Host "Script path : $ScriptPath"
Write-Host "Data path   : $DataPath"
Write-Host "Using OSRM  : $($OsrmFile.Name)"
Write-Host "Server URL  : http://localhost:5000"
Write-Host "======================================"

# Run OSRM server
docker run -t -i -p 5000:5000 -v "${DataPath}:/data" $DockerImage osrm-routed --algorithm mld /data/$($OsrmFile.Name)
