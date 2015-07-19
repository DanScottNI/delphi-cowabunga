unit cLevel;

interface

uses contnrs, offsetlist, sysutils, GR32, types, classes,
  cEnemy, cSpecOBJ, cBoss, cEntrance, iNESImage,cWorldEnemy;

type

  TSideScrLevel = class(TiNESImageAccessor)
  private
    function GetPatternTableBG : Byte;
    procedure SetPatternTableBG(pByte : Byte);
    function GetPatternTableSpr : Byte;
    procedure SetPatternTableSpr(pByte : Byte);
    function GetPaletteSetting : Byte;
    procedure SetPaletteSetting(pByte : Byte);
    function GetLevelWidth : Byte;
    procedure SetLevelWidth(pByte : Byte);
    function GetLevelHeight : Byte;
    procedure SetLevelHeight(pByte : Byte);
    function GetRoomNo(pIndex : Integer) : byte;
    procedure SetRoomNo(pIndex : Integer;pValue : Byte);
    function GetSpriteChange(pIndex : Integer) : byte;
    procedure SetSpriteChange(pIndex : Integer;pValue : Byte);
  public
    Enemies : TSideScrollEnemyList;
    SpecialObjects : TSpecialObjectList;
    Boss : TBossList;
    Exits : TEntranceList;
    // Offsets.
    NumExits : Integer;
    Glitched : Boolean;
    TSAOffset : Integer;
    AttributeOffset : Integer;
    ScrollDataOffset : Integer;
    PatternTableSettingsOffset : Integer;
    PaletteSettingsOffset : Integer;
    SpriteSettingsOffset : Integer;
    EnemyPointersOffset : Integer;
    BossDataOffset : Integer;
    SpecialObjectsOffset : Integer;
    ExitDataOffset : Integer;
    DamStage : Boolean;
    MaxTiles : Byte;
    constructor Create();
    destructor Destroy;override;
    // Methods to manipulate the data.
    property PatternTableBGSetting : Byte read GetPatternTableBG write SetPatternTableBG;
    property PatternTableSprSetting : Byte read GetPatternTableSpr write SetPatternTableSpr;
    property PaletteSetting : Byte read GetPaletteSetting write SetPaletteSetting;
    property Width : Byte read GetLevelWidth write SetLevelWidth;
    property Height : Byte read GetLevelHeight write SetLevelHeight;
    property RoomNumbers [index : Integer] : Byte read GetRoomNo write SetRoomNo;
    property SpriteChange [index : integer] : Byte read GetSpriteChange write SetSpriteChange;
  end;

  TSideScrLevelList = class(TObjectList)
  protected
    function GetSideScrLevelItem(Index: Integer) : TSideScrLevel;
    procedure SetSideScrLevelItem(Index: Integer; const Value: TSideScrLevel);
  public
    function Add(AObject: TSideScrLevel) : Integer;
    property Items[Index: Integer] : TSideScrLevel read GetSideScrLevelItem write SetSideScrLevelItem;default;
    function Last : TSideScrLevel;
  end;

  TLevel = class(TiNESImageAccessor)
  private
    _CurrentSideScrollingStage : Integer;
    _DamStage : Integer;
    _ScrollDataOffset : Integer;
    _WorldMapTiles : TBitmap32;
    _WorldMapScreen : Integer;
    _WorldMapDrawTiles : Array [0..255] Of Boolean;
    _NoWorldMap : Boolean;
    _MaxTiles : Byte;
    function GetLevelWidth : Byte;
    procedure SetLevelWidth(pByte : Byte);
    function GetLevelHeight : Byte;
    procedure SetLevelHeight(pByte : Byte);
    function GetMapScr(pIndex : Integer) : Byte;
    procedure SetMapScr(pIndex : Integer;pID : Byte);
    procedure DrawWorldMapTile(pIndex : Integer);
    procedure DumpPatternTable(pFilename : String);
    procedure SetWorldMapScreen(pInt : Integer);
    procedure SetWorldMapData(pIndex,pIndex1 : Integer;pNewTile : Byte);
    function GetWorldMapData(pIndex,pIndex1 : Integer): Byte;
    function GetEntranceDataOffset : Integer;
  public
    PatternTable : Array [0.. 4095] of Byte;
    Palette : Array [0..3,0..3] of Byte;
    SideScroll : TSideScrLevelList;
    Properties : T1BytePropertyList;
    Entrances : TEntranceList;
    Enemies : TWorldEnemyList;
    procedure ClearWorldMapTiles;
    property EntranceDataOffset : Integer read GetEntranceDataOffset;
    property MaxTiles : Byte read _MaxTiles write _MaxTiles;
    property CurrentStage : Integer read _CurrentSideScrollingStage write _CurrentSideScrollingStage;
    property DamStage : Integer read _DamStage write _DamStage;
    property ScrollDataOffset : Integer read _ScrollDataOffset write _ScrollDataOffset;
    property WorldMapScreens [index : Integer] : Byte read GetMapScr write SetMapScr;
    property MapWidth : Byte read GetLevelWidth write SetLevelWidth;
    property MapHeight : Byte read GetLevelHeight write SetLevelHeight;
    property WorldMapScreen : Integer read _WorldMapScreen write SetWorldMapScreen;
    property NoWorldMap : Boolean read _NoWorldMap write _NoWorldMap;
    procedure DrawTileSelector(pBitmap : TBitmap32;pIndex : Integer);
    procedure DrawWorldMap(pBitmap : TBitmap32;pFilter : Byte; pAssetDirectory : String);
    procedure FreeTilesBitmap;
    procedure LoadBGPalette(pPalettePointers : Pointer);
    procedure LoadWorldMapTiles;
    procedure LoadPatternTable;
    procedure EditTSA(pTileID,pX,pY,pNewTile : Byte);
    procedure IncrementTileAttributes(pTileID,pX,pY : Byte);
    property WorldMapData[pIndex,pIndex1 : Integer] : Byte read GetWorldMapData write SetWorldMapData;
    destructor Destroy;override;
  end;

  TLevelList = class(TObjectList)
  protected
    function GetLevelItem(Index: Integer) : TLevel;
    procedure SetLevelItem(Index: Integer; const Value: TLevel);
  public
    function Add(AObject: TLevel) : Integer;
    property Items[Index: Integer] : TLevel read GetLevelItem write SetLevelItem;default;
    function Last : TLevel;
  end;


