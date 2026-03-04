@echo off
title Car Rental - Backend Server
color 0A

cls
echo ========================================
echo   CAR RENTAL BACKEND SERVER
echo ========================================
echo.

set APP_PATH=%~dp0Files\car_rental
set PORT=8080

echo Starting PHP Backend Server...
echo.
echo API Endpoints:
echo   http://localhost:%PORT%/status
echo   http://localhost:%PORT%/cars
echo   http://localhost:%PORT%/bookings
echo   http://localhost:%PORT%/drivers
echo   http://localhost:%PORT%/customers
echo.
echo Press Ctrl+C to stop
echo.

cd /d "%APP_PATH%"
php -S localhost:%PORT% backend-server.php
