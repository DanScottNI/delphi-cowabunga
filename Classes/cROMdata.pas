unit cROMdata;

interface

uses gr32,ImgList,GR32_Image, dialogs, classes,cSpecobj,bytelist,
    offsetlist, cLevel, cEnemy, cSolidity,uConsts, windows,
    cBoss, cEntrance, iNESImage, pasCRC32;

type
  TWidthHeight = record
    Width : Integer;
    Height : Integer;
  end;

  T8x8Graphic = record
    Pixels : Array [0..15, 0..15] of Byte;
  end;

  TTMNTROM = class(TiNESImageAccessor)
  private
    _AssetDirectory : String;
    _Tiles : TBitmap32;
    _PatternTable : Array [0.. 4095] of Byte;
    _Palette : Array [0..3,0..3] of Byte;
    _CurrentLevelIndex : Integer;
    _CurrentSideScrollIndex : Integer;
    _TileDrawn : Array [0..255] Of Boolean;
    _PalettePointers : Integer;
    _Room : Integer;
    _SolidityStart : Integer;
    _EnemiesUsedPointers : Integer;
    _EnemyStartOffset : Integer;
    _EnemyEndOffset : Integer;
    _EnemyTotalAmount : Integer;
    _ExitDataCRC32 : LongWord;
    _ExitDataPatchFilename : String;
    // functions
    function GetChanged(): Boolean;
    function GetPalette(pIndex1,pIndex2 : Integer) : Byte;
    function GetROMFilename(): String;
    function GetAvailableEnemies(pIndex : Integer) : Byte;
    function GetRoomData(pIndex,pIndex1 : Integer): Byte;
    // procedures
    procedure DrawLevelTile(pIndex : Integer);
    procedure LoadColonSeparatedFile(pStringList : TStringList;pFilename : String);overload;
    procedure LoadColonSeparatedFile(pStringList : TStringList;pFilename : String;pMaxNumber : Integer);overload;
    procedure LoadDataFile();
    procedure LoadRoomTiles(pRoom : Integer);
    procedure LoadEnemyData;
    procedure SaveEnemyData;
    procedure LoadWorldMapEnemyData;
    procedure SaveWorldMapEnemyData;
    procedure LoadSpecialObjects;
    procedure SaveSpecialObjects;
    procedure SaveExitData;
    procedure LoadExitData;
    procedure SaveBossData;
    procedure LoadBossData;
    procedure LoadEntranceData;
    procedure SaveEntranceData;
    procedure SetChanged(pChanged: Boolean);
    procedure SetLevel(pLevel : Integer);
    procedure SetSideScroll(pSideScroll : Integer);
    procedure SetRoomData(pIndex,pIndex1 : Integer; pData : Byte);
    procedure SetPalette(pIndex1,pIndex2 : Integer;pNewTile : Byte);
    procedure SetRoom(pValue : Integer);
    procedure LoadSideScrollStageData(pLevel : Integer);
    procedure LoadEnemyNames;
    procedure LoadSpecialObjectNames;
    procedure LoadTileTypes;
    procedure CalculateExitDataSize;
    procedure PrepareROM();
  public
    // Used for the entrance data.
    EntrancesStartOffset : Integer;
    EntrancesEndOffset : Integer;
    EntrancesTotalAmount : Integer;
    // Used for exit data.
    ExitFreeSpaceStart : Integer;
    ExitFreeSpaceEnd : Integer;
    ExitSpaceStart : Integer;
    ExitSpaceEnd : Integer;
    DataFile : String;
    HighestTile : Byte;
    CurrLevel : TLevel;
    CurrSideScroll : TSideScrLevel;
    Levels : TLevelList;
    EnemyNames : TStringList;
    SpecialObjectNames : TStringList;
    TileTypes : TStringList;
    // constructor(s)
    constructor Create(pFilename, pDataFile, pAssetDirectory : String);
    // destructor
    destructor Destroy;override;
    // functions
    function Export8x8Pat(pID: Integer) : T8x8Graphic;
    function CalculateTotalEnemies : Integer;
    function GetEnemyUnderMouse(pX,pY : Integer) : Integer;
    function GetSpecialObjUnderMouse(pX,pY : Integer) : Integer;
    function GetBossUnderMouse(pX,pY : Integer) : Integer;
    function GetEntranceUnderMouse(pX,pY : Integer) : Integer;
    function DetectObjectUnderMouse(pX,pY : Integer) : TObjDetect;
    function IsValidROM(): Boolean;
    function GetColor32NESPal(pElement: Integer): TColor32;
    function Save: Boolean;
    function SaveAs(pFilename : String): Boolean;
    function CHRCount : Byte;
    function PRGCount : Byte;
    function MemoryMapper : Byte;
    function MemoryMapperStr : String;
    function FileSize : Integer;
    function AvailableSpritesBySpr(pSpr : Byte;pID : Byte):Byte;
    function AddEnemy: Boolean;
    function CalculateSpecialObjectAmount : Integer;
    function BossPresent : Boolean;
    function GetHighestScreenNumber(pWorld : Byte) : Byte;
    function CalculateCRCArea(pStartOffset, pEndOffset: Integer): LongWord;
    // procedures
    procedure DrawScreen(pBitmap : TBitmap32;pRoomIndex : Byte; pX, pY : Integer;pFilter : Byte;pBitmap32List : TBitmap32List;pEnemyView : Byte);
    procedure DrawTileSelector(pBitmap : TBitmap32;pIndex : Integer);
    procedure DrawTSAPatternTable(pBitmap : TBitmap32; pPal : Byte; pWorldMap : Boolean);
    procedure DumpPatternTable(pFilename : String);
    procedure EditTSA(pTileID,pX,pY,pNewTile : Byte);
    procedure Import8x8Pat(pID: Integer; p8x8: T8x8Graphic);
    procedure IncrementTileAttributes(pTileID,pX,pY : Byte);
    procedure LoadBGPalette();overload;
    procedure LoadBGPalette(pPaletteIndex : Byte);overload;
    procedure LoadDefaultPalette;
    procedure LoadPaletteFile(pPaletteFile : String);
    procedure LoadPatternTable();
    procedure LoadScrollData;
    procedure RefreshOnScreenTiles(pTileSelectorValue : Byte);
    procedure SaveBGPalette();overload;
    procedure SavePatternTable();
    procedure RestoreDefaultiNESHeader;
    procedure DrawPatternTable(pBitmap : TBitmap32; pPal : Byte;pIndex : Byte;pInterLeave : Byte);
    procedure DrawLevelMap(pBitmap : TBitmap32;pHighlightedScreen : Integer);overload;
    procedure DrawLevelMap(pBitmap : TBitmap32;pHeight,pWidth : Integer;pHighlightedScreen : Integer);overload;
    procedure DeleteEnemy(pID : Integer);
    procedure IncrementSpecialObjID(pID : Integer);
    procedure InitialiseWorldMap();
    procedure SaveBGPalette(pPaletteIndex : Byte);overload;
    procedure SaveScrollData;
    procedure LoadSolidityData(pSolidityList : TSolidityList);
    procedure SaveSolidityData(pSolidityList : TSolidityList);
    // properties
    property Changed : Boolean read GetChanged write SetChanged;
    property CurrentLevel : Integer read _CurrentLevelIndex write SetLevel;
    property CurrentSideScroll : Integer read _CurrentSideScrollIndex write SetSideScroll;
    property Filename : String read GetROMFilename;
    property NESPal [index1 : Integer] : TColor32 read GetColor32NESPal;
    property Palette[index1,index2 : Integer] : Byte read GetPalette write SetPalette;
    property RoomData[index1 : integer;index2 : Integer] : Byte read GetRoomData write SetRoomData;
    property Room : Integer read _Room write SetRoom;
    property AvailableEnemies [index : Integer] : Byte read GetAvailableEnemies;
  end;

implementation

uses sysutils,MemINIHexFile, cWorldEnemy, PatchIPS;

{ TROMData }

constructor TTMNTROM.Create(pFilename, pDataFile, pAssetDirectory : String);
begin
  ROM := TiNESImage.Create(pFilename);
  _AssetDirectory := pAssetDirectory;
  DataFile := pDataFile;
  LoadDataFile();

  // After we have loaded the data file, we need to check the
  // exit data, and see if it has been patched.
  PrepareROM();

  _CurrentLevelIndex := -1;
  LoadEnemyNames;
  LoadSpecialObjectNames;
  LoadTileTypes;
  LoadEnemyData;
  LoadWorldMapEnemyData;
  LoadSpecialObjects;
  LoadEntranceData;
  LoadExitData;
  LoadScrollData;
  LoadBossData;
end;

/// <summary>Prepares the ROM for editing.
/// </summary>
procedure TTMNTROM.PrepareROM();
var
  ExitCRC32 : LongWord;
