@echo off
echo ========================================
echo Car Rental System - Status Check
echo ========================================
echo.

set APP_PATH=%~dp0Files\car_rental

echo [Checking Prerequisites]
echo.

REM Check PHP
php -v >nul 2>&1
if %errorLevel% equ 0 (
    echo ✓ PHP installed
    php -v | findstr /C:"PHP"
) else (
    echo ✗ PHP not found
)
echo.

REM Check MySQL
mysql --version >nul 2>&1
if %errorLevel% equ 0 (
    echo ✓ MySQL installed
    mysql --version
) else (
    echo ✗ MySQL not found
)
echo.

echo [Checking Files]
echo.

if exist "%APP_PATH%\index.php" (
    echo ✓ Application files found
) else (
    echo ✗ Application files missing
)

if exist "%APP_PATH%\application\config\database.php" (
    echo ✓ Database config found
) else (
    echo ✗ Database config missing
)

if exist "%~dp0Database\car_rental.sql" (
    echo ✓ Database SQL file found
) else (
    echo ✗ Database SQL file missing
)
echo.

echo [Checking Server]
echo.

netstat -ano | findstr ":8000" >nul 2>&1
if %errorLevel% equ 0 (
    echo ✓ Server running on port 8000
    echo   URL: http://localhost:8000
) else (
    echo ✗ Server not running
    echo   Run start-server.bat to start
)
echo.

echo [Checking Permissions]
echo.

if exist "%APP_PATH%\application\logs" (
    echo ✓ Logs directory exists
) else (
    echo ✗ Logs directory missing
)

if exist "%APP_PATH%\application\cache" (
    echo ✓ Cache directory exists
) else (
    echo ✗ Cache directory missing
)
echo.

echo ========================================
echo Status check complete
echo ========================================
pause
