@echo off
chcp 65001 >nul
title Fix Roblox CDN (hosts)

:: --- Проверка прав администратора ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Требуются права администратора. Перезапуск...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "HOSTS=C:\Windows\System32\drivers\etc\hosts"

:: --- Удаляем старые записи tr.rbxcdn.com ---
findstr /V /I "tr.rbxcdn.com" "%HOSTS%" > "%TEMP%\hosts_new"
move /Y "%TEMP%\hosts_new" "%HOSTS%" >nul

:: --- Добавляем новые записи ---
(
echo.
echo # Roblox CDN fix
echo 18.64.211.78 tr.rbxcdn.com
echo 18.64.211.88 tr.rbxcdn.com
echo 128.116.126.3 tr.rbxcdn.com
) >> "%HOSTS%"

echo Новые записи добавлены.

:: --- Сброс DNS ---
echo Сброс DNS-кэша...
ipconfig /flushdns

echo.
echo Готово! Нажмите любую клавишу для выхода.
pause >nul
