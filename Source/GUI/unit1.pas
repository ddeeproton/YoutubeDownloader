unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, XMLConf, FileUtil, BCButtonFocus, BCLabel, BGRACustomDrawn,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ExtCtrls, clipbrd, Windows, lclintf, Buttons, CheckLst, Registry, ShlObj;

var
  CurrentVersion : String = '0.0.41';

type

  { TForm1 }

  TForm1 = class(TForm)
    BCButtonFocus1: TBCButtonFocus;
    BCButtonFocus10: TBCButtonFocus;
    BCButtonFocus11: TBCButtonFocus;
    BCButtonFocus2: TBCButtonFocus;
    BCButtonFocus3: TBCButtonFocus;
    BCButtonFocus4: TBCButtonFocus;
    BCButtonFocus5: TBCButtonFocus;
    BCButtonFocus6: TBCButtonFocus;
    BCButtonFocus7: TBCButtonFocus;
    BCButtonFocus8: TBCButtonFocus;
    BCButtonFocus9: TBCButtonFocus;
    BCLabel1: TBCLabel;
    BCLabel2: TBCLabel;
    BCLabel3: TBCLabel;
    BCLabel4: TBCLabel;
    CheckListBoxConfig: TCheckListBox;
    ComboBoxEncoding: TComboBox;
    EditHTTP: TEdit;
    EditPath: TEdit;
    Image1: TImage;
    ImageList1: TImageList;
    ImageList2: TImageList;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItemLangFra: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItemLangEng: TMenuItem;
    MenuItemHideOnDownload: TMenuItem;
    MenuItemPathDL: TMenuItem;
    MenuItemSkinBlack: TMenuItem;
    MenuItemCheckClipboard: TMenuItem;
    MenuItemSkinWhite: TMenuItem;
    MenuItemSkinBlue: TMenuItem;
    MenuItemSkin: TMenuItem;
    MenuItemUpdateOnBoot: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItemStartOnBoot: TMenuItem;
    MenuItemCacheToggle: TMenuItem;
    MenuItemAbout: TMenuItem;
    MenuItemCacheHelp: TMenuItem;
    MenuItemCacheClear: TMenuItem;
    MenuItemCacheOpen: TMenuItem;
    MenuItemExit: TMenuItem;
    PopupMenuSkin: TPopupMenu;
    PopupMenuHistory: TPopupMenu;
    PopupMenuTray: TPopupMenu;
    PopupMenuLang: TPopupMenu;
    Process1: TProcess;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    TimerAfterLoad: TTimer;
    TimerClipboard: TTimer;
    TrayIcon1: TTrayIcon;
    XMLConfig1: TXMLConfig;
    procedure BCButtonFocus10Click(Sender: TObject);
    procedure BCButtonFocus1Click(Sender: TObject);
    procedure BCButtonFocus4Click(Sender: TObject);
    procedure BCButtonFocus5Click(Sender: TObject);
    procedure BCButtonFocus8Click(Sender: TObject);
    procedure ButtonDownloadKeyPress(Sender: TObject; var Key: char);
    procedure ButtonSetDownloadPathClick(Sender: TObject);
    procedure ButtonMenuClick(Sender: TObject);
    procedure ButtonDownloadClick(Sender: TObject);
    procedure ButtonPasteClick(Sender: TObject);
    procedure CheckListBoxConfigClick(Sender: TObject);
    procedure CheckListBoxConfigClickCheck(Sender: TObject);
    procedure ComboBoxEncodingChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemHideOnDownloadClick(Sender: TObject);
    procedure MenuItemPathDLClick(Sender: TObject);
    procedure MenuItemAboutClick(Sender: TObject);
    procedure MenuItemCacheClearClick(Sender: TObject);
    procedure MenuItemCacheHelpClick(Sender: TObject);
    procedure MenuItemCacheOpenClick(Sender: TObject);
    procedure MenuItemCacheToggleClick(Sender: TObject);
    procedure MenuItemCheckClipboardClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemHideClick(Sender: TObject);
    procedure MenuItemShowClick(Sender: TObject);
    procedure MenuItemSkinBlackClick(Sender: TObject);
    procedure MenuItemSkinBlueClick(Sender: TObject);
    procedure MenuItemSkinRedClick(Sender: TObject);
    procedure MenuItemSkinWhiteClick(Sender: TObject);
    procedure MenuItemStartOnBootClick(Sender: TObject);
    procedure MenuItemUpdateClick(Sender: TObject);
    procedure MenuItemUpdateOnBootClick(Sender: TObject);
    procedure TimerAfterLoadTimer(Sender: TObject);
    procedure TimerClipboardTimer(Sender: TObject);
    procedure DoDownload();
    function GetWinDir: string;
    procedure ExecuteProcess(cmd: String);
    procedure ExecuteProcess(cmd: String; pwait, pshow: Boolean);
    procedure ExecuteProcess(app, cmd: String; pwait, pshow: Boolean);
    procedure ExecAndContinue(sExe, sCmd: string; wShowWin: Word);
    function CloseProcess(const windowName: PChar): Boolean;
    function getEncoding(): String;
    procedure ConfigSave;
    procedure ConfigLoad;
    procedure WriteFile(Filename, Content : String);
    function ReadFile(Filename: String):String;
    procedure DownloadFile(http, filename: String; wait, pshow: Boolean);
    procedure DownloadFileToDir(http, dir: String; wait, pshow: Boolean);
    procedure CheckUpdate();
    procedure DoDownloadWithMixcloud();
    procedure DoDownloadWithYoutubeDl();
    function FindWindowByTitle(WindowTitle: string): Hwnd;
    procedure StartWithWindows(doStart: Boolean);
    function isStartWithWindows(): Boolean;
    procedure SplitStr(const Source, Delimiter: String; var DelimitedList: TStringList);
    function getUserPath:string;
    procedure setFormHeight(h: Integer);
    procedure setFormAtBottomRight;
    procedure SetSkin(skinIdImage: Integer; skinColor, bgColor:TColor);
    procedure ConfigSaveFromCheckBox;
    function LoadLanguage(filename:String):TXMLConfig;
    procedure getListOfLanguages;
    function dir(dirname : wideString; Filtre : string = '*.*'; onlyDir: Boolean = False; onlyFiles: Boolean = False; isFullPath: Boolean = True ) : TStringList;
    procedure MenuItemLangClick(Sender: TObject);
  private
    { private declarations }
  protected
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  public
    { public declarations }
  end;


