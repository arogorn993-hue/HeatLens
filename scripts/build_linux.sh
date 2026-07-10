#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "Installing build dependencies..."
python3 -m pip install -r requirements.txt -r requirements-build.txt

echo "Building HeatLens binary..."
python3 -m PyInstaller --noconfirm --clean heatlens.spec

OUT="$ROOT/dist/HeatLens"
if [[ ! -f "$OUT" ]]; then
  echo "Build failed: $OUT was not created." >&2
  exit 1
fi

chmod +x "$OUT"

ARCHIVE="$ROOT/dist/HeatLens-linux-$(uname -m).tar.gz"
tar -czf "$ARCHIVE" -C "$ROOT/dist" HeatLens

echo ""
echo "Done."
echo "  Binary:  $OUT"
echo "  Archive: $ARCHIVE"
echo ""
echo "Run: ./dist/HeatLens"
echo "For RAPL/hwmon sensors you may need permissions; see README."
