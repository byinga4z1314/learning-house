@echo off
REM ==========================================================
REM  Learning House - One-time GitHub Authorization (via local proxy)
REM  Run this ONCE. After it succeeds, WorkBuddy can push
REM  to GitHub automatically with no further action.
REM ==========================================================

REM Make gh and git available to cmd
set "PATH=C:/Users/bying/.workbuddy/binaries/gh/bin;C:/Users/bying/.workbuddy/binaries/PortableGit/versions/1.2.0/cmd;%PATH%"

REM Route gh and git through the local proxy (Clash on 7890)
set "HTTP_PROXY=http://127.0.0.1:7890"
set "HTTPS_PROXY=http://127.0.0.1:7890"

cd /d "D:/learning-house"

echo.
echo ============================================
echo  Step 1 / 3   Authorize GitHub
echo ============================================
echo.
echo A one-time code will appear below.
echo Press ENTER to open your browser,
echo paste the code, then click "Authorize GitHub".
echo.
pause

gh auth login --web --scopes repo -h github.com

if errorlevel 1 (
  echo.
  echo [FAILED] Authorization did not complete.
  echo Make sure your proxy software is running, then run this script again.
  echo.
  pause
  exit /b 1
)

echo.
echo ============================================
echo  Step 2 / 3   Connect git to gh
echo ============================================
gh auth setup-git

echo.
echo ============================================
echo  Step 3 / 3   Test the connection
echo ============================================
git push origin main

if errorlevel 1 (
  echo.
  echo [FAILED] Push test failed. See message above.
) else (
  echo.
  echo [SUCCESS] GitHub is now connected!
  echo From now on, just tell WorkBuddy "deploy" and it will push for you.
)
echo.
pause