var
  Form1: TForm1;
  Config_YoutubeDownloader: String = 'youtube-dl.exe';
  Config_HeightMinimized: Integer = 60;
  Config_HeightMaximized: Integer = 280;
  oldClipboardValue: String = '';
  currentSkin: Integer = 0;
  Config_Dir: String = '';
  currentDir: String = '';
  currentLanguage: String = '';
  xmlLang: TXMLConfig;
  
implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormCreate(Sender: TObject);
begin
  setFormHeight(Config_HeightMinimized);
  Image1.Align:= alClient;
  EditHTTP.Clear;
  EditPath.Clear;
  EditPath.TabStop := False;

  currentDir := ExtractFileDir(Application.ExeName) +'\';

  Config_Dir := getUserPath + '\YoutubeDownloader\';
  if not DirectoryExists(Config_Dir) then MkDir(Config_Dir);

  ConfigLoad;

  if currentSkin = 0 then MenuItemSkinBlueClick(nil);
  if currentSkin = 1 then MenuItemSkinWhiteClick(nil);
  if currentSkin = 2 then MenuItemSkinBlackClick(nil);
  if currentSkin = 3 then MenuItemSkinRedClick(nil);

  TimerClipboard.Enabled := MenuItemCheckClipboard.Checked;
  MenuItemUpdateOnBoot.Checked := isStartWithWindows;

  getListOfLanguages;
end;



procedure TForm1.MenuItemPathDLClick(Sender: TObject);
begin
  setFormHeight(Config_HeightMaximized);
  EditPath.TabStop := True;
  EditPath.SetFocus;
  Show;
end;

procedure TForm1.setFormHeight(h: Integer);
begin
  Self.Height:= h;
  Self.Constraints.MaxHeight := h;
  Self.Constraints.MinHeight:= h;
  setFormAtBottomRight;
end;

procedure TForm1.TimerAfterLoadTimer(Sender: TObject);
var i: integer;
begin
  TimerAfterLoad.Enabled := False;
  if MenuItemUpdateOnBoot.Checked then CheckUpdate();

  for i:=0 to ParamCount() do
  begin
    if ParamStr(i) = '/background' then hide;
    if ParamStr(i) = '/close' then
    begin
      CloseProcess(PChar(Self.Caption));
      Application.Terminate;
    end;
  end;

end;

procedure TForm1.ConfigLoad;
begin
  XMLConfig1 := TXMLConfig.Create(nil);
  if FileExists(Config_Dir+'config.xml') then XMLConfig1.LoadFromFile(Config_Dir+'config.xml');
  ComboBoxEncoding.ItemIndex := XMLConfig1.GetValue('Encoding', 4);
  MenuItemCacheToggle.Checked := XMLConfig1.GetValue('UseCache', True);
  MenuItemUpdateOnBoot.Checked := XMLConfig1.GetValue('UpdateOnBoot', True);
  EditPath.Text := XMLConfig1.GetValue('Path', ExtractFileDir(Application.ExeName));
  currentSkin := XMLConfig1.GetValue('Skin', 0);
  MenuItemCheckClipboard.Checked := XMLConfig1.GetValue('CheckClipboard', True);
  MenuItemHideOnDownload.Checked := XMLConfig1.GetValue('HideOnDownload', False);
  MenuItemStartOnBoot.Checked:= isStartWithWindows();

  currentLanguage := XMLConfig1.GetValue('language', 'lang_fr.txt');
  xmlLang := LoadLanguage(currentLanguage);

  CheckListBoxConfig.Checked[0] := XMLConfig1.GetValue('CheckClipboard', True);
  CheckListBoxConfig.Checked[1] := XMLConfig1.GetValue('HideOnDownload', False);
  CheckListBoxConfig.Checked[2] := XMLConfig1.GetValue('UpdateOnBoot', True);
  CheckListBoxConfig.Checked[3] := isStartWithWindows();
  CheckListBoxConfig.Checked[4] := XMLConfig1.GetValue('UseCache', True);
  CheckListBoxConfig.Checked[5] := XMLConfig1.GetValue('AskBeforeExit', True);



  XMLConfig1.Free;
