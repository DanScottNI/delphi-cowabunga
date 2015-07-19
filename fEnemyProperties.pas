unit fEnemyProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DanHexEdit, cROMData;

type
  TfrmEnemyProperties = class(TForm)
    lblID: TLabel;
    cbEnemyList: TComboBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    lblScreen: TLabel;
    grpUnknownBits: TGroupBox;
    chkUnknownBit1: TCheckBox;
    chkUnknownBit2: TCheckBox;
    chkUnknownBit3: TCheckBox;
    chkUnknownBit5: TCheckBox;
    chkUnknownBit4: TCheckBox;
    cmdScreenSelect: TButton;
    chkFollowEnemy: TCheckBox;
    cbScreen: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdScreenSelectClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    _ID,_Sprites : Integer;
    procedure LoadEnemyData;
    procedure SaveEnemyData;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    property ID : Integer read _ID write _ID;
    property Sprites : Integer read _Sprites write _Sprites;
    { Public declarations }
  end;

var
  frmEnemyProperties: TfrmEnemyProperties;

implementation


{$R *.dfm}

uses flevelmap;

procedure TfrmEnemyProperties.LoadEnemyData;
var
  i, SprCHR : Integer;
begin
  cbScreen.Items.BeginUpdate;
  cbScreen.Items.Clear;
  for i := 0 to (_ROMData.CurrSideScroll.Width * _ROMData.CurrSideScroll.Height) -1 do
  begin
    cbScreen.Items.Add(IntToHex(i,2));
  end;
  cbScreen.Items.EndUpdate;

  SprCHR := _ROMData.CurrSideScroll.PatternTableSprSetting;

  if _Sprites > 0 then
    SprCHR := _ROMData.CurrSideScroll.SpriteChange[_Sprites - 1];

  for i := 0 to 5 do
    cbEnemyList.Items.Add(_ROMData.EnemyNames[_ROMData.AvailableSpritesBySpr(SprCHR,i)]);

  cbEnemyList.ItemIndex := _ROMData.CurrSideScroll.Enemies[_ID].SpriteID;

  cbScreen.ItemIndex := _ROMData.CurrSideScroll.Enemies[_ID].ScreenID;

  chkUnknownBit1.Checked := _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit1;
  chkUnknownBit2.Checked := _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit2;
  chkUnknownBit3.Checked := _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit3;
  chkUnknownBit4.Checked := _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit4;
  chkUnknownBit5.Checked := _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit5;

end;

procedure TfrmEnemyProperties.SaveEnemyData;
begin

  if (chkFollowEnemy.Checked = true) and (_ROMData.CurrSideScroll.Enemies[_ID].ScreenID <> cbScreen.ItemIndex) then
  begin
    _ROMData.Room := cbScreen.ItemIndex;
  end;

  _ROMData.CurrSideScroll.Enemies[_ID].ScreenID := cbScreen.ItemIndex;

  _ROMData.CurrSideScroll.Enemies[_ID].SpriteID := cbEnemyList.ItemIndex;
  _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit1 := chkUnknownBit1.Checked;
  _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit2 := chkUnknownBit2.Checked;
  _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit3 := chkUnknownBit3.Checked;
  _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit4 := chkUnknownBit4.Checked;
  _ROMData.CurrSideScroll.Enemies[_ID].UnknownBit5 := chkUnknownBit5.Checked;

end;

procedure TfrmEnemyProperties.FormShow(Sender: TObject);
begin
  LoadEnemyData;
end;

procedure TfrmEnemyProperties.cmdOKClick(Sender: TObject);
begin
  SaveEnemyData;
end;

procedure TfrmEnemyProperties.cmdScreenSelectClick(Sender: TObject);
var
  LevelMap : TfrmLevelMap;
begin
  LevelMap := TfrmLevelMap.Create(self, _ROMData);
  try
    LevelMap.SelectedScreen := cbScreen.ItemIndex;
    if LevelMap.ShowModal = mrOk then
    begin
      cbScreen.ItemIndex := LevelMap.ClickedScreen;
    end;
  finally
    FreeAndNil(LevelMap);
  end;
end;

constructor TfrmEnemyProperties.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
