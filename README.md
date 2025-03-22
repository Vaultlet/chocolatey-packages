# Chocolatey Packages – Vaultlet

This repository contains the Chocolatey packaging files for [Vaultlet](https://github.com/Vaultlet/Vaultlet), a secure CLI tool for injecting environment variables using Windows Credential Manager.

## 📦 Package: Vaultlet

- **Chocolatey ID:** `vaultlet`
- **Source Code:** [Vaultlet on GitHub](https://github.com/Vaultlet/Vaultlet)
- **License:** MIT
- **Author:** Steven Li

Vaultlet allows you to securely store secrets and inject them into subprocesses, making `.env` files unnecessary and unsafe credential handling a thing of the past.

---

## 📁 Structure

```
https://github.com/vaultlet/chocolatey-packages
└── vaultlet/
    ├── vaultlet.nuspec
    ├── tools/
    │   ├── chocolateyInstall.ps1
```
---
## 🚀 Usage
Once published, users can install Vaultlet via Chocolatey:

```powershell
choco install vaultlet
```
---
## 🛠️ Maintainer Instructions
### Build `.nupkg` locally:
```powershell
cd vaultlet
choco pack
```
### Test install locally:
```powershell
choco install vaultlet -s .
```
### Push to Chocolatey:
```powershell
choco apikey --key YOUR_API_KEY --source https://push.chocolatey.org/
choco push vaultlet.1.0.0.nupkg --source https://push.chocolatey.org/
```
🔐 Get your API key from https://community.chocolatey.org/account

## 🧪 Notes
- This repo contains only the packaging logic, not the application source.
- Vaultlet is installed via pip install vaultlet or directly from GitHub.
- Update vaultlet.nuspec and chocolateyInstall.ps1 for new versions.

## 📄 License
- Packaging: MIT
- Vaultlet App: MIT
