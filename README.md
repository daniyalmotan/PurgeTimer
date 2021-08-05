# PurgeTimer

## Description:

Windows DOS batch script which will remove contents of folder every N (e.g 14) days only if the file or sub-folder is older than M (e.g. 3) days: purge_timer_v2.bat

The batch script is run in the background using a Virtual Basic script: run_bg_purge_timer.vbs

## Version

3.1 (2020-09-21)

## Classification?:

The PurgeTimer script is to be deployed onto a clinical server that holds patient data (specifically DICOM files). The script itself is not performing any calculation nor is making changes to the patient data. It is meant to purge files that are older than a specified data and have been further processed backed up already.

However, the script has potential to impact patient care if it fails. There may be potential loss of patient data that hasn’t been backed up/further processed as needed if the script functions contrary to what is expected.

Based on its function the script does not qualify as Health software or Medical device software, but due to the clinical risks it poses it must still undergo some level of testing before being deployed onto the live server.

## Usage:

1.	The following variables in purge_timer_v2.bat script should be set by the user e.g.:

SET /A days = 14

SET /A age = 3

SET drive=M: 

SET scriptPath=M:\PurgeTimer\  The path to the script folder

SET fullpath1=M:\temp\  The path to directory for file monitoring and deletion (based on age)

In above example the script removes files and sub-folders in fullpath1 every 14 days if they are older than 3 days.

2.	A lock file (lockfile.txt) is created when the script is first executed in the directory scriptPath and this empty file must be manually deleted before running the script again. This guards aginst multiple instances of the script running. If the file exists then the script execution exits immediately.

3.	A variable fullpath2 is set in the body of the script and must match fullpath1 otherwise the script execution exits immediately.

4.	The variable strArgs (line 3) of run_bg_purge_timer.vbs should be set by the user to point to the full file path of purge_timer_v2.bat e.g.:

  strArgs = "cmd /c M:\purge_timer.bat"

5.	The script is executed by running run_bg_purge_timer.vbs which runs purge_timer_v2.bat continuously in the background.

6.	To halt script execution kill run_bg_purge_timer.vbs processes by

    a.	Open the Task Manager > Processes; 

    b.	Search for:

       i.	 "Windows Command Processor" with command line ""C:\Windows\System32\cmd.exe" /c M:purge_timer.bat"

       ii.	"timeout" with command line "time /t 86400"

    c.	And kill both processes.
