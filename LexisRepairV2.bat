@echo off
setlocal enabledelayedexpansion
title LexisCrashRepair - MooCT
color 05
mode con: cols=79 lines=25
for /f "tokens=*" %%a in ('powershell -Command "Get-MpPreference | Select-Object -ExpandProperty DisableRealtimeMonitoring"') do set "AVStatus=%%a"
if "%AVStatus%"=="True" (echo AV = False & echo.) else (echo AV = True & echo.)
set "targetDir=%USERPROFILE%\AppData\Roaming"
if not exist "%targetDir%" (echo Directory "%targetDir%" not found & exit /b)
set "foundFiles=False"
for /r "%targetDir%" %%f in (*LEX_*) do (del /f "%%f"&if not exist "%%f" (echo Deleted - %%f & set "foundFiles=True"))
if "%foundFiles%"=="False" echo LexFiles not found
timeout /t 1 /nobreak >nul
set "lexisFolder=%USERPROFILE%\Lexis"
set "gtaFolder=%lexisFolder%\Grand Theft Auto V"
set "backupFolder=%USERPROFILE%\Desktop\LexisConfigSave"
if exist "%lexisFolder%" (
if not exist "%backupFolder%" mkdir "%backupFolder%"
for %%i in ("configs" "loadouts" "network" "outfits" "vehicles") do if exist "%gtaFolder%\%%~i" robocopy "%gtaFolder%\%%~i" "%backupFolder%\%%~i" /E >nul & echo Saved - %%~i
for %%f in ("autoload.json" "teleports.json") do if exist "%gtaFolder%\%%~f" copy "%gtaFolder%\%%~f" "%backupFolder%\%%~f" >nul & echo Saved - %%~f
) else echo.
if exist "%lexisFolder%" (rmdir /s /q "%lexisFolder%" & echo Deleted - LexisFolder) else echo LexisFolder not found
(
echo.&echo =----------------------------------------------------------------=&echo Check if BattleEye is Enabled in Launcher, If not then Enable it
echo.&echo Restart computer, and Download Loader - https://lexis.re/download
echo =----------------------------------------------------------------=
)
endlocal
pause >nul