implementation

uses uConsts;

{  TSideScrLevel  }
function TSideScrLevel.GetPatternTableBG : Byte;
begin
  result := ROM[self.PatternTableSettingsOffset];
end;

procedure TSideScrLevel.SetPatternTableBG(pByte : Byte);
begin
  ROM[self.PatternTableSettingsOffset] := pByte;
end;

function TSideScrLevel.GetPatternTableSpr : Byte;
begin
  result := ROM[self.PatternTableSettingsOffset + 1];
end;

procedure TSideScrLevel.SetPatternTableSpr(pByte : Byte);
begin
  ROM[self.PatternTableSettingsOffset + 1] := pByte;
end;

function TSideScrLevel.GetPaletteSetting : Byte;
begin
  result := ROM[PaletteSettingsOffset];
end;

procedure TSideScrLevel.SetPaletteSetting(pByte : Byte);
begin
  ROM[PaletteSettingsOffset] := pByte;
end;

function TSideScrLevel.GetLevelWidth : Byte;
begin
  result := ROM[ScrollDataOffset];
end;

procedure TSideScrLevel.SetLevelWidth(pByte : Byte);
begin
  ROM[ScrollDataOffset] := pByte;
end;

function TSideScrLevel.GetLevelHeight : Byte;
begin
  result := ROM[ScrollDataOffset + 1];
end;

procedure TSideScrLevel.SetLevelHeight(pByte : Byte);
begin
  ROM[ScrollDataOffset + 1] := pByte;
end;

function TSideScrLevel.GetRoomNo(pIndex : Integer) : byte;
begin
  result := ROM[ScrollDataOffset + 2 + pIndex];
end;

procedure TSideScrLevel.SetRoomNo(pIndex : Integer;pValue : Byte);
begin
  ROM[ScrollDataOffset + 2 + pIndex] := pValue;
end;

function TSideScrLevel.GetSpriteChange(pIndex : Integer) : byte;
begin
  result := ROM[self.SpriteSettingsOffset + pIndex];
end;

procedure TSideScrLevel.SetSpriteChange(pIndex : Integer;pValue : Byte);
begin
  ROM[self.SpriteSettingsOffset + pIndex] := pValue;
end;

