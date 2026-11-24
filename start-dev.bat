@echo off
setlocal
chcp 65001 >nul
title Кабинет УЗИ — режим разработки
pushd "%~dp0"
if errorlevel 1 exit /b 1

rem Full Tauri backend; debug builds use data\uzi.db.
if exist "%USERPROFILE%\.cargo\bin\cargo.exe" set "PATH=%USERPROFILE%\.cargo\bin;%PATH%"
where node.exe >nul 2>&1
if errorlevel 1 (
    echo Не найден Node.js. Установите Node.js и повторите запуск.
    goto :failed
)
where npm.cmd >nul 2>&1
if errorlevel 1 (
    echo Не найден npm. Проверьте установку Node.js.
    goto :failed
)
where cargo.exe >nul 2>&1
if errorlevel 1 (
    echo Не найден Rust Cargo. Установите Rust и средства сборки C++ для Windows.
    goto :failed
)
if not exist "data\uzi.db" (
    echo Не найдена база: %CD%\data\uzi.db
    echo Восстановите базу в папке data и повторите запуск.
    goto :failed
)
if not exist "node_modules\@tauri-apps\cli\tauri.js" (
    echo Установка зависимостей приложения...
    call npm.cmd ci
    if errorlevel 1 goto :failed
)

echo Запуск полной версии приложения в режиме разработки...
echo База: %CD%\data\uzi.db
echo Изменения пациентов и исследований сохраняются в этой базе.
echo Первичная сборка может занять несколько минут.
echo Для остановки закройте приложение и нажмите Ctrl+C в этом окне.
echo.
call npm.cmd run desktop -- --config src-tauri/tauri.dev.conf.json
if errorlevel 1 goto :failed
popd
endlocal
exit /b 0

:failed
echo.
echo Запуск не выполнен. Подробности ошибки приведены выше.
pause
popd
endlocal
exit /b 1
