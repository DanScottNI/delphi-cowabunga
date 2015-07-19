unit fWorldMapEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32_Image, GR32, ComCtrls, ToolWin, Menus, GR32_Layers,
  ActnList, cROMData, cConfiguration;

type
  TfrmWorldMapEditor = class(TForm)
    imgScreen: TImage32;
    scrLevelV: TScrollBar;
    scrLevel: TScrollBar;
    imgTiles: TImage32;
    scrTiles: TScrollBar;
    ToolBar: TToolBar;
    tlbMapEditingMode: TToolButton;
    MainMenu: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuMapEditingMode: TMenuItem;
    mnuObjectEditingMode: TMenuItem;
    mnuTools: TMenuItem;
    mnuTSAEditor: TMenuItem;
    mnuPaletteEditor: TMenuItem;
    mnuWorldMapSettings: TMenuItem;
    StatusBar: TStatusBar;
    mnuView: TMenuItem;
    mnuViewGridlines: TMenuItem;
    mnuViewEnemies: TMenuItem;
    mnuViewEntrances: TMenuItem;
    tlbObjectEditingMode: TToolButton;
    tlbViewGridlines: TToolButton;
    ActionList: TActionList;
    actWorldMapSettings: TAction;
    actPaletteEditor: TAction;
    actTSAEditor: TAction;
    actViewGridlines: TAction;
    actMapEditingMode: TAction;
    actObjEditingMode: TAction;
    mnuMinimapEditor: TMenuItem;
    actMinimapEditor: TAction;
    tlbTSAEditor: TToolButton;
    tlbPaletteEditor: TToolButton;
    tlbWorldMapSettings: TToolButton;
    tlbMinimapEditor: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure scrLevelChange(Sender: TObject);
    procedure scrTilesChange(Sender: TObject);
    procedure scrTilesScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure imgScreenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgTilesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure mnuViewEnemiesClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    _EditorConfig : TEditorConfig;
    _CurTileLeft, _CurTileMid : Byte;
    _EditingMode : Byte;
    _CurTSABlock : Integer;
    function CalculateRoomNo : Integer;
    procedure DrawWorldMap;
    procedure DrawTileSelector;
    procedure DisplayWorldInfo;
    procedure SetLevelScrMaxWorld;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM;
      EditorConfig: TEditorConfig);
    property CurTileLeft : Byte read _CurTileLeft write _CurTileleft;
    property CurTileMid : Byte read _CurTileMid write _CurTileMid;
    { Public declarations }
  end;

var
  frmWorldMapEditor: TfrmWorldMapEditor;

implementation

{$R *.dfm}

uses uResourcestrings, uConsts;

procedure TfrmWorldMapEditor.FormShow(Sender: TObject);
begin
  _CurTSABlock := -1;
  _ROMData.InitialiseWorldMap;
  DrawWorldMap;
  DrawTileSelector;
  SetLevelScrMaxWorld;
  DisplayWorldInfo;
end;

procedure TfrmWorldMapEditor.DrawWorldMap;
var
  TempBitmap : Tbitmap32;
  i : Integer;
  Filter : Byte;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 256;
    TempBitmap.Height := 256;
    Filter := 0;
    if mnuViewEnemies.Checked = True then
      Filter := Filter + uConsts.VIEWENEMIES;

    if mnuViewEntrances.Checked = True then
      Filter := Filter + uConsts.VIEWENTRANCEDATA;

    _ROMData.CurrLevel.DrawWorldMap(TempBitmap, Filter, ExtractFileDir(Application.ExeName) + '\Data');
    if _EditorConfig.GridlinesWorldMapOn = True then
    begin
      for i := 1 to 7 do
        TempBitmap.Line(i*32,0,i*32,TempBitmap.Height,_EditorConfig.GridlineColour);
      for i := 1 to 7 do
        TempBitmap.Line(0,i*32,TempBitmap.Width,i*32,_EditorConfig.GridlineColour);
    end;
    imgScreen.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;


end;

function TfrmWorldMapEditor.CalculateRoomNo : Integer;
begin
  result := ((scrLevelV.Position) * (scrLevel.Max + 1)) + scrLevel.Position;
end;

procedure TfrmWorldMapEditor.scrLevelChange(Sender: TObject);
begin
  _ROMData.CurrLevel.WorldMapScreen := CalculateRoomNo;
  DrawWorldMap();
  DrawTileSelector;
  //DisplayScreenInfo;
end;

