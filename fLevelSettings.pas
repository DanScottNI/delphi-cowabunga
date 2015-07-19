unit fLevelSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32_Image, ComCtrls, GR32, DanHexEdit, cROMData;

type
  TfrmLevelSettings = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
    pgcPatternTableSettings: TPageControl;
    tshBGPatternTable: TTabSheet;
    lblBGPatternTable: TLabel;
    imgBGPatternTable: TImage32;
    scrBGSetting: TScrollBar;
    tshSprPatternTable: TTabSheet;
    lblSprPatternTable: TLabel;
    imgSprPatternTable: TImage32;
    scrSprSetting: TScrollBar;
    rdgInterLeave: TRadioGroup;
    tshGeneral: TTabSheet;
    lblWidth: TLabel;
    txtWidth: TEdit;
    lblHeight: TLabel;
    txtHeight: TEdit;
    lblRoomsUsed: TLabel;
    lstRooms: TListBox;
    tshSpriteChanges: TTabSheet;
    lblSpriteChanges: TLabel;
    imgSpriteChange: TImage32;
    rdgSpriteChange: TRadioGroup;
    lstAvailableEnemies: TListBox;
    txtSpriteChange1: TDanHexEdit;
    txtSpriteChange2: TDanHexEdit;
    txtSpriteChange3: TDanHexEdit;
    txtSpriteChange4: TDanHexEdit;
    procedure FormShow(Sender: TObject);
    procedure scrBGSettingChange(Sender: TObject);
    procedure scrSprSettingChange(Sender: TObject);
    procedure rdgInterLeaveClick(Sender: TObject);
    procedure txtSpriteChange1Enter(Sender: TObject);
    procedure txtSpriteChange1KeyPress(Sender: TObject; var Key: Char);
    procedure txtSpriteChange1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgSpriteChangeClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure lstRoomsDblClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    _CurSpriteChangePatternTable : Byte;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure DrawSprPatternTable;
    procedure DrawBGPatternTable;
    procedure DrawSpriteChangePatternTable;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    { Public declarations }
  end;

var
  frmLevelSettings: TfrmLevelSettings;

implementation

{$R *.dfm}

procedure TfrmLevelSettings.LoadSettings;
var
  i : Integer;
begin
  txtWidth.Text := IntToStr(_ROMData.CurrSideScroll.Width);
  txtHeight.Text := IntToStr(_ROMData.CurrSideScroll.Height);
  txtWidth.Enabled := False;
  txtHeight.Enabled := False;
  lstRooms.Items.BeginUpdate;
  for i := 0 to (_ROMData.CurrSideScroll.Width * _ROMData.CurrSideScroll.Height) -1 do
    lstRooms.Items.Add(IntToHex(_ROMData.CurrSideScroll.RoomNumbers[i],2));

  lstRooms.Items.EndUpdate;

  _CurSpriteChangePatternTable := 0;
  DrawSpriteChangePatternTable;
  scrBGSetting.Max := (_ROMData.CHRCount * 2) - 1;
  scrSprSetting.Max := (_ROMData.CHRCount * 2) - 1;
  scrBGSetting.Position := _ROMData.CurrSideScroll.PatternTableBGSetting;
  DrawBGPatternTable;
  scrSprSetting.Position := _ROMData.CurrSideScroll.PatternTableSprSetting;
  DrawSprPatternTable;

  txtSpriteChange1.Text := IntToHex(_ROMData.CurrSideScroll.SpriteChange[0],2);
  txtSpriteChange2.Text := IntToHex(_ROMData.CurrSideScroll.SpriteChange[1],2);
  txtSpriteChange3.Text := IntToHex(_ROMData.CurrSideScroll.SpriteChange[2],2);
  txtSpriteChange4.Text := IntToHex(_ROMData.CurrSideScroll.SpriteChange[3],2);

  for i := 0 to 5 do
    lstAvailableEnemies.Items.Add(_ROMData.EnemyNames[_ROMData.AvailableEnemies[i]]);

end;

procedure TfrmLevelSettings.SaveSettings;
var
  i : Integer;
