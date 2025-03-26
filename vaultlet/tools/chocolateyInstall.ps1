$ErrorActionPreference = 'Stop'

$toolsDir   = Split-Path -Parent $MyInvocation.MyCommand.Definition
$zipUrl     = 'https://github.com/Vaultlet/Vaultlet/archive/refs/tags/1.0.0.zip'
$zipFile    = Join-Path $toolsDir 'vaultlet.zip'
$extractDir = Join-Path $toolsDir 'vaultlet-source'
$projectDir = Join-Path $extractDir 'Vaultlet-1.0.0'
$venvPath   = Join-Path $toolsDir 'venv'
$shimPath   = Join-Path $toolsDir 'vaultlet.bat'

Write-Host "📦 Downloading Vaultlet zip from GitHub..."
Get-ChocolateyWebFile -PackageName 'vaultlet' -FileFullPath $zipFile -Url $zipUrl

Write-Host "📂 Extracting source to $extractDir..."
Get-ChocolateyUnzip -FileFullPath $zipFile -Destination $extractDir

Write-Host "🐍 Creating virtual environment..."
# Get full path to Python executable installed by Chocolatey
$pythonPath = Get-Command python | Select-Object -ExpandProperty Source

& "$pythonPath" -m venv $venvPath

if (-not (Test-Path "$venvPath\Scripts\python.exe")) {
    throw "❌ Python venv creation failed. '$venvPath\Scripts\python.exe' not found."
}

Write-Host "⬆️ Ensuring pip is installed in the venv..."
& "$venvPath\Scripts\python.exe" -m ensurepip
& "$venvPath\Scripts\python.exe" -m pip install --upgrade pip

Write-Host "📥 Installing Vaultlet from source..."
& "$venvPath\Scripts\pip.exe" install "$projectDir"

Write-Host "🪄 Creating CLI shim (vaultlet.bat)..."
Set-Content -Path $shimPath -Value "@echo off`r`n`"$venvPath\Scripts\python.exe`" -m vaultlet %*"

Write-Host "🔗 Registering shim with Chocolatey..."
Install-BinFile -Name 'vaultlet' -Path $shimPath

Write-Host "✅ Vaultlet installation complete."
