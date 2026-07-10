# Changelog

All notable changes to HeatLens are documented here.

## [0.1.7] - 2026-07-10

### Added
- **Metric units** in Options (°C, kW, kWh) with ambient auto-conversion and one-decimal precision
- **Y-axis value toggle** on trend graphs (complement to X-axis time labels)
- **Export options** in Options dialog:
  - Default format: Excel (.xlsx) or CSV (.csv)
  - Column units: match display, raw, imperial, metric, or all columns
  - Timestamp format, CSV delimiter, header row, summary sheet, bold headers, auto-size columns

### Changed
- Ambient field shows a single unit label (°F or °C) and converts when switching unit systems

## [0.1.6] - 2026-07-10

### Added
- **Time axis** on trend graphs showing local clock time (on by default)
- **Y-axis grid values** on each trend band
- **Options** dialog with graph controls:
  - Toggle X-axis time labels
  - X-axis window: Auto, 1–30 minutes
  - Y-axis scaling: Auto, Include zero, Padded (10%)
  - **Restart as administrator** on Windows
  - **Always start as administrator** (saved in `~/.heatlens/preferences.json`)

## [0.1.5] - 2026-07-10

### Changed
- Windows portable build: disabled UPX compression and embedded exe version metadata to reduce SmartScreen/AV false positives
- README and [docs/CODE_SIGNING.md](docs/CODE_SIGNING.md) explain SmartScreen and optional Authenticode signing

## [0.1.4] - 2026-07-10

### Added
- Portable **Windows `.exe`**, **Linux binary**, and **macOS `.app`** builds via PyInstaller
- `scripts/build_windows.ps1`, `scripts/build_linux.sh`, and `scripts/build_macos.sh` for local builds
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