begin
  // First, we need to check the CRC32 on the exit data.
  // If it matches the CRC32 that the datafile has stored,
  // then we need to run whatever patch file is specified for this
  // type of ROM.
  ExitCRC32 := CalculateCRCArea(self.ExitSpaceStart, self.ExitSpaceEnd);
  if ExitCRC32 = self._ExitDataCRC32 then
  begin
    // The CRC32's match, and we should patch the ROM with the IPS patch
    // specified in the datafile, so that it fixes the problems with the exit data.
    ROM.ApplyIPSPatch(_AssetDirectory + '\' + _ExitDataPatchFilename);
  end;
end;

procedure TTMNTROM.LoadTileTypes;
var
  i : Integer;
begin
  TileTypes := TStringList.Create;
  if FileExists(_AssetDirectory + '\tiletypes.dat') then
  begin
    LoadColonSeparatedFile(TileTypes,_AssetDirectory + '\tiletypes.dat', $0F);
  end
  else
  begin
    for i := 0 to $0F do
    begin
      TileTypes.Add('$' + IntToHex(i,2) + ' - ' +  UNKNOWNENEMY)
    end;
  end;
end;

procedure TTMNTROM.LoadEnemyNames;
var
  i : Integer;
begin
  EnemyNames := TStringList.Create;
  if FileExists(_AssetDirectory + '\enemy.dat') then
  begin
    LoadColonSeparatedFile(EnemyNames,_AssetDirectory + '\enemy.dat');
  end
  else
  begin
    for i := 0 to 255 do
    begin
      EnemyNames.Add('$' + IntToHex(i,2) + ' - ' +  UNKNOWNENEMY)
    end;
  end;

end;

procedure TTMNTROM.LoadSpecialObjectNames;
var
  i : Integer;
begin
  SpecialObjectNames := TStringList.Create;
  if FileExists(_AssetDirectory + '\specobj.dat') then
  begin
    LoadColonSeparatedFile(SpecialObjectNames,_AssetDirectory + '\specobj.dat');
  end
  else
  begin
    for i := 0 to 255 do
    begin
      EnemyNames.Add('$' + IntToHex(i,2) + ' - ' +  UNKNOWNENEMY)
    end;
  end;

end;

procedure TTMNTROM.LoadColonSeparatedFile(pStringList : TStringList;pFilename : String);
begin
  LoadColonSeparatedFile(pStringList,pFilename,255);
end;

procedure TTMNTROM.LoadColonSeparatedFile(pStringList : TStringList;pFilename : String;pMaxNumber : Integer);
var
  ColonFile : TStringList;
  Index : String;
  i, count : Integer;
begin

  for i := 0 to pMaxNumber do
    pStringList.Add('$' + IntToHex(i,2) + ' - ' +  UNKNOWNENEMY);

  // Now load in the enemy names from the file 'enemy.dat' in the data directory.
  if FileExists(pFilename) = True then
  begin
    ColonFile := TStringList.Create;
    ColonFile.LoadFromFile(pFilename);

    for i := 0 to ColonFile.Count - 1 do
    begin
      if copy(ColonFile[i],1,2) <> '//' then
      begin
        count := 1;
        Index := '';
        while ((ColonFile[i][count] <> ':') or (count = length(ColonFile[i]))) do
        begin
          Index := Index + ColonFile[i][count];
          inc(Count);
        end;
        inc(Count);
        pStringList[StrToInt('$' + Index)] := '$' + Index + ' - ' + copy(ColonFile[i],Count,Length(ColonFile[i]) - count +1);
      end;

    end;

  end;
  FreeAndNil(ColonFile);

end;

destructor TTMNTROM.Destroy;
begin
  FreeAndNil(ROM);
  FreeAndNil(_Tiles);
  FreeAndNil(Levels);
  FreeAndNil(EnemyNames);

  FreeAndNil(SpecialObjectNames);
  FreeAndNil(TileTypes);

  inherited;
end;

procedure TTMNTROM.LoadDataFile();
var
  INI : TMemINIHexFile;
  TempLevel : TLevel;
  i,x : Integer;
begin
  INI := TMemINIHexFile.Create(self.DataFile);
  try
    _SolidityStart := INI.ReadHexValue('General','SolidityPointers');

    _PalettePointers := INI.ReadHexValue('General','PalettePointers');

    _EnemiesUsedPointers := INI.ReadHexValue('General','EnemiesUsedSprite');
    _EnemyStartOffset := INI.ReadHexValue('EnemyData','StartEnemyData');
    _EnemyEndOffset := INI.ReadHexValue('EnemyData','EndEnemyData');
    _EnemyTotalAmount := INI.ReadInteger('EnemyData','TotalEnemies');

    EntrancesStartOffset := INI.ReadHexValue('Entrances','StartEntrances');
    EntrancesEndOffset := INI.ReadHexValue('Entrances','EndEntrances');

    // Exit related information.
    ExitFreeSpaceStart := INI.ReadHexValue('Exits','ExitFreeSpaceStart');
    ExitFreeSpaceEnd := INI.ReadHexValue('Exits','ExitFreeSpaceEnd');
    ExitSpaceStart := INI.ReadHexValue('Exits','ExitSpaceStart');
    ExitSpaceEnd := INI.ReadHexValue('Exits','ExitSpaceEnd');

    // Exit patching related information.
    _ExitDataCRC32 := INI.ReadHexValue('Exits','StandardExitDataCRC');
    _ExitDataPatchFilename := INI.ReadString('Exits','ExitDataPatch');

    Levels := TLevelList.Create(true);
    self.Levels.Capacity := INI.ReadInteger('General','Levels',0);
    for i := 0 to self.Levels.Capacity -1 do
    begin
      Levels.Add(TLevel.Create);
      TempLevel := Levels.Last;
      TempLevel.SideScroll := TSideScrLevelList.Create(true);
      TempLevel.SideScroll.Capacity := INI.ReadInteger('Level' + IntToStr(i),'NumOfStages');
      if INI.ValueExists('Level' + IntToStr(i),'DamStage') then
        TempLevel.DamStage := INI.ReadInteger('Level' + IntToStr(i),'DamStage')
      else
        TempLevel.DamStage := -1;
      TempLevel.Properties := T1BytePropertyList.Create(true);
      // The properties for the world map.
      TempLevel.NoWorldMap := INI.ReadBool('Level'+IntToStr(i),'NoWorldMap',False);
      if  TempLevel.NoWorldMap = False then
      begin
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldLevelDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'WorldLevelDataPointer')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldTSAPointer',INI.ReadHexValue('Level' + IntToStr(i),'WorldTSAPointer')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldAttributePointer',INI.ReadHexValue('Level' + IntToStr(i),'WorldAttributePointer')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldScrollDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'WorldScrollDataPointer')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldEntrancePointer',INI.ReadHexValue('Level' + IntToStr(i),'WorldEntrancePointer')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldPalette',INI.ReadHexValue('Level' + IntToStr(i),'WorldPalette')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldPatternTable',INI.ReadHexValue('Level' + IntToStr(i),'WorldPatternTable')));
        TempLevel.Properties.Add(T1ByteProperty.Create('WorldEnemyData',INI.ReadHexValue('Level' + IntToStr(i),'WorldEnemyPointer')));

        TempLevel.ScrollDataOffset := ROM.PointerToOffset(TempLevel.Properties['WorldScrollDataPointer'].Offset,$0,$C000);
      end;
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelDataPointer')));
      if INI.ValueExists('Level' + IntToStr(i),'LevelTSAPointer') then
        TempLevel.Properties.Add(T1ByteProperty.Create('LevelTSAPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelTSAPointer')))
      else if INI.ValueExists('Level' + IntToStr(i),'Level5TSAStart') then
        TempLevel.Properties.Add(T1ByteProperty.Create('Level5TSAStart',INI.ReadHexValue('Level' + IntToStr(i),'Level5TSAStart')));

      if INI.ValueExists('Level' + IntToStr(i),'LevelAttributePointer') then
        TempLevel.Properties.Add(T1ByteProperty.Create('LevelAttributePointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelAttributePointer')))
      else if INI.ValueExists('Level' + IntToStr(i),'Level5AttributeStart') then
        TempLevel.Properties.Add(T1ByteProperty.Create('Level5AttributeStart',INI.ReadHexValue('Level' + IntToStr(i),'Level5AttributeStart')));

      TempLevel.Properties.Add(T1ByteProperty.Create('LevelScrollDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelScrollDataPointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelEnemyDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelEnemyDataPointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelSpecialObjPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelSpecialObjPointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelPalettePointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelPalettePointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelPatTablePointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelPatTablePointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelBossDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelBossDataPointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelExitDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelExitDataPointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelEntranceDataPointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelEntranceDataPointer')));
      TempLevel.Properties.Add(T1ByteProperty.Create('LevelSpriteChangePointer',INI.ReadHexValue('Level' + IntToStr(i),'LevelSpriteChangePointer')));
      TempLevel.MaxTiles := INI.ReadHexValue('Level'+IntToStr(i),'MaxTiles');
      LoadSideScrollStageData(i);

      for x := 0 to TempLevel.SideScroll.Capacity -1 do
      begin
        TempLevel.SideScroll[x].TSAOffset := INI.ReadHexValue('Level' + IntToStr(i),'Stage' + intToStr(x) + 'TSA');
        TempLevel.SideScroll[x].AttributeOffset := INI.ReadHexValue('Level' + IntToStr(i),'Stage' + intToStr(x) + 'Attribute');
        TempLevel.SideScroll[x].Glitched := INi.ReadBool('Level' + IntToStr(i),'Stage' + intToStr(x) + 'Glitched',False);
        TempLevel.SideScroll[x].MaxTiles := INI.ReadHexValue('Level' + IntToStr(i),'Stage' + intToStr(x) + 'MaxTiles');
        if INI.ValueExists('Level' + IntToStr(i),'Stage' + IntToStr(x) + 'NumExits') then
          TempLevel.SideScroll[x].NumExits := INI.ReadHexValue('Level' + IntToStr(i),'Stage' + intToStr(x) + 'NumExits');
      end;
    end;
  finally
    FreeAndNil(INI);
  end;

