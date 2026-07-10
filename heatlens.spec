# PyInstaller spec for HeatLens portable builds.
# Run: pyinstaller heatlens.spec  (or use scripts/build_windows.ps1 / build_linux.sh)

import sys
from pathlib import Path

block_cipher = None
root = Path(SPECPATH)

hiddenimports = [
    "psutil",
    "openpyxl",
    "openpyxl.styles",
    "openpyxl.utils",
]

if sys.platform == "win32":
    hiddenimports.extend(
        [
            "win32com.client",
            "pythoncom",
            "pywintypes",
        ]
    )

a = Analysis(
    [str(root / "hardware_heat_widget.py")],
    pathex=[str(root)],
    binaries=[],
    datas=[],
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name="HeatLens",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    version_file=None,
)
