param([string]$AppFolder = $PSScriptRoot)
$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$report = New-Object System.Collections.Generic.List[string]
function Add-Line([string]$text) { $report.Add($text); Write-Host $text }
Add-Line 'Кабинет УЗИ — проверка компьютера'
Add-Line ('Дата: ' + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
$win = Get-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
Add-Line ('Windows: сборка ' + $win.CurrentBuild + '; выпуск ' + $win.DisplayVersion + '; ' + $env:PROCESSOR_ARCHITECTURE)
if ([Environment]::Is64BitOperatingSystem -and [int]$win.CurrentBuild -ge 10240) { Add-Line 'ОС: подходит для этой сборки x64' } else { Add-Line 'ОС: требуется Windows 10/11 x64' }
$runtime = @('HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}', 'HKLM:\SOFTWARE\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}', 'HKCU:\Software\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}') | ForEach-Object { (Get-ItemProperty -LiteralPath $_ -Name pv -ErrorAction SilentlyContinue).pv } | Where-Object { $_ -and $_ -ne '0.0.0.0' }
if ($runtime) { Add-Line ('WebView2: ' + ($runtime -join ', ')) } else { Add-Line 'WebView2 не найден. Установите автономный установщик из requirements.' }
$database = Join-Path $AppFolder 'uzi.db'
if (Test-Path -LiteralPath $database) { Add-Line ('База найдена; размер МБ: ' + [math]::Round((Get-Item -LiteralPath $database).Length / 1MB, 1)) } else { Add-Line 'База uzi.db рядом с программой не найдена' }
$exe = Join-Path $AppFolder 'Кабинет УЗИ — новая версия.exe'
Add-Line ('Новая программа найдена: ' + (Test-Path -LiteralPath $exe))
$probe = Join-Path $AppFolder ('.write-check-' + [guid]::NewGuid().ToString('N'))
try { [IO.File]::WriteAllText($probe, 'ok'); Remove-Item -LiteralPath $probe; Add-Line 'Запись в папку разрешена' } catch { Add-Line ('Нет записи в папку: ' + $_.Exception.Message) }
try { $drive = New-Object IO.DriveInfo([IO.Path]::GetPathRoot((Resolve-Path -LiteralPath $AppFolder).Path)); Add-Line ('Свободно ГБ: ' + [math]::Round($drive.AvailableFreeSpace / 1GB, 1)) } catch { Add-Line 'Свободное место: не удалось определить' }
try { $printers = @(Get-CimInstance Win32_Printer); if ($printers.Count) { foreach ($printer in $printers) { Add-Line ('Принтер: ' + $printer.Name + '; драйвер: ' + $printer.DriverName + '; по умолчанию: ' + $printer.Default) } } else { Add-Line 'Принтеров не найдено' } } catch { Add-Line 'Не удалось получить список принтеров' }
Add-Line 'Эта проверка не заменяет запуск приложения и пробную печать по инструкции.'
$output = Join-Path $AppFolder ('Проверка компьютера-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.txt')
try { $report | Set-Content -LiteralPath $output -Encoding UTF8; Write-Host ('Отчёт сохранён: ' + $output) } catch { Write-Host 'Отчёт не удалось сохранить; скопируйте текст этого окна.' }
