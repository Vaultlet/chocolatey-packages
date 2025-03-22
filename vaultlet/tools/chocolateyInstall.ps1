$ErrorActionPreference = 'Stop'

$toolsDir     = Split-Path -Parent $MyInvocation.MyCommand.Definition
$zipUrl       = 'https://github.com/Vaultlet/Vaultlet/archive/refs/tags/1.0.0.zip'
$zipFile      = Join-Path $toolsDir 'vaultlet.zip'
$extractDir   = Join-Path $toolsDir 'vaultlet-source'
$projectPath  = Join-Path $extractDir 'Vaultlet-1.0.0'
$venvPath     = Join-Path $toolsDir 'venv'
$pythonPath   = Join-Path $venvPath 'Scripts\python.exe'
$shimPath     = Join-Path $toolsDir 'vaultlet.bat'

Write-Host "Downloading Vaultlet using Chocolatey's Get-ChocolateyWebFile..."
Get-ChocolateyWebFile -PackageName "vaultlet" `
                      -FileFullPath $zipFile `
                      -Url $zipUrl `
                      -Checksum '' `
                      -ChecksumType 'sha256'

if (-not (Test-Path $zipFile)) {
    throw "Download failed: $zipFile not found."
}

Write-Host "Extracting $zipFile to $extractDir..."
Get-ChocolateyUnzip -FileFullPath $zipFile -Destination $extractDir

Write-Host "Creating virtual environment..."
python -m venv $venvPath

Write-Host "Ensuring pip is installed in the venv..."
& $pythonPath -m ensurepip

Write-Host "Upgrading pip..."
& $pythonPath -m pip install --upgrade pip

Write-Host "Installing Vaultlet..."
& $pythonPath -m pip install $projectPath

Write-Host "Creating vaultlet.bat shim..."
$shimContent = "@echo off`r`n`"$pythonPath`" -m vaultlet %*"
Set-Content -Path $shimPath -Value $shimContent -Encoding ASCII

Write-Host "Registering shim with Chocolatey..."
Install-BinFile -Name 'vaultlet' -Path $shimPath

Write-Host "Vaultlet installation complete."
