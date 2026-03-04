@echo off
echo ========================================
echo Car Rental System - Database Setup
echo ========================================
echo.

set DB_PATH=%~dp0Database

REM Prompt for database credentials
set /p DB_HOST="Enter MySQL host (default: localhost): "
if "%DB_HOST%"=="" set DB_HOST=localhost

set /p DB_USER="Enter MySQL username (default: root): "
if "%DB_USER%"=="" set DB_USER=root

set /p DB_PASS="Enter MySQL password: "

set /p DB_NAME="Enter database name (default: car_rental): "
if "%DB_NAME%"=="" set DB_NAME=car_rental

echo.
echo Creating database '%DB_NAME%'...
mysql -h %DB_HOST% -u %DB_USER% -p%DB_PASS% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;"

if %errorLevel% neq 0 (
    echo ERROR: Failed to create database
    echo Please check your MySQL credentials
    pause
    exit /b 1
)

echo ✓ Database created successfully
echo.

if exist "%DB_PATH%\car_rental.sql" (
    echo Importing database schema...
    mysql -h %DB_HOST% -u %DB_USER% -p%DB_PASS% %DB_NAME% < "%DB_PATH%\car_rental.sql"
    
    if %errorLevel% equ 0 (
        echo ✓ Database imported successfully
    ) else (
        echo WARNING: Database import completed with errors
    )
) else (
    echo WARNING: Database SQL file not found at %DB_PATH%\car_rental.sql
)

echo.
echo Database setup complete!
echo Database: %DB_NAME%
echo Host: %DB_HOST%
echo.
echo Don't forget to update your database configuration in:
echo Files\car_rental\application\config\database.php
echo.
pause
