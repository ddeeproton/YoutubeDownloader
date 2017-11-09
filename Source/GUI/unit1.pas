unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Menus, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonPaste: TButton;
    ButtonDownload: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    MenuItemHide: TMenuItem;
    MenuItemShow: TMenuItem;
    MenuItemExit: TMenuItem;
    PopupMenu1: TPopupMenu;
    Process1: TProcess;
    SaveDialog1: TSaveDialog;
    TrayIcon1: TTrayIcon;
    procedure ButtonPasteClick(Sender: TObject);
    procedure ButtonDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemHideClick(Sender: TObject);
    procedure MenuItemShowClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Config_YoutubeDownloader: String = 'youtube-dl.exe';
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

procedure TForm1.ButtonDownloadClick(Sender: TObject);
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
  if not SaveDialog1.Execute then exit;

  if not SaveDialog1.FileName.EndsWith('.m4a', true) then
    SaveDialog1.FileName := SaveDialog1.FileName + '.m4a';

  Process1.ApplicationName := Config_YoutubeDownloader;
  Process1.CommandLine:= '-q -x --audio-format m4a --write-thumbnail -o "'+SaveDialog1.FileName+'" "'+Edit1.Text+'"';
  process1.Execute;
end;

procedure TForm1.ButtonPasteClick(Sender: TObject);
begin
  Edit1.PasteFromClipboard;
end;

end.