end;

procedure TTMNTROM.LoadSideScrollStageData(pLevel : Integer);
var
  TempSideScr : TSideScrLevel;
  x : Integer;
begin
  for x := 0 to Levels[pLevel].SideScroll.Capacity -1 do
  begin
    Levels[pLevel].SideScroll.Add(TSideScrLevel.Create);
    TempSideScr := Levels[pLevel].SideScroll.Last;
    if x = Levels[pLevel].DamStage then
      TempSideScr.DamStage := True;
    TempSideScr.PatternTableSettingsOffset := ROM.PointerToOffset(Levels[pLevel].Properties['LevelPatTablePointer'].Offset,$0,$C000) + (x * 2);
    TempSideScr.ScrollDataOffset := ROM.PointerToOffset(ROM.PointerToOffset(Levels[pLevel].Properties['LevelScrollDataPointer'].Offset,$0,$C000) + (x*2),$0,$C000);
    TempSideScr.PaletteSettingsOffset := ROM.PointerToOffset(Levels[pLevel].Properties['LevelPalettePointer'].Offset,$0,$C000) + x;
    TempSideScr.SpriteSettingsOffset := ROM.PointerToOffset(ROM.PointerToOffset(Levels[pLevel].Properties['LevelSpriteChangePointer'].Offset) + (x*2));
    TempSideScr.EnemyPointersOffset := ROM.PointerToOffset(Levels[pLevel].Properties['LevelEnemyDataPointer'].Offset) + (x*2);
    TempSideScr.SpecialObjectsOffset := ROM.PointerToOffset(Levels[pLevel].Properties['LevelSpecialObjPointer'].Offset) + (x*2);
    TempSideScr.BossDataOffset := ROM.PointerToOffset(Levels[pLevel].Properties['LevelBossDataPointer'].Offset) + (x*2);
    TempSideScr.ExitDataOffset := ROM.PointerToOffset( Levels[pLevel].Properties['LevelExitDataPointer'].Offset, 0, $C000) + (x*2);

  end;
end;

procedure TTMNTROM.SetRoom(pValue : Integer);
begin
  _Room := pValue;
//  LoadRoomTiles(_Room);
end;

function TTMNTROM.Save(): Boolean;
begin
  SaveEnemyData;
  SaveWorldMapEnemyData;
  SaveBossData;
  SaveEntranceData;
  SaveExitData;
  SaveScrollData;
  SaveSpecialObjects;
  result := ROM.Save;

end;

function TTMNTROM.SaveAs(pFilename : String) : Boolean;
begin
  result := ROM.SaveAs(pFilename);
end;

procedure TTMNTROM.LoadPatternTable();
var
  i, CHRBankOffset : Integer;
begin
  CHRBankOffset := $10 + (ROM.PRGCount * $4000) + (CurrSideScroll.PatternTableBGSetting * $1000);
  for i := 0 to 4095 do
  begin
    _PatternTable[i] := ROM[CHRBankOffset + i];
  end;

end;

procedure TTMNTROM.SavePatternTable();
var
  i, CHRBankOffset : Integer;
begin
  CHRBankOffset := $10 + (ROM.PRGCount * $4000) + (CurrSideScroll.PatternTableBGSetting * $1000);

  for i := 0 to 4095 do
    ROM[CHRBankOffset + i] := _PatternTable[i];

end;

procedure TTMNTROM.DumpPatternTable(pFilename : String);
var
  Mem : TMemoryStream;
begin
  Mem := TMemoryStream.Create;
  try
    Mem.Write(_PatternTable[0],4096);
    Mem.SaveToFile(pFilename);
  finally
    FreeAndNil(Mem);
  end;
end;

procedure TTMNTROM.LoadBGPalette();
begin
  LoadBGPalette(CurrSideScroll.PaletteSetting);
end;

procedure TTMNTROM.LoadBGPalette(pPaletteIndex : Byte);
var
  i, x, PaletteOffset : Integer;
begin
  PaletteOffset := ROM.PointerToOffset(  _PalettePointers  + (pPaletteIndex * 2),0,$C000);
  for i := 0 to 3 do
    _Palette[i,0] := $0F;

  for i := 0 to 3 do
    for x := 1 to 3 do
      _Palette[i,x] := ROM[PaletteOffset + (i*3) + (x -1)];

end;

procedure TTMNTROM.SaveBGPalette();
begin
  SaveBGPalette(CurrSideScroll.PaletteSetting);
end;

procedure TTMNTROM.SaveBGPalette(pPaletteIndex : Byte);
var
  i, x, PaletteOffset : Integer;
begin
  PaletteOffset := ROM.PointerToOffset(  _PalettePointers  + (pPaletteIndex * 2),0,$C000);

  for i := 0 to 3 do
    for x := 1 to 3 do
      ROM[PaletteOffset + (i*3) + (x -1)] := _Palette[i,x];

end;

procedure TTMNTROM.SetLevel(pLevel : Integer);
var
  i : Integer;
begin
  if self._CurrentLevelIndex > -1 then
  begin
//    SaveEnemyData;
  end;

  self._CurrentLevelIndex := pLevel;
  if Assigned(CurrLevel) then
    CurrLevel.FreeTilesBitmap;
  CurrLevel := Levels[_CurrentLevelIndex];

  _Room := 0;
  HighestTile := 0;

  // Reinitialise DrawTiles
  for i := 0 to 255 do
    _TileDrawn[i] := False;

  if Assigned(_Tiles) = False then
    _Tiles := TBitmap32.Create;

  _Tiles.Width := 256 * 32;
  _Tiles.Height := 32;

  _CurrentSideScrollIndex := -1;
  CurrentSideScroll := 0;
end;

procedure TTMNTROM.SetSideScroll(pSideScroll : Integer);
var
  i : Integer;
begin

  _Room := 0;

  if _CurrentSideScrollIndex > -1 then
  begin

    if CurrLevel.SideScroll[_CurrentSideScrollIndex].PatternTableBGSetting <> CurrLevel.SideScroll[pSideScroll].PatternTableBGSetting then
    begin
      // Reinitialise DrawTiles
      for i := 0 to 255 do
        _TileDrawn[i] := False;
    end
    else if CurrLevel.SideScroll[_CurrentSideScrollIndex].PaletteSetting <> CurrLevel.SideScroll[pSideScroll].PaletteSetting then
    begin
      // Reinitialise DrawTiles
      for i := 0 to 255 do
        _TileDrawn[i] := False;
    end;
  end;

  _CurrentSideScrollIndex := pSideScroll;

  CurrSideScroll := CurrLevel.SideScroll[_CurrentSideScrollIndex];
  LoadPatternTable();
  LoadBGPalette();

  for i := 0 to (CurrSideScroll.Height * CurrSideScroll.Width) - 1 do
  begin
    LoadRoomTiles(i);
  end;
end;

// This function iterates through the current screen's level data
// and fills in the tiles that haven't yet been drawn onto to the
// tiles bitmap.
procedure TTMNTROM.LoadRoomTiles(pRoom : Integer);
var
  RoomOffset,i,x, RoomByte : Integer;
begin
  RoomOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelDataPointer'].Offset) + (CurrSideScroll.RoomNumbers[pRoom] * 48);

  for i := 0 to 5 do
    for x := 0 to 7 do
    begin
      RoomByte := ROM[RoomOffset + (i * 8) + x];
      if HighestTile < RoomByte then
        HighestTile := RoomByte;

      if _TileDrawn[RoomByte] = False then
      begin

        DrawLevelTile(RoomByte);
        _TileDrawn[RoomByte] := True;

      end;
    end;

{  for i := 0 to 255 do
  begin
    DrawLevelTile(i);
    _DrawTiles[i] := True;
  end;}
end;

procedure TTMNTROM.DrawLevelTile(pIndex : Integer);
var
  i,x, TSAOffset,AttributeOffset : Integer;
  TilePal : Array [0..1,0..1] Of Byte;