{ TLevel }
destructor TLevel.Destroy;
begin
  FreeAndNil(self.SideScroll);
  FreeAndNil(Properties);
  FreeAndNil(_WorldMapTiles);
  FreeAndNil(Entrances);
  FreeAndNil(Enemies);
  inherited;
end;

procedure TLevel.SetMapScr(pIndex : Integer;pID : Byte);
begin
  ROM[_ScrollDataOffset + 2 + pIndex] := pID;
end;

function TLevel.GetMapScr(pIndex : Integer) : Byte;
begin
  result := ROM[_ScrollDataOffset + 2 + pIndex];
end;

function TLevel.GetLevelWidth : Byte;
begin
  result := ROM[_ScrollDataOffset];
end;

procedure TLevel.SetLevelWidth(pByte : Byte);
begin
  ROM[_ScrollDataOffset] := pByte;
end;

function TLevel.GetLevelHeight : Byte;
begin
  result := ROM[_ScrollDataOffset + 1];
end;

procedure TLevel.SetLevelHeight(pByte : Byte);
begin
  ROM[_ScrollDataOffset + 1] := pByte;
end;

procedure TLevel.DrawWorldMap(pBitmap : TBitmap32;pFilter : Byte; pAssetDirectory : String);
var
  i,x : Integer;
  NumbersBMP,BlankBMP : TBitmap32;
  EnemyID : Byte;
begin
  for i := 0 to 7 do
    for x := 0 to 7 do
    begin
      pBitmap.Draw(bounds(x*32,i*32,32,32),bounds((ROM[ROM.PointerToOffset(Properties['WorldLevelDataPointer'].Offset) + (WorldMapScreens[_WorldMapScreen] * 64) + (i * 8) + x]) * 32,0,32,32),_WorldMapTiles);
    end;
  // Whether or not we display the enemies.
  if (pFilter and uConsts.VIEWENEMIES = uConsts.VIEWENEMIES) and (Assigned(Enemies))
    and (Enemies.Count > 0) then
  begin
    if FileExists(pAssetDirectory + '\numbers.bmp') =  true then
    begin
      NumbersBMP := TBitmap32.Create;
      BlankBMP := TBitmap32.Create;
      try
        NumbersBMP.Width := 136;
        NumbersBMP.Height := 8;
        NumbersBMP.LoadFromFile(pAssetDirectory + '\numbers.bmp');
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(pAssetDirectory + '\blankenemy.bmp');

        // Draw the enemies on screen.
        for i := 0 to Enemies.Count - 1 do
        begin
          if Enemies[i].ScreenID = self._WorldMapScreen then
          begin
//            EnemyID := self.AvailableSpritesBySpr($10,Enemies[i].SpriteID);
            pBitmap.Draw(Enemies[i].X,Enemies[i].Y,BlankBMP);
//            pBitmap.Draw(bounds(Enemies[i].X,Enemies[i].Y,8,8),bounds(StrToInt('$' + IntToHex(EnemyID,2)[1]) * 8,0,8,8),NumbersBMP);
//            pBitmap.Draw(bounds(Enemies[i].X+8,Enemies[i].Y,8,8),bounds(StrToInt('$' + IntToHex(EnemyID,2)[2]) * 8,0,8,8),NumbersBMP);
          end;
        end;
      finally
        FreeAndNil(BlankBMP);
        FreeAndNil(NumbersBMP);
      end;

    end;
    if FileExists(pAssetDirectory + '\numbers.bmp') = True then
    begin

    end;
  end;

  if pFilter and uConsts.VIEWENTRANCEDATA = uConsts.VIEWENTRANCEDATA then
  begin
    if FileExists(pAssetDirectory + '\entrance.bmp') =  true then
    begin
      BlankBMP := TBitmap32.Create;
      try
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(pAssetDirectory + '\entrance.bmp');
        for i := 0 to Entrances.Count -1 do
        begin
          if Entrances[i].SourceScreen = _WorldMapScreen then
          begin
            pBitmap.Draw(Entrances[i].SourceX,Entrances[i].SourceY,BlankBMP);
          end;
        end;
      finally
        FreeAndNil(BlankBMP);
      end;
    end;
  end;

end;

function TLevel.GetWorldMapData(pIndex,pIndex1 : Integer): Byte;
var
  RoomOffset : Integer;
