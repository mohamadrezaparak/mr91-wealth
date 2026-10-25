@echo off
setlocal
set "APP_HOME=%~dp0"
set "GRADLE_VERSION=8.9"
set "GRADLE_HOME=%USERPROFILE%\.gradle\mr91-wrapper\gradle-%GRADLE_VERSION%"
set "GRADLE_BIN=%GRADLE_HOME%\bin\gradle.bat"
if not exist "%GRADLE_BIN%" (
  set "ZIP_PATH=%USERPROFILE%\.gradle\mr91-wrapper\gradle-%GRADLE_VERSION%-bin.zip"
  if not exist "%USERPROFILE%\.gradle\mr91-wrapper" mkdir "%USERPROFILE%\.gradle\mr91-wrapper"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip' -OutFile '%ZIP_PATH%'"
  if errorlevel 1 exit /b %errorlevel%
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Force '%ZIP_PATH%' '%USERPROFILE%\.gradle\mr91-wrapper'"
  if errorlevel 1 exit /b %errorlevel%
)
call "%GRADLE_BIN%" -p "%APP_HOME%" %*
exit /b %errorlevel%
