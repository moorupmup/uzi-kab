param([switch]$SkipBuild)
$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
Push-Location $taskRoot
try {
    if (-not $SkipBuild) {
        npm run desktop:build
        if ($LASTEXITCODE -ne 0) { throw 'Desktop build failed' }
    }
    $releasePath = Join-Path $taskRoot 'release/Кабинет УЗИ'
    New-Item -ItemType Directory -Force $releasePath | Out-Null
    Copy-Item -LiteralPath (Join-Path $taskRoot 'src-tauri/target/release/uzi-desktop.exe') -Destination (Join-Path $releasePath 'Кабинет УЗИ — новая версия.exe')
    $databaseTarget = Join-Path $releasePath 'uzi.db'
    if (Test-Path -LiteralPath $databaseTarget) { Write-Output 'Existing release database preserved' }
    else { Copy-Item -LiteralPath (Join-Path $taskRoot 'data/uzi.db') -Destination $databaseTarget }
    Copy-Item -LiteralPath (Join-Path $taskRoot 'docs/WINDOWS10-ACCEPTANCE.md') -Destination (Join-Path $releasePath 'Инструкция проверки.md')
    Copy-Item -LiteralPath (Join-Path $taskRoot 'docs/Инструкция для врача.html') -Destination (Join-Path $releasePath 'Инструкция для врача.html')
    Copy-Item -LiteralPath (Join-Path $taskRoot 'tools/check-windows.ps1') -Destination (Join-Path $releasePath 'check-windows.ps1')
    Copy-Item -LiteralPath (Join-Path $taskRoot 'docs/Тестовый протокол.pdf') -Destination (Join-Path $releasePath 'Тестовый протокол.pdf')
    $launcher = "@echo off`r`nchcp 65001 >nul`r`npowershell.exe -NoProfile -ExecutionPolicy Bypass -File `"%~dp0check-windows.ps1`"`r`npause`r`n"
    [IO.File]::WriteAllText((Join-Path $releasePath 'Проверить компьютер.cmd'), $launcher, [Text.Encoding]::ASCII)
    [IO.File]::WriteAllText((Join-Path $releasePath 'Инструкция проверки.txt'), [IO.File]::ReadAllText((Join-Path $taskRoot 'docs/WINDOWS10-ACCEPTANCE.md')), (New-Object Text.UTF8Encoding($true)))
    $runtime = Join-Path $taskRoot 'release/requirements/MicrosoftEdgeWebView2RuntimeInstallerX64.exe'
    if (Test-Path -LiteralPath $runtime) {
        $runtimeFolder = Join-Path $releasePath 'requirements'
        New-Item -ItemType Directory -Force $runtimeFolder | Out-Null
        Copy-Item -LiteralPath $runtime -Destination $runtimeFolder
    }
    Write-Output "Ready: $releasePath"
} finally { Pop-Location }
