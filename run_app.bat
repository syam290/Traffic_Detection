@echo off
SETLOCAL EnableDelayedExpansion

echo ===================================================
echo      Smart Traffic Analysis System - Launcher
echo ===================================================

REM 1. Check for Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in PATH.
    pause
    exit /b
)

REM 2. Install Dependencies
echo [INFO] Installing/Verifying dependencies...
pip install -r backend/requirements.txt
pip install -r frontend/requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies.
    pause
    exit /b
)

REM 3. Cleanup existing processes
echo [INFO] Cleaning up old processes...
taskkill /F /IM python.exe /T >nul 2>&1

REM 4. Start Backend (Traffic Analyzer)
echo.
echo [INFO] Starting Traffic Analysis Backend (Verified Stable Streaming)...
echo     - Using video file: C:\Users\megha\Videos\tracked_output_static_roi.avi
echo     - Mode: API Engine (MJPEG Stream)
start "Traffic Analyzer Backend" cmd /k "python backend/api_engine.py"

REM 4. Start Frontend (Dashboard)
echo.
echo [INFO] Starting Dashboard...
timeout /t 5 /nobreak >nul
start "Traffic Dashboard" cmd /k "streamlit run frontend/app.py"

echo.
echo [SUCCESS] System is running!
echo     - Backend is processing video in a separate window.
echo     - Dashboard should open in your browser automatically.
echo.
pause
