@echo off
echo ========================================
echo Car Rental System - Preview
echo ========================================
echo.

set APP_PATH=%~dp0Files\car_rental
set PORT=8000

REM Check if PHP is available
php -v >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: PHP not found. Please install PHP first.
    pause
    exit /b 1
)

REM Check if server is already running
netstat -ano | findstr ":%PORT%" >nul 2>&1
if %errorLevel% equ 0 (
    echo Server already running on port %PORT%
    echo Opening browser...
    start http://localhost:%PORT%
    pause
    exit /b 0
)

echo Starting server and opening preview...
echo.

REM Start server in background
cd /d "%APP_PATH%"
start /min "Car Rental Server" php -S localhost:%PORT%

REM Wait for server to start
timeout /t 3 /nobreak >nul

REM Open browser
start http://localhost:%PORT%

echo.
echo ✓ Server started on http://localhost:%PORT%
echo ✓ Browser opened
echo.
echo Press any key to stop the server...
pause >nul

REM Stop server
taskkill /FI "WINDOWTITLE eq Car Rental Server*" /F >nul 2>&1
echo Server stopped.
