@echo off
title Car Rental - Complete Deployment
color 0A

cls
echo ========================================
echo   CAR RENTAL SYSTEM
echo   Complete Deployment
echo ========================================
echo.

set APP_PATH=%~dp0Files\car_rental

echo [1] Starting Backend Server (Port 8080)...
start "Backend Server" cmd /k "%~dp0start-backend.bat"
timeout /t 3 /nobreak >nul

echo [2] Opening API Tester...
start "" "%APP_PATH%\api-tester.html"
timeout /t 2 /nobreak >nul

echo [3] Opening Preview Pages...
start "" "%APP_PATH%\home_preview.html"
timeout /t 1 /nobreak >nul
start "" "%APP_PATH%\live_admin_preview.html"

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo.
echo Backend API: http://localhost:8080
echo API Tester:  Opened in browser
echo Previews:    Opened in browser
echo.
echo Press any key to exit...
pause >nul
