Set-Location -LiteralPath (Split-Path -Parent $PSScriptRoot)
git config core.hooksPath .githooks
Write-Output "Git hooks enabled: commits will strip Cursor co-author lines automatically."
