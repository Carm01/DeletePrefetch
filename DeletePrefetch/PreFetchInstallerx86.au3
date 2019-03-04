#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\AppData\Roaming\WinRAR\Themes\Vista_WinRAR_48x48_1\Setup.ico
#AutoIt3Wrapper_Outfile=FireFox-Flash-Fix(x86)_autoBeta(v1.3).exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=v 1.3 add conde simplification and removal of bat files
#AutoIt3Wrapper_Res_Description=creates a task to delete prefetch files for firefox/flash every 15 minutes
#AutoIt3Wrapper_Res_Fileversion=1.3.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
Local $find = "HOSTNAME\USERNAME"; sets variable '$find'
Local $replace = (@ComputerName & '\' & @UserName); sets variable '$replace' to the current machines' hostname\username format
DirRemove(@AppDataDir & "\prefetch\", 1);Deletes the temp install space under: c:\users\%username%\appdata\roaming\prefetch
Sleep(175)
DirRemove("C:\ProgramData\Scripts", 1);Deletes the folder and contents of
Sleep(250)
FileDelete("C:\Windows\Prefetch\flashpl*.pf")
FileDelete("C:\Windows\Prefetch\PLUGIN-CONTAINER*.pf")
FileDelete("C:\Windows\Prefetch\firefox*.pf")
FileDelete("C:\Windows\Prefetch\FLASHPLAYERUPDATESERVICE*.pf")
FileDelete("C:\Windows\Prefetch\SILVERLIGHT*.pf")
Sleep(175)
DirCreate("C:\ProgramData\Scripts");Creates C:\ProgramData\Scripts the actual script are stored
Sleep(175)
DirCreate(@AppDataDir & "\prefetch\"); Creates the locations c:\users\%username%\appdata\roaming\prefetch where the temp installer data is placed
Local $b = True
If $b = True Then FileInstall("C:\Users\Carm\Documents\Project\Cleaner\Files\Scripts.rar", @AppDataDir & "\prefetch\Scripts.rar"); copies the rar package containng most of the files and integrates it into the installer, and instructs the installer to place it in (c:\users\%username%\appdata\roaming\prefetch )
Local $b = True
If $b = True Then FileInstall("C:\Program Files (x86)\Unrar\UnRAR.exe", @AppDataDir & "\prefetch\UnRAR.exe"); copies unrar.exe unpacker ( smaller installer size ) and integrates it into the installer, and instructs the installer to place it in (c:\users\%username%\appdata\roaming\prefetch )
Sleep(175)
$CMD =  'cd C:\Users\%username%\AppData\Roaming\prefetch && ' & _
		'unrar x -o+ scripts.rar && ' & _
		'xcopy "C:\Users\%username%\AppData\Roaming\prefetch\Delete_prefetch.exe" "C:\ProgramData\Scripts" && ' & _
		'SchTasks /Delete /TN "Clear Firefox Prefetch" /f'
RunWait('"' & @ComSpec & '" /c ' & $CMD, @SystemDir)
; Runs the command that will actually extract the data to c:\users\%username%\appdata\roaming\prefetch. and then move the Delete_prefetch.exe to "C:\ProgramData\Scripts" This command will run until the bat file is complete then move to the next line. This also initially deletes selected prefetch files, and deletes any scheduled task that was created as a result of this script being run multiple times.

Local $filename = (@AppDataDir & "\prefetch\Firefox_Flash\Clear Firefox Prefetch.xml")
_ReplaceStringInFile($filename, $find, $replace); does a find and replace in the xml file in lines 5 & 21
Sleep(175)

$CMD1 = 'schtasks.exe /create /tn "Clear Firefox Prefetch" /xml "C:\Users\%username%\AppData\Roaming\prefetch\FireFox_Flash\Clear Firefox Prefetch.xml"'
RunWait('"' & @ComSpec & '" /k ' & $CMD1, @SystemDir)
; imports task. use /c to close cmd window and end. /k leaves it open
Sleep(175)
DirRemove(@AppDataDir & "\prefetch\", 1); Removes temp data location and all files created for install c:\users\%username%\appdata\roaming\prefetch
Sleep(175)
Exit
;http://www.autoitscript.com/forum/topic/111184-need-to-execute-cmd-commands/
