# HeatLens 0.1.3

Source-only milestone release (Python install required). Portable `.exe` builds begin in [v0.1.4](https://github.com/arogorn993-hue/HeatLens/releases/tag/v0.1.4).

## What's fixed in 0.1.3

- After starting LibreHardwareMonitor, HeatLens now waits up to ~60 seconds for the sensor feed instead of checking once
- Status bar shows live progress while waiting for Libre sensors
- Clearer instructions when Libre is running but its web server is not enabled

## Install

```powershell
git clone https://github.com/arogorn993-hue/HeatLens.git
cd HeatLens
git checkout v0.1.3
py -3 -m pip install -r requirements.txt
.\run_heatlens.ps1
```

See [README.md](README.md) for Linux/macOS and LibreHardwareMonitor setup.

## Full changelog

See [CHANGELOG.md](CHANGELOG.md).
