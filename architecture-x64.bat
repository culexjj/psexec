REM :: % loop will read the computer names from a file (computers.txt) executing the installation command line for each one. %
REM :: % In addition to this, we set a couple of log files. the first one gives us the exit code of the process (log.txt) %
REM :: % the second one, the detail of what have happened just in case we have to do some debugging (detail_%MYDATE: =%.log). %
REM :: % be sure you run it with proper rights %
REM :: % acknowledgements to everyones help me to set up this batch, included stackoverflow.com, docs.microsoft.com, forum.sysinternals.com, ss64.com and a lot of more %

cls

@ECHO OFF

echo ---------------------------------------
echo     Checking architecture x86 - x64
echo         %date%  -  %time%
echo ---------------------------------------

REM :: % Deleting previous log file %
del "log.txt"

REM :: % Loop %
for /F "tokens=*" %%a in (computers.txt) do (

REM :: % log.txt only shows x64 computers %
if exist "\\%%a\c$\Program Files (x86)\" (echo ##### Architecture Computer %%a x64 #####) >> log.txt 2>&1
echo ##### Checking architecture Computer %%a #####)
) 

pause