begin
  if Assigned(_Tiles) = False then
    exit;

  TSAOffset := 0;
  AttributeOffset := 0;

  if CurrSideScroll.TSAOffset > 0 then
    TSAOffset := ROM.PointerToOffset(CurrSideScroll.TSAOffset,$C010)
  else if CurrLevel.Properties['LevelTSAPointer'] <> nil then
    TSAOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelTSAPointer'].Offset,$C010)
  else if CurrLevel.Properties['Level5TSAStart'] <> nil then
    TSAOffset := ROM.PointerToOffset(CurrLevel.Properties['Level5TSAStart'].Offset + (self._CurrentSideScrollIndex * 2),$C010);

  if CurrSideScroll.AttributeOffset > 0 then
    AttributeOffset := ROM.PointerToOffset(CurrSideScroll.AttributeOffset,$C010)
  else if CurrLevel.Properties['LevelAttributePointer'] <> nil then
    AttributeOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelAttributePointer'].Offset,$C010)
  else if CurrLevel.Properties['Level5AttributeStart'] <> nil then
    AttributeOffset := ROM.PointerToOffset(CurrLevel.Properties['Level5AttributeStart'].Offset + (self._CurrentSideScrollIndex * 2),$C010);


  TilePal[0,0] := (ROM[AttributeOffset + pIndex]) and 3;
  tilepal[0,1] := (ROM[AttributeOffset + pIndex] shr 2) and 3;
  tilepal[1,0] := (ROM[AttributeOffset + pIndex] shr 4) and 3;
  tilepal[1,1] := (ROM[AttributeOffset + pIndex] shr 6) and 3;
  for i := 0 to 3 do
    for x := 0 to 3 do
      ROM.DrawNESTile(@_PatternTable[ROM[TSAOffset + ((pIndex * 16)) + (i *4 + x)]*16] ,_tiles,(pIndex * 32) + x * 8,i*8,@_Palette[tilepal[i div 2,x div 2],0]);
end;

procedure TTMNTROM.DrawScreen(pBitmap : TBitmap32; pRoomIndex : Byte; pX, pY : Integer;pFilter : Byte;pBitmap32List : TBitmap32List;pEnemyView : Byte);
var
  i,x, EnemyID,Spr : Integer;
  NumbersBMP, BlankBMP : TBitmap32;
begin
  for i := 0 to 5 do
    for x := 0 to 7 do
    begin
      pBitmap.Draw(bounds(pX +  (x*32),pY + (i*32),32,32),bounds((ROM[ROM.PointerToOffset(CurrLevel.Properties['LevelDataPointer'].Offset) + (CurrSideScroll.RoomNumbers[pRoomIndex] * 48) + (i * 8) + x]) * 32,0,32,32),_Tiles);
    end;

  // Drawing the enemies.
  if (pFilter and VIEWENEMIES = VIEWENEMIES) and (Assigned(self.CurrSideScroll.Enemies))
    and (CurrSideScroll.Enemies.Count > 0) then
  begin
    if FileExists(_AssetDirectory + '\numbers.bmp') =  true then
    begin
      NumbersBMP := TBitmap32.Create;
      BlankBMP := TBitmap32.Create;
      try
        NumbersBMP.Width := 136;
        NumbersBMP.Height := 8;
        NumbersBMP.LoadFromFile(_AssetDirectory + '\numbers.bmp');
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(_AssetDirectory + '\blankenemy.bmp');
        Spr := CurrSideScroll.PatternTableSprSetting;

        if pEnemyView = 1 then
        begin
          Spr := CurrSideScroll.SpriteChange[0];
        end
        else if pEnemyView = 2 then
        begin
          Spr := CurrSideScroll.SpriteChange[1];
        end
        else if pEnemyView = 3 then
        begin
          Spr := CurrSideScroll.SpriteChange[2];
        end
        else if pEnemyView = 4 then
        begin
          Spr := CurrSideScroll.SpriteChange[3];
        end;

        // Draw the enemies on screen.
        for i := 0 to CurrSideScroll.Enemies.Count - 1 do
        begin
          if CurrSideScroll.Enemies[i].ScreenID = pRoomIndex then
          begin
            EnemyID := self.AvailableSpritesBySpr(Spr,CurrSideScroll.Enemies[i].SpriteID);
            pBitmap.Draw(pX + CurrSideScroll.Enemies[i].X,pY + CurrSideScroll.Enemies[i].Y,BlankBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.Enemies[i].X,pY + CurrSideScroll.Enemies[i].Y,8,8),bounds(StrToInt('$' + IntToHex(EnemyID,2)[1]) * 8,0,8,8),NumbersBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.Enemies[i].X+8,pY + CurrSideScroll.Enemies[i].Y,8,8),bounds(StrToInt('$' + IntToHex(EnemyID,2)[2]) * 8,0,8,8),NumbersBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.Enemies[i].X+8,pY + CurrSideScroll.Enemies[i].Y+8,8,8),bounds(StrToInt('$' + IntToHex(CurrSideScroll.Enemies[i].SpriteID,2)[2]) * 8,0,8,8),NumbersBMP);            
          end;
        end;
      finally
        FreeAndNil(BlankBMP);
        FreeAndNil(NumbersBMP);
      end;

    end;
  end;

  // Drawing the special objects.
  if (pFilter and VIEWSPECIALOBJECTS = VIEWSPECIALOBJECTS) and (Assigned(CurrSideScroll.SpecialObjects))
    and (CurrSideScroll.SpecialObjects.Count > 0) then
  begin
    if FileExists(_AssetDirectory + '\numbers.bmp') =  true then
    begin
      NumbersBMP := TBitmap32.Create;
      BlankBMP := TBitmap32.Create;
      try
        NumbersBMP.Width := 136;
        NumbersBMP.Height := 8;
        NumbersBMP.LoadFromFile(_AssetDirectory + '\numbers.bmp');
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(_AssetDirectory + '\blankspecobj.bmp');

        // Draw the special objects on screen.
        for i := 0 to CurrSideScroll.SpecialObjects.Count - 1 do
        begin
          if CurrSideScroll.SpecialObjects[i].ScreenID = pRoomIndex then
          begin
            pBitmap.Draw(pX + CurrSideScroll.SpecialObjects[i].X,pY + CurrSideScroll.SpecialObjects[i].Y,BlankBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.SpecialObjects[i].X,pY + CurrSideScroll.SpecialObjects[i].Y,8,8),bounds(StrToInt('$' + IntToHex(CurrSideScroll.SpecialObjects[i].ID,2)[1]) * 8,0,8,8),NumbersBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.SpecialObjects[i].X+8,pY + CurrSideScroll.SpecialObjects[i].Y,8,8),bounds(StrToInt('$' + IntToHex(CurrSideScroll.SpecialObjects[i].ID,2)[2]) * 8,0,8,8),NumbersBMP);
          end;
        end;

      finally
        FreeAndNil(BlankBMP);
        FreeAndNil(NumbersBMP);
      end;
    end;
  end;

  // Draw the boss data.
  if (pFilter and VIEWBOSSDATA = VIEWBOSSDATA) and (Assigned(CurrSideScroll.Boss))
    and (CurrSideScroll.Boss.Count > 0) then
  begin
    if FileExists(_AssetDirectory + '\numbers.bmp') =  true then
    begin
      NumbersBMP := TBitmap32.Create;
      BlankBMP := TBitmap32.Create;
      try
        NumbersBMP.Width := 136;
        NumbersBMP.Height := 8;
        NumbersBMP.LoadFromFile(_AssetDirectory + '\numbers.bmp');
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(_AssetDirectory + '\blankbossdata.bmp');

        for i := 0 to CurrSideScroll.Boss.Count -1 do
        begin
          if ((CurrSideScroll.Boss[i].ScreenY * CurrSideScroll.Width) + CurrSideScroll.Boss[i].ScreenX) = pRoomIndex then
          begin
            pBitmap.Draw(pX + CurrSideScroll.Boss[i].X,pY + CurrSideScroll.Boss[i].Y,BlankBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.Boss[i].X,pY + CurrSideScroll.Boss[i].Y,8,8),bounds(StrToInt('$' + IntToHex(CurrSideScroll.Boss[i].SpriteID,2)[1]) * 8,0,8,8),NumbersBMP);
            pBitmap.Draw(bounds(pX + CurrSideScroll.Boss[i].X+8,pY + CurrSideScroll.Boss[i].Y,8,8),bounds(StrToInt('$' + IntToHex(CurrSideScroll.Boss[i].SpriteID,2)[2]) * 8,0,8,8),NumbersBMP);
          end;
        end;

      finally
        FreeAndNil(NumbersBMP);
        FreeAndNil(BlankBMP);
      end;
    end;
  end;

