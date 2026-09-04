@echo off
REM ==========================================================
REM  Learning House - Push to GitHub
REM  Auto-detect proxy, fallback to direct connection
REM ==========================================================

set "PATH=C:/Users/bying/.workbuddy/binaries/gh/bin;C:/Users/bying/.workbuddy/binaries/PortableGit/versions/1.2.0/cmd;%PATH%"

cd /d "D:/learning-house"

echo.
echo === Changed files ===
git status --short
echo.

git add index.html week-*.html *.bat .gitignore
git commit -m "update learning pages"
if errorlevel 1 echo [INFO] No new changes, pushing existing commits...
echo.

REM ===== Try 1: via proxy (Clash 7890) =====
echo [1/2] Try proxy push...
set "HTTP_PROXY=http://127.0.0.1:7890"
set "HTTPS_PROXY=http://127.0.0.1:7890"
git push 2>nul
if not errorlevel 1 goto success

REM ===== Try 2: direct connection, retry 5 times =====
echo [2/2] Proxy unavailable, try direct...
set "HTTP_PROXY="
set "HTTPS_PROXY="
set PUSH_OK=0
for /L %%i in (1,1,5) do (
  echo   Direct attempt %%i...
  git push 2>nul
  if not errorlevel 1 (
    set PUSH_OK=1
    goto push_done
  )
  ping -n 3 127.0.0.1 >nul
)
:push_done
if "%PUSH_OK%"=="1" goto success

REM ===== All failed =====
echo.
echo ========================================
echo [FAILED] Push failed!
echo Possible causes:
echo   1. Network unstable, try again
echo   2. GitHub login expired, re-auth
echo   3. Start Clash proxy then retry
echo ========================================
echo.
pause
exit /b 1

:success
echo.
echo ========================================
echo [SUCCESS] Pushed to GitHub!
echo Cloudflare Pages will deploy in 1-2 min
echo Hard-refresh tablet to see updates
echo ========================================
echo.
ping -n 4 127.0.0.1 >nul
