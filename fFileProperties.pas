unit fFileProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, cROMData;

type
  TfrmFileProperties = class(TForm)
    lblFilename: TLabel;
    txtFilename: TEdit;
    lblMemoryMapper: TLabel;
    lblPRGCount: TLabel;
    lblCHRCount: TLabel;
    lblFileSize: TLabel;
    cmdOK: TButton;
    cmdRestoreHeaderToDefault: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdRestoreHeaderToDefaultClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    procedure Load;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    { Public declarations }
  end;

var
  frmFileProperties: TfrmFileProperties;

implementation

{$R *.dfm}

procedure TfrmFileProperties.FormShow(Sender: TObject);
begin
  Load;
end;

procedure TfrmFileProperties.Load;
begin
  txtFilename.Text := _ROMData.Filename;
  lblCHRCount.Caption := 'CHR Count: ' + IntToStr(_ROMData.CHRCount);
  lblPRGCount.Caption := 'PRG Count: ' + IntToStr(_ROMData.PRGCount);
  lblMemoryMapper.Caption := 'Memory Mapper: ' + IntToStr(_ROMData.MemoryMapper) + ' (' + _ROMData.MemoryMapperStr + ')';
  if _ROMData.ROM.DiskDudePresent = True then
    lblMemoryMapper.Caption := lblMemoryMapper.Caption + ' (Diskdude Tag Present)';
  lblFilesize.Caption := 'File Size: ' + IntToStr(_ROMData.FileSize) + ' bytes';
end;

procedure TfrmFileProperties.cmdRestoreHeaderToDefaultClick(
  Sender: TObject);
begin
  _ROMData.RestoreDefaultiNESHeader;
  Load;
  showmessage('Header restored.');
end;

constructor TfrmFileProperties.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