{  if (pFilter and VIEWEXITDATA = VIEWEXITDATA) and Assigned(CurrLevel.Entrances) then
  begin
    if FileExists(_AssetDirectory + '\numbers.bmp') =  true then
    begin
      NumbersBMP := TBitmap32.Create;
      BlankBMP := TBitmap32.Create;
      try
        NumbersBMP.Width := 136;
        NumbersBMP.Height := 8;
        NumbersBMP.LoadFromFile(_AssetDirectory + '\numbers.bmp');
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(_AssetDirectory + '\blankexitdata.bmp');
        for i := 0 to CurrLevel.Exits.Count -1 do
        begin
          if (CurrLevel.Exits[i].StageID = _CurrentSideScroll) and (CurrLevel.Exits[i].LevelStartScreen = _Room) then
          begin
            pBitmap.Draw(CurrLevel.Exits[i].LevelX,CurrLevel.Exits[i].LevelY,BlankBMP);
            pBitmap.Draw(bounds(CurrLevel.Exits[i].LevelX,CurrLevel.Exits[i].LevelY,8,8),bounds(StrToInt('$' + IntToHex($FF,2)[1]) * 8,0,8,8),NumbersBMP);
            pBitmap.Draw(bounds(CurrLevel.Exits[i].LevelX+8,CurrLevel.Exits[i].LevelY,8,8),bounds(StrToInt('$' + IntToHex($FF,2)[2]) * 8,0,8,8),NumbersBMP);
          end;
        end;
      finally
        FreeAndNil(NumbersBMP);
        FreeAndNil(BlankBMP);
      end;
    end;
  end;}

  if (pFilter and VIEWENTRANCEDATA = VIEWENTRANCEDATA) and Assigned(CurrLevel.Entrances) then
  begin
    if FileExists(_AssetDirectory + '\entrance.bmp') =  true then
    begin
      BlankBMP := TBitmap32.Create;
      try
        BlankBMP.Width := 16;
        BlankBMP.Height := 16;
        BlankBMP.LoadFromFile(_AssetDirectory + '\entrance.bmp');
        for i := 0 to CurrLevel.Entrances.Count -1 do
        begin

          if (CurrLevel.Entrances[i].DestID = _CurrentSideScrollIndex) and
           ((CurrLevel.Entrances[i].DestScreenNumberY * CurrSideScroll.Width) + CurrLevel.Entrances[i].DestScreenNumberX = pRoomIndex) then
          begin
            pBitmap.Draw(pX + CurrLevel.Entrances[i].DestX,pY + CurrLevel.Entrances[i].DestY,BlankBMP);
          end;
        end;
      finally
        FreeAndNil(BlankBMP);
      end;
    end;
  end;

end;

procedure TTMNTROM.DrawTSAPatternTable(pBitmap : TBitmap32; pPal : Byte; pWorldMap : Boolean);
var
  i,x : Integer;
begin
  if pWorldMap = False then
  begin
    for i := 0 to 15 do
      for x := 0 to 15 do
        ROM.DrawNESTile(@_PatternTable[(i*16 + x) * 16],pBitmap,x*8,i*8,@_Palette[pPal,0])
  end
  else
  begin

    for i := 0 to 15 do
      for x := 0 to 15 do
        ROM.DrawNESTile(@CurrLevel.PatternTable[(i*16 + x) * 16],pBitmap,x*8,i*8,@CurrLevel.Palette[pPal,0])
  end;
{  for x := 0 to 7 do
    for i := 0 to 31 do
      DrawMMTile((x*32 + i) * 16,pBitmap,(i div 2) *8,(x*16)+(i mod 2) *8,pPal);}
end;

function TTMNTROM.GetRoomData(pIndex,pIndex1 : Integer): Byte;
var
  RoomOffset : Integer;
begin

  RoomOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelDataPointer'].Offset) + (CurrSideScroll.RoomNumbers[_Room] * 48);
  result := ROM[RoomOffset + (pIndex1 * 8) + pIndex];
end;

procedure TTMNTROM.SetRoomData(pIndex,pIndex1 : Integer; pData : Byte);
var
  RoomOffset : Integer;
begin

  RoomOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelDataPointer'].Offset) + (CurrSideScroll.RoomNumbers[_Room] * 48);
  ROM[RoomOffset + (pIndex1 * 8) + pIndex] := pData;
end;

procedure TTMNTROM.DrawTileSelector(pBitmap : TBitmap32;pIndex : Integer);
var
  i : Integer;
begin
  if Assigned(_Tiles) = False then
    exit;
  for i := 0 to 5 do
  begin
    if _TileDrawn[i + pIndex] = False then
    begin
      DrawLevelTile(pIndex + i);
      _TileDrawn[pindex + i] := True;
    end;
    pBitmap.Draw(bounds(0,i * 32,32,32),bounds((pindex+i) * 32,0,32,32),_tiles);
  end;
end;

procedure TTMNTROM.RefreshOnScreenTiles(pTileSelectorValue : Byte);
var
  i : integer;
begin

  // Reset all the tiles back to the false drawing state.
  for i := 0 to high(_TileDrawn) do
    _TileDrawn[i] := false;
  for i := 0 to (CurrSideScroll.Height * CurrSideScroll.Width) - 1 do
    LoadRoomTiles(i);

  // Now scroll through the blocks displayed in the tile selector
  for i := pTileSelectorValue to pTileSelectorValue + 5 do
    if _TileDrawn[i] = false then
    begin
      DrawLevelTile(i);
      _TileDrawn[i] := True;
    end;

end;

procedure TTMNTROM.LoadPaletteFile(pPaletteFile : String);
begin
  ROM.LoadPaletteFile(pPaletteFile);
end;

procedure TTMNTROM.LoadDefaultPalette;
begin
  ROM.LoadDefaultPalette;
end;

function TTMNTROM.GetROMFilename(): String;
begin
  result := ROM.Filename;
end;

procedure TTMNTROM.SetChanged(pChanged: Boolean);
begin
  ROM.Changed := pChanged;
end;

function TTMNTROM.GetChanged(): Boolean;
begin
  result := ROM.Changed;
end;

procedure TTMNTROM.EditTSA(pTileID,pX,pY,pNewTile : Byte);
var
//  TempSolidity : Byte;
  TSAOffset : Integer;
  TileOffset : Integer;
begin
  TSAOffset := 0;

  if CurrSideScroll.TSAOffset > 0 then
    TSAOffset := ROM.PointerToOffset(CurrSideScroll.TSAOffset,$C010)
  else  if CurrLevel.Properties['LevelTSAPointer'] <> nil then
    TSAOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelTSAPointer'].Offset,$C010)
  else if CurrLevel.Properties['Level5TSAStart'] <> nil then
    TSAOffset := ROM.PointerToOffset(CurrLevel.Properties['Level5TSAStart'].Offset + (self._CurrentSideScrollIndex * 2),$C010);

  TileOffset :=  TSAOffset + (pTileID * 16) + (pX) + (pY * 4);
//  TempSolidity := ROM[TileOffset] and $C0;
  ROM[TileOffset] := pNewTile;
  DrawLevelTile(pTileID);
end;

procedure TTMNTROM.IncrementTileAttributes(pTileID,pX,pY : Byte);
var
  TilePal : Array [0..1,0..1] Of Byte;
  AttributeOffset : Integer;
begin
  AttributeOffset := 0;

  if CurrSideScroll.AttributeOffset > 0 then
    AttributeOffset := ROM.PointerToOffset(CurrSideScroll.AttributeOffset,$C010)
  else  if CurrLevel.Properties['LevelAttributePointer'] <> nil then
    AttributeOffset := ROM.PointerToOffset(CurrLevel.Properties['LevelAttributePointer'].Offset,$C010)
  else if CurrLevel.Properties['Level5AttributeStart'] <> nil then
    AttributeOffset := ROM.PointerToOffset(CurrLevel.Properties['Level5AttributeStart'].Offset + (self._CurrentSideScrollIndex * 2),$C010);

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
  DrawLevelTile(pTileID);
end;

function TTMNTROM.Export8x8Pat(pID: Integer) : T8x8Graphic;
var
  x,y : Integer;
  curBit, curBit2 : Char;
  TempBin1,TempBin2, TempBin3 : String;
  Tile1 : Array [0..15] of Byte;
  p8x8 : T8x8Graphic;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[(pID * 16) +y];

  for y := 0 to 7 do
  begin
    TempBin1 := ROM.ByteToBin(Tile1[y]);
    TempBin2 := ROM.ByteToBin(Tile1[y + 8]);
    for x := 0  to 7 do
    begin
      CurBit := TempBin1[x + 1];
      CurBit2 := TempBin2[x + 1];
      TempBin3 := CurBit + CurBit2;

      if TempBin3 = '00' Then
        p8x8.Pixels[y,x] := 0
      else if TempBin3 = '10' Then
        p8x8.Pixels[y,x] := 1
      else if TempBin3 = '01' Then
        p8x8.Pixels[y,x] := 2
      else if TempBin3 = '11' Then
        p8x8.Pixels[y,x] := 3;
    end;
  end;
  result := p8x8;
end;


procedure TTMNTROM.Import8x8Pat(pID: Integer; p8x8: T8x8Graphic);
var
  x,y : Integer;
  TempBin1, TempBin2 : String;
  Tile1 : Array [0..15] of Byte;
begin
  For y := 0 To 15 do
    Tile1[y] := self._PatternTable[(pID * 16) +y];

  for y := 0 to 7 do
  begin
    for x := 0  to 7 do
    begin

      TempBin1 := IntToStr(p8x8.Pixels[y,x] and 1) + TempBin1;
      TempBin2 := IntToStr(p8x8.Pixels[y,x] shr 1) + TempBin2;


    end;

    self._PatternTable[(pID * 16) +y] := ROM.BinToByte(TempBin1);
    self._PatternTable[(pID * 16) +y + 8] := ROM.BinToByte(TempBin2);

  end;
  SavePatternTable;
end;

function TTMNTROM.GetColor32NESPal(pElement: Integer): TColor32;
begin
  result := ROM.NESPal[pElement];
end;

procedure TTMNTROM.SetPalette(pIndex1,pIndex2 : Integer;pNewTile : Byte);
begin
  self._Palette[pIndex1,pIndex2] := pNewTile;
end;

function TTMNTROM.GetPalette(pIndex1,pIndex2 : Integer) : Byte;
begin
  result := self._Palette[pIndex1,pIndex2];
end;

function TTMNTROM.CHRCount : Byte;
begin
  result := ROM.CHRCount;
