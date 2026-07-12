# Changelog

All notable changes to HeatLens are documented here.

## [0.1.10] - 2026-07-12

### Fixed
- **Severe freeze on first load, especially when LibreHardwareMonitor is not running.** All LibreHardwareMonitor detection (process scan, Windows uninstall registry, OneDrive/Documents/Downloads/Desktop folder walks, and HTTP sensor probes) now runs on a background thread instead of the Tk main loop, so the window stays responsive and draggable while HeatLens looks for Libre. Previously this work ran on the UI thread at startup and again every 2 seconds during the "waiting for Libre" retry loop (up to 30 attempts), locking up the window and eventually reporting that it couldn't retrieve Libre.
- The configured-port lookup is now cached, so the sensor-feed retry loop no longer re-scans the filesystem/registry on every probe.

### Added
- **Automatic detection of LibreHardwareMonitor's Remote Web Server port.** HeatLens now inspects the running Libre process and connects to whatever port it is actually listening on, so a **custom port works out of the box** — handy when another app (e.g. a game client) already occupies Libre's default port 8085. Falls back to the configured port and the usual defaults (8085/8086/8080).
- **Option to run without LibreHardwareMonitor.** A new **Options → Sensors** toggle, "Don't use LibreHardwareMonitor (built-in sensors and estimates only)", skips Libre entirely and stops the startup prompt. The startup prompt also offers **Cancel = turn Libre off**, and when Libre is off the status bar clearly reads **"LibreHardwareMonitor is off"** instead of a "not connected" note. HeatLens continues to report wattage and heat from built-in sensors and estimates (psutil, nvidia-smi, RAPL/hwmon, etc.).

## [0.1.9] - 2026-07-11

### Fixed
- **Window drag/resize stutter**, most noticeable in **Low impact mode**: the graph now suspends its redraw and defers label/table refreshes while the window is being moved or resized, then catches up once movement settles

### Removed
- **"Buy me a coffee" footer link from the app** (the in-app footer label and `DONATE_URL`). Removed on purpose — I thought it was corny in the app itself. The link still lives on the GitHub page for anyone who wants it.

## [0.1.8] - 2026-07-10

### Added
- **Performance** options: sensor refresh interval (1–10 seconds) and **Low impact mode** for gaming

### Changed
- Default sensor refresh increased from 1.5s to **3s** to reduce CPU overhead
- UI updates throttled (~1 Hz), detail tables refresh every 5s, graphs redraw at most once per second
- Skip redundant Windows WMI/psutil sensor scans when LibreHardwareMonitor HTTP is active
- Cache LibreHardwareMonitor HTTP URL/port; faster timeouts on cached connections
- Graph rendering uses downsampling and disables expensive smooth line interpolation

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
