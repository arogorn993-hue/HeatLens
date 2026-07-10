#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "Installing build dependencies..."
python3 -m pip install -r requirements.txt -r requirements-build.txt

echo "Building HeatLens macOS app..."
python3 -m PyInstaller --noconfirm --clean heatlens.spec

ARCH="$(uname -m)"
ARCHIVE="$ROOT/dist/HeatLens-macos-${ARCH}.tar.gz"

if [[ -d "$ROOT/dist/HeatLens.app" ]]; then
  tar -czf "$ARCHIVE" -C "$ROOT/dist" HeatLens.app
  echo ""
  echo "Done."
  echo "  App:     $ROOT/dist/HeatLens.app"
  echo "  Archive: $ARCHIVE"
  echo ""
  echo "Run: open dist/HeatLens.app"
  echo "If macOS blocks the app, right-click → Open once, or run:"
  echo "  xattr -dr com.apple.quarantine dist/HeatLens.app"
elif [[ -f "$ROOT/dist/HeatLens" ]]; then
  chmod +x "$ROOT/dist/HeatLens"
  tar -czf "$ARCHIVE" -C "$ROOT/dist" HeatLens
  echo ""
  echo "Done."
  echo "  Binary:  $ROOT/dist/HeatLens"
  echo "  Archive: $ARCHIVE"
else
  echo "Build failed: no HeatLens.app or HeatLens binary in dist/." >&2
  exit 1
fi
