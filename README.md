# HeatLens

**See how much heat your PC is putting into the room.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Python 3.10+](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey)](#quick-start)

HeatLens is a small Python desktop widget that answers a simple question:

> *How much heat is this computer adding to my room right now?*

It shows total wattage, heat dissipation (**BTU/hr** or **kW**), session heat, live temperatures, trend graphs, and rough room-heating context — with clear labeling when values come from direct sensors vs estimates. Switch between **imperial** and **metric** units in **Options**.

![HeatLens dashboard](docs/screenshot.png)

## Features

- **Total wattage** from hardware power sensors, with smart fallbacks
- **Heat dissipation** in BTU/hr or kW, plus **session heat** in BTU or kWh
- **Max temperature** with Pascal NVIDIA hot-spot handling
- **Trend graphs** for watts, heat, and temperature — optional time axis and Y-axis value labels
- **CFM cooling estimate** — enter ambient temperature to see approximate **CFM** (or **m³/h** in metric) needed to exhaust PC heat with a +10 °F (+10 °C) rise, plus **still-air room rise** per hour for a reference room size
- **Sensor inspector** — see every source and what counts toward the total
- **Ambient input** for above-ambient delta, air-rise, and airflow estimates
- **Options** — units (imperial/metric), graph scaling, Windows admin mode, Excel/CSV export formatting
- **Performance controls** — adjustable sensor refresh and **Low impact mode** to reduce CPU use and gaming stutter
- **Excel and CSV export** for monitoring sessions (configurable columns, delimiters, timestamps)
- **Compact mode** for a smaller always-on-top widget (also skips heavy detail-table updates)

## Performance and stability

HeatLens reads hardware sensors in the background and updates a live dashboard. Early versions polled aggressively and redrew the full UI on every sample, which could cause micro-stutter or hurt **1% lows** while gaming.

**v0.1.8+** is tuned to stay out of your way:

| What | Default behavior |
|------|------------------|
| **Sensor refresh** | Every **3 seconds** (was 1.5s) |
| **Top cards** (watts, BTU, temps) | Update about **once per second** |
| **Detail tables** | Rebuild every **5 seconds** (skipped entirely in **Compact** mode) |
| **Trend graphs** | Redraw at most **once per second**, with downsampled points |
| **LibreHardwareMonitor HTTP** | When active, redundant WMI/psutil scans are skipped; the working URL is cached |

Open **Options → Performance** to change this:

- **Sensor refresh** — 1, 2, **3** (recommended), 5, or 10 seconds between sensor reads
- **Low impact mode** — best for gaming: 5s sensor refresh, slower UI/graph work, detail tables every 10s

Session logging and graph history still record every sensor sample; only screen redraws are throttled. Your exported Excel/CSV logs stay complete.

**Tips while gaming**

1. Enable **Low impact mode** in Options, or set sensor refresh to **5–10 seconds**
2. Use **Compact** — smaller window and no detail-table churn
3. Pin the widget if you want it visible without alt-tabbing to a full dashboard

HeatLens is a monitor, not a game overlay. It should be lightweight, but if you are squeezing maximum FPS, Low impact mode + Compact is the intended setup.

## Quick start

### Portable download (no Python required)

Pre-built binaries are attached to [GitHub Releases](https://github.com/arogorn993-hue/HeatLens/releases):

| Platform | File | Notes |
|----------|------|-------|
| **Windows** | `HeatLens.exe` | Double-click to run. If SmartScreen appears: **More info** → **Run anyway** (unsigned app). Right-click → **Run as administrator** for extra sensors. |
| **Linux** | `HeatLens` or `HeatLens-linux-x86_64.tar.gz` | `chmod +x HeatLens && ./HeatLens`. Needs X11/Wayland with Tk; RAPL/hwmon may need permissions. |
| **macOS** | `HeatLens-macos-arm64.tar.gz` | Extract, then open `HeatLens.app`. First launch: right-click → **Open** if Gatekeeper blocks it. |

Place `LibreHardwareMonitor.exe` in the **same folder** as `HeatLens.exe` on Windows if you want the **Libre** button to find it easily.

To build locally:

```powershell
# Windows
.\scripts\build_windows.ps1
```

```bash
# Linux
bash scripts/build_linux.sh

# macOS
bash scripts/build_macos.sh
```

### Windows (from source)

```powershell
git clone https://github.com/arogorn993-hue/HeatLens.git
cd HeatLens
py -3 -m pip install -r requirements.txt
.\run_heatlens.ps1
```

For motherboard, ACPI, or storage temperature counters that Windows sometimes blocks:

```powershell
.\run_heatlens_admin.ps1
```

### Linux

```bash
git clone https://github.com/arogorn993-hue/HeatLens.git
cd HeatLens
python3 -m pip install -r requirements.txt
./run_heatlens.sh
```

On Linux, HeatLens can read **Intel/AMD RAPL** package power from sysfs and **hwmon** power/temperature sensors when the kernel exposes them. AMD GPUs can be read through `rocm-smi` when installed.

### macOS

```bash
git clone https://github.com/arogorn993-hue/HeatLens.git
cd HeatLens
python3 -m pip install -r requirements.txt
python3 hardware_heat_widget.py
```

macOS support is estimate-oriented (CPU load + any temperatures `psutil` can see). NVIDIA GPUs still work if `nvidia-smi` is installed.

## Best sensor results

For the most complete Windows sensor coverage, run [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor) with its web server enabled. HeatLens checks:

1. Libre/OpenHardwareMonitor `data.json` over HTTP (default port `8085`)
2. Libre/OpenHardwareMonitor WMI namespaces
3. `nvidia-smi` for NVIDIA GPU power/temperature
4. Native Windows ACPI and storage WMI counters (admin may be required)
5. Linux RAPL / hwmon / `rocm-smi` on supported systems
6. CPU/platform estimates through `psutil` when direct power sensors are unavailable

Use the **Sensors** button in HeatLens to see each live sensor, its source backend, and whether it contributes to total wattage.

On Windows, HeatLens can also **start LibreHardwareMonitor for you** if it is installed, or open the download page if it is not. Use the **Libre** button in the header any time to retry.

## FAQ

**Do I need LibreHardwareMonitor?**  
No. HeatLens works with `nvidia-smi`, Linux sensors, and estimates. Libre just gives the best coverage on Windows (CPU package power, motherboard, RAM, NVMe).

**Why does it say "estimated" wattage?**  
Some parts of a PC do not expose power sensors in software. HeatLens labels those rows with `~` so you can see what was measured directly vs inferred.

**Why is my total lower than a wall power meter?**  
Software usually cannot see monitor power, full PSU loss, or every platform rail. A plug-in meter at the wall is still the most accurate whole-system reading.

**How do I get the best results on Windows?**  
Install [LibreHardwareMonitor](https://github.com/LibreHardwareMonitor/LibreHardwareMonitor), click **Libre** in HeatLens to start it, then enable **Options → Remote Web Server → Run** (port 8085).

**Can I run it pinned on top?**  
Yes. Check **Pin** in the header, or use **Compact** for a smaller window.

**What does the CFM number mean?**  
Enter ambient temperature (°F or °C) in the header. HeatLens estimates how much **CFM** (cubic feet per minute) of exhaust airflow would be needed to carry away the PC’s heat while keeping exhaust air about **10 °F above ambient** — a rough HVAC-style sanity check, not a duct design tool. In metric mode the same estimate is shown as **m³/h**. You also get **still-air rise**: how fast a closed reference room (~1,000 ft³ / ~28 m³) would warm with no ventilation.

**Can I use metric units?**  
Yes. **Options → Display system → Metric (C, kW, kWh)**. Ambient converts automatically when you switch.

**Will HeatLens hurt gaming performance or cause stutter?**  
It should not when using the built-in performance controls. Enable **Options → Performance → Low impact mode** while gaming, or set sensor refresh to 5–10 seconds. **Compact** mode also reduces UI work. See [Performance and stability](#performance-and-stability) for details.

**Windows says "protected your PC" when I run the `.exe`. Is it safe?**  
That is **Microsoft SmartScreen** blocking unsigned downloads from the internet — common for indie/open-source apps. HeatLens is open source; you can inspect the code or run from source. To launch the portable exe: click **More info** → **Run anyway**. See [docs/CODE_SIGNING.md](docs/CODE_SIGNING.md) for signing and reputation options.

## Heat math

HeatLens uses standard conversion constants:

```text
BTU/hr = watts × 3.412141633
BTU     = watt-hours × 3.412141633
kWh/hr  = watts / 1000
```

Session energy uses trapezoidal integration between samples so short spikes are averaged more fairly than a simple snapshot sum.

When direct sensors only cover CPU/GPU package power, HeatLens can add labeled estimates for motherboard/platform load, RAM DIMMs, NVMe/storage, and PSU conversion loss. Estimated rows are marked with `~` and shown separately in the Sensors view.

Ambient temperature input unlocks above-ambient delta, still-air room rise per 1,000 ft³ (~28 m³), and approximate **cooling airflow (CFM)** needed for a 10 °F exhaust rise (10 °C in metric). Ambient does not add BTU/hr by itself.

The CFM estimate assumes ideal exhaust: all PC heat leaves in the airstream at the target temperature rise. Real rooms mix air, leak heat to walls, and rarely match a single exhaust point — treat the number as context, not a specification.

A wall power meter is still the gold standard for whole-system room heat, because software sensors may omit monitor power, some PSU losses, or parts of the platform.

## License

MIT — see [LICENSE](LICENSE).

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## Support

If HeatLens is useful to you, [buy me a coffee](https://buymeacoffee.com/arogorn993hue) — totally optional, but appreciated.
