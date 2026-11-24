param([switch]$SkipBuild)
$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
Push-Location $taskRoot
try {
    if (-not $SkipBuild) {
        npm run desktop:build
        if ($LASTEXITCODE -ne 0) { throw 'Desktop build failed' }
    }
    $taskVersion = (Get-Content -LiteralPath 'package.json' -Raw | ConvertFrom-Json).version
    $taskTauriVersion = (Get-Content -LiteralPath 'src-tauri/tauri.conf.json' -Raw | ConvertFrom-Json).version
    if ($taskVersion -ne $taskTauriVersion) { throw 'Application versions do not match' }
    $taskExe = Join-Path $taskRoot 'src-tauri/target/release/uzi-desktop.exe'
    if ((Get-Item -LiteralPath $taskExe).VersionInfo.ProductVersion -ne $taskVersion) { throw 'Build the executable for the current version before packaging' }
    $taskFolder = Join-Path $taskRoot "release/updates/$taskVersion"
    New-Item -ItemType Directory -Force -Path $taskFolder | Out-Null
    $taskTarget = Join-Path $taskFolder "uzi-kab-$taskVersion.exe"
    Copy-Item -LiteralPath $taskExe -Destination $taskTarget
    $taskHash = (Get-FileHash -LiteralPath $taskExe -Algorithm SHA256).Hash
    if ((Get-FileHash -LiteralPath $taskTarget -Algorithm SHA256).Hash -ne $taskHash) { throw 'Packaged executable differs from build output' }
    $taskOtherFiles = Get-ChildItem -LiteralPath $taskFolder -File | Where-Object { $_.Name -notin @("uzi-kab-$taskVersion.exe", 'uzi.lock') }
    if ($taskOtherFiles) { throw 'Update folder contains files other than the executable or its runtime lock' }
    @{version=$taskVersion;asset="uzi-kab-$taskVersion.exe";sha256=$taskHash;bytes=(Get-Item -LiteralPath $taskTarget).Length;databaseIncluded=$false} |
        ConvertTo-Json | Set-Content -LiteralPath "docs/release-$taskVersion-check.json" -Encoding UTF8
    $taskOfficeFolder = Join-Path $taskRoot 'release/Кабинет УЗИ'
    New-Item -ItemType Directory -Force -Path $taskOfficeFolder | Out-Null
    $taskOfficeTarget = Join-Path $taskOfficeFolder "uzi-kab-$taskVersion.exe"
    Copy-Item -LiteralPath $taskExe -Destination $taskOfficeTarget
    if ((Get-FileHash -LiteralPath $taskOfficeTarget -Algorithm SHA256).Hash -ne $taskHash) { throw 'Office executable differs from build output' }
    Write-Output "Ready: $taskTarget"
    Write-Output "Ready: $taskOfficeTarget"
} finally { Pop-Location }
