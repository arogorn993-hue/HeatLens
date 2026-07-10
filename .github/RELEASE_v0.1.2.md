# HeatLens 0.1.2

Source-only milestone release (Python install required). Portable `.exe` builds begin in [v0.1.4](https://github.com/arogorn993-hue/HeatLens/releases/tag/v0.1.4).

## What's fixed in 0.1.2

- LibreHardwareMonitor detection now finds portable installs (including OneDrive `Documents\ai`), running processes, config files, and registry entries

## Install

```powershell
git clone https://github.com/arogorn993-hue/HeatLens.git
cd HeatLens
git checkout v0.1.2
py -3 -m pip install -r requirements.txt
.\run_heatlens.ps1
```

See [README.md](README.md) for Linux/macOS and LibreHardwareMonitor setup.

## Full changelog

See [CHANGELOG.md](CHANGELOG.md).
