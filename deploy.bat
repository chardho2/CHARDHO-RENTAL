@echo off
echo ========================================
echo Car Rental System - Deployment Script
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please run this script as Administrator
    pause
    exit /b 1
)

REM Set project paths
set PROJECT_ROOT=%~dp0
set APP_PATH=%PROJECT_ROOT%Files\car_rental
set DB_PATH=%PROJECT_ROOT%Database

echo [1/5] Checking prerequisites...
echo.

REM Check PHP
php -v >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: PHP is not installed or not in PATH
    echo Please install PHP 7.4+ and add it to your system PATH
    pause
    exit /b 1
)
echo ✓ PHP found

REM Check MySQL
mysql --version >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: MySQL is not installed or not in PATH
    echo Please install MySQL/MariaDB and add it to your system PATH
    pause
    exit /b 1
)
echo ✓ MySQL found

echo.
echo [2/5] Setting up database...
echo.

REM Prompt for database credentials
set /p DB_HOST="Enter MySQL host (default: localhost): " || set DB_HOST=localhost
set /p DB_USER="Enter MySQL username (default: root): " || set DB_USER=root
set /p DB_PASS="Enter MySQL password: "
set /p DB_NAME="Enter database name (default: car_rental): " || set DB_NAME=car_rental

REM Create database and import schema
echo Creating database...
mysql -h %DB_HOST% -u %DB_USER% -p%DB_PASS% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;" 2>nul
if %errorLevel% neq 0 (
    echo ERROR: Failed to create database. Please check your credentials.
    pause
    exit /b 1
)

echo Importing database schema...
if exist "%DB_PATH%\car_rental.sql" (
    mysql -h %DB_HOST% -u %DB_USER% -p%DB_PASS% %DB_NAME% < "%DB_PATH%\car_rental.sql"
    if %errorLevel% equ 0 (
        echo ✓ Database imported successfully
    ) else (
        echo WARNING: Database import had errors
    )
) else (
    echo WARNING: Database file not found at %DB_PATH%\car_rental.sql
)

echo.
echo [3/5] Configuring application...
echo.

REM Update database configuration
set CONFIG_FILE=%APP_PATH%\application\config\database.php
if exist "%CONFIG_FILE%" (
    echo Updating database configuration...
    powershell -Command "(Get-Content '%CONFIG_FILE%') -replace \"'hostname' => '.*'\", \"'hostname' => '%DB_HOST%'\" | Set-Content '%CONFIG_FILE%'"
    powershell -Command "(Get-Content '%CONFIG_FILE%') -replace \"'username' => '.*'\", \"'username' => '%DB_USER%'\" | Set-Content '%CONFIG_FILE%'"
    powershell -Command "(Get-Content '%CONFIG_FILE%') -replace \"'password' => '.*'\", \"'password' => '%DB_PASS%'\" | Set-Content '%CONFIG_FILE%'"
    powershell -Command "(Get-Content '%CONFIG_FILE%') -replace \"'database' => '.*'\", \"'database' => '%DB_NAME%'\" | Set-Content '%CONFIG_FILE%'"
    echo ✓ Database configuration updated
) else (
    echo WARNING: Database config file not found
)

echo.
echo [4/5] Setting up web server...
echo.

REM Check if Apache is running
sc query Apache2.4 >nul 2>&1
if %errorLevel% equ 0 (
    echo Apache service found
    set /p START_APACHE="Start/Restart Apache? (Y/N): "
    if /i "%START_APACHE%"=="Y" (
        net stop Apache2.4 >nul 2>&1
        net start Apache2.4
        echo ✓ Apache restarted
    )
) else (
    echo Apache service not found. Starting PHP built-in server...
    set /p PORT="Enter port number (default: 8000): " || set PORT=8000
    cd /d "%APP_PATH%"
    start "Car Rental Server" php -S localhost:%PORT%
    echo ✓ PHP server started on http://localhost:%PORT%
)

echo.
echo [5/5] Final checks...
echo.

REM Set permissions for writable directories
if exist "%APP_PATH%\application\logs" (
    echo Setting permissions for logs directory...
    icacls "%APP_PATH%\application\logs" /grant Everyone:(OI)(CI)F /T >nul 2>&1
)

if exist "%APP_PATH%\application\cache" (
    echo Setting permissions for cache directory...
    icacls "%APP_PATH%\application\cache" /grant Everyone:(OI)(CI)F /T >nul 2>&1
)

if exist "%APP_PATH%\public\assets\img" (
    echo Setting permissions for uploads directory...
    icacls "%APP_PATH%\public\assets\img" /grant Everyone:(OI)(CI)F /T >nul 2>&1
)

echo.
echo ========================================
echo Deployment Complete!
echo ========================================
echo.
echo Application URL: http://localhost:%PORT%
echo Database: %DB_NAME%
echo.
echo IMPORTANT NEXT STEPS:
echo 1. Change default admin password after first login
echo 2. Review application/config/config.php for production settings
echo 3. Set ENVIRONMENT to 'production' in index.php for production use
echo.
pause
