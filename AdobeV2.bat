
@ECHO OFF

REM :: % Version 1.0 %
REM :: % The loop will read the computer names from a file (computers.txt) and will copy the 'sources' folder to the remote machine \\host\temp\fonts %
REM :: % Execute the script for installing the new fonts and finally delete the folder \\host\temp\fonts %
REM :: % Before copying the files it checks if the target computer is online %
REM :: % If the computer is offline it adds the hostmane to the file pending.txt %
REM :: % This file 'pending.txt' will be the new 'computers.txt' next time we run the script %
REM :: % This way it will be easier to have under control which computers still pending to update % 
REM :: % In addition to this, we set a couple of log files. the first one gives us the exit code of the process (log.txt) %
REM :: % The second one, the detail of what have happened just in case we have to do some debugging (detail_%MYDATE: =%.log). %
REM :: % Be sure you run it with proper rights %
REM :: % after installing a reboot is needed %
REM :: % Acknowledgements to everyones help me to set up this batch, included stackoverflow.com, docs.microsoft.com, forum.sysinternals.com, ss64.com and a lot of more %

cls

echo ---------------------------------------
echo       Installing  Adobe Acrobat 
echo         %date%  -  %time%
echo ---------------------------------------


REM :: % Setting log file date %
set yy=%date:~-4%
set mm=%date:~-7,2%
set dd=%date:~-10,2%
set hh=%time:~0,2%
set mmm=%time:~3,2%
set ss=%time:~6,2%
set MYDATE=%dd%%mm%%yy%%hh%%mmm%%ss%

REM :: % Setting user & pass arguments %
set user=%1
set pass=%2


REM :: % Setting reset for loop environment variable %
REM :: % for expanding variables at execution time %
setlocal enabledelayedexpansion


REM :: % Deleting previous log file %
del "log.txt"


REM :: % Loop %
for /F "tokens=*" %%a in (computers.txt) do (

	REM :: % Checking if computer is online %
	REM :: % When the computer is online !errorlevel!=0 and we enter the if branch of the conditional sentence %
	ping -n 1 %%a | findstr /r /c:"[0-9] *ms" >> .\logs\ping.txt 2>&1
	
	
	if !errorlevel! EQU 0 ( 
		REM :: Installing new version
		psexec \\%%a -c -s -u %user% -p %pass%  D:\ADM\Sources\AcroRdr.exe /sAll /rs >> .\Logs\detail_%MYDATE: =%.log 2>&1
		REM :: % We use two echo command in order to show the output to STDOUT and to file log.txt %
		echo %%a,!errorlevel! >> log.txt 2>&1
		echo ##### Computer %%a updated  #####
	) else (
		echo ##### Computer %%a offline #####
		echo %%a >> pending.txt
	)
)

REM :: % Pending computer will be the new computers.txt next time we run the script %
del "computers.txt"
rename pending.txt computers.txt
 
pause