end;

function TTMNTROM.PRGCount : Byte;
begin
  result := ROM.PRGCount;
end;

function TTMNTROM.MemoryMapper : Byte;
begin
  result := ROM.MapperNumber;
end;

function TTMNTROM.MemoryMapperStr : String;
begin
  result := ROM.MapperName;
end;

function TTMNTROM.FileSize : Integer;
begin
  result := ROM.ROMSize;
end;

function TTMNTROM.IsValidROM(): Boolean;
var
  Mapper,PRG,CHR : Integer;
  INI : TMemINIHexFile;
begin
  INI := TMemINIHexFile.Create(self.DataFile);
  try
    Mapper := INI.ReadInteger('Mapper','MapperNum',1);
    PRG := INI.ReadInteger('Mapper','PRGSize',8);
    CHR := INI.ReadInteger('Mapper','CHRSize',16);
    result := true;
    if ROM.ValidImage = False then
      result := false
    else if Mapper <> ROM.MapperNumber then
      result := false
    else if PRG <> ROM.PRGCount then
      result := false
    else if CHR <> ROM.CHRCount then
      result := false;
  finally
    freeandNil(INI);
  end;
end;

procedure TTMNTROM.RestoreDefaultiNESHeader;
var
  Mapper,PRG,CHR,Vertical : Integer;
  INI : TMemINIHexFile;
begin
  INI := TMemINIHexFile.Create(self.DataFile);
  try
    Mapper := INI.ReadInteger('Mapper','MapperNum',2);
    PRG := INI.ReadInteger('Mapper','PRGSize',8);
    CHR := INI.ReadInteger('Mapper','CHRSize',0);
    Vertical := INI.ReadInteger('Mapper','Vertical',1);
    ROM[0] := $4E;
    ROM[1] := $45;
    ROM[2] := $53;
    ROM[3] := $1A;
    ROM[4] := PRG;
    ROM[5] := CHR;
    ROM[6] := ((Mapper and $0F) Shl 4) + Vertical;
    ROM[7] := (Mapper and $F0);
    ROM[8] := $00;
    ROM[9] := $00;
    ROM[10] := $00;
    ROM[11] := $00;
    ROM[12] := $00;
    ROM[13] := $00;
    ROM[14] := $00;
    ROM[15] := $00;
  finally
    freeandNil(INI);
  end;

end;

procedure TTMNTROM.LoadEnemyData;
var
  i,x,z,offset : Integer;
begin
  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin
      with Levels[i].SideScroll[x] do
      begin
        if Assigned(Enemies) then
          FreeAndNil(Enemies);

        Enemies := TSideScrollEnemyList.Create(true);

        for z := 0 to (Width * Height) - 1 do
        begin
          offset := ROM.PointerToOffset(ROM.PointerToOffset(EnemyPointersOffset) + (z * 2));
          while ROM[offset] <> $FF do
          begin
            Enemies.Add(TSideScrollEnemy.Create(offset,z));
            inc(offset,3);
          end;
        end;

      end;
    end;
  end;
end;

procedure TTMNTROM.SaveEnemyData;
var
  i,x,z,e,enemyscreencount,offset,pointoffset : Integer;
begin

  // Backup the enemy data bank, just in case we over-write stuff.
  ROM.BackupBank(ROM.CalculateBank(_EnemyStartOffset));

  // we take the start offset of where we should write the enemy data
  // to.
  // Then, we store pointers to the various level data.
  offset := self._EnemyStartOffset;

  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin
      // Store the address for the start of the stage's enemy pointers.
      ROM.StorePointerOffset(offset,Levels[i].SideScroll[x].EnemyPointersOffset,$8000);
      // Copy this address, as we will need to update the pointers.
      pointoffset := offset;
      // Work out how many screens are in the level, and add that value multiplied by 2 to offset
      offset := offset + ((Levels[i].SideScroll[x].Width * Levels[i].SideScroll[x].Height) * 2);

      for z := 0 to (Levels[i].SideScroll[x].Width * Levels[i].SideScroll[x].Height)-1 do
      begin
        ROM.StorePointerOffset(offset,pointoffset + (z*2),$8000);

        enemyscreencount := 0;

        with Levels[i].SideScroll[x] do
        begin

          for e := 0 to Enemies.Count -1 do
          begin
            if Enemies[e].ScreenID = z then
            begin
              inc(enemyscreencount);
              ROM[Offset] := Enemies[e].X;

              ROM[Offset+1] := Enemies[e].Y + $10;
              ROM[Offset+2] := Enemies[e].ID;
              inc(offset,3);
            end;

          end;
        end;

        if enemyscreencount > 0 then
        begin
          ROM[offset] := $FF;
          inc(offset);
        end
        else
        begin

          if z > 0 then
          begin
            if ROM[offset - 1] = $FF then
            begin
              dec(offset);
              ROM.StorePointerOffset(offset,pointoffset + (z*2),$8000);
              inc(offset)
            end;
          end
          else if z = 0 then
          begin
            ROM[offset] := $FF;
            inc(offset);
          end;

        end;

      end; //z

    end; // x
  end; // i


  if Offset > _EnemyEndOffset + 1 then
  begin
    showmessage('Your enemy data is too big. Please delete some ' +
      'enemies until the enemy data falls within the required range.');
    ROM.RestoreBank(ROM.CalculateBank(_EnemyStartOffset) ); 
  end;

end;

procedure TTMNTROM.LoadSpecialObjects;
var
  i,x,offset : Integer;
begin
  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin

      if Assigned(Levels[i].SideScroll[x].SpecialObjects) then
        FreeAndNil(Levels[i].SideScroll[x].SpecialObjects);
      Levels[i].SideScroll[x].SpecialObjects := TSpecialObjectList.Create(true);

      offset := ROM.PointerToOffset(Levels[i].SideScroll[x].SpecialObjectsOffset);
      while ROM[offset] <> $FF do
      begin
        Levels[i].SideScroll[x].SpecialObjects.Add(TSpecialObject.Create(offset));
        Levels[i].SideScroll[x].SpecialObjects.Last.ScreenID := ROM[Offset];
        Levels[i].SideScroll[x].SpecialObjects.Last.UnknownX := ROM[Offset+1];
        Levels[i].SideScroll[x].SpecialObjects.Last.X := ROM[Offset+2];
        Levels[i].SideScroll[x].SpecialObjects.Last.Y := ROM[Offset+3];
        Levels[i].SideScroll[x].SpecialObjects.Last.UnknownY := ROM[Offset+4];
        Levels[i].SideScroll[x].SpecialObjects.Last.ID := ROM[Offset+5];
        Levels[i].SideScroll[x].SpecialObjects.Last.Unknown1 := ROM[Offset+6];
        Levels[i].SideScroll[x].SpecialObjects.Last.Unknown2 := ROM[Offset+7];
        inc(offset,8);
      end;

    end;
  end;



end;

procedure TTMNTROM.SaveSpecialObjects;
var
  i,x,z,offset : Integer;
begin
  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin

      if Assigned(Levels[i].SideScroll[x].SpecialObjects) then
      begin

        offset := ROM.PointerToOffset(Levels[i].SideScroll[x].SpecialObjectsOffset);
        for z := 0 to Levels[i].SideScroll[x].SpecialObjects.count -1 do
        begin
          ROM[Offset] := Levels[i].SideScroll[x].SpecialObjects[z].ScreenID;
          ROM[Offset+1] := Levels[i].SideScroll[x].SpecialObjects[z].UnknownX;
          ROM[Offset+2] := Levels[i].SideScroll[x].SpecialObjects[z].X;
          ROM[Offset+3] := Levels[i].SideScroll[x].SpecialObjects[z].Y;
          ROM[Offset+4] := Levels[i].SideScroll[x].SpecialObjects[z].UnknownY;
          ROM[Offset+5] := Levels[i].SideScroll[x].SpecialObjects[z].ID;
          ROM[Offset+6] := Levels[i].SideScroll[x].SpecialObjects[z].Unknown1;
          ROM[Offset+7] := Levels[i].SideScroll[x].SpecialObjects[z].Unknown2;
          inc(offset,8);
        end;
        ROM[offset] := $FF;
      end;

    end;
  end;

end;

procedure TTMNTROM.LoadEntranceData;
var
  i, offset : Integer;
begin

  for i := 0 to Levels.Count -1 do
  begin

    offset := ROM.PointerToOffset( Levels[i].Properties['LevelEntranceDataPointer'].Offset,0,$C000);

    if Assigned(Levels[i].Entrances) then
      FreeAndNil(Levels[i].Entrances);

    Levels[i].Entrances := TEntranceList.Create(true);

    if Levels[i].NoWorldMap <> True then
    begin
      while (ROM[offset] <> $FF) do
      begin
        Levels[i].Entrances.Add(TEntrance.Create(offset));
        inc(offset,11);
      end;
    end;
  end;
end;

procedure TTMNTROM.SaveEntranceData;
var
  i,x,offset : Integer;
