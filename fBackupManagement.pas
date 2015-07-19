unit fBackupManagement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, math, strutils;

type
  TfrmBackupManagement = class(TForm)
    lvwBackups: TListView;
    cmdOK: TButton;
    PopupMenu: TPopupMenu;
    mnuDelete: TMenuItem;
    lblOverallSize: TLabel;
    procedure FormShow(Sender: TObject);
    procedure mnuDeleteClick(Sender: TObject);
  private
    procedure PopulateListview;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBackupManagement: TfrmBackupManagement;

implementation

{$R *.dfm}

procedure TfrmBackupManagement.FormShow(Sender: TObject);
begin
  PopulateListView;
end;

procedure TfrmBackupManagement.PopulateListview;
var
  sr: TSearchRec;
  OverallSize : Integer;
begin
  lvwBackups.Items.BeginUpdate;
  lvwBackups.Items.Clear;
  OverallSize := 0;
  if FindFirst(ExtractFileDir(Application.ExeName)+ '\Backups\*.zip', faAnyFile, sr) = 0 then
  begin
    repeat
      if Length(sr.Name) = 26 then
      begin
        with lvwBackups.Items.Add do
        begin
  //      'MM 01-06-2004 12-59-55.zip'
          Caption := Copy(sr.Name,4,10);
          SubItems.Add(AnsiReplaceText(Copy(sr.Name,15,8),'-',':'));
          SubItems.Add(FloatToStr(SimpleRoundTo(sr.Size / 1024,-2)) + 'kb');
          OverallSize := OverallSize + sr.Size;
        end;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  lvwBackups.Items.EndUpdate;
  lblOverallSize.Caption := 'Overall Size: ' + FloatToStr(SimpleRoundTo(OverallSize / 1024,-2)) + 'kb';
end;

procedure TfrmBackupManagement.mnuDeleteClick(Sender: TObject);
var
  Filename : String;
begin
  if messagedlg('Do you wish to delete this backup?',mtConfirmation,[mbYes, mbNo],0) = mrYes then
  begin
    Filename := ExtractFileDir(Application.ExeName) + '\Backups\' + 'MM ' + lvwBackups.Selected.Caption + ' ' + AnsiReplaceText(lvwBackups.Selected.SubItems[0],':','-') + '.zip';
    if FileExists(Filename) then
    begin
      DeleteFile(Filename);
      PopulateListview;
    end;
  end;
end;

end.