procedure TfrmWorldMapEditor.DrawTileSelector;
var
  TempBitmap : TBitmap32;
  tlFont : TFont;
  i : integer;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 32;
    TempBitmap.Height := 32 * 8;
    _ROMData.CurrLevel.DrawTileSelector(TempBitmap,scrTiles.Position);
    tlFont := TFont.Create;
    tlFont.Name := 'Tahoma';
    tlFont.Size := 7;
    tlFont.Color := wincolor(_EditorConfig.LeftTextColour);
    TempBitmap.Font := tlFont;

    for i := 1 to 7 do
      TempBitmap.Line(0,i*32,32,i*32,clwhite32);

    if (_CurTileLeft >= scrTiles.Position) and (_CurTileLeft <= scrTiles.Position + 7) then
    begin
      if _CurTileLeft = _CurTileMid then
      begin
        TempBitmap.Line(0,(_CurTileLeft - scrTiles.Position)*32,0,(_CurTileLeft-scrTiles.Position)* 32 + 32,_EditorConfig.LeftTextColour);
        TempBitmap.Line(0,(_CurTileLeft - scrTiles.Position)*32,32,(_CurTileLeft-scrTiles.Position)* 32,_EditorConfig.LeftTextColour);
      end
      else
        TempBitmap.FrameRectS(0,(_CurTileLeft - scrTiles.Position)*32,32,(_CurTileLeft-scrTiles.Position)* 32 + 32,_EditorConfig.LeftTextColour);
      if _EditorConfig.DispLeftMidText = true then
        TempBitmap.Textout(1,(_CurTileLeft - scrTiles.Position)*32,RES_LEFT);
    end;
    TempBitmap.Font.Color := wincolor(_EditorConfig.MiddleTextColour);
    if (_CurTileMid >= scrTiles.Position) and (_CurTileMid <= scrTiles.Position + 7) then
    begin
      if _CurTileLeft = _CurTileMid then
      begin
        TempBitmap.Line(31,(_CurTileMid - scrTiles.Position)*32,31,(_CurTileMid-scrTiles.Position)* 32 + 32,_EditorConfig.MiddleTextColour);
        TempBitmap.Line(0,(_CurTileMid - scrTiles.Position)*32+31,32,(_CurTileMid-scrTiles.Position)* 32+31,_EditorConfig.MiddleTextColour);
      end
      else
        TempBitmap.FrameRectS(0,(_CurTileMid - scrTiles.Position)*32,32,(_CurTileMid-scrTiles.Position)* 32 + 32,_EditorConfig.MiddleTextColour);
      if _EditorConfig.DispLeftMidText = true then
        TempBitmap.Textout(1,(_CurTileMid - scrTiles.Position)*32+16,RES_MIDDLE);
    end;

    imgTiles.Bitmap := TempBitmap;
  finally
    FreeAndNil(tlFont);
    FreeAndNil(TempBitmap);
  end;

end;

procedure TfrmWorldMapEditor.scrTilesChange(Sender: TObject);
begin
  DrawTileSelector;
end;

procedure TfrmWorldMapEditor.scrTilesScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  DrawTileSelector;
end;

procedure TfrmWorldMapEditor.imgScreenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  CurTilePos : Integer;
begin
  if _EditingMode = MAPEDITINGMODE then
  begin
    if Button = mbRight then
    begin
      CurTilePos := _ROMData.CurrLevel.WorldMapData[(x div 2) div 32,(y div 2) div 32];
      if ssShift in Shift then
        _CurTileMid := CurTilePos
      else
        _CurTileLeft := CurTilePos;
      if CurTilePos > scrTiles.Max then CurTilePos := scrTiles.Max;
      if (CurTilePos <= scrTiles.Position) or (CurTilePos >= scrTiles.Position + 5) then
        scrTiles.Position := CurTilePos;
      DrawTileSelector();

    end
    else if Button = mbLeft then
    begin
      if ssShift in Shift then
        _ROMData.CurrLevel.WorldMapData[(x div 2) div 32,(y div 2) div 32] := _CurTileMid
      else
        _ROMData.CurrLevel.WorldMapData[(x div 2) div 32,(y div 2) div 32] := _CurTileLeft;
      DrawWorldMap();
    end
    else if Button = mbMiddle then
    begin
      if ssShift in Shift then
        _CurTileMid := _ROMData.CurrLevel.WorldMapData[(x div 2) div 32,(y div 2) div 32]
      else
        _ROMData.CurrLevel.WorldMapData[(x div 2) div 32,(y div 2) div 32] := _CurTileMid;
      DrawWorldMap();
    end;
  end;
end;

procedure TfrmWorldMapEditor.imgTilesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if _CurTSABlock = -1 then
  begin
    if ((Button = mbLeft) and (ssShift in Shift)) or (Button = mbMiddle) then
    begin
      _CurTileMid := scrTiles.Position + ((Y div 2) div 32);
    end
    else if Button = mbLeft then
    begin
      _CurTileLeft := scrTiles.Position + ((Y div 2) div 32);
    end;
  end
  else
  begin
    if Button = mbRight then
    begin
      _ROMData.CurrLevel.IncrementTileAttributes((y div (32*2)) + scrTiles.Position,x div (16*2),(y mod (32 * 2)) div (16*2));
      DrawWorldMap();
    end
    else if Button = mbLeft then
    begin

      _ROMData.CurrLevel.EditTSA((y div (32*2)) + scrTiles.Position,x div 16,(y mod (32*2)) div 16,_CurTSABlock);
//        ROMData.EditTSA((y div (32*2)) + scrTiles.Position,x div (16*2),(y mod (32*2)) div (16*2),_CurTSABlock);
      DrawWorldMap();


    end;

  end;
  DrawTileSelector;
end;

procedure TfrmWorldMapEditor.DisplayWorldInfo;
begin
  StatusBar.Panels[1].Text := RES_LEVELNO + IntToStr(_ROMData.CurrentLevel+1);
end;

procedure TfrmWorldMapEditor.SetLevelScrMaxWorld;
begin
  scrLevelV.Max := _ROMData.CurrLevel.MapHeight -1;
  scrLevel.Max := _ROMData.CurrLevel.MapWidth -1;

  if _ROMData.CurrLevel.MapWidth = 1 then
    scrLevel.Enabled := False
  else
    scrLevel.Enabled := True;

  if _ROMData.CurrLevel.MapHeight = 1 then
    scrLevelV.Enabled := False
  else
    scrLevelV.Enabled := True;
end;

procedure TfrmWorldMapEditor.mnuViewEnemiesClick(Sender: TObject);
begin
  DrawWorldMap;
end;

constructor TfrmWorldMapEditor.Create(AOwner: TComponent;ROMData : TTMNTROM; EditorConfig : TEditorConfig);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
  _EditorConfig := EditorConfig;
end;

end.
