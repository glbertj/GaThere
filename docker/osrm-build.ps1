$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$DataPath   = Join-Path $ScriptPath "..\osrm-data"

# PBF file !! CHANGE HERE !!
$PbfFile = "java-250913.osm.pbf"

$BaseName = [System.IO.Path]::GetFileNameWithoutExtension(
        [System.IO.Path]::GetFileNameWithoutExtension($PbfFile)
)

$DockerImage = "osrm/osrm-backend"

function Run-Step($StepName, $Command) {
    Write-Host "[$StepName]..."
    Invoke-Expression $Command
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[$StepName] FAILED" -ForegroundColor Red
        exit $LASTEXITCODE
    }
}

# Steps
Run-Step "Extract"  "docker run -t -v `${DataPath}:/data` $DockerImage osrm-extract -p /opt/car.lua /data/$PbfFile"
Run-Step "Partition" "docker run -t -v `${DataPath}:/data` $DockerImage osrm-partition /data/$BaseName.osrm"
Run-Step "Customize" "docker run -t -v `${DataPath}:/data` $DockerImage osrm-customize /data/$BaseName.osrm"

Write-Host "Build complete! Run osrm-start.ps1 to start the server."
