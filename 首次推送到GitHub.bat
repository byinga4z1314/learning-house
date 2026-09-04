@echo off
REM ==========================================================
REM  Learning House - First Push to GitHub
REM
REM  BEFORE running this:
REM  Create an empty PRIVATE repo named "learning-house" at
REM  https://github.com/new  (do NOT add README or .gitignore)
REM ==========================================================

REM Add WorkBuddy portable git to PATH so cmd can find "git"
set "PATH=C:/Users/bying/.workbuddy/binaries/PortableGit/versions/1.2.0/cmd;%PATH%"

cd /d "D:/learning-house"

set /p GHUSER=Enter your GitHub username:

if "%GHUSER%"=="" (
  echo.
  echo [ERROR] Username cannot be empty.
  pause
  exit /b 1
)

echo.
echo Repository : https://github.com/%GHUSER%/learning-house.git
echo Branch     : main
echo.
echo A browser window will open for GitHub login - please authorize it.
echo.
pause

git remote remove origin 2>nul
git remote add origin https://github.com/%GHUSER%/learning-house.git
git branch -M main
git push -u origin main

echo.
if errorlevel 1 (
  echo [FAILED] Push did not succeed. Read the message above.
  echo Common causes:
  echo   - Repo "learning-house" not created yet
  echo   - Browser login was cancelled
  echo   - Network cannot reach github.com
) else (
  echo [SUCCESS] Pushed to GitHub!
  echo Next step: connect this repo in Cloudflare Pages.
)
echo.
pause
