@echo off
::option extension
REM set "_ext=mp4"

if "%~1"=="" echo onlydragand drop file or folder&pause&exit

if exist "%~1\" (
	set "_path=%~1"
	::its a folder get file extension from the last file in folder
	for %%g in ("%~1\*") do set "_ext=%%~xg"
)else (
	set "_path=%cd%"
	set "_ext=%~x1"
)

type nul>"%temp%\index.1"
type nul>"%temp%\rand.1"
type nul>"%temp%\mylist.1"

set /a _max=0
for %%g in ("%_path%\*.%_ext%") do call :make_index "%%g"

::generate a random list of numbers, check for repeated
set /a _files=0
echo Making the random list...
:while_loop
if %_files% equ %_max% goto while_out

REM set /a _rand=(%random%%%(max-min+1))+min
set /a "_rand=(%random%%%%_max%)+1"
findstr /b /r /c:"^%_rand%$" "%temp%\rand.1" >nul
if %errorlevel% equ 0 goto :while_loop
(echo %_rand%)>>"%temp%\rand.1"

for /f "tokens=2 delims=	" %%g in ('findstr /b /c:"%_rand%	" "%temp%\index.1"') do (
	(echo file '%%~g')>>"%temp%\mylist.1"
)

set /a _files+=1
title %_files% / %_max%
goto :while_loop
:while_out
cd /d "%~dp0"
copy /y "%temp%\mylist.1" mylist.txt

if not exist "ffmpeg.exe" echo ffmpeg was not found&pause&exit
ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.%_ext%

title FINISHED
pause&exit
:make_index
set /a _max+=1
(echo %_max%	%1) >>"%temp%\index.1"
exit /b
