"""Capture a HeatLens window screenshot for the README."""
from __future__ import annotations

import sys
import time
from pathlib import Path

import tkinter as tk

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from hardware_heat_widget import HeatLensApp, SensorCollector  # noqa: E402


def main() -> None:
    output = ROOT / "docs" / "screenshot.png"
    output.parent.mkdir(parents=True, exist_ok=True)

    # Prime sensor data so cards are not empty.
    snapshot = SensorCollector().sample()
    root = tk.Tk()
    root.withdraw()
    app = HeatLensApp(root)
    app._apply_snapshot(snapshot, update_session=False)
    root.deiconify()
    root.attributes("-topmost", True)
    root.focus_force()
    root.update_idletasks()
    root.update()
    time.sleep(1.25)
    root.update()

    x = root.winfo_rootx()
    y = root.winfo_rooty()
    width = root.winfo_width()
    height = root.winfo_height()

    try:
        from PIL import ImageGrab
    except ImportError as exc:
        raise SystemExit("Pillow is required: py -3 -m pip install pillow") from exc

    image = ImageGrab.grab(bbox=(x, y, x + width, y + height))
    image.save(output)
    print(f"Saved {output}")
    app.on_close()


if __name__ == "__main__":
    main()