begin

  for i := 0 to (_ROMData.CurrSideScroll.Width * _ROMData.CurrSideScroll.Height) -1 do
    _ROMData.CurrSideScroll.RoomNumbers[i] := StrToInt('$' + lstRooms.Items[i]);
  
  _ROMData.CurrSideScroll.PatternTableSprSetting := scrSprSetting.Position;
  _ROMData.CurrSideScroll.SpriteChange[0] := StrToInt('$' + txtSpriteChange1.Text);
  _ROMData.CurrSideScroll.SpriteChange[1] := StrToInt('$' + txtSpriteChange2.Text);
  _ROMData.CurrSideScroll.SpriteChange[2] := StrToInt('$' + txtSpriteChange3.Text);
  _ROMData.CurrSideScroll.SpriteChange[3] := StrToInt('$' + txtSpriteChange4.Text);
end;

procedure TfrmLevelSettings.FormShow(Sender: TObject);
begin
  if _ROMData.CurrSideScroll.DamStage = True then
    tshSpriteChanges.TabVisible := False;
  LoadSettings;
end;

procedure TfrmLevelSettings.scrBGSettingChange(Sender: TObject);
begin
  lblBGPatternTable.Caption := 'BG Pattern Table : (' + IntToHex(scrBGSetting.Position,2) + ')';
  DrawBGPatternTable;
end;

procedure TfrmLevelSettings.scrSprSettingChange(Sender: TObject);
begin
  lblSprPatternTable.Caption := 'Spr Pattern Table : (' + IntToHex(scrSprSetting.Position,2) + ')';
  DrawSprPatternTable;
end;

procedure TfrmLevelSettings.DrawSprPatternTable;
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 128;
    TempBitmap.Height := 128;
    _ROMData.DrawPatternTable(TempBitmap,0,scrSprSetting.Position,rdgInterLeave.ItemIndex);
    imgSprPatternTable.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmLevelSettings.DrawBGPatternTable;
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 128;
    TempBitmap.Height := 128;
    _ROMData.DrawPatternTable(TempBitmap,0,scrBGSetting.Position,0);
    imgBGPatternTable.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmLevelSettings.DrawSpriteChangePatternTable;
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 128;
    TempBitmap.Height := 128;
    _ROMData.DrawPatternTable(TempBitmap,0,_CurSpriteChangePatternTable,rdgSpriteChange.ItemIndex);
    imgSpriteChange.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmLevelSettings.rdgInterLeaveClick(Sender: TObject);
begin
  DrawSprPatternTable;
end;

procedure TfrmLevelSettings.txtSpriteChange1Enter(Sender: TObject);
begin
  if Length(TEdit(Sender).Text) > 0 then
    if StrToInt('$' + TEdit(Sender).Text) > (_ROMData.CHRCount * 2) -1 then
    begin
      _CurSpriteChangePatternTable := (_ROMData.CHRCount * 2) -1
    end
    else
    begin
      _CurSpriteChangePatternTable := StrToInt('$' + TEdit(Sender).Text);
    end
  else
    _CurSpriteChangePatternTable := 0;

  DrawSpriteChangePatternTable;
end;

procedure TfrmLevelSettings.txtSpriteChange1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = Chr(8) then exit;

  if (Key >= '0') and (Key <= '9') then
    exit;

  if (Key >= 'A') and (Key <= 'F') then
    exit;

  if (Key >= 'a') and (Key <= 'f') then
    exit;

  Key := chr(0);
end;

procedure TfrmLevelSettings.txtSpriteChange1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Length(TEdit(Sender).Text) > 0 then
    if StrToInt('$' + TEdit(Sender).Text) > (_ROMData.CHRCount * 2) -1 then
    begin
      _CurSpriteChangePatternTable := (_ROMData.CHRCount * 2) -1
    end
    else
    begin
      _CurSpriteChangePatternTable := StrToInt('$' + TEdit(Sender).Text);
    end
  else
    _CurSpriteChangePatternTable := 0;

  DrawSpriteChangePatternTable;
end;

procedure TfrmLevelSettings.rdgSpriteChangeClick(Sender: TObject);
begin
  DrawSpriteChangePatternTable;
end;

procedure TfrmLevelSettings.cmdOKClick(Sender: TObject);
begin
  SaveSettings;
end;

procedure TfrmLevelSettings.lstRoomsDblClick(Sender: TObject);
var
  NewVal : String;
begin
  NewVal := InputBox('Enter new value','Enter new value',lstRooms.Items[lstRooms.ItemIndex]);
  try
    lstRooms.Items[lstRooms.ItemIndex] := NewVal;
  except
    on EConvertError do
    begin
      showmessage('You need to enter a valid hexadecimal value. Not ' + NewVal + '.');
    end;
  end;
end;

constructor TfrmLevelSettings.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
