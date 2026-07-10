Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Set-Location -LiteralPath (Split-Path -Parent $PSScriptRoot)

Write-Host "Installing build dependencies..."
py -3 -m pip install -r requirements.txt -r requirements-build.txt

Write-Host "Building HeatLens.exe..."
py -3 -m PyInstaller --noconfirm --clean heatlens.spec

$exe = Join-Path $PWD "dist\HeatLens.exe"
if (-not (Test-Path -LiteralPath $exe)) {
    throw "Build failed: $exe was not created."
}

Write-Host ""
Write-Host "Done. Portable executable:"
Write-Host "  $exe"
Write-Host ""
Write-Host "Copy HeatLens.exe anywhere and double-click to run."
Write-Host "Place LibreHardwareMonitor.exe in the same folder for one-click Libre support."
