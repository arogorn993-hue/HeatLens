@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath 'py' -ArgumentList '-3', '\"%~dp0hardware_heat_widget.py\"' -Verb RunAs"
