@echo off
title Ghidra Setup
echo ===================================================
echo        Ghidra Requirements Installation Script
echo ===================================================
echo.

REM Check for administrative privileges
openfiles >nul 2>nul
if %errorlevel% NEQ 0 (
    echo You must run this script as an administrator.
    pause
    exit /b
)

REM Install Chocolatey if not installed
echo Checking for Chocolatey...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-Command choco 2>&1 | Out-Null; if (-Not $?) {Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))}"
if %errorlevel% NEQ 0 (
    echo Failed to install Chocolatey. Exiting...
    pause
    exit /b
)

REM Install AdoptOpenJDK
echo Installing AdoptOpenJDK...
choco install adoptopenjdk -y
if %errorlevel% NEQ 0 (
    echo Failed to install AdoptOpenJDK. Exiting...
    pause
    exit /b
)

REM Optionally install Git (if you plan to clone Ghidra or its plugins)
echo Installing Git...
choco install git -y
if %errorlevel% NEQ 0 (
    echo Failed to install Git. Exiting...
    pause
    exit /b
)

REM Clone Ghidra repository (optional)
echo Cloning Ghidra repository...
git clone https://github.com/NationalSecurityAgency/ghidra.git
if %errorlevel% NEQ 0 (
    echo Failed to clone Ghidra repository. Exiting...
    pause
    exit /b
)

echo.
echo ===================================================
echo        Ghidra Requirements Installation Complete
echo ===================================================
pause
exit
