@echo off
echo ==========================================
echo DEPLOYING TO STAGING ENV (Port 9999)
echo ==========================================

:: 1. Kill the old process if it exists (Using Window Title to be safe)
taskkill /F /FI "WINDOWTITLE eq STAGING_APP" 2>NUL

:: 2. Wait a second for cleanup
timeout /t 2 /nobreak >NUL

:: 3. Start the new app in background with a specific Title
:: We use 'target\java-webapp-1.0.jar' assuming the script runs from workspace root
echo Starting new application...
start "STAGING_APP" /B java -jar target\java-webapp-1.0.jar --server.port=9999

echo Deployment Triggered.
exit 0
