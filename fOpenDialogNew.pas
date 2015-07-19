unit fOpenDialogNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SsShlDlg, StdCtrls, Buttons, XPMan,JCLShell, shlobj;

type
  TfrmOpenDialogNew = class(TForm)
    pnlOpenDialog: TPanel;
    stOpenDialog: TStDialogPanel;
    XPManifest1: TXPManifest;
    pnlNavigation: TPanel;
    cmdApplicationDirectory: TBitBtn;
    cmdMyDocuments: TBitBtn;
    cmdDesktop: TBitBtn;
    pnlExtra: TPanel;
    lblOpenAs: TLabel;
    cbDataFile: TComboBox;
    chkAutoCheckROMType: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure cmdMyDocumentsClick(Sender: TObject);
    procedure cmdDesktopClick(Sender: TObject);
    procedure cmdApplicationDirectoryClick(Sender: TObject);
    procedure stOpenDialogOpenButtonClick(Sender: TObject;
      var DefaultAction: Boolean);
  private
    _MyDocumentsDir, _DesktopDir, _AppDir : String;
    procedure LoadDataFiles();
    { Private declarations }
  public
    Filename,OpenDir,DataFile : String;
    AutoCheck : Boolean;
    { Public declarations }
  end;

var
  frmOpenDialogNew: TfrmOpenDialogNew;

implementation

{$R *.dfm}

uses uResourceStrings, uGlobal;

procedure TfrmOpenDialogNew.FormShow(Sender: TObject);
begin
  _MyDocumentsDir := GetSpecialFolderLocation(CSIDL_PERSONAL);
  _DesktopDir := GetSpecialFolderLocation(CSIDL_DESKTOP);
  _AppDir := ExtractFileDir(Application.ExeName);
  LoadDataFiles();
  chkAutoCheckROMType.Checked := EditorConfig.AutoCheck;
  cbDataFile.ItemIndex := cbDataFile.Items.IndexOf(EditorConfig.DataFileName);
  if DirectoryExists(OpenDir) = False then
  begin
    stOpenDialog.InitialDir := ExtractFileDir(Application.ExeName);
  end
  else
    stOpenDialog.InitialDir := OpenDir;
end;

procedure TfrmOpenDialogNew.LoadDataFiles();
begin
  cbDataFile.Items.Clear;
  cbDataFile.Items.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\data.dat');
end;

procedure TfrmOpenDialogNew.cmdMyDocumentsClick(Sender: TObject);
begin
  stOpenDialog.InitialDir := _MyDocumentsDir;
end;

procedure TfrmOpenDialogNew.cmdDesktopClick(Sender: TObject);
begin
  stOpenDialog.InitialDir := _DesktopDir;
end;

procedure TfrmOpenDialogNew.cmdApplicationDirectoryClick(Sender: TObject);
begin
  stOpenDialog.InitialDir := _AppDir;
end;

procedure TfrmOpenDialogNew.stOpenDialogOpenButtonClick(Sender: TObject;
  var DefaultAction: Boolean);
begin
  if FileExists(stOpenDialog.FileName) = true then
  begin
    Filename := stOpenDialog.FileName;
    DataFile := ExtractFileDir(Application.ExeName) + '\Data\' + cbDataFile.Items[cbDataFile.ItemIndex];
    AutoCheck := chkAutoCheckROMType.Checked;
    modalresult := mrOK;
  end
  else
    messagebox(handle,PChar(RES_FILENOTEXIST),PChar(Application.Title),0);
end;

end.
