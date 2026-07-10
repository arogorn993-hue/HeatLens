$script = Join-Path -Path $PSScriptRoot -ChildPath "hardware_heat_widget.py"
Start-Process -FilePath "py" -ArgumentList @("-3", "`"$script`"") -Verb RunAs
