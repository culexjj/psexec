REM :: % loop will read the computer names from a file (computers.txt) executing the installation command line for each one. %
REM :: % In addition to this, we set a couple of log files. the first one gives us the exit code of the process (log.txt) %
REM :: % the second one, the detail of what have happened just in case we have to do some debugging (detail_%MYDATE: =%.log). %
REM :: % be sure you run it with proper rights %
REM :: % acknowledgements to everyones help me to set up this batch, included stackoverflow.com, docs.microsoft.com, forum.sysinternals.com, ss64.com and a lot of more %

cls

@ECHO OFF

echo ---------------------------------------
echo            Checking HotFix  
echo            %date%  -  %time%
echo ---------------------------------------

REM :: % Deleting previous log file %
del "log.txt"

REM :: % Setting log file date %
set yy=%date:~-4%
set mm=%date:~-7,2%
set dd=%date:~-10,2%
set hh=%time:~0,2%
set mmm=%time:~3,2%
set ss=%time:~6,2%
set MYDATE=%dd%%mm%%yy%%hh%%mmm%%ss%

REM :: % Setting reset for loop environment variable %
REM :: % for expanding variables at execution time %
setlocal enabledelayedexpansion


REM :: % Loop %
for /F "tokens=*" %%a in (computers.txt) do (
echo: >> log_%MYDATE: =%.log
echo ##### Checking Computer %%a ##### >> log_%MYDATE: =%.log
echo: >> log_%MYDATE: =%.log
REM :: % we set between quotes "" the HF number we are looking for %
REM :: % For example "KB2729094 KB2731771 KB2533623 KB2670838 KB2786081 KB2834140"
wmic /node:%%a qfe get hotfixid | findstr /si "KB2729094 KB2731771 KB2533623 KB2670838 KB2786081 KB2834140" >>log_%MYDATE: =%.log 2>&1

REM :: % We use two echo commands, the first one send the output to STDOUT and the second one to a log file %
echo ##### Control HF IE 11 Computer %%a #####  exit code: !errorlevel!
echo ##### Control HF IE 11 Computer %%a #####  exit code: !errorlevel! >>log.txt 2>&1
)

pause

