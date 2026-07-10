# HeatLens 0.1.7

Desktop widget for PC wattage and room heat in BTU/hr.

## What's new in 0.1.7

- **Metric units** in Options (°C, kW, kWh) with ambient auto-conversion and one-decimal precision
- **Y-axis value toggle** on trend graphs
- **Export options**: Excel or CSV, column units, timestamp format, CSV delimiter, headers, and Excel formatting

## Downloads

| Platform | File |
|----------|------|
| Windows | `HeatLens.exe` |
| Linux | `HeatLens` or `HeatLens-linux-x86_64.tar.gz` |
| macOS | `HeatLens-macos-arm64.tar.gz` |

## Install (portable)

**Windows:** Download `HeatLens.exe`. If SmartScreen appears: **More info** → **Run anyway**.

**Linux:** Extract the archive, then `chmod +x HeatLens && ./HeatLens`

**macOS:** Extract, open `HeatLens.app` (right-click → **Open** if blocked)

## From source

```bash
git checkout v0.1.7
py -3 -m pip install -r requirements.txt
py -3 hardware_heat_widget.py
```
