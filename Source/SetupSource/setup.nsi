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

;InstallDir "C:\YoutubeDownloader"
InstallDir "$PROGRAMFILES\YoutubeDownloader"

InstallDirRegKey HKLM "SOFTWARE\YoutubeDownloader" ""

ShowInstDetails show
ShowUninstDetails show



; Set to silent mode
;SilentInstall silent
; Request application privileges for Windows Vista
RequestExecutionLevel admin


BGGradient 000000 000080 FFFFFF 
InstallColors 8080FF 000030 
XPStyle on

SetCompressor bzip2

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
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File "YoutubeDownloader.exe"
  File "youtube-dl.exe"  
  File "ffprobe.exe"  
  WriteUninstaller "uninstall_YoutubeDownloader.exe"


  
  WriteRegStr HKLM "SOFTWARE\YoutubeDownloader" "" $INSTDIR
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YoutubeDownloader" "DisplayName" "YoutubeDownloader (remove only)"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YoutubeDownloader" "UninstallString" '"$INSTDIR\uninstall_DNSRelayServer.exe"'
  
  
  CreateDirectory "$SMPROGRAMS\YoutubeDownloader"
  CreateShortCut "$SMPROGRAMS\YoutubeDownloader\YoutubeDownloader.lnk" "$INSTDIR\YoutubeDownloader.exe" "" "$INSTDIR\YoutubeDownloader.exe" 0
  CreateShortCut "$DESKTOP\YoutubeDownloader.lnk" "$INSTDIR\YoutubeDownloader.exe" "" "$INSTDIR\YoutubeDownloader.exe" 0
  CreateShortCut "$SMPROGRAMS\YoutubeDownloader\Uninstall.lnk" "$INSTDIR\uninstall_YoutubeDownloader.exe" "" "$INSTDIR\uninstall_YoutubeDownloader.exe" 0

  
  Exec "YoutubeDownloader.exe" 
  Quit
SectionEnd ; end the section




# Uninstall section.

Section "Uninstall"

	  DeleteRegKey HKLM "SOFTWARE\YoutubeDownloader"
	  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\YoutubeDownloader"

	  RMDir /r "$SMPROGRAMS\YoutubeDownloader"

	  Delete "$INSTDIR\youtube-dl.exe"
	  Delete "$INSTDIR\YoutubeDownloader.exe"
	  Delete "$INSTDIR\ffprobe.exe"
	  Delete "$INSTDIR\uninstall_YoutubeDownloader.exe"

	  RMDir $INSTDIR

SectionEnd




Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

