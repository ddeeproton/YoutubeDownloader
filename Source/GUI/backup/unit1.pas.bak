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
    MenuItemHide: TMenuItem;
    MenuItemShow: TMenuItem;
    MenuItemExit: TMenuItem;
    PopupMenu1: TPopupMenu;
    Process1: TProcess;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure ButtonDownloadWAVClick(Sender: TObject);
    procedure ButtonPasteClick(Sender: TObject);
    procedure ButtonDownloadMP3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemHideClick(Sender: TObject);
    procedure MenuItemShowClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure DoDownload(DoConvert:Boolean);
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

procedure TForm1.MenuItemExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItemHideClick(Sender: TObject);
begin
  Hide;
end;

procedure TForm1.MenuItemShowClick(Sender: TObject);
begin
  Show;
  Form1.WindowState:= wsNormal;
  BringToFront;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
  MenuItemShowClick(nil);
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
     Process1.CommandLine:= '-q --download-archive archive.txt --extract-audio --audio-format mp3 --audio-quality 128K --write-thumbnail --restrict-filenames -o "'+SelectDirectoryDialog1.FileName+'\%(title)s.%(ext)s" "'+Edit1.Text+'"'
  else
     Process1.CommandLine:= '-q --download-archive archive.txt --extract-audio --audio-format wav --write-thumbnail --restrict-filenames -o "'+SelectDirectoryDialog1.FileName+'\%(title)s.%(ext)s" "'+Edit1.Text+'"';
  process1.Execute;
end;

procedure TForm1.ButtonDownloadMP3Click(Sender: TObject);
begin
  DoDownload(True);
end;


procedure TForm1.ButtonDownloadWAVClick(Sender: TObject);
begin
  DoDownload(False);
end;

procedure TForm1.ButtonPasteClick(Sender: TObject);
begin
  Edit1.Clear;
  Edit1.PasteFromClipboard;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var url: string;
begin
  url := clipbrd.Clipboard.AsText;
  if url = oldClipboardValue then exit;
  oldClipboardValue := url;
  if not url.StartsWith('http', true) then exit;
  MenuItemShowClick(nil);
  if Length(url) > 100 then
    url := url.Substring(0, 100)+'...';
  if MessageDlg('Voulez-vous télécharger?'+#13#10#13#10+url,  mtConfirmation, [mbYes, mbNo], 0) <> IDYES then
    Exit;
  ButtonPasteClick(nil);
  if MessageDlg('Compresser l''audio? (Réponse oui => MP3, non => WAV)',  mtConfirmation, [mbYes, mbNo], 0) = IDYES then
    ButtonDownloadMP3Click(nil)
  else
    ButtonDownloadWAVClick(nil);


end;


end.

