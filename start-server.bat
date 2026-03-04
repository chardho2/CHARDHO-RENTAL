@echo off
echo ========================================
echo Car Rental System - Quick Start
echo ========================================
echo.

set APP_PATH=%~dp0Files\car_rental
set PORT=8000

REM Check if PHP is available
php -v >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: PHP is not installed or not in PATH
    pause
    exit /b 1
)

echo Starting PHP development server...
echo.
echo Server URL: http://localhost:%PORT%
echo Press Ctrl+C to stop the server
echo.

cd /d "%APP_PATH%"
php -S localhost:%PORT%

pause