begin

  RoomOffset := ROM.PointerToOffset(Properties['WorldLevelDataPointer'].Offset) + (WorldMapScreens[_WorldMapScreen] * 64);
  result := ROM[RoomOffset + (pIndex1 * 8) + pIndex];
end;

procedure TLevel.SetWorldMapData(pIndex,pIndex1 : Integer;pNewTile : Byte);
var
  RoomOffset : Integer;
begin

  RoomOffset := ROM.PointerToOffset(Properties['WorldLevelDataPointer'].Offset) + (WorldMapScreens[_WorldMapScreen] * 64);
  ROM[RoomOffset + (pIndex1 * 8) + pIndex] := pNewTile;

end;

procedure TLevel.DrawWorldMapTile(pIndex : Integer);
var
  i,x, TSAOffset,AttributeOffset : Integer;
  TilePal : Array [0..1,0..1] Of Byte;
begin

  if Assigned(_WorldMapTiles) = False then
    exit;

  TSAOffset := ROM.PointerToOffset(Properties['WorldTSAPointer'].Offset,$10010);
  AttributeOffset := ROM.PointerToOffset(Properties['WorldAttributePointer'].Offset,$10010);

  TilePal[0,0] := (ROM[AttributeOffset + pIndex]) and 3;
  tilepal[0,1] := (ROM[AttributeOffset + pIndex] shr 2) and 3;
  tilepal[1,0] := (ROM[AttributeOffset + pIndex] shr 4) and 3;
  tilepal[1,1] := (ROM[AttributeOffset + pIndex] shr 6) and 3;

  for i := 0 to 3 do
    for x := 0 to 3 do
      ROM.DrawNESTile(@PatternTable[ROM[TSAOffset + ((pIndex * 16)) + (i *4 + x)]*16] ,_WorldMaptiles,(pIndex * 32) + x * 8,i*8,@Palette[tilepal[i div 2,x div 2],0]);

end;

procedure TLevel.EditTSA(pTileID,pX,pY,pNewTile : Byte);
var
//  TempSolidity : Byte;
  TSAOffset : Integer;
  TileOffset : Integer;
begin

  TSAOffset := ROM.PointerToOffset(Properties['WorldTSAPointer'].Offset,$10010);

  TileOffset :=  TSAOffset + (pTileID * 16) + (pX) + (pY * 4);
//  TempSolidity := ROM[TileOffset] and $C0;
  ROM[TileOffset] := pNewTile;
  DrawWorldMapTile(pTileID);

end;

procedure TLevel.IncrementTileAttributes(pTileID,pX,pY : Byte);
var
  TilePal : Array [0..1,0..1] Of Byte;
  AttributeOffset : Integer;
begin
  AttributeOffset := ROM.PointerToOffset(Properties['WorldAttributePointer'].Offset,$10010);

  TilePal[0,0] := (ROM[AttributeOffset  +pTileID]) and 3;
  tilepal[1,0] := (ROM[AttributeOffset + pTileID] shr 2) and 3;
  tilepal[0,1] := (ROM[AttributeOffset + pTileID] shr 4) and 3;
  tilepal[1,1] := (ROM[AttributeOffset + pTileID] shr 6) and 3;

  if tilepal[pX,pY] = 3 then
    tilepal[pX,pY] := 0
  else
    inc(tilepal[pX,pY]);


  ROM[AttributeOffset + pTileID] := ((TilePal[0,0] and 3)) + ((TilePal[1,0] and 3) shl 2) +
    ((TilePal[0,1] and 3) shl 4) + ((TilePal[1,1] and 3) shl 6);
  DrawWorldMapTile(pTileID);
end;

procedure TLevel.LoadWorldMapTiles;
var
  RoomOffset,i,x, RoomByte : Integer;
begin
  RoomOffset := ROM.PointerToOffset(Properties['WorldLevelDataPointer'].Offset) + (WorldMapScreens[_WorldMapScreen] * 64);

  for i := 0 to 7 do
    for x := 0 to 7 do
    begin
      RoomByte := ROM[RoomOffset + (i * 8) + x];

      if _WorldMapDrawTiles[RoomByte] = False then
      begin

        DrawWorldMapTile(RoomByte);
        _WorldMapDrawTiles[RoomByte] := True;

      end;
    end;
{  for i := 0 to 255 do
  begin
    DrawLevelTile(i);
    _DrawTiles[i] := True;
  end;}
end;

