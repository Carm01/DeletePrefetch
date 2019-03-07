#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\Downloads\Oxygen-Icons.org-Oxygen-Actions-view-pim-tasks.ico
#AutoIt3Wrapper_Outfile_x64=FireFox-Flash-Fix(64)(v1.4).exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=v 1.4 adds file structure to scripts folder \prefetch
#AutoIt3Wrapper_Res_Description=creates a task to delete prefetch files for firefox/flash every 15 minutes
#AutoIt3Wrapper_Res_Fileversion=1.4.0.0
#AutoIt3Wrapper_Res_LegalCopyright=CarmWare
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
If FileExists("C:\ProgramData\Scripts\Delete_prefetch.exe") Then
	FileDelete("C:\ProgramData\Scripts\Delete_prefetch.exe")
ElseIf FileExists("C:\ProgramData\Scripts\Delete_prefetch(64).exe") Then
	FileExists("C:\ProgramData\Scripts\Delete_prefetch(64).exe")
EndIf
$retask = 'SchTasks /Delete /TN "Clear Firefox Prefetch" /f'
RunWait('"' & @ComSpec & '" /c ' & $retask, @SystemDir)

Local $find = "HOSTNAME\USERNAME"; sets variable '$find'
Local $replace = (@ComputerName & '\' & @UserName); sets variable '$replace' to the current machines' hostname\username format
DirRemove(@AppDataDir & "\prefetch\", 1);Deletes the temp install space under: c:\users\%ysername%\appdata\roaming\prefetch
Sleep(175)
DirRemove("C:\ProgramData\Scripts\prefetch", 1);Deletes the folder and contents of
Sleep(250)
FileDelete("C:\Windows\Prefetch\flashpl*.pf")
FileDelete("C:\Windows\Prefetch\PLUGIN-CONTAINER*.pf")
FileDelete("C:\Windows\Prefetch\firefox*.pf")
FileDelete("C:\Windows\Prefetch\FLASHPLAYERUPDATESERVICE*.pf")
FileDelete("C:\Windows\Prefetch\SILVERLIGHT*.pf")
Sleep(175)
DirCreate("C:\ProgramData\Scripts\prefetch");Creates C:\ProgramData\Scripts the actual script are stored
Sleep(175)
DirCreate(@AppDataDir & "\prefetch\"); Creates the locations c:\users\%ysername%\appdata\roaming\prefetch where the temp installer data is placed
Local $b = True
If $b = True Then FileInstall("C:\Users\Carm\Documents\Project\Cleaner\Files\64\Scripts.rar", @AppDataDir & "\prefetch\Scripts.rar"); copies the rar package containng most of the files and integrates it into the installer, and instructs the installer to place it in (c:\users\%ysername%\appdata\roaming\prefetch )

Local $b = True
If $b = True Then FileInstall("C:\Program Files (x86)\Unrar\UnRAR.exe", @AppDataDir & "\prefetch\UnRAR.exe"); copies unrar.exe unpacker ( smaller installer size ) and integrates it into the installer, and instructs the installer to place it in (c:\users\%ysername%\appdata\roaming\prefetch )
Sleep(175)
$CMD = 'cd C:\Users\%username%\AppData\Roaming\prefetch && ' & _
		'unrar x -o+ scripts.rar && ' & _
		'xcopy "C:\Users\%username%\AppData\Roaming\prefetch\Delete_prefetch(64).exe" "C:\ProgramData\Scripts\prefetch" && ' & _
		'SchTasks /Delete /TN "Clear Firefox Prefetch" /f'
RunWait('"' & @ComSpec & '" /c ' & $CMD, @SystemDir, @SW_HIDE)
; Runs the command that will actually extract the data to c:\users\%ysername%\appdata\roaming\prefetch. and then move the Delete_prefetch(64).exe to "C:\ProgramData\Scripts" This command will run until the bat file is complete then move to the next line. Also clears the task "Clear Firefox Prefetch" if run multiple times and re-creats from scratch if bad.

Local $filename = (@AppDataDir & "\prefetch\Firefox_Flash\Clear Firefox Prefetch.xml")
_ReplaceStringInFile($filename, $find, $replace); does a find and replace in the xml file in lines 5 & 21.
Sleep(175)
$CMD1 = 'schtasks.exe /create /tn "Clear Firefox Prefetch" /xml "C:\Users\%username%\AppData\Roaming\prefetch\FireFox_Flash\Clear Firefox Prefetch.xml"'
RunWait('"' & @ComSpec & '" /c ' & $CMD1, @SystemDir, @SW_HIDE)
; imports task.
Sleep(300)
If FileExists("C:\Windows\System32\Tasks\Clear Firefox Prefetch") And FileExists("C:\ProgramData\Scripts\prefetch\Delete_prefetch(64).exe") Then
	MsgBox(48, "Carm Says: ", "Your Windows task for Clear Firefox Prefetch has been successful", 30)
ElseIf Not FileExists("C:\Windows\System32\Tasks\Clear Firefox Prefetch") Or Not FileExists("C:\ProgramData\Scripts\prefetch\Delete_prefetch(64).exe") Then
	MsgBox(16, " Carm Says: ", "Your windows task has not been completely created, try again")
EndIf
DirRemove(@AppDataDir & "\prefetch\", 1); Removes temp data location and all files created for install c:\users\%ysername%\appdata\roaming\prefetch
Sleep(175)
Exit
;http://www.autoitscript.com/forum/topic/111184-need-to-execute-cmd-commands/