begin
  // TO-DO
  // - Make more efficient, reusing the $FF terminators for previous
  //   entrances.

  offset := EntrancesStartOffset;

  for i := 0 to Levels.Count -1 do
  begin
    if (Levels[i].NoWorldMap = False) and Assigned(Levels[i].Entrances) then
    begin
      ROM.StorePointerOffset( offset,Levels[i].Properties['LevelEntranceDataPointer'].Offset,$C000);

      if Levels[i].Entrances.Count > 0 then
      begin
        for x := 0 to Levels[i].Entrances.Count -1 do
        begin
          ROM[offset] := Levels[i].Entrances[x].SourceScreen;
          ROM[offset+1] := Levels[i].Entrances[x].SourceX;
          ROM[offset+2] := Levels[i].Entrances[x].SourceY;
          ROM[offset+3] := Levels[i].Entrances[x].EntranceToLevel;
          ROM[offset+4] := Levels[i].Entrances[x].DestID;
          ROM[offset+5] := Levels[i].Entrances[x].DestX;
          ROM[offset+6] := Levels[i].Entrances[x].DestY;
          ROM[offset+7] := Levels[i].Entrances[x].DestScreenX1;
          ROM[offset+8] := Levels[i].Entrances[x].DestScreenX2;
          ROM[offset+9] := Levels[i].Entrances[x].DestScreenY1;
          ROM[offset+10] := Levels[i].Entrances[x].DestScreenY2;
          inc(offset,11);
        end;
      end;

      ROM[offset] := $FF;
      inc(offset);
    end;
  end;

end;

procedure TTMNTROM.LoadExitData;
var
  i,x, offset, CurExit : Integer;
  LoadNoMore : Boolean;
begin

  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin
      if Assigned(Levels[i].SideScroll[x].Exits) then
        FreeAndNil(Levels[i].SideScroll[x].Exits);

      Levels[i].SideScroll[x].Exits := TEntranceList.Create(true);
      // Reset the current exit index.
      CurExit := 0;
      LoadNoMore := false;
      // Calculate the offset where the 
      offset := ROM.PointerToOffset( Levels[i].SideScroll[x].ExitDataOffset,0,$C000);
      if offset >= $1C010 then
      begin

        while ((ROM[offset] <> $FF) and (LoadNoMore = false)) do
        begin
          // If a hard coded limit has been set for the number of exits
          // in this side-stage, and the current exit index is over this
          // number, load no more for this level.
          if Levels[i].SideScroll[x].NumExits > -1 then
            if CurExit >= Levels[i].SideScroll[x].NumExits then LoadNoMore := True;

          // Check if we should load in this exit.
          if LoadNoMore = false then
          begin
            Levels[i].SideScroll[x].Exits.Add(TEntrance.Create(offset));
            inc(offset,11);
            // Increment the current exit number.
            inc(CurExit);
          end;
        end;
      end;
    end;

  end;
end;

/// <summary>Calculates the amount of bytes that the exit data
/// needs in the ROM. </summary>
procedure TTMNTROM.CalculateExitDataSize;
begin

end;

procedure TTMNTROM.SaveExitData;
begin
  { TODO : SaveExitData in TTMNTROM }
end;

function TTMNTROM.DetectObjectUnderMouse(pX,pY : Integer) : TObjDetect;
var
  res : Integer;
  Obj : TObjDetect;
begin
  // If the object is an enemy
  res := GetEnemyUnderMouse(pX,pY);
  if res <> -1 then
  begin
    Obj.ObjType := uConsts.OBJENEMY;
    Obj.ObjIndex := res;
    result := Obj;
    exit;
  end;
  // Check if the object is a special object
  res := GetSpecialObjUnderMouse(pX,pY);
  if res <> -1 then
  begin
    Obj.ObjType := uConsts.OBJSPECIAL;
    Obj.ObjIndex := res;
    result := Obj;
    exit;
  end;
  // Check if the object is an entrance
  res := GetEntranceUnderMouse(pX,pY);
  if res <> -1 then
  begin
    Obj.ObjType := uConsts.OBJENTRANCE;
    Obj.ObjIndex := res;
    result := Obj;
    exit;
  end;
  // Check if the object is a boss
  res := GetBossUnderMouse(pX,pY);
  if res <> -1 then
  begin
    Obj.ObjType := uConsts.OBJBOSS;
    Obj.ObjIndex := res;
    result := Obj;
    exit;
  end;
  // Check if the object is an exit


  // If we get to here, then there is no object, so we need to tell
  // the calling routine to perform no action.
  Obj.ObjType := -1;
  Obj.ObjIndex := -1;
  result := Obj;
end;

function TTMNTROM.GetEnemyUnderMouse(pX,pY : Integer) : Integer;
var
  i : Integer;
begin
  result := -1;
  if Assigned(CurrSideScroll.Enemies) = False then exit;
  if CurrSideScroll.Enemies.Count = 0 then exit;
  for i := 0 to CurrSideScroll.Enemies.Count -1 do
  begin
    if CurrSideScroll.Enemies[i].ScreenID =  self._Room then
    begin
      if (pX >= CurrSideScroll.Enemies[i].X) and (pX <= CurrSideScroll.Enemies[i].X + 16) then
        if (pY >= CurrSideScroll.Enemies[i].Y) and (pY <= CurrSideScroll.Enemies[i].Y + 16) then
        begin
          result := i;
          break;
        end;
    end;
  end;
end;

function TTMNTROM.GetBossUnderMouse(pX,pY : Integer) : Integer;
var
  i : Integer;
begin
  result := -1;
  if Assigned(CurrSideScroll.Boss) = False then exit;
  if CurrSideScroll.Boss.Count = 0 then exit;
  for i := 0 to CurrSideScroll.Boss.Count -1 do
  begin
    if CurrSideScroll.Boss[i].ScreenX =  self._Room then
    begin
      if (pX >= CurrSideScroll.Boss[i].X) and (pX <= CurrSideScroll.Boss[i].X + 16) then
        if (pY >= CurrSideScroll.Boss[i].Y) and (pY <= CurrSideScroll.Boss[i].Y + 16) then
        begin
          result := i;
          break;
        end;
    end;
  end;
end;

function TTMNTROM.GetEntranceUnderMouse(pX,pY : Integer) : Integer;
var
  i : Integer;
begin
  result := -1;
  if Assigned(CurrLevel.Entrances) = False then exit;
  if CurrLevel.Entrances.Count = 0 then exit;
  for i := 0 to CurrLevel.Entrances.Count -1 do
  begin
    if (CurrLevel.Entrances[i].DestID = _CurrentSideScrollIndex) and
      ((CurrLevel.Entrances[i].DestScreenNumberY * CurrSideScroll.Width) +
        CurrLevel.Entrances[i].DestScreenNumberX = _Room) then
    begin
      if (pX >= CurrLevel.Entrances[i].DestX) and (pX <= CurrLevel.Entrances[i].DestX + 16) then
        if (pY >= CurrLevel.Entrances[i].DestY) and (pY <= CurrLevel.Entrances[i].DestY + 16) then
        begin
          result := i;
          break;
        end;
    end;
  end;
end;

function TTMNTROM.GetSpecialObjUnderMouse(pX,pY : Integer) : Integer;
var
  i : Integer;
begin
  result := -1;
  if Assigned(CurrSideScroll.SpecialObjects) = False then exit;
  if CurrSideScroll.SpecialObjects.Count = 0 then exit;
  for i := 0 to CurrSideScroll.SpecialObjects.Count -1 do
  begin
    if CurrSideScroll.SpecialObjects[i].ScreenID =  self._Room then
    begin
      if (pX >= CurrSideScroll.SpecialObjects[i].X) and (pX <= CurrSideScroll.SpecialObjects[i].X + 16) then
        if (pY >= CurrSideScroll.SpecialObjects[i].Y) and (pY <= CurrSideScroll.SpecialObjects[i].Y + 16) then
        begin
          result := i;
          break;
        end;
    end;
  end;
end;

function TTMNTROM.GetAvailableEnemies(pIndex : Integer) : Byte;
begin
  result := ROM[ROM.PointerToOffset(self._EnemiesUsedPointers + (CurrSideScroll.PatternTableSprSetting * 2)) + pIndex];
end;

procedure TTMNTROM.DrawLevelMap(pBitmap : TBitmap32;pHeight,pWidth : Integer;pHighlightedScreen : Integer);
var
  i,x : Integer;
begin
  for i := 0 to pHeight -1 do
    for x := 0 to pWidth -1 do
    begin
      if (i * pWidth) + x = pHighlightedScreen then
      begin
        pBitmap.FillRect(x*LEVELMAPBLOCKSIZE,i*LEVELMAPBLOCKSIZE,
          (x*LEVELMAPBLOCKSIZE) +LEVELMAPBLOCKSIZE,(i*LEVELMAPBLOCKSIZE) +
            LEVELMAPBLOCKSIZE,clRed32);
        pBitmap.FrameRectS(x*LEVELMAPBLOCKSIZE,i*LEVELMAPBLOCKSIZE,
          (x*LEVELMAPBLOCKSIZE) +LEVELMAPBLOCKSIZE,(i*LEVELMAPBLOCKSIZE) +
            LEVELMAPBLOCKSIZE,clWhite32);
      end
      else
      begin
        pBitmap.FillRect(x*LEVELMAPBLOCKSIZE,i*LEVELMAPBLOCKSIZE,
          (x*LEVELMAPBLOCKSIZE) +LEVELMAPBLOCKSIZE,(i*LEVELMAPBLOCKSIZE) +
            LEVELMAPBLOCKSIZE,clFuchsia32);
        pBitmap.FrameRectS(x*LEVELMAPBLOCKSIZE,i*LEVELMAPBLOCKSIZE,
          (x*LEVELMAPBLOCKSIZE) +LEVELMAPBLOCKSIZE,(i*LEVELMAPBLOCKSIZE) +
            LEVELMAPBLOCKSIZE,clWhite32);
      end;
    end;