procedure TLevel.ClearWorldMapTiles;
var
  i : Integer;
begin
  for i := 0 to 255 do
    _WorldMapDrawTiles[i] := False;

  if Assigned(_WorldMapTiles) = False then
    _WorldMapTiles := TBitmap32.Create;

  _WorldMapTiles.Width := 256 * 32;
  _WorldMapTiles.Height := 32;
end;

procedure TLevel.FreeTilesBitmap;
begin
  if Assigned(_WorldMapTiles) then
    FreeAndNil(_WorldMapTiles);
end;

procedure TLevel.LoadBGPalette(pPalettePointers : Pointer);
var
  i, x, PaletteOffset : Integer;
  PalettePointers : ^integer;
begin
  PalettePointers := pPalettePointers;
  PaletteOffset := ROM.PointerToOffset(PalettePointers^  + (Properties['WorldPalette'].Value * 2),0,$C000);
  for i := 0 to 3 do
    Palette[i,0] := $0F;

  for i := 0 to 3 do
    for x := 1 to 3 do
      Palette[i,x] := ROM[PaletteOffset + (i*3) + (x -1)];

end;

procedure TLevel.LoadPatternTable;
var
  i, CHRBankOffset : Integer;
begin
  CHRBankOffset := $10 + (ROM.PRGCount * $4000) + (Properties['WorldPatternTable'].Value * $1000);
  for i := 0 to 4095 do
    PatternTable[i] := ROM[CHRBankOffset + i];
end;

procedure TLevel.DumpPatternTable(pFilename : String);
var
  Mem : TMemoryStream;
begin
  Mem := TMemoryStream.Create;
  try
    Mem.Write(PatternTable[0],4096);
    Mem.SaveToFile(pFilename);
  finally
    FreeAndNil(Mem);
  end;
end;

function TLevel.GetEntranceDataOffset : Integer;
begin
  result := 0;
  if Properties['LevelEntranceDataPointer'] <> nil then
  begin
    result := ROM.PointerToOffset( Properties['LevelEntranceDataPointer'].Offset,0,$C000);
  end;

end;

procedure TLevel.SetWorldMapScreen(pInt : Integer);
begin
  _WorldMapScreen := pInt;
  LoadWorldMapTiles;
end;

procedure TLevel.DrawTileSelector(pBitmap : TBitmap32;pIndex : Integer);
var
  i : Integer;
begin
  if Assigned(self._WorldMapTiles) = False then
    exit;
  for i := 0 to 7 do
  begin
    if _WorldMapDrawTiles[i + pIndex] = False then
    begin

      DrawWorldMapTile(pIndex + i);
      _WorldMapDrawTiles[pindex + i] := True;
    end;
    pBitmap.Draw(bounds(0,i * 32,32,32),bounds((pindex+i) * 32,0,32,32),_WorldMapTiles);
  end;
end;

constructor TSideScrLevel.Create;
begin
  NumExits := -1;
end;

destructor TSideScrLevel.Destroy;
begin
  inherited;
  FreeAndNil(Enemies);
  FreeAndNil(SpecialObjects);
  FreeAndNil(Boss);
  FreeAndNil(Exits);  
end;

{ TLevelList }
{$REGION 'TLevelList'}
  function TLevelList.Add(AObject: TLevel): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TLevelList.GetLevelItem(Index: Integer): TLevel;
  begin
    Result := TLevel(inherited Items[Index]);
  end;
  
  procedure TLevelList.SetLevelItem(Index: Integer; const Value: TLevel);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TLevelList.Last : TLevel;
  begin
    result := TLevel(inherited Last);
  end;
{$ENDREGION}

{ TSideScrLevelList }
{$REGION 'TSideScrLevelList'}
  function TSideScrLevelList.Add(AObject: TSideScrLevel): Integer;
  begin
    Result := inherited Add(AObject);
  end;
  
  function TSideScrLevelList.GetSideScrLevelItem(Index: Integer): TSideScrLevel;
  begin
    Result := TSideScrLevel(inherited Items[Index]);
  end;
  
  procedure TSideScrLevelList.SetSideScrLevelItem(Index: Integer; const Value: TSideScrLevel);
  begin
    inherited Items[Index] := Value;
  end;
  
  function TSideScrLevelList.Last : TSideScrLevel;
  begin
    result := TSideScrLevel(inherited Last);
  end;
{$ENDREGION}

end.