end;


procedure TForm1.ConfigSaveFromCheckBox;
begin
  XMLConfig1 := TXMLConfig.Create(nil);
  XMLConfig1.SetValue('CheckClipboard', CheckListBoxConfig.Checked[0]);
  XMLConfig1.SetValue('HideOnDownload', CheckListBoxConfig.Checked[1]);
  XMLConfig1.SetValue('UpdateOnBoot', CheckListBoxConfig.Checked[2]);

  if CheckListBoxConfig.Checked[3] then
  begin
    if not isStartWithWindows() then MenuItemStartOnBootClick(MenuItemStartOnBoot);
  end else
  begin
    if isStartWithWindows() then MenuItemStartOnBootClick(MenuItemStartOnBoot);
  end;

  XMLConfig1.SetValue('UseCache', CheckListBoxConfig.Checked[4]);
  XMLConfig1.SetValue('AskBeforeExit', CheckListBoxConfig.Checked[5]);
  XMLConfig1.SetValue('Encoding', ComboBoxEncoding.ItemIndex);
  XMLConfig1.SetValue('Path', EditPath.Text);
  XMLConfig1.SetValue('Skin', currentSkin);
  XMLConfig1.SetValue('language', currentLanguage);

  XMLConfig1.SaveToFile(Config_Dir+'config.xml');
  XMLConfig1.Free;
  ConfigLoad;
end;


procedure TForm1.ConfigSave;
begin
  XMLConfig1 := TXMLConfig.Create(nil);
  XMLConfig1.SetValue('Encoding', ComboBoxEncoding.ItemIndex);
  XMLConfig1.SetValue('UseCache', MenuItemCacheToggle.Checked);
  XMLConfig1.SetValue('UpdateOnBoot', MenuItemUpdateOnBoot.Checked);
  XMLConfig1.SetValue('Path', EditPath.Text);
  XMLConfig1.SetValue('Skin', currentSkin);
  XMLConfig1.SetValue('CheckClipboard', MenuItemCheckClipboard.Checked);
  XMLConfig1.SetValue('HideOnDownload', MenuItemHideOnDownload.Checked);
  XMLConfig1.SetValue('AskBeforeExit', CheckListBoxConfig.Checked[5]);
  XMLConfig1.SetValue('language', currentLanguage);
  XMLConfig1.SaveToFile(Config_Dir+'config.xml');
  XMLConfig1.Free;
  ConfigLoad;
end;



function TForm1.dir(dirname : wideString; Filtre : String = '*.*'; onlyDir: Boolean = False; onlyFiles: Boolean = False; isFullPath: Boolean = True ) : TStringList;
var filename : String;
    dirHandle  : integer;
    SearchResult     : TSearchRec;
    Attributs: Integer;
