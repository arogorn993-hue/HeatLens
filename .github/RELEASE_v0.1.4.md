# HeatLens 0.1.4

Desktop widget for PC wattage and room heat in BTU/hr.

## What's new in 0.1.4

- **Portable Windows `.exe`** — no Python install required
- **Portable Linux binary** — single executable plus `.tar.gz` archive
- Build scripts for local packaging (`scripts/build_windows.ps1`, `scripts/build_linux.sh`)

## Downloads

| Platform | File |
|----------|------|
| Windows | `HeatLens.exe` |
| Linux | `HeatLens` or `HeatLens-linux-x86_64.tar.gz` |

## Install (portable)

**Windows:** Download `HeatLens.exe`, double-click to run. Right-click → **Run as administrator** for extra ACPI/storage sensors.

**Linux:** Download `HeatLens-linux-x86_64.tar.gz`, extract, then:

```bash
chmod +x HeatLens
./HeatLens
```

Place `LibreHardwareMonitor.exe` next to `HeatLens.exe` on Windows for easy **Libre** button support.

## Install (from source)

```powershell
git clone https://github.com/arogorn993-hue/HeatLens.git
cd HeatLens
py -3 -m pip install -r requirements.txt
.\run_heatlens.ps1
```

See [README.md](README.md) for Linux/macOS and LibreHardwareMonitor setup.

## Full changelog

See [CHANGELOG.md](CHANGELOG.md).
