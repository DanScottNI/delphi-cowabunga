unit fScrollEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32, GR32_Image, DanHexEdit, Spin, cROMData;

type
  TfrmScrollEditor = class(TForm)
    lblWidth: TLabel;
    lblHeight: TLabel;
    imgLevelMap: TImage32;
    cmdOk: TButton;
    cmdCancel: TButton;
    txtWidth: TEdit;
    txtHeight: TEdit;
    procedure FormShow(Sender: TObject);
    procedure txtHeightChange(Sender: TObject);
    procedure txtHeightKeyPress(Sender: TObject; var Key: Char);
  private
    _ROMData : TTMNTROM;  
    procedure DrawLevelMap;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    { Public declarations }
  end;

var
  frmScrollEditor: TfrmScrollEditor;

implementation

{$R *.dfm}

uses uConsts;

procedure TfrmScrollEditor.FormShow(Sender: TObject);
begin
  txtWidth.Text := IntToStr(_ROMData.CurrSideScroll.Width);
  txtHeight.Text := IntToStr(_ROMData.CurrSideScroll.Height);
  DrawLevelMap;
end;

procedure TfrmScrollEditor.DrawLevelMap;
var
  LevelMap : TBitmap32;
begin
  LevelMap := TBitmap32.Create;
  try
    LevelMap.Width := StrToInt(txtWidth.Text) * LEVELMAPBLOCKSIZE;
    LevelMap.Height := StrToInt(txtHeight.Text) * LEVELMAPBLOCKSIZE;
    _ROMData.DrawLevelMap(LevelMap, StrToInt(txtHeight.Text),StrToInt(txtWidth.Text),-1);
    imgLevelMap.Bitmap := LevelMap;
  finally
    FreeAndNil(LevelMap);
  end;
end;

procedure TfrmScrollEditor.txtHeightChange(Sender: TObject);
begin
  if Length(TEdit(sender).Text) > 0 then
  begin
    DrawLevelMap;
  end;
end;

procedure TfrmScrollEditor.txtHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(8) then exit;

  if (Key >= '0') and (Key <= '9') then
    exit;

  Key := chr(0);
end;

constructor TfrmScrollEditor.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
