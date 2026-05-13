@echo off
chcp 65001 >nul
cd /d "%~dp0"
title 小游戏站 - 本地服务器
set PORT=8765
set URL=http://127.0.0.1:%PORT%/index.html

echo ========================================
echo   小游戏站 - 本地预览（必须用 http）
echo ========================================
echo 当前目录: %CD%
echo.
echo 浏览器将打开: %URL%
echo 地址栏必须是 http:// 开头，不能是 file:///
echo 不要关闭本窗口，关闭即停止服务。
echo ========================================
echo.

where py >nul 2>&1
if %errorlevel%==0 goto :use_py

where python >nul 2>&1
if %errorlevel%==0 goto :use_python

where npx >nul 2>&1
if %errorlevel%==0 goto :use_npx

echo [错误] 未找到 Python，也未找到 Node（npx）。
echo.
echo 任选一种安装后即可本机预览：
echo   1^) 安装 Python 3：https://www.python.org/downloads/
echo      安装时勾选 "Add python.exe to PATH"
echo   2^) 安装 Node.js：https://nodejs.org/
echo      安装后本脚本会自动用 npx serve 启动
echo.
pause
exit /b 1

:use_py
start "" "%URL%"
ping -n 2 127.0.0.1 >nul
py -3 -m http.server %PORT%
goto :eof

:use_python
start "" "%URL%"
ping -n 2 127.0.0.1 >nul
python -m http.server %PORT%
goto :eof

:use_npx
echo 使用 Node 的 serve 启动...
start "" "%URL%"
ping -n 2 127.0.0.1 >nul
npx --yes serve . -l %PORT%
goto :eof
