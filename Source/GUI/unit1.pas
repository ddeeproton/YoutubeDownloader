unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Menus, ExtCtrls, clipbrd, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ButtonDownloadWAV: TButton;
    ButtonDownloadMP3: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItemCacheHelp: TMenuItem;
    MenuItemCacheClear: TMenuItem;
    MenuItemCacheOpen: TMenuItem;
    MenuItemHide: TMenuItem;
    MenuItemShow: TMenuItem;
    MenuItemExit: TMenuItem;
    PopupMenuTray: TPopupMenu;
    Process1: TProcess;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure ButtonDownloadWAVClick(Sender: TObject);
    procedure ButtonPasteClick(Sender: TObject);
    procedure ButtonDownloadMP3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemCacheClearClick(Sender: TObject);
    procedure MenuItemCacheHelpClick(Sender: TObject);
    procedure MenuItemCacheOpenClick(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemHideClick(Sender: TObject);
    procedure MenuItemShowClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DoDownload(DoConvert:Boolean);
    function GetWinDir: string;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Config_YoutubeDownloader: String = 'youtube-dl.exe';
  oldClipboardValue: String = '';

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.Height:= 66;
  Edit1.Text:= '';
end;

procedure TForm1.MenuItemCacheClearClick(Sender: TObject);
begin
  if MessageDlg('Voulez-vous effacer le cache?',  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then Exit;
  DeleteFile('archive.txt');
  if FileExists('archive.txt') then
    ShowMessage('Il y a eu un problème avec l''effacement du cache. '
      +'Peut-être le fichier est utilisé. '
      +'Veuillez fermer tous les programmes et recommencer, '
      +'ou effacer à la main le fichier "archive.txt"')
  else
    ShowMessage('Cache effacé :)');
end;

procedure TForm1.MenuItemCacheHelpClick(Sender: TObject);
begin
  ShowMessage('Ce cache mémorise les vidéos téléchargées pour ne pas les télécharger une seconde fois.');
end;


function TForm1.GetWinDir: string;
var
  dir: array [0..MAX_PATH] of Char;
begin
  GetWindowsDirectory(dir, MAX_PATH);
  Result := StrPas(dir);
end;

procedure TForm1.MenuItemCacheOpenClick(Sender: TObject);
var p: TProcess;
begin
  p := TProcess.Create(nil);
  p.ApplicationName:= '';
  p.CommandLine:= '"'+GetWinDir+'\notepad.exe" "'+ExtractFileDir(Application.ExeName) + '\archive.txt"';
  p.Execute;
end;

procedure TForm1.MenuItemExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItemShowClick(Sender: TObject);
begin
  Show;
  Form1.WindowState:= wsNormal;
  BringToFront;
end;

procedure TForm1.MenuItemHideClick(Sender: TObject);
begin
  Hide;
end;

procedure TForm1.ButtonPasteClick(Sender: TObject);
begin
  Edit1.Clear;
  Edit1.PasteFromClipboard;
end;

procedure TForm1.ButtonDownloadMP3Click(Sender: TObject);
begin
  DoDownload(True);
end;

procedure TForm1.ButtonDownloadWAVClick(Sender: TObject);
begin
  DoDownload(False);
end;

procedure TForm1.DoDownload(DoConvert:Boolean);
begin
  if Edit1.Text = '' then
  begin
    ShowMessage('Veuillez entrer d''abord un lien Youtube avant de cliquer sur Télécharger.');
    exit;
  end;

  if not FileExists(Config_YoutubeDownloader) then
  begin
    ShowMessage('youtube-dl.exe est introuvable. Il doit se trouver à côté de cette application pour fonctionner.');
    exit;
  end;

  if not SelectDirectoryDialog1.Execute then exit;

  Process1.ApplicationName := Config_YoutubeDownloader;
  if DoConvert then
     Process1.CommandLine := '-q --download-archive archive.txt --extract-audio --audio-format mp3 --audio-quality 128K --restrict-filenames -o "'+SelectDirectoryDialog1.FileName+'\%(title)s.%(ext)s" "'+Edit1.Text+'"'
  else
     Process1.CommandLine := '-q --download-archive archive.txt --extract-audio --audio-format wav --restrict-filenames -o "'+SelectDirectoryDialog1.FileName+'\%(title)s.%(ext)s" "'+Edit1.Text+'"';
  Process1.Execute;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var url: string;
begin
  url := clipbrd.Clipboard.AsText;
  if url = oldClipboardValue then exit;
  oldClipboardValue := url;
  if not url.StartsWith('http', true) then exit;
  MenuItemShowClick(nil);
  if Length(url) > 100 then url := url.Substring(0, 100)+'...';
  if MessageDlg('Voulez-vous télécharger?'+#13#10#13#10+url,  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then Exit;
  ButtonPasteClick(nil);
  if MessageDlg('Compresser l''audio? (Réponse oui => MP3, non => WAV)',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    ButtonDownloadMP3Click(nil)
  else
    ButtonDownloadWAVClick(nil);
end;


end.