end;

procedure TTMNTROM.DrawLevelMap(pBitmap : TBitmap32;pHighlightedScreen : Integer);
begin
  self.DrawLevelMap(pBitmap,CurrSideScroll.Height,CurrSideScroll.Width,pHighlightedScreen);
end;

function TTMNTROM.AvailableSpritesBySpr(pSpr : Byte;pID : Byte):Byte;
begin
  result := ROM[ROM.PointerToOffset(self._EnemiesUsedPointers + (pSpr * 2)) + pID];
end;

procedure TTMNTROM.DrawPatternTable(pBitmap : TBitmap32; pPal : Byte;pIndex : Byte;pInterLeave : Byte);
var
  i,x,PatOffset : Integer;
begin
  PatOffset := (ROM.PRGCount * $4000) + $10 + (pIndex * $1000);
  if pInterLeave = 0 then
  begin
    for i := 0 to 15 do
      for x := 0 to 15 do
        ROM.DrawNESTile(@ROM.RawROM[PatOffset + (i*16 + x) * 16],pBitmap,x*8,i*8,@_Palette[pPal,0])
  end
  else if pInterLeave = 1 then
  begin
    for x := 0 to 7 do
      for i := 0 to 31 do
        ROM.DrawNESTile(@ROM.RawROM[PatOffset + (x*32 + i) * 16],pBitmap,(i div 2) *8,(x*16)+(i mod 2) *8,@_Palette[pPal,0]);
  end
  else if pInterLeave = 2 then
  begin
    for x := 0 to 15 do
      for i := 0 to 3 do
        ROM.DrawNESTile( @ROM.RawROM[PatOffset + (x * 4 + i) * 16],pBitmap,(x div 2 * 16) + (i div 2) *8,(x mod 2 * 16) + (i mod 2) *8,@_Palette[pPal,0]);
  end;
end;

procedure TTMNTROM.DeleteEnemy(pID : Integer);
begin
  CurrSideScroll.Enemies.Delete(pID);
  ROM.Changed := True;
end;

function TTMNTROM.AddEnemy: Boolean;
begin
  result := False;
  if CalculateTotalEnemies < _EnemyTotalAmount then
  begin
    CurrSideScroll.Enemies.Add(TSideScrollEnemy.Create(-1, _Room));
    ROM.Changed := True;
    result := True;
  end;
end;

procedure TTMNTROM.IncrementSpecialObjID(pID : Integer);
begin
  if CurrSideScroll.SpecialObjects.Count = 0 then exit;
  if pID < CurrSideScroll.SpecialObjects.Count then
  begin
    if CurrSideScroll.SpecialObjects[pID].ID = $FF then
      CurrSideScroll.SpecialObjects[pID].ID := 0
    else
      CurrSideScroll.SpecialObjects[pID].ID := CurrSideScroll.SpecialObjects[pID].ID + 1;
  end;
end;

procedure TTMNTROM.InitialiseWorldMap();
begin
  CurrLevel.WorldMapScreen := 0;
  CurrLevel.ClearWorldMapTiles;
  CurrLevel.LoadBGPalette(@_PalettePointers);
  CurrLevel.LoadPatternTable;
  CurrLevel.LoadWorldMapTiles;
end;

procedure TTMNTROM.LoadSolidityData(pSolidityList : TSolidityList);
var
  offset : Integer;
begin
  offset := ROM.PointerToOffset(self._SolidityStart + ((CurrSideScroll.PatternTableBGSetting - $0D) * 2),$1C010, $C000);
  while(ROM[offset] <> $FF) do
  begin
    pSolidityList.Add(TSolidity.Create(offset));
    inc(offset,2);
  end;
end;

procedure TTMNTROM.SaveSolidityData(pSolidityList : TSolidityList);
var
  offset : Integer;
  i : Integer;
begin
  offset := ROM.PointerToOffset(self._SolidityStart + ((CurrSideScroll.PatternTableBGSetting - $0D) * 2),$1C010, $C000);
  for i := 0 to pSolidityList.Count -1 do
  begin
    pSolidityList[i].SaveData(offset);
    inc(offset,2);
  end;
end;

function TTMNTROM.CalculateTotalEnemies : Integer;
var
  i,z,numenemies : Integer;
begin
  numenemies := 0;
  for i := 0 to Levels.Count -1 do
  begin
    for z := 0 to Levels[i].SideScroll.Count -1 do
    begin
      numenemies := numenemies + Levels[i].SideScroll[z].Enemies.Count;
    end;
  end;
  result := numenemies;
end;

function TTMNTROM.CalculateSpecialObjectAmount : Integer;
var
  i,x : Integer;
begin
  result := 0;
  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin
      result := result + Levels[i].SideScroll[x].SpecialObjects.Count;                  
    end;
  end;
end;

procedure TTMNTROM.LoadBossData;
var
  i,x, offset : Integer;
begin
  for i := 0 to Levels.Count -1 do
  begin
    for x := 0 to Levels[i].SideScroll.Count -1 do
    begin
      offset := ROM.PointerToOffset(Levels[i].SideScroll[x].BossDataOffset);
      if Assigned(Levels[i].SideScroll[x].Boss) then
        FreeAndNil(Levels[i].SideScroll[x].Boss);

      Levels[i].SideScroll[x].Boss := TBossList.Create(true);

      while ROM[offset] <> $FF do
      begin
        Levels[i].SideScroll[x].Boss.Add(TBoss.Create(offset));
        if Levels[i].SideScroll[x].Boss.Last.WorldBoss = true then
          inc(offset,6)
        else
          inc(offset,5);
      end;
    end;
  end;
end;

procedure TTMNTROM.SaveBossData;
begin
  { TODO : SaveBossData in TTMNTROM }
end;

function TTMNTROM.BossPresent : Boolean;
var
  i : Integer;
begin
  result := False;
  for i:= 0 to CurrSideScroll.Boss.Count -1 do
  begin
    if CurrSideScroll.Boss[i].ScreenX = self._Room then
    begin
      result := True;
      break;
    end;
  end;
end;

procedure TTMNTROM.LoadWorldMapEnemyData;
var
  i,x,pointeroffsets,enemydataoffset : Integer;
begin
  for i := 0 to Levels.Count -1 do
  begin
    if Levels[i].NoWorldMap = False then
    begin

      pointeroffsets := ROM.PointerToOffset(Levels[i].Properties['WorldEnemyData'].Offset);

      if Assigned(Levels[i].Enemies) = True then
        FreeAndNil(Levels[i].Enemies);

      Levels[i].Enemies := TWorldEnemyList.Create(True);

      for x := 0 to (Levels[i].MapWidth * Levels[i].MapHeight) - 1 do
      begin
        enemydataoffset := ROM.PointerToOffset(pointeroffsets + (x * 2));

        while(ROM[enemydataoffset] <> $FF) do
        begin
          Levels[i].Enemies.Add(TWorldEnemy.Create(enemydataoffset, x));
          inc(enemydataoffset,3);
        end; // while

      end; // x

    end; // if

  end; // i

end;

procedure TTMNTROM.SaveWorldMapEnemyData;
begin
{ TODO : Add SaveWorldMapEnemyData in TTMNTROM }
end;

procedure TTMNTROM.LoadScrollData;
begin
{ TODO : Add LoadScrollData in TTMNTROM }
end;

procedure TTMNTROM.SaveScrollData;
begin
{ TODO : Add SaveScrollData in TTMNTROM }
end;

function TTMNTROM.GetHighestScreenNumber(pWorld : Byte) : Byte;
var
  i,x,temp : Integer;
begin
  temp := 0;
  for i := 0 to Levels[pWorld].SideScroll.Count -1 do
  begin
    for x := 0 to (Levels[pWorld].SideScroll[i].Width * Levels[pWorld].SideScroll[i].Height - 1) do
    begin

      if (Levels[pWorld].SideScroll[i].RoomNumbers[x] <> $FF) and (Levels[pWorld].SideScroll[i].RoomNumbers[x] > temp) then
        temp := Levels[pWorld].SideScroll[i].RoomNumbers[x];

    end;
  end;
  result := temp;
end;

function TTMNTROM.CalculateCRCArea(pStartOffset, pEndOffset : Integer) : LongWord;
var
  lwCRC32 : Longword;
  AreaSize : Integer;
begin
  AreaSize := pEndOffset - pStartOffset;
  lwCRC32 := $FFFFFFFF; // match "normal" / PKZIP / etc. , step one: initialize with $FFFFFFFF (-1 signed)
  CalcCRC32(@ROM.RawROM[pStartOffset], AreaSize+1, lwCRC32);
  lwCRC32 := not lwCRC32; // match "normal" / PKZIP / etc. , step two: invert the bits of the result

  result := lwCRC32;
end;

end.
