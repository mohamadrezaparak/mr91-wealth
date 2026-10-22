@echo off
setlocal
cd /d "%~dp0"
set "GRADLE_VERSION=8.9"
set "GRADLE_HOME=%USERPROFILE%\.gradle\mr91-gradle-%GRADLE_VERSION%"
if not exist "%GRADLE_HOME%\bin\gradle.bat" (
  echo Downloading Gradle %GRADLE_VERSION%...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; New-Item -ItemType Directory -Force -Path '%USERPROFILE%\.gradle' | Out-Null; Invoke-WebRequest 'https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip' -OutFile '%USERPROFILE%\.gradle\mr91-gradle.zip'; Expand-Archive -Force '%USERPROFILE%\.gradle\mr91-gradle.zip' '%USERPROFILE%\.gradle'; Move-Item -Force '%USERPROFILE%\.gradle\gradle-%GRADLE_VERSION%' '%GRADLE_HOME%'"
  if errorlevel 1 (echo Gradle download failed. Open the project in Android Studio and let it configure Gradle. & pause & exit /b 1)
)
call "%GRADLE_HOME%\bin\gradle.bat" assembleDebug
if errorlevel 1 (echo Build failed. Check Android SDK installation and Gradle output. & pause & exit /b 1)
echo.
echo APK created at: app\build\outputs\apk\debug\app-debug.apk
pause
