unit fSolidityEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,cSolidity, ComCtrls, DanHexEdit, GR32,
  GR32_Image, GR32_Layers, cConfiguration, cROMData;

type
  TfrmSolidityEditor = class(TForm)
    lvwSolidityData: TListView;
    lblUpToTile: TLabel;
    lblTileType: TLabel;
    txtUpToTile: TDanHexEdit;
    cmdOK: TButton;
    cmdCancel: TButton;
    cmdEdit: TButton;
    cbTileType: TComboBox;
    imgTSA: TImage32;
    chkDrawColours: TCheckBox;
    lblHighlight: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure imgTSAMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure lvwSolidityDataClick(Sender: TObject);
    procedure lvwSolidityDataSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cmdOKClick(Sender: TObject);
    procedure chkDrawColoursClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    _EditorConfig : TEditorConfig;
    procedure PopulateListBox;
    procedure DrawPatternTable();
    procedure DrawLayers;
    procedure PopulateSolidityArr;
    { Private declarations }
  public
    SoliditySettings : TSolidityList;
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM;
      EditorConfig: TEditorConfig);
    { Public declarations }
  end;

var
  frmSolidityEditor: TfrmSolidityEditor;

implementation

uses uConsts;

var
  SolidityArr : Array [0..255] of Byte;

{$R *.dfm}

procedure TfrmSolidityEditor.FormShow(Sender: TObject);
begin
  SoliditySettings := TSolidityList.Create(true);
  DrawPatternTable();
  cbTileType.Items := _ROMData.TileTypes;
  _ROMData.LoadSolidityData(SoliditySettings);
  PopulateListBox;
  PopulateSolidityArr;
end;

procedure TfrmSolidityEditor.PopulateListBox;
var
  i : Integer;
  PreviousTile : Integer;
begin
  PreviousTile := 0;
  lvwSolidityData.Items.BeginUpdate;
  lvwSolidityData.Items.Clear;
  for i := 0 to SoliditySettings.Count -1 do
  begin
    with lvwSolidityData.Items.Add do
    begin
      Caption := IntToHex(PreviousTile,2) + ' to ' + IntToHex(SoliditySettings[i].UpToTile,2);
      SubItems.Add(_ROMData.TileTypes[SoliditySettings[i].TileType]);
      PreviousTile := SoliditySettings[i].UpToTile + 1;
    end;
  end;
  lvwSolidityData.Items.EndUpdate;
end;

procedure TfrmSolidityEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(SoliditySettings);
end;

procedure TfrmSolidityEditor.cmdEditClick(Sender: TObject);
begin
  if lvwSolidityData.ItemIndex = -1 then exit;
  if lvwSolidityData.ItemIndex > SoliditySettings.Count -1 then exit;
  if cbTileType.ItemIndex = -1 then exit;
  SoliditySettings[lvwSolidityData.ItemIndex].UpToTile := StrToInt('$' + txtUpToTile.Text);
  SoliditySettings[lvwSolidityData.ItemIndex].TileType := cbTileType.ItemIndex;
  self.PopulateListBox;
  DrawPatternTable;
end;

procedure TfrmSolidityEditor.DrawPatternTable();
var
  TSA : TBitmap32;
begin
  TSA := TBitmap32.Create;
  try
    TSA.Width := 128;
    TSA.Height := 128;
    _ROMData.DrawTSAPatternTable(TSA,_EditorConfig.LastPaletteTSA, False);
    imgTSA.Bitmap := TSA;
    DrawLayers;
  finally
    FreeAndNil(TSA);
  end;
end;

procedure TfrmSolidityEditor.imgTSAMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
  HighlightTile : Byte;
begin
  HighLightTile := (((y div 16) * 16 * 16) + ((X div 16) * 16)) div 16;

  lblHighlight.Caption := 'Highlighted Tile: $' + IntToHex(HighlightTile,2) + ' ' +
    _ROMData.TileTypes[SolidityArr[HighlightTile]];
end;

procedure TfrmSolidityEditor.lvwSolidityDataClick(Sender: TObject);
begin
  if lvwSolidityData.ItemIndex = -1 then exit;
  if lvwSolidityData.ItemIndex > SoliditySettings.Count -1 then exit;
  txtUpToTile.Text := IntToHex(SoliditySettings[lvwSolidityData.ItemIndex].UpToTile,2);
  cbTileType.ItemIndex := SoliditySettings[lvwSolidityData.ItemIndex].TileType;
end;

procedure TfrmSolidityEditor.lvwSolidityDataSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if lvwSolidityData.ItemIndex = -1 then exit;
  if lvwSolidityData.ItemIndex > SoliditySettings.Count -1 then exit;
  txtUpToTile.Text := IntToHex(SoliditySettings[lvwSolidityData.ItemIndex].UpToTile,2);
  cbTileType.ItemIndex := SoliditySettings[lvwSolidityData.ItemIndex].TileType;
end;

procedure TfrmSolidityEditor.cmdOKClick(Sender: TObject);
begin
  if SoliditySettings.Last.UpToTile <> $FF then
  begin
    showmessage('The last solidity setting must be up to $FF.');
    modalresult := mrNone;
  end;
  _ROMData.SaveSolidityData(SoliditySettings);
end;

procedure TfrmSolidityEditor.PopulateSolidityArr;
var
  i,x, start : Integer;
begin
  start := 0;
  for i := 0 to SoliditySettings.Count -1 do
  begin
    for x := start to SoliditySettings[i].UpToTile do
    begin
      SolidityArr[x] := SoliditySettings[i].TileType;
    end;
    start := SoliditySettings[i].UpToTile +1;
  end;
end;

procedure TfrmSolidityEditor.DrawLayers;
var
  i : Integer;
  Temp : TBitmap32;

begin
  if chkDrawColours.Checked = True then
  begin
    imgTSA.BeginUpdate;
    for i := 0 to 255 do
      begin
      Temp := TBitmap32.Create;
      Temp.Height := 8;
      Temp.Width := 8;
      Temp.FillRect(0,0,Temp.Width,Temp.Height,_EditorConfig.SolidityColours[SolidityArr[i]]);
      Temp.MasterAlpha := 100;
      Temp.DrawMode := dmBlend;
      imgTSA.Bitmap.DrawMode := dmBlend;
      imgTSA.Bitmap.Draw((i mod 16) * 8,(i div 16) * 8,Temp);

      FreeAndNil(Temp);
    end;

    imgTSA.EndUpdate;
    imgTSA.Changed;
  end;

end;

procedure TfrmSolidityEditor.chkDrawColoursClick(Sender: TObject);
begin
  DrawPatternTable;
end;

constructor TfrmSolidityEditor.Create(AOwner: TComponent;ROMData : TTMNTROM; EditorConfig : TEditorConfig);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
  _EditorConfig := EditorConfig;
end;

end.
