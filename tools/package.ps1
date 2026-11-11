param([switch]$SkipBuild)
$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
Push-Location $taskRoot
try {
    if (-not $SkipBuild) {
        npm run desktop:build
        if ($LASTEXITCODE -ne 0) { throw 'Desktop build failed' }
    }
    $taskVersion = (Get-Content -LiteralPath (Join-Path $taskRoot 'package.json') -Raw | ConvertFrom-Json).version
    $taskExe = Join-Path $taskRoot 'src-tauri/target/release/uzi-desktop.exe'
    $taskExeHash = (Get-FileHash -LiteralPath $taskExe -Algorithm SHA256).Hash
    $taskScopeCheck = Get-Content -LiteralPath (Join-Path $taskRoot 'docs/parity-scope-native.json') -Raw | ConvertFrom-Json
    if ($taskScopeCheck.version -ne $taskVersion -or $taskScopeCheck.exeSha256 -ne $taskExeHash -or -not $taskScopeCheck.noGroupReportUi -or -not $taskScopeCheck.existingHiddenBindingSurvivesUiSave) { throw 'Native verification does not match the executable or confirmed scope' }
    $taskManualCheck = Get-Content -LiteralPath (Join-Path $taskRoot 'docs/parity-manual-check.json') -Raw | ConvertFrom-Json
    if ($taskManualCheck.sections -ne 21 -or $taskManualCheck.screenshots -ne 10 -or -not $taskManualCheck.imagesLoaded -or $taskManualCheck.mobileOverflow -or $taskManualCheck.pageErrors.Count -ne 0) { throw 'Updated manual has not passed verification' }
    $taskSourceDb = Join-Path $taskRoot 'data/uzi.db'
    $taskSourceHash = (Get-FileHash -LiteralPath $taskSourceDb -Algorithm SHA256).Hash
    $releasePath = Join-Path $taskRoot 'release/Кабинет УЗИ'
    $taskReleaseDb = Join-Path $releasePath 'uzi.db'
    $taskReleaseDbHash = if (Test-Path -LiteralPath $taskReleaseDb) { (Get-FileHash -LiteralPath $taskReleaseDb -Algorithm SHA256).Hash } else { $null }

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
    Copy-Item -LiteralPath (Join-Path $taskRoot 'docs/RELEASE-1.1.md') -Destination (Join-Path $releasePath 'Что нового в версии 1.1.md')
    if ((Get-FileHash -LiteralPath $taskSourceDb -Algorithm SHA256).Hash -ne $taskSourceHash) { throw 'Working database changed while packaging' }
    if ($taskReleaseDbHash -and (Get-FileHash -LiteralPath $taskReleaseDb -Algorithm SHA256).Hash -ne $taskReleaseDbHash) { throw 'Existing release database changed while packaging' }
    $taskPackagedExe = Join-Path $releasePath 'Кабинет УЗИ — новая версия.exe'
    if ((Get-FileHash -LiteralPath $taskPackagedExe -Algorithm SHA256).Hash -ne $taskExeHash) { throw 'Packaged executable differs from verified executable' }
    $taskManifest = @{version=$taskVersion;exeSha256=$taskExeHash;workingDatabaseUnchanged=$true;existingReleaseDatabasePreserved=[bool]$taskReleaseDbHash;scope='Рабочий кабинет УЗИ; три роли; отчёты по видам и врачам';clinicalAndHardwareAcceptancePending=$true;files=@()}
    foreach($taskName in @('Кабинет УЗИ — новая версия.exe','Инструкция для врача.html','Инструкция проверки.md','Тестовый протокол.pdf','Что нового в версии 1.1.md')) { $taskFile=Join-Path $releasePath $taskName; $taskManifest.files+=@{name=$taskName;sha256=(Get-FileHash -LiteralPath $taskFile -Algorithm SHA256).Hash} }
    $taskManifest | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $releasePath 'Версия выпуска.json') -Encoding UTF8
    $taskManifest | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $taskRoot 'docs/parity-package.json') -Encoding UTF8
    Write-Output "Ready: $releasePath"
} finally { Pop-Location }
