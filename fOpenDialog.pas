unit fOpenDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, JCLShell,Buttons,shlobj, JvExStdCtrls, JvListBox,
  JvDriveCtrls, JvCombobox, FileCtrl, cConfiguration;

type
  TfrmOpenDialog = class(TForm)
    lblFilter: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    cmdMyDocuments: TBitBtn;
    cmdDesktop: TBitBtn;
    cmdApplicationDirectory: TBitBtn;
    lblOpenAs: TLabel;
    cbDataFile: TComboBox;
    chkAutoCheckROMType: TCheckBox;
    DriveCombo: TJvDriveCombo;
    FileListBox: TJvFileListBox;
    DirectoryListBox: TJvDirectoryListBox;
    cbFilter: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure FileListBoxDblClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdMyDocumentsClick(Sender: TObject);
    procedure cmdMyComputerClick(Sender: TObject);
    procedure cmdDesktopClick(Sender: TObject);
    procedure cmdApplicationDirectoryClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbFilterChange(Sender: TObject);
  private
    _MyDocumentsDir, _DesktopDir, _AppDir : String;
    procedure LoadDataFiles;
    { Private declarations }
  public
    _EditorConfig : TEditorConfig;  
    Filename,OpenDir,DataFile : String;
    AutoCheck : Boolean;
    constructor Create(AOwner: TComponent; EditorConfig: TEditorConfig);
    { Public declarations }
  end;

var
  frmOpenDialog: TfrmOpenDialog;

implementation

{$R *.dfm}

uses uResourcestrings;

procedure TfrmOpenDialog.FormShow(Sender: TObject);
begin
  _MyDocumentsDir := GetSpecialFolderLocation(CSIDL_PERSONAL);
  _DesktopDir := GetSpecialFolderLocation(CSIDL_DESKTOP);
  _AppDir := ExtractFileDir(Application.ExeName);
  LoadDataFiles();
  chkAutoCheckROMType.Checked := _EditorConfig.AutoCheck;
  cbDataFile.ItemIndex := cbDataFile.Items.IndexOf(_EditorConfig.DataFileName);
  if DirectoryExists(OpenDir) = False then
  begin
    DirectoryListBox.Directory := ExtractFileDir(Application.ExeName);
  end
  else
    DirectoryListBox.Directory := OpenDir;
//  sdpOpen.InitialDir := OpenDir;
end;

procedure TfrmOpenDialog.FileListBoxDblClick(Sender: TObject);
begin
//  Filename := FileListBox.FileName;
//  modalresult := mrOk;
end;

procedure TfrmOpenDialog.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    close;
end;

procedure TfrmOpenDialog.cmdOKClick(Sender: TObject);
begin
  if FileExists(FileListBox.FileName) = true then
  begin
    Filename := FileListBox.Filename;
    DataFile := ExtractFileDir(Application.ExeName) + '\Data\' + cbDataFile.Items[cbDataFile.ItemIndex];
    AutoCheck := chkAutoCheckROMType.Checked;
    modalresult := mrOK;
  end
  else
    messagebox(handle,PChar(RES_FILENOTEXIST),PChar(Application.Title),0);
end;

procedure TfrmOpenDialog.cmdMyDocumentsClick(Sender: TObject);
begin
  DirectoryListBox.Directory := _MyDocumentsDir;

end;

procedure TfrmOpenDialog.cmdMyComputerClick(Sender: TObject);
begin
  DirectoryListBox.Directory := GetSpecialFolderLocation(CSIDL_DRIVES);
end;

procedure TfrmOpenDialog.cmdDesktopClick(Sender: TObject);
begin
  DirectoryListBox.Directory := _DesktopDir;
end;

procedure TfrmOpenDialog.cmdApplicationDirectoryClick(Sender: TObject);
begin
  DirectoryListBox.Directory := _AppDir;
end;

procedure TfrmOpenDialog.LoadDataFiles();
begin
  cbDataFile.Items.Clear;
  cbDataFile.Items.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\data.dat');
end;

procedure TfrmOpenDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F5 then
  begin
    DriveCombo.Refresh;
    directorylistbox.Refresh;
    FileListBox.Refresh;
  end;
end;

procedure TfrmOpenDialog.cbFilterChange(Sender: TObject);
begin
  if cbFilter.ItemIndex = 0 then
    FileListBox.Mask := '*.nes'
  else
    FileListBox.Mask := '*.*';
end;

constructor TfrmOpenDialog.Create(AOwner: TComponent;EditorConfig : TEditorConfig);
begin
  inherited Create(AOwner);
  _EditorConfig := EditorConfig;
end;

end.
