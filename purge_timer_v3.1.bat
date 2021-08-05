REM Windows batch file to remove files from specific directory every N days

REM UCLH Scientific Computing 2020
REM UCLH, Mpbit (UNIVERSITY COLLEGE LONDON HOSPITALS NHS FOUNDATION TRUST) <mpbit.uclh@nhs.net>

REM Version 1: Remove contents of folder every N days
REM Version 2: Remove contents of folder every N (e.g 14) days only if the file or sub-folder is older than M (e.g. 3) days
REM Version 3: Added use of lock file and second input of full path for monitoring and deletion with conditional statements which guard against multiple script instances and incorrect input of directory

SET /A days = 4
SET /A age = 500
SET drive=M: 
SET scriptPath=C:\Users\dmotan\Documents\scriptest\PurgeTimer3.1\
SET fullpath1=C:\Users\dmotan\Documents\scriptest\test\

REM Don't edit below this line!

SET TempFile=lockfile.txt
SET scriptPathTempFile=%scriptPath%%TempFile%

REM Check if lock file exists; if it does exit script immediately

if exist %scriptPathTempFile% (
	REM lock file already exist
	exit
) else (
	REM Starting script...
	echo. 2>%scriptPathTempFile%
)

REM Compare fullpath1 with hardcoded path (fullpath2) for monitoring and deletion of files here. It they done match exit script immediately

REM Edit below line on final deployment system once only

SET fullpath2=C:\Users\dmotan\Documents\scriptest\test\

REM Edit above line on final deployment system once only


if "%fullpath1%" NEQ "%fullpath2%" (
	exit
)


REM Start loop through user defined number of days (in seconds)

:LOOP

%drive%
forfiles /p %fullpath1% /s /m *.* /d -%age% /c "cmd /c del @path"
forfiles /p %fullpath1% /S /D -%age% /C "cmd /c IF @isdir == TRUE rd /S /Q @path"

SET /A iter=0
:DAYSLOOP
IF /I "%iter%" NEQ "%days%" (
	timeout /t 5
	SET /A "iter = %iter% + 1"
        GOTO DAYSLOOP
)

GOTO LOOP