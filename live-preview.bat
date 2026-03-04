@echo off
title Car Rental System - Live Preview
color 0B

cls
echo ========================================
echo   CAR RENTAL SYSTEM - LIVE PREVIEW
echo ========================================
echo.
echo Opening preview pages in your browser...
echo.

set APP_PATH=%~dp0Files\car_rental

start "" "%APP_PATH%\home_preview.html"
timeout /t 2 /nobreak >nul

start "" "%APP_PATH%\design_preview.html"
timeout /t 2 /nobreak >nul

start "" "%APP_PATH%\driver_portal_preview.html"
timeout /t 2 /nobreak >nul

start "" "%APP_PATH%\live_admin_preview.html"
timeout /t 2 /nobreak >nul

start "" "%APP_PATH%\portals.html"

echo.
echo ✓ Preview pages opened in browser
echo.
echo Available Previews:
echo - Home Page
echo - Design Preview
echo - Driver Portal
echo - Admin Panel
echo - Portals Overview
echo.
pause