begin
  result := TStringList.Create;
  Attributs := faDirectory + faHidden + faSysFile+ faVolumeID + faArchive ;
  dirHandle := FindFirst(dirname+'\'+filtre,Attributs, SearchResult);
  while dirHandle = 0 do
  begin
    if isFullPath then
      filename := dirname+'\'+SearchResult.Name
    else
      filename := SearchResult.Name;
    if ((SearchResult.Attr and faDirectory) <= 0) then // if is file
      if not onlyDir then
        result.Add(filename)
    else // if is dir
      if not onlyFiles then
        result.Add(filename);

    dirHandle := FindNext(SearchResult);
  end;
  //FindClose(SearchResult);
end;



procedure TForm1.MenuItemLangClick(Sender: TObject);
begin
  xmlLang := LoadLanguage(TMenuItem(Sender).Hint);
  ConfigSave;
end;

procedure TForm1.getListOfLanguages;
var
  i: Integer;
  files: TStringList;
  xml: TXMLConfig;
  m: TMenuItem;
  curLang: String;
begin
  PopupMenuLang.Items.Clear;
  m := TMenuItem.Create(nil);
  m.Caption:=PChar('Français');
  m.Hint :=PChar('lang_fr.xml');
  m.OnClick:= @MenuItemLangClick;
  PopupMenuLang.Items.Add(m);

  files := dir(ExtractFileDir(Application.ExeName), 'lang_*.xml', False, True, False);
  for i := 0 to files.Count -1 do
  begin
    xml := TXMLConfig.Create(nil);
    if FileExists(currentDir + files[i]) then
    begin
      xml.LoadFromFile(currentDir + files[i]);

      curLang := xml.GetValue('CurrentLanguage', PChar('error'));
      if curLang <> 'error' then
      begin
        m := TMenuItem.Create(nil);
        m.Caption:=PChar(curLang);
        m.Hint :=PChar(files[i]);
        m.OnClick:= @MenuItemLangClick;
        PopupMenuLang.Items.Add(m);
      end;

    end;
  end;
end;


function TForm1.LoadLanguage(filename:String):TXMLConfig;
begin

  result := TXMLConfig.Create(nil);
  if FileExists(currentDir+filename) then
    result.LoadFromFile(currentDir+filename);

  currentLanguage :=  filename;

  BCLabel1.Caption := result.GetValue('Title1', PChar('Adresse URL'))+' :';
  BCLabel2.Caption := result.GetValue('Title2', PChar('Format'))+' :';
  MenuItemPathDL.Caption:= result.GetValue('Title3', PChar('Chemin de téléchargement'));
  BCLabel3.Caption := MenuItemPathDL.Caption+' :';
  BCLabel4.Caption := result.GetValue('Title4', PChar('Configuration'))+' :';

  BCButtonFocus2.Caption := result.GetValue('Button2', PChar(BCButtonFocus2.Caption));
  BCButtonFocus3.Caption := result.GetValue('Button3', PChar(BCButtonFocus3.Caption));
  BCButtonFocus4.Caption := result.GetValue('Button4', PChar(BCButtonFocus4.Caption));
  BCButtonFocus5.Caption := result.GetValue('Button5', PChar(BCButtonFocus5.Caption));
  BCButtonFocus6.Caption := result.GetValue('Button6', PChar(BCButtonFocus6.Caption));
  BCButtonFocus8.Caption := result.GetValue('Button8', PChar(BCButtonFocus8.Caption));
  BCButtonFocus9.Caption := result.GetValue('Button9', PChar(BCButtonFocus9.Caption));

  MenuItem1.Caption:= BCButtonFocus4.Caption;
  MenuItemSkin.Caption:= BCButtonFocus5.Caption;
  MenuItemAbout.Caption:= BCButtonFocus6.Caption;


  MenuItem7.Caption:= result.GetValue('PopSkin1', MenuItem7.Caption);
  MenuItem5.Caption:= result.GetValue('PopSkin2', MenuItem5.Caption);
  MenuItem6.Caption:= result.GetValue('PopSkin3', MenuItem6.Caption);
  MenuItem11.Caption:= result.GetValue('PopSkin4', MenuItem11.Caption);

  MenuItemSkinBlack.Caption := MenuItem7.Caption;
  MenuItemSkinBlue.Caption := MenuItem5.Caption;
  MenuItemSkinWhite.Caption := MenuItem6.Caption;
  MenuItem12.Caption := MenuItem11.Caption;

  MenuItem8.Caption:= result.GetValue('PopHistory1', MenuItem8.Caption);
  MenuItem9.Caption:= result.GetValue('PopHistory2', MenuItem9.Caption);
  MenuItem10.Caption:= result.GetValue('PopHistory3', MenuItem10.Caption);
  MenuItem3.Caption:= result.GetValue('PopTray1', MenuItem3.Caption);
  MenuItem4.Caption:= result.GetValue('PopTray2', MenuItem4.Caption);
  MenuItemExit.Caption:= result.GetValue('PopTray3', MenuItemExit.Caption);


  CheckListBoxConfig.Items.Clear;
  CheckListBoxConfig.Items.Add(result.GetValue('Config1', PChar('Surveiller le presse papier')));
  CheckListBoxConfig.Items.Add(result.GetValue('Config2', PChar('Masquer la fenêtre après clique sur télécharger')));
  CheckListBoxConfig.Items.Add(result.GetValue('Config3', PChar('Mise à jour au démarrage de l''application')));
  CheckListBoxConfig.Items.Add(result.GetValue('Config4', PChar('Lancer l''application au démarrage du système')));
  CheckListBoxConfig.Items.Add(result.GetValue('Config5', PChar('Interdire de télécharger deux fois la même vidéo (mise en historique)')));
  CheckListBoxConfig.Items.Add(result.GetValue('Config6', PChar('Demander confirmation pour quitter')));

  MenuItemCheckClipboard.Caption:= CheckListBoxConfig.Items[0];
  MenuItemHideOnDownload.Caption:= CheckListBoxConfig.Items[1];
  MenuItem4.Caption:= BCButtonFocus3.Caption;
  MenuItemUpdateOnBoot.Caption:= CheckListBoxConfig.Items[2];
  MenuItemStartOnBoot.Caption:= CheckListBoxConfig.Items[3];

end;

procedure TForm1.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTCAPTION; // Move window on drag
end;

function TForm1.ReadFile(Filename: String):String;
var
  Fichier        : textfile;
  texte          : string;
begin
  result:= '';
  assignFile(Fichier, Filename);
  reset(Fichier);
  while not eof(Fichier) do begin
    read(Fichier, texte);
    result := result + texte;
  end;
  closefile(Fichier);
end;

procedure TForm1.WriteFile(Filename, Content : String);
var
  Fp : textfile;
begin
  assignFile(Fp, Filename);
  reWrite(Fp);
  Writeln(Fp, Content);
  closefile(Fp);
end;


function TForm1.GetWinDir: string;
var
  dirname: array [0..MAX_PATH] of Char;
begin
  dirname := '';
  GetWindowsDirectory(dirname, MAX_PATH);
  Result := StrPas(dirname);
end;


function TForm1.getUserPath:string;
var pathString:array[0..1023] of char;
begin
   ShGetSpecialFolderPath(0,PChar(@pathString),CSIDL_APPDATA,false);
   result:=pathString;
end;


function TForm1.FindWindowByTitle(WindowTitle: string): Hwnd;
var
  NextHandle: Hwnd;
  NextTitle: array[0..260] of char;
  ProcessId: Cardinal;
begin
  // Get the first window
  NextHandle := GetWindow(Self.Handle, GW_HWNDFIRST);
  while NextHandle > 0 do
  begin
    // retrieve its text
    GetWindowText(NextHandle, NextTitle, 255);
    GetWindowThreadProcessId(NextHandle ,@ProcessId);
    if (Pos(LowerCase(WindowTitle), LowerCase(StrPas(NextTitle))) <> 0) then
    begin
      Result := NextHandle;
      Exit;
    end
    else
      // Get the next window
      NextHandle := GetWindow(NextHandle, GW_HWNDNEXT);
  end;
  Result := 0;
end;



function TForm1.CloseProcess(const windowName: PChar): Boolean;
var AppHandle: THandle;
begin
  AppHandle:=FindWindow(Nil, windowName);
  Result:=PostMessage(AppHandle, WM_QUIT, 0, 0);
end;

procedure TForm1.ExecAndContinue(sExe, sCmd: string; wShowWin: Word);
var
  h: Cardinal;
  operation: PChar;
begin
  ShellExecute(0, 'open', PChar(sExe), PChar(sCmd), nil,wShowWin);
end;

procedure TForm1.ExecuteProcess(cmd: String);
begin
  ExecuteProcess(cmd, False, True);
end;


procedure TForm1.ExecuteProcess(cmd: String; pwait, pshow: Boolean);
var p: TProcess;
begin
  p := TProcess.Create(nil);
  p.ApplicationName:= '';
  p.CommandLine:= cmd;
  if not pshow then p.ShowWindow:= swoHIDE;
  p.Execute;
  if pwait then p.WaitOnExit;
end;

procedure TForm1.ExecuteProcess(app, cmd: String; pwait, pshow: Boolean);
var p: TProcess;
begin
  p := TProcess.Create(nil);
  p.ApplicationName:= app;
  p.CommandLine:= cmd;
  if not pshow then p.ShowWindow:= swoHIDE;
  p.Execute;
  if pwait then p.WaitOnExit;
end;


procedure TForm1.StartWithWindows(doStart: Boolean);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  try
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    if doStart then
      Reg.WriteString('YoutubeDownloader.exe', '"'+Application.ExeName+'" /background')
    else
      Reg.DeleteValue('YoutubeDownloader.exe');   // ExtractFileName(Application.ExeName)
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;


function TForm1.isStartWithWindows(): Boolean;
var
  Reg: TRegistry;
begin
  result := False;
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', True) then
  begin
    result := Reg.ValueExists('YoutubeDownloader.exe');
    Reg.CloseKey;
  end;
  Reg.Free;
end;

procedure TForm1.MenuItemCacheClearClick(Sender: TObject);
begin
  if MessageDlg(xmlLang.GetValue('Question1', PChar('Effacer l''historique?')),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then Exit;
  DeleteFile('archive.txt');
  if FileExists('archive.txt') then
    ShowMessage(xmlLang.GetValue('error', PChar('Erreur')))
  else
    ShowMessage(xmlLang.GetValue('erased', PChar('Effacé')));
end;

procedure TForm1.MenuItemCacheHelpClick(Sender: TObject);
begin
  ShowMessage(xmlLang.GetValue('helpcache', PChar('Ce cache mémorise les vidéos téléchargées pour ne pas les télécharger une seconde fois.')));
end;

procedure TForm1.MenuItemAboutClick(Sender: TObject);
begin
  ShowMessage('Youtube Downlader version: '+CurrentVersion+#13#10#13#10+
  'Source: https://github.com/ddeeproton/YoutubeDownloader');
end;


procedure TForm1.DownloadFile(http, filename: String; wait, pshow: Boolean);
begin
  if not FileExists(currentDir + 'wget.exe') then
  begin
    ShowMessage(xmlLang.GetValue('error_wget', PChar('Erreur: wget.exe est introuvable')));
    exit;
  end;
  if FileExists(filename) then DeleteFile(PChar(filename));
  ExecuteProcess('"' + currentDir + 'wget.exe" -O "'+filename+'" "'+http+'" --no-check-certificate', wait, pshow);
end;


procedure TForm1.DownloadFileToDir(http, dir: String; wait, pshow: Boolean);
begin
  if not FileExists('wget.exe') then
  begin
    ShowMessage(xmlLang.GetValue('error_wget', PChar('Erreur: wget.exe est introuvable')));
    exit;
  end;
  if not DirectoryExists(dir) then
  begin
    if not SelectDirectoryDialog1.Execute then exit;
    EditPath.Text := SelectDirectoryDialog1.FileName;
    ConfigSave;
    dir := EditPath.Text;
  end;
  SetCurrentDirectory(PChar(dir));
  ExecuteProcess(ExtractFileDir(Application.Exename)+'\wget.exe "'+http+'" --no-check-certificate', wait, pshow);
  SetCurrentDirectory(PChar(ExtractFileDir(Application.Exename)));
end;


procedure TForm1.MenuItemCacheOpenClick(Sender: TObject);
begin
  ExecuteProcess('"'+GetWinDir+'\notepad.exe" "'+ExtractFileDir(Application.ExeName) + '\archive.txt"');
end;

procedure TForm1.MenuItemCacheToggleClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  ConfigSave;
end;

procedure TForm1.MenuItemCheckClipboardClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  TimerClipboard.Enabled := TMenuItem(Sender).Checked;
  ConfigSave;
end;


procedure TForm1.MenuItemHideOnDownloadClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  ConfigSave;
end;

procedure TForm1.MenuItemExitClick(Sender: TObject);
begin
  if CheckListBoxConfig.Checked[5] then
  begin
    if MessageDlg(xmlLang.GetValue('QuestionExit', PChar('Voulez-vous fermer l''application?')),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then Exit;
  end;
  Application.Terminate;
end;

procedure TForm1.MenuItemShowClick(Sender: TObject);
begin
  Show;
  Form1.WindowState:= wsNormal;
  BringToFront;
end;


procedure TForm1.SetSkin(skinIdImage: Integer; skinColor, bgColor:TColor);
var a: TControlBorderSpacing;
  b: TSpacingSize;
begin
  currentSkin := skinIdImage;
  ImageList1.GetIcon(currentSkin, Image1.Picture.Icon);
  ImageList2.GetIcon(currentSkin, Self.Icon);
  ImageList2.GetIcon(currentSkin, TrayIcon1.Icon);


  BCButtonFocus1.StateNormal.Background.Gradient1.EndColor:= bgColor; //$009C9623;
  BCButtonFocus2.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus3.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus4.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus5.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus6.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus7.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus8.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus9.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus10.StateNormal.Background.Gradient1.EndColor:= bgColor;
  BCButtonFocus11.StateNormal.Background.Gradient1.EndColor:= bgColor;

  BCLabel1.FontEx.Color := skinColor;
  BCLabel1.FontEx.ShadowColor := bgColor;
  BCLabel2.FontEx.Color := skinColor;
  BCLabel2.FontEx.ShadowColor := bgColor;
  BCLabel3.FontEx.Color := skinColor;
  BCLabel3.FontEx.ShadowColor := bgColor;
  BCLabel4.FontEx.Color := skinColor;
  BCLabel4.FontEx.ShadowColor := bgColor;

  EditHTTP.Font.Color := skinColor; //RGB(117,190,197);
  EditHTTP.Color := bgColor;

  EditPath.Font.Color := skinColor;
  EditPath.Color := bgColor;

  CheckListBoxConfig.Font.Color := skinColor;
  CheckListBoxConfig.Color := bgColor;

  ComboBoxEncoding.Font.Color := skinColor;
  ComboBoxEncoding.Color := bgColor;

end;

procedure TForm1.MenuItemSkinBlueClick(Sender: TObject);
begin
  SetSkin(0, clWhite, $009C9623);
  if Sender <> nil then ConfigSave;
end;

procedure TForm1.MenuItemSkinRedClick(Sender: TObject);
begin
  SetSkin(3, clWhite, RGB(210, 0, 20));
  if Sender <> nil then ConfigSave;
end;

procedure TForm1.MenuItemSkinWhiteClick(Sender: TObject);
begin
  SetSkin(1, clBlack, $00B7B7B7);
  if Sender <> nil then ConfigSave;
end;

procedure TForm1.MenuItemSkinBlackClick(Sender: TObject);
begin
  SetSkin(2, RGB(200, 200, 200), RGB(20, 20, 20));
  if Sender <> nil then ConfigSave;
end;

procedure TForm1.MenuItemStartOnBootClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  StartWithWindows(TMenuItem(Sender).Checked);
end;

procedure TForm1.CheckUpdate();
var lastVersion: String;
begin
  if not FileExists('wget.exe') then exit;
  DownloadFile('https://github.com/ddeeproton/YoutubeDownloader/raw/master/lastversion.txt','lastversion.txt', True, False);
  if not FileExists('lastversion.txt') then exit;
  lastVersion := ReadFile('lastversion.txt');
  DeleteFile(PChar('lastversion.txt'));
  if CurrentVersion = lastVersion then exit;
  if MessageDlg(xmlLang.GetValue('update_aviable', PChar('Une mise à jour est disponible. Télécharger?')),  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then Exit;
  MenuItemUpdateClick(nil);
end;

procedure TForm1.MenuItemUpdateClick(Sender: TObject);
var lastVersion: String;
begin
  if not FileExists(currentDir + 'wget.exe') then
  begin
    ShowMessage(xmlLang.GetValue('error_wget', PChar('Erreur: wget.exe est introuvable')));
    exit;
  end;
  DownloadFile('https://github.com/ddeeproton/YoutubeDownloader/raw/master/lastversion.txt',Config_Dir + 'lastversion.txt', True, False);

  if not FileExists(Config_Dir + 'lastversion.txt') then
  begin
    ShowMessage(xmlLang.GetValue('error_network', PChar('Vous ne semblez pas connecté à Internet')));
    exit;
  end;

  lastVersion := ReadFile(Config_Dir + 'lastversion.txt');
  DeleteFile(PChar(Config_Dir + 'lastversion.txt'));

  if CurrentVersion = lastVersion then
  begin
    ShowMessage(xmlLang.GetValue('already_updated', PChar('Vous êtes à jour :)')));
    exit;
  end;

  if FileExists(currentDir + 'YoutubeDownloaderSetup.exe') then
  begin
    DeleteFile(PChar(currentDir + 'YoutubeDownloaderSetup.exe'));
  end;

  DownloadFile('https://github.com/ddeeproton/YoutubeDownloader/raw/master/Setup%20installation/YoutubeDownloaderSetup_'+lastVersion+'.exe',currentDir + 'YoutubeDownloaderSetup.exe', True, True);

  if not FileExists(currentDir + 'YoutubeDownloaderSetup.exe') then
  begin
    ShowMessage(xmlLang.GetValue('error_update', PChar('Erreur lors du téléchargement de la mise à jour')));
    exit;
  end;

  //ExecuteProcess(currentDir + 'YoutubeDownloaderSetup.exe', '/S', False, True);

  ExecAndContinue(currentDir + 'YoutubeDownloaderSetup.exe', '/S', SW_SHOW);
  Application.Terminate;

end;

procedure TForm1.MenuItemUpdateOnBootClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  ConfigSave;
end;


procedure TForm1.MenuItemHideClick(Sender: TObject);
begin
  Hide;
  setFormHeight(Config_HeightMinimized);
end;

procedure TForm1.setFormAtBottomRight;
var x,y: Integer;
begin
  Left := Screen.WorkAreaWidth  - Form1.Width  + Screen.WorkAreaLeft;
  Top  := Screen.WorkAreaHeight - Form1.Height + Screen.WorkAreaTop;
end;

procedure TForm1.ButtonPasteClick(Sender: TObject);
begin
  EditHTTP.Clear;
  EditHTTP.PasteFromClipboard;
end;

procedure TForm1.CheckListBoxConfigClick(Sender: TObject);
var i: Integer;
begin
  i := CheckListBoxConfig.ItemIndex;
  if i = -1 then exit;
  CheckListBoxConfig.Checked[i] := not CheckListBoxConfig.Checked[i];
  ConfigSaveFromCheckBox;
end;

procedure TForm1.CheckListBoxConfigClickCheck(Sender: TObject);
begin
  ConfigSaveFromCheckBox;
end;

procedure TForm1.ComboBoxEncodingChange(Sender: TObject);
begin
  ConfigSave;
end;


procedure TForm1.ButtonDownloadClick(Sender: TObject);
begin
  DoDownload();

end;

procedure TForm1.ButtonMenuClick(Sender: TObject);
begin
  PopupMenuTray.PopUp;
end;

procedure TForm1.ButtonSetDownloadPathClick(Sender: TObject);
begin
  if not SelectDirectoryDialog1.Execute then exit;
  EditPath.Text := SelectDirectoryDialog1.FileName;
  ConfigSave;
end;


procedure TForm1.ButtonDownloadKeyPress(Sender: TObject; var Key: char);
begin
  if ord(Key) = 27 then MenuItemHideClick(nil);
  if ord(Key) = 13 then ButtonDownloadClick(nil);
end;

procedure TForm1.BCButtonFocus4Click(Sender: TObject);
begin
  PopupMenuHistory.PopUp;
end;

procedure TForm1.BCButtonFocus10Click(Sender: TObject);
begin

end;

procedure TForm1.BCButtonFocus1Click(Sender: TObject);
begin
  if Height = Config_HeightMaximized then
    setFormHeight(Config_HeightMinimized)
  else
    setFormHeight(Config_HeightMaximized);
  setFormAtBottomRight;
end;



procedure TForm1.BCButtonFocus5Click(Sender: TObject);
begin
  PopupMenuSkin.PopUp;
end;

procedure TForm1.BCButtonFocus8Click(Sender: TObject);
begin
  PopupMenuLang.PopUp;
end;



procedure TForm1.SplitStr(const Source, Delimiter: String; var DelimitedList: TStringList);
var
  s: PChar;
  DelimiterIndex: Integer;
  Item: String;
begin
  s:=PChar(Source);
  repeat
    DelimiterIndex:=Pos(Delimiter, s);
    if DelimiterIndex=0 then Break;
    Item:=Copy(s, 1, DelimiterIndex-1);
    DelimitedList.Add(Item);
    inc(s, DelimiterIndex + Length(Delimiter)-1);
  until DelimiterIndex = 0;
  DelimitedList.Add(s);
end;

function TForm1.getEncoding(): String;
var
  i:integer;
  media_type, media_format, media_quality: String;
  data: TStringList;
begin
  data := TStringList.Create;
  SplitStr(ComboBoxEncoding.Text,' ',data);

  if data.Count = 1 then
  begin
    media_format := ComboBoxEncoding.Text;
    media_quality := '';
    media_type := '';
  end;
  if data.Count = 2 then
  begin
    media_type := data.Strings[0];
    media_format := data.Strings[1];
    media_quality := '';
  end;
  if data.Count = 3 then
  begin
    media_type := data.Strings[0];
    media_format := data.Strings[1];
    media_quality := data.Strings[2];
  end;
  if media_type = 'audio' then
  begin
    media_type := '--extract-audio ';
    if media_format = 'ogg' then media_format := 'vorbis';
    if media_format <> '' then media_format := ' --audio-format '+media_format;
    if media_quality <> '' then media_quality := ' --audio-quality '+media_quality;
    result := media_type + media_format + media_quality;
  end else
  begin
    result := '-f '+media_format;
  end;

end;

procedure TForm1.DoDownload();
var url: String;
begin
  url := EditHTTP.Text;
  if url = '' then
  begin
    ShowMessage(xmlLang.GetValue('error_noUrlFound', PChar('Veuillez entrer d''abord un lien avant de cliquer sur Télécharger.')));
    exit;
  end;

  if ComboBoxEncoding.Text = 'fichier brut' then
  begin
    DownloadFileToDir(url, EditPath.Text, False, True);
  end else
  begin
    if url.Contains('https://www.mixcloud.com/') then
      DoDownloadWithMixcloud
    else
      DoDownloadWithYoutubeDl;
  end;

  if MenuItemHideOnDownload.Checked then
    MenuItemHideClick(nil);

end;



procedure TForm1.DoDownloadWithYoutubeDl();
var
  UseCache: String;
  WindRect: TRect;
  CmdHandle: Handle;
  VolumeWidth, VolumeHeight, VolumeTop, VolumeLeft: Integer;
begin

  if not FileExists(Config_YoutubeDownloader) then
  begin
    ShowMessage(xmlLang.GetValue('error_YTnotFound', PChar('youtube-dl.exe est introuvable. Il doit se trouver à côté de cette application pour fonctionner.')));
    exit;
  end;

  if EditHTTP.Text = '' then
  begin
    ShowMessage(xmlLang.GetValue('error_noUrlFound', PChar('Veuillez entrer d''abord un lien avant de cliquer sur Télécharger.')));
    exit;
  end;

  if not DirectoryExists(EditPath.Text) then
  begin
    if not SelectDirectoryDialog1.Execute then exit;
    EditPath.Text := SelectDirectoryDialog1.FileName;
    ConfigSave;
  end;

  UseCache := '';
  if MenuItemCacheToggle.Checked then
    UseCache := '--download-archive "archive.txt"';

  Process1.ApplicationName := Config_YoutubeDownloader;
  Process1.CommandLine := ' '+UseCache
                       +' --ignore-errors '
                       +getEncoding()
                       +' --restrict-filenames -o "'+EditPath.Text+'\%(title)s.%(ext)s" '
                       +'"'+EditHTTP.Text+'"';

  Process1.Execute;
  Application.ProcessMessages;
  Sleep(1000);


  CmdHandle := FindWindowByTitle(Config_YoutubeDownloader);
  // Récupère les informations de la fenêtre (largeur, hauteur)
  GetWindowRect(CmdHandle, WindRect);
  // Mémorise les dimensions de la fenêtre du volume
  VolumeWidth := WindRect.Right - WindRect.Left;
  VolumeHeight := WindRect.Bottom - WindRect.Top;
  VolumeTop := Screen.WorkAreaHeight - VolumeHeight;
  VolumeLeft := Screen.WorkAreaWidth - VolumeWidth;
  // Déplace la fenêtre en bas de l'écran
  MoveWindow(CmdHandle, VolumeLeft, VolumeTop, VolumeWidth, VolumeHeight, true);
end;


procedure TForm1.DoDownloadWithMixcloud();
var
  url, filename: String;
  i: Integer;
begin
  url := EditHTTP.Text;
  if url = '' then
  begin
    ShowMessage(xmlLang.GetValue('error_noUrlFound', PChar('Veuillez entrer d''abord un lien avant de cliquer sur Télécharger.')));
    exit;
  end;
  if not SelectDirectoryDialog1.Execute then exit;
  // Get the filename in last position of url
  i := url.LastIndexOf('/');
  if i = Length(url)-1 then
    url := Copy(url, 0, Length(url)-1);
  i := url.LastIndexOf('/');
  filename := Copy(url, i+2);
  url := url.Replace('https://www.mixcloud.com/', 'http://download.mixcloud-downloader.com/d/mixcloud/');
  DownloadFile(url, SelectDirectoryDialog1.FileName+'\'+filename+'.m4a', False, True);
end;

procedure TForm1.TimerClipboardTimer(Sender: TObject);
var url, message: string;
begin
  url := clipbrd.Clipboard.AsText;
  if url = oldClipboardValue then exit;
  oldClipboardValue := url;
  if not url.StartsWith('http', true) then exit;
  MenuItemShowClick(nil);
  ButtonPasteClick(nil);
end;


end.

