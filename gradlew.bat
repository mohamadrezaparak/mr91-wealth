@echo off
setlocal
set "GRADLE_HOME=%USERPROFILE%\.gradle\mr91-gradle-8.9"
if not exist "%GRADLE_HOME%\bin\gradle.bat" (
 echo Run BUILD_APK_WINDOWS.bat once to download Gradle.
 exit /b 1
)
call "%GRADLE_HOME%\bin\gradle.bat" %*
