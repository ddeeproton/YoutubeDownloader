; Setup DNS Relay Server
!define /file VERSION version.txt

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------

; The name of the installer
Name "Youtube Downloader ${VERSION}"

; The file to write
OutFile "YoutubeDownloaderSetup_${VERSION}.exe"

; The default installation directory

;InstallDir "$PROGRAMFILES\YoutubeDownloader"
InstallDir "C:\YoutubeDownloader"

InstallDirRegKey HKLM "SOFTWARE\YoutubeDownloader" ""

ShowInstDetails show
ShowUninstDetails show



; Set to silent mode
;SilentInstall silent
; Request application privileges for Windows Vista
;RequestExecutionLevel admin


BGGradient 000000 000080 FFFFFF 
InstallColors 8080FF 000030 
XPStyle on

;SetCompressor bzip2
SetCompressor /SOLID lzma

;--------------------------------
;Interface Settings

!define MUI_ABORTWARNING

!define MUI_ICON "favicon.ico"
!define MUI_UNICON "favicon.ico"

!define MUI_HEADERIMAGE
#!define MUI_HEADERIMAGE_BITMAP "..\images\NSISBanner.bmp"
!define MUI_HEADERIMAGE_LEFT
;--------------------------------

; Pages

#Page directory
#Page instfiles

;--------------------------------
;Languages

  #!insertmacro MUI_LANGUAGE "English" ;first language is the default language
  !insertmacro MUI_LANGUAGE "French"
  !define MUI_LANGDLL_ALLLANGUAGES
;--------------------------------
;Pages
  #!insertmacro MUI_PAGE_WELCOME
  #!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  #!insertmacro MUI_PAGE_COMPONENTS
  
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  #!insertmacro MUI_PAGE_FINISH

  #!insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  #!insertmacro MUI_UNPAGE_FINISH

;--------------------------------


; The stuff to install
Section "" ;No components page, name is not important
  ; Slow down install if is silent
  Call IsSilent
  Pop $0
  StrCmp $0 1 goSilent1 goNotSilent1
  goSilent1:
  Sleep 5000
  goNotSilent1:
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  Call CloseProcessYoutube
  
  SetOverwrite off
  File "youtube-dl.exe"  
  File "msvcr100.dll"  
  File "ffprobe.exe"  
  File "ffmpeg.exe"  
  File "ffplay.exe"  
  File "wget.exe"
  SetOverwrite on
  
  WriteUninstaller "uninstall_YoutubeDownloader.exe"


  
  WriteRegStr HKLM "SOFTWARE\YoutubeDownloader" "" $INSTDIR
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YoutubeDownloader" "DisplayName" "YoutubeDownloader (remove only)"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YoutubeDownloader" "UninstallString" '"$INSTDIR\uninstall_DNSRelayServer.exe"'
  
  
  CreateDirectory "$SMPROGRAMS\YoutubeDownloader"
  CreateShortCut "$SMPROGRAMS\YoutubeDownloader\YoutubeDownloader.lnk" "$INSTDIR\YoutubeDownloader.exe" "" "$INSTDIR\YoutubeDownloader.exe" 0
  CreateShortCut "$DESKTOP\YoutubeDownloader.lnk" "$INSTDIR\YoutubeDownloader.exe" "" "$INSTDIR\YoutubeDownloader.exe" 0
  CreateShortCut "$SMPROGRAMS\YoutubeDownloader\Uninstall.lnk" "$INSTDIR\uninstall_YoutubeDownloader.exe" "" "$INSTDIR\uninstall_YoutubeDownloader.exe" 0


  ; Put file there
  
  File "lang_en.xml"
  
  File "YoutubeDownloader.exe"
  Exec "YoutubeDownloader.exe"   

  Quit
SectionEnd ; end the section




# Uninstall section.

