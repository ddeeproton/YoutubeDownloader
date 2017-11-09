unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonDownload: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Process1: TProcess;
    SaveDialog1: TSaveDialog;
    procedure ButtonDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  Edit1.Text:= '';
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

end.

