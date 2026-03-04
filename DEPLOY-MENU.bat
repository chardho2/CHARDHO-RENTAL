@echo off
title Car Rental System - Deployment Manager
color 0A

:MENU
cls
echo ========================================
echo   CAR RENTAL SYSTEM - DEPLOYMENT
echo ========================================
echo.
echo   1. Full Deployment (Setup Everything)
echo   2. Database Setup Only
echo   3. Start Server
echo   4. Preview Application
echo   5. Check Status
echo   6. View Installation Guide
echo   7. Exit
echo.
echo ========================================
set /p choice="Select option (1-7): "

if "%choice%"=="1" goto DEPLOY
if "%choice%"=="2" goto DATABASE
if "%choice%"=="3" goto SERVER
if "%choice%"=="4" goto PREVIEW
if "%choice%"=="5" goto STATUS
if "%choice%"=="6" goto GUIDE
if "%choice%"=="7" goto EXIT
goto MENU

:DEPLOY
cls
echo Running Full Deployment...
call deploy.bat
pause
goto MENU

:DATABASE
cls
echo Running Database Setup...
call setup-database.bat
pause
goto MENU

:SERVER
cls
echo Starting Server...
call start-server.bat
goto MENU

:PREVIEW
cls
echo Opening Preview...
call preview.bat
goto MENU

:STATUS
cls
call check-status.bat
goto MENU

:GUIDE
cls
type INSTALL-PREREQUISITES.md
echo.
pause
goto MENU

:EXIT
echo.
echo Goodbye!
timeout /t 2 /nobreak >nul
exit