Section "Uninstall"

	  DeleteRegKey HKLM "SOFTWARE\YoutubeDownloader"
	  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YoutubeDownloader"

	  RMDir /r "$SMPROGRAMS\YoutubeDownloader"

	  Delete "$INSTDIR\youtube-dl.exe"
	  Delete "$INSTDIR\msvcr100.dll"
	  Delete "$INSTDIR\YoutubeDownloader.exe"
	  Delete "$INSTDIR\ffprobe.exe"
	  Delete "$INSTDIR\ffmpeg.exe"
	  Delete "$INSTDIR\ffplay.exe"
	  Delete "$INSTDIR\wget.exe"
	  Delete "$INSTDIR\lang_en.xml"
	  Delete "$INSTDIR\uninstall_YoutubeDownloader.exe"
	  RMDir $INSTDIR

SectionEnd


Function "CloseProcessYoutube"
    ClearErrors
    File "libgcc_s_dw2-1.dll" 
    File "kill.exe" 
    Exec "kill.exe k $\"youtube downloader$\"" 
    Sleep 2000
FunctionEnd

/*
Function "CloseProcessYoutubeOLD"
    ClearErrors
    FileOpen $0 "closeYoutube.vbs" w
    IfErrors FSkip
    FileWrite $0 "const ProcessusATuer = $\"YoutubeDownloader.exe$\"$\r$\n   const TempsPauseEntreChaquesVerifs = 200$\r$\n   const NbrMaximumVerifications = 2000$\r$\n  strComputer = $\".$\"$\r$\n  Set objWMIService = GetObject($\"winmgmts:$\" & $\"{impersonationLevel=impersonate}!\\$\" & strComputer & $\"\root\cimv2$\")$\r$\n  Set colProcessList = objWMIService.ExecQuery($\"Select * from Win32_Process Where Name = '$\" & ProcessusATuer & $\"'$\")$\r$\n  dim i$\r$\n  i = 0$\r$\n  do while i <= NbrMaximumVerifications$\r$\n    i = i + 1$\r$\n    For Each objProcess in colProcessList$\r$\n       objProcess.Terminate()$\r$\n       wscript.quit$\r$\n    Next$\r$\n    wscript.sleep TempsPauseEntreChaquesVerifs$\r$\n  loop"
    FileClose $0
    Exec "wscript.exe closeYoutube.vbs" 
    Sleep 2000
    Delete "closeYoutube.vbs"
    FSkip:
FunctionEnd
*/
Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

 
  
    IfFileExists "$PROGRAMFILES\YoutubeDownloader\uninstall_YoutubeDownloader.exe" 0 +3
      MessageBox MB_OK "Avant d'installer, il est conseillé de désinstaller la version courante."
      Exec "$PROGRAMFILES\YoutubeDownloader\uninstall_YoutubeDownloader.exe" 
      StrCpy $INSTDIR "C:\YoutubeDownloader"
      ;Exec "YoutubeDownloaderSetup_${VERSION}.exe"
      ;Quit
FunctionEnd





Function IsSilent
  Push $0
  Push $CMDLINE
  Push "/S"
  Call StrStr
  Pop $0
  StrCpy $0 $0 3
  StrCmp $0 "/S" silent
  StrCmp $0 "/S " silent
    StrCpy $0 0
    Goto notsilent
  silent: StrCpy $0 1
  notsilent: Exch $0
FunctionEnd
 
Function StrStr
  Exch $R1 ; st=haystack,old$R1, $R1=needle
  Exch    ; st=old$R1,haystack
  Exch $R2 ; st=old$R1,old$R2, $R2=haystack
  Push $R3
  Push $R4
  Push $R5
  StrLen $R3 $R1
  StrCpy $R4 0
  ; $R1=needle
  ; $R2=haystack
  ; $R3=len(needle)
  ; $R4=cnt
  ; $R5=tmp
  loop:
    StrCpy $R5 $R2 $R3 $R4
    StrCmp $R5 $R1 done
    StrCmp $R5 "" done
    IntOp $R4 $R4 + 1
    Goto loop
  done:
  StrCpy $R1 $R2 "" $R4
  Pop $R5
  Pop $R4
  Pop $R3
  Pop $R2
  Exch $R1
FunctionEnd
