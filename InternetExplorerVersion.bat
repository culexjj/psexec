REM :: % loop will read the computer names from a file (computers.txt) executing the installation command line for each one. %
REM :: % In addition to this, we set a couple of log files. the first one gives us the exit code of the process (log.txt) %
REM :: % the second one, the detail of what have happened just in case we have to do some debugging (detail_%MYDATE: =%.log). %
REM :: % be sure you run it with proper rights %
REM :: % acknowledgements to everyones help me to set up this batch, included stackoverflow.com, docs.microsoft.com, forum.sysinternals.com, ss64.com and a lot of more %

REM :: % I advice to redirect output to a file when you run this batch %


@ECHO OFF

echo ------------------------------------------
echo         Internet Explorer Version 
echo         %date%  -  %time%
echo ------------------------------------------

REM :: % Setting reset for loop environment variable %
REM :: % for expanding variables at execution time %
setlocal enabledelayedexpansion

REM :: % Loop %
for /F "tokens=*" %%a in (computers.txt) do (

echo:
echo ------------------------------------------

REM :: We use 2>nul for avoiding default output of psexec.
echo ##### Version  IE Computer %%a #####
psexec \\%%a -u domain\admin_user -p password -h cmd /c reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer" /v "svcVersion" 2>nul
) 

pause

