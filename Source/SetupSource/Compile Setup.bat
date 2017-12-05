@echo off

set /p v=<version.txt

echo Version %v%

echo NSIS version 3.01 is required
echo Download here
echo http://prdownloads.sourceforge.net/nsis/nsis-3.01-setup.exe


echo ==============================
echo Compile NSIS setup
echo ==============================

"C:\Program Files\NSIS\makensis.exe" setup.nsi

echo ==============================
echo Copy file in setup installation dir
echo ==============================

copy YoutubeDownloaderSetup_%v%.exe "..\..\Setup installation\YoutubeDownloaderSetup_%v%.exe"
copy version.txt "..\..\lastversion.txt"


rem echo ==============================
rem echo commit svn
rem echo ==============================

rem svn add --force "..\..\Setup installation\YoutubeDownloaderSetup_%v%.exe"
rem svn commit "..\..\" 


echo ==============================
echo Done.
echo ==============================
@pause