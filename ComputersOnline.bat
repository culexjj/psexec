REM :: % loop will read the computer names from a file (computers.txt) executing the installation command line for each one. %
REM :: % In addition to this, we set a couple of log files. the first one gives us the exit code of the process (log.txt) %
REM :: % the second one, the detail of what have happened just in case we have to do some debugging (detail_%MYDATE: =%.log). %
REM :: % be sure you run it with proper rights %
REM :: % acknowledgements to everyones help me to set up this batch, included stackoverflow.com, docs.microsoft.com, forum.sysinternals.com, ss64.com and a lot of more %

cls

@ECHO OFF

echo ** CHECKING COMPUTERS ONLINE ** 

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


REM :: % Deleting previous log file %
del "log.txt"


REM :: % Loop %
for /F "tokens=*" %%a in (computers.txt) do (
ping -n 1 %%a | findstr /r /c:"[0-9] *ms" >> detail_%MYDATE: =%.log 2>&1

REM :: % We use two echo commands, the first one send the output to STDOUT and the second one to a log file %
REM :: % Solo los equipos que dan respuesta aparecen en log2.txt con exit code 0 %
echo ##### Ping Computer %%a #####  exit code: !errorlevel!
echo ##### Ping Computer %%a #####  exit code: !errorlevel! >> log.txt 2>&1
)

pause



