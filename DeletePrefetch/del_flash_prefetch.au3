#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\AppData\Roaming\WinRAR\Themes\WinRAR_Vista_48x48\SFX.ico
#AutoIt3Wrapper_Outfile=Delete_prefetch.exe
#AutoIt3Wrapper_Outfile_x64=Delete_prefetch(64).exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=added: FileDelete("C:\Windows\Prefetch\firefox*.pf") ,FileDelete("C:\Windows\Prefetch\FLASHPLAYERUPDATESERVICE*.pf")  reduced time to exit by .2 seconds
#AutoIt3Wrapper_Res_Description=delete prefetch files
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
FileDelete("C:\Windows\Prefetch\flashpl*.pf")
FileDelete("C:\Windows\Prefetch\PLUGIN-CONTAINER*.pf")
FileDelete("C:\Windows\Prefetch\firefox*.pf")
FileDelete("C:\Windows\Prefetch\FLASHPLAYERUPDATESERVICE*.pf")
FileDelete("C:\Windows\Prefetch\SILVERLIGHT*.pf")
sleep(100)
Exit
