![](preview3.jpg)

![](preview.jpg)

![](preview2.jpg)

# Youtube Downloader


### Description:
 This is a video downloader for Youtube, Dailymotion and others.
 
 Ce programme télécharge l'audio des vidéos de Youtube, Dailymotion et autres.

### Download:
 https://github.com/ddeeproton/YoutubeDownloader/raw/master/Setup%20installation/YoutubeDownloaderSetup_1.0.17.exe
 
### Langages:
  English
  
  Français
  
  Can be translated with a XML file. Check "lang_en.xml" for eg.
  
  Peut-être traduit depuis un fichier XML. Voir "lang_en.xml" pour l'exemple.
  
  https://raw.githubusercontent.com/ddeeproton/YoutubeDownloader/master/Source/GUI/lang_en.xml


### Support / Liste des sites supportés:
 
 https://github.com/rg3/youtube-dl/blob/master/docs/supportedsites.md

### How does it work? / Fonctionnement:
 This application will check your clipboard. If a http link is copied, then it will ask if you want to download the video, the audio or just a file. 

 Ce programme, une fois lancé, surveille votre presse papier. Dès qu'un lien http est copié, le programme vous propose de télécharger l'audio, la vidéo ou le fichier brut.


### Other documentation / Autre Doc:	
  https://github.com/rg3/youtube-dl/
  
  https://github.com/rg3/youtube-dl/blob/master/README.md


### Compilation:
 GUI is compiled with Lazarus (Free Pascal)
 
 Le GUI est compilé avec Lazarus (Free Pascal)
 
 http://www.lazarus-ide.org/
 
 ### Packets required for Lazarus / Paquets requis pour Lazarus
 
 Download and install this packets in Lazarus.
 
 Télécharger et installer ces paquets dans Lazarus.
  
 ![](help1.jpg)
  
  "Compile" and "Use / Install". Finally, click "ok" and "yes".
 
 "Compiler" puis "Utiliser / Installer". Pour finir, clique "ok" et "oui".
  
  ![](help2.jpg)
 
 -1. Download / Télécharger "BGRABitmap" (must be installed first / dois être installé en premier)
 https://github.com/bgrabitmap/bgrabitmap
  
 (Open, compile and install "bglcontrols.lpk")
 (Ouvrir, compiler et installer "bglcontrols.lpk")
  
 -2. Download / Télécharger "BGRAControls" 
 http://wiki.lazarus.freepascal.org/BGRAControls
 
 (Open, compile and install "bgracontrols.lpk")
 (Ouvrir, compiler et installer "bgracontrols.lpk")
 
 
 
 ### If broken links / Si les liens ne fonctionnent plus
 
 For both packets, a copy is aviable in "other" folder. 
 
 Pour ces deux paquets, une copie est disponible dans le dossier "other".
 
 ### How to create setup installation / Comment créer le setup d'installation
 
 The Setup is compiled with NSIS (Windows only)
 
 Le Setup est compilé avec NSIS (seulement sur Windows)
 
 #### Step 1 / Etape 1
 Download and Install NSIS 
 
 Télécharger et installer NSIS
 
 http://nsis.sourceforge.net/Main_Page

 #### Step 2 / Etape 2
 Compile "YoutubeDownloader.exe" with Lazarus and copy this file in "SetupSource" folder
 
 Compiler "YoutubeDownloader.exe" avec Lazarus et copier ce fichier dans le dossier "SetupSource" 

 #### Step 3 / Etape 3
 Set version in "version.txt"
 
 Définir la version dans "version.txt"

 #### Step 4 / Etape 4
 Double click on "Compile Setup.bat" and wait 5 minutes
 
 Double cliquer sur "Compile Setup.bat" et attendre 5 minutes


### Operating system / Système d'exploitation:
 Windows
 
 To compile with Linux or Mac, the code must be modified before (path in "/" instead of "\\", ...)
 
 Pour compiler sur Linux ou Mac, le code devra d'abord être adapté (chemin en "/" à la place de "\\", etc.)

### Changes / Changements:

#### 1.0.0
Stable version

#### 1.0.17
Youtube-dl.exe - Add last version in setup installation

#### 1.0.18
New documentation
Set new version in "YoutubeDownloader.exe"