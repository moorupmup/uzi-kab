$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
$taskExe = Join-Path $taskRoot 'src-tauri/target/release/uzi-desktop.exe'
$taskFolder = Join-Path $taskRoot ('.tools/update-native/' + [Guid]::NewGuid().ToString() + "/Кабинет 'УЗИ'")
New-Item -ItemType Directory -Path $taskFolder -Force | Out-Null
$taskTarget = Join-Path $taskFolder 'Кабинет УЗИ.exe'
$taskStaged = Join-Path $taskFolder 'new.exe'
$taskHelper = Join-Path $taskFolder 'helper.exe'
$taskBackup = Join-Path $taskFolder 'previous.bak'
$taskReady = Join-Path $taskFolder 'ready'
$taskPlan = Join-Path $taskFolder 'plan.json'
Copy-Item -LiteralPath $taskExe -Destination $taskHelper
[IO.File]::WriteAllText($taskTarget, 'original executable fixture')
Copy-Item -LiteralPath (Join-Path $env:SystemRoot 'System32/whoami.exe') -Destination $taskStaged
$taskHash = (Get-FileHash -LiteralPath $taskStaged -Algorithm SHA256).Hash
$taskParent = Start-Process -FilePath 'powershell.exe' -ArgumentList '-NoProfile -Command "Start-Sleep -Seconds 4"' -WindowStyle Hidden -PassThru
$taskPlanData = @{pid=$taskParent.Id;target=$taskTarget;staged=$taskStaged;backup=$taskBackup;ready=$taskReady}
[IO.File]::WriteAllText($taskPlan, ($taskPlanData | ConvertTo-Json), (New-Object Text.UTF8Encoding($false)))
$taskHelperProcess = Start-Process -FilePath $taskHelper -ArgumentList @('--uzi-update-helper', ('"' + $taskPlan + '"')) -WindowStyle Hidden -PassThru
for ($taskAttempt=0; $taskAttempt -lt 100 -and -not (Test-Path -LiteralPath $taskReady); $taskAttempt++) { Start-Sleep -Milliseconds 50 }
if (-not (Test-Path -LiteralPath $taskReady)) { throw 'Helper did not acknowledge parent handle' }
if ($taskParent.HasExited) { throw 'Parent exited before wait verification' }
if ([IO.File]::ReadAllText($taskTarget) -ne 'original executable fixture') { throw 'Target changed before parent exit' }
[IO.File]::WriteAllText((Join-Path $taskFolder 'commit'), 'commit')
if (-not $taskHelperProcess.WaitForExit(15000)) { throw 'Helper timeout' }
if ((Get-FileHash -LiteralPath $taskTarget -Algorithm SHA256).Hash -ne $taskHash) { throw 'New executable was not installed' }
if ([IO.File]::ReadAllText($taskBackup) -ne 'original executable fixture') { throw 'Original executable was not preserved' }
Write-Output 'Passed: real helper waits for parent, replaces EXE at original path, retains original; spaces, Cyrillic and apostrophe in path.'

$taskEvidence=@{version='1.1.0';nativeHelper=$true;waitsForParent=$true;verifiedReplacement=$true;previousExeRetained=$true;cyrillicSpacesAndApostrophePath=$true}
$taskEvidence | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $taskRoot 'docs/parity-updater-helper.json') -Encoding UTF8
