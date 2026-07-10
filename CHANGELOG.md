# Changelog

All notable changes to HeatLens are documented here.

## [0.1.4] - 2026-07-10

### Added
- Portable **Windows `.exe`** and **Linux binary** builds via PyInstaller
- `scripts/build_windows.ps1` and `scripts/build_linux.sh` for local builds
- GitHub Actions workflow to attach binaries to tagged releases

## [0.1.3] - 2026-07-10

### Fixed
- After starting LibreHardwareMonitor, HeatLens now waits up to ~60 seconds for the sensor feed instead of checking once
- Status bar shows live progress while waiting for Libre sensors
- Clearer instructions when Libre is running but its web server is not enabled

## [0.1.2] - 2026-07-10

### Fixed
- LibreHardwareMonitor detection now finds portable installs (including OneDrive `Documents\ai`), running processes, config files, and registry entries

## [0.1.1] - 2026-07-09

### Added
- **Libre** button and startup helper to launch LibreHardwareMonitor when installed
- Friendly download prompt when LibreHardwareMonitor is not installed
- Optional laid-back **Buy me a coffee** footer link

## [0.1.0] - 2026-07-09

### Added
- Desktop widget for total wattage, BTU/hr, session heat, and max temperature
- Live trend graphs for watts, BTU/hr, and temperature
- Multi-backend sensor collection:
  - LibreHardwareMonitor / OpenHardwareMonitor (HTTP + WMI)
  - `nvidia-smi` for NVIDIA GPUs
  - Linux RAPL, hwmon, and `rocm-smi`
  - Windows ACPI and storage WMI counters
  - `psutil` fallbacks when direct power sensors are unavailable
- Sensor inspector showing source, component, and total-wattage contribution
- Labeled estimates for unmetered platform, RAM, storage, and PSU loss
- Ambient temperature input for above-ambient delta and air-rise estimates
- Excel session export
- Windows, Linux, and macOS launch scripts

### Notes
- Software sensor totals are useful estimates; a wall power meter is still the most accurate way to measure whole-system room heat.
