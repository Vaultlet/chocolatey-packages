# 🚀 Manual Release Instructions for Vaultlet Chocolatey Package

This document outlines the step-by-step process for manually releasing a new version of Vaultlet to Chocolatey.org.

---

## ✅ Prerequisites

- Ensure your Vaultlet GitHub repo has a published **release tag** (e.g. `1.0.1`, `1.2.0`, etc).
- Make sure the corresponding ZIP is accessible at:

  ```
  https://github.com/Vaultlet/Vaultlet/archive/refs/tags/<version>.zip
  ```

- Ensure you have:
  - Python installed (`python --version`)
  - Chocolatey installed
  - An API key for Chocolatey.org added to your environment or command line

---

## 🛠 Step-by-Step Release Instructions

### 1. Update Versioned References

If releasing a new version:
- Update `vaultlet.nuspec`:

  ```xml
  <version>1.0.0</version>
  ```

- Update `tools\chocolateyinstall.ps1`:

  ```powershell
  $zipUrl = 'https://github.com/Vaultlet/Vaultlet/archive/refs/tags/1.0.0.zip'
  $projectPath  = Join-Path $extractDir 'Vaultlet-1.0.0'
  ```

✅ Be sure all version references are consistent across both files.

---

### 2. Pack the Chocolatey Package

```powershell
choco pack
```

This generates a `.nupkg` file (e.g. `vaultlet.1.0.0.nupkg`).

---

### 3. Test Locally (optional but recommended)

```powershell
choco install vaultlet --source . --force --allow-downgrade
vaultlet --version
```

Use this to confirm the install works as expected before publishing.

---

### 4. Push to Chocolatey.org

```powershell
choco push vaultlet.{version}.nupkg --source https://push.chocolatey.org/ --api-key {CHOCOLATEY_API_KEY}
```

Replace `{CHOCOLATEY_API_KEY}` with your real API key from https://community.chocolatey.org/account

---

## 📌 Notes

- First-time submissions may be held for moderation.
- Future updates will be processed faster after initial approval.
- Chocolatey packages are **immutable** — to update the release, you must bump the version.

---

## ✅ Done!

Once approved, your package will be listed at:

🔗 https://community.chocolatey.org/packages/vaultlet