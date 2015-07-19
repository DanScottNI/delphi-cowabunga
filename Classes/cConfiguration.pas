unit cConfiguration;

interface

uses GR32, INIFiles, SysUtils, classes, forms;

type
  TEditorConfig = class
  private
    _Changed : Boolean;
    _LeftTextColour : TColor32;
    _MidTextColour : TColor32;
    _GridlineColour : TColor32;
    _OptionsFilename : String;
    _Palette : String;
    _GridlinesEnabled,_GridlinesOnDef : Boolean;
    _DisplayLeftMiddleText : Boolean;
    _DataFile : String;
    _BackupFiles : Boolean;
    _EmulatorPath : String;
    _EmulatorFilenameSettings : Byte;
    _EmulatorDisplaySaveWarning : Boolean;
    _LastPaletteTSA : Byte;
    _LastPaletteTileEditor : Byte;
    _LastPaletteTitleScreenEd : Byte;
    _MapperWarnings : Byte;
    _RecentlyOpenedFiles : TStringlist;
    _AutoCheck : Boolean;
    _OriginalROMFile : String;
    _IPSOutput : String;
    _AutoObjMode : Boolean;
    _SpecObjOutline : TColor32;
    _IconTransparency : Boolean;
    _IconOpaque : Byte;
    _DisableEnemyDeletePrompt : Boolean;
    _GridlinesWorldMap : Boolean;
    _UseOldOpenDialog : Byte;
    _SolidityColours : Array [0..15] of TColor32;
    procedure SetLeftTextColour(pLeftTextColour : TColor32);
    procedure SetSpecObjColour(pLeftTextColour : TColor32);
    procedure SetMiddleTextColour(pMiddleTextColour : TColor32);
    procedure SetGridlineColour(pGridlineColour : TColor32);
    function GetFullPalette: String;
    procedure SetFullPalette(const Value: String);
    function GetFullDataFilename: String;
    procedure SetFullDataFileName(const Value: String);
    procedure SetDataFile(const Value: String);
    procedure SetDisplayLeftMiddleText(const Value: Boolean);
    procedure SetGridlinesEnabled(const Value: Boolean);
    procedure SetGridlinesWorldMap(const Value : Boolean);
    procedure SetOptionsFileName(const Value: String);
    procedure SetPalette(const Value: String);
    procedure SetGridlinesOnDef(const Value: Boolean);
    procedure SetBackupFiles(const Value: Boolean);
    procedure SetEmu83Filename(const Value: Byte);
    procedure SetIconTransparency(const Value: Boolean);
    procedure SetIconOpaque(const Value: Byte);
    procedure SetEmulatorDisplaySaveWarning(const Value: Boolean);
    procedure SetEmuPath(const Value: String);
    procedure SetLastPaletteTileEditor(const Value: Byte);
    procedure SetLastPaletteTitleScreen(const Value: Byte);
    procedure SetLastPaletteTSA(const Value: Byte);
    procedure SetMapperWarnings(const Value: Byte);
    function GetNumberOfRecentlyOpenedFiles: Integer;
    function GetRecentFile(index: Integer): String;
    procedure SetRecentFile(index: Integer; const Value: String);
    procedure SetupMRU;
    procedure SetAutoCheck(const Value: Boolean);
    procedure SetOriginalROMFile(const Value : String);
    procedure SetIPSOutput(const Value : String);
    procedure SetAutoObjMode (const Value : Boolean);
    procedure SetDisableEnemyDeletePrompt (const Value : Boolean);
    procedure SetUseOldOpenDialog(const Value : Byte);
    procedure CleanupMRU();
    procedure SetSolidityColours(pIndex : Integer;const Value : TColor32);
    function GetSolidityColours (pIndex : Integer) : TColor32;
  public
    constructor Create(pOptionsFilename : String);
    destructor Destroy;override;
    property Changed : Boolean read _Changed write _Changed;
    procedure Save;
    procedure Load;
    property LeftTextColour : TColor32 read _LeftTextColour write SetLeftTextColour;
    property MiddleTextColour : TColor32 read _MidTextColour write SetMiddleTextColour;
    property GridlineColour : TColor32 read _GridlineColour write SetGridlineColour;
    property SpecObjOutline : TColor32 read _SpecObjOutline write SetSpecObjColour;
    property NumberOfRecentlyOpenedFiles : Integer read GetNumberOfRecentlyOpenedFiles;
    property RecentFile [index : Integer] : String read GetRecentFile write SetRecentFile;
    procedure AddRecentFile(pNewFile : String);
    procedure LoadDefaultSettings;
    property DrawTransparentIcons : Boolean read _IconTransparency write SetIconTransparency;
    property IconTransparency : Byte read _IconOpaque write SetIconOpaque;
    property Filename : String read _OptionsFilename write SetOptionsFileName;
    property Palette : String read _Palette write SetPalette;
    property FullPaletteName : String read GetFullPalette write SetFullPalette;
    property GridlinesOn : Boolean read _GridlinesEnabled write SetGridlinesEnabled;
    property GridlinesOnByDefault : Boolean read _GridlinesOnDef write SetGridlinesOnDef;
    property DispLeftMidText : Boolean read _DisplayLeftMiddleText write SetDisplayLeftMiddleText;
    property DataFileName : String read _DataFile write SetDataFile;
    property FullDataFileName : String read GetFullDataFilename write SetFullDataFileName;
    property BackupFilesWhenSaving : Boolean read _BackupFiles write SetBackupFiles;
    property EmulatorPath : String read _EmulatorPath write SetEmuPath;
    property EmulatorFileSettings : Byte read _EmulatorFilenameSettings write SetEmu83Filename;
    property EmulatorDisplaySaveWarning : Boolean read _EmulatorDisplaySaveWarning write SetEmulatorDisplaySaveWarning;
    property LastPaletteTSA : Byte read _LastPaletteTSA write SetLastPaletteTSA;
    property LastPaletteTileEditor : Byte read _LastPaletteTileEditor write SetLastPaletteTileEditor;
    property LastPaletteTitleScreenEd : Byte read _LastPaletteTitleScreenEd write SetLastPaletteTitleScreen;
    property MapperWarnings : Byte read _MapperWarnings write SetMapperWarnings;
    property AutoCheck : Boolean read _AutoCheck write SetAutoCheck;
    property OriginalROMFile : String read _OriginalROMFile write SetOriginalROMFile;
    property IPSOutput : String read _IPSOutput write SetIPSOutput;
    property AutoObjMode : Boolean read _AutoObjMode write SetAutoObjMode;
    property DisableEnemyDeletePrompt : Boolean read _DisableEnemyDeletePrompt write SetDisableEnemyDeletePrompt;
    property GridlinesWorldMapOn : Boolean read _GridlinesWorldMap write SetGridlinesWorldMap;
    property UseOldOpenDialog : Byte read _UseOldOpenDialog write SetUseOldOpenDialog;
    property SolidityColours [index : Integer] : TColor32 read GetSolidityColours write SetSolidityColours;
  end;

implementation

uses uConsts;

const
  SolidityColoursDefaults : Array [0..15] of TColor32 = (clBlue32,clLightGray32,
    clYellow32,clMaroon32,clGreen32,clOlive32,clNavy32,clPurple32,clTeal32,
    clRed32,clLime32,clBlue32,clFuchsia32,clAqua32,$FFD09EF6,$FFA7F5F0);

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.Create
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: pOptionsFilename : String
  Result:    None
-----------------------------------------------------------------------------}
constructor TEditorConfig.Create(pOptionsFilename : String);
begin
  _OptionsFIlename := pOptionsFilename;
  Load;
  Save;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.Save
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.Save;
var
  INI : TMemINIFile;
  i : Integer;
begin
  INI := TMemINIFile.Create(_OptionsFilename);
  try
    // Write the left text settings.
    INI.WriteInteger('LeftText','R',(_LeftTextColour and $00FF0000) shr 16);
    INI.WriteInteger('LeftText','G',(_LeftTextColour and $0000FF00) shr 8);
    INI.WriteInteger('LeftText','B',_LeftTextColour and $0000FF);
    INI.WriteInteger('LeftText','A',_LeftTextColour shr 24);
    // Write the middle text settings
    INI.WriteInteger('MidText','R',(_MidTextColour and $00FF0000) shr 16);
    INI.WriteInteger('MidText','G',(_MidTextColour and $0000FF00) shr 8);
    INI.WriteInteger('MidText','B',_MidTextColour and $0000FF);
    INI.WriteInteger('MidText','A',_MidTextColour shr 24);
    // Write the gridline settings
    INI.WriteInteger('Gridline','R',(_GridlineColour and $00FF0000) shr 16);
    INI.WriteInteger('Gridline','G',(_GridlineColour and $0000FF00) shr 8);
    INI.WriteInteger('Gridline','B',_GridlineColour and $0000FF);
    INI.WriteInteger('Gridline','A',_GridlineColour shr 24);

    // Write the special object outline settings
    INI.WriteInteger('SpecOutline','R',(_SpecObjOutline and $00FF0000) shr 16);
    INI.WriteInteger('SpecOutline','G',(_SpecObjOutline and $0000FF00) shr 8);
    INI.WriteInteger('SpecOutline','B',_SpecObjOutline and $0000FF);
    INI.WriteInteger('SpecOutline','A',_SpecObjOutline shr 24);

    for i := 0 to $F do
    begin
      // Write the solidity colour settings
      INI.WriteInteger('SolidityColour' + IntToStr(i),'R',(_SolidityColours[i] and $00FF0000) shr 16);
      INI.WriteInteger('SolidityColour' + IntToStr(i),'G',(_SolidityColours[i] and $0000FF00) shr 8);
      INI.WriteInteger('SolidityColour' + IntToStr(i),'B',_SolidityColours[i] and $0000FF);
      INI.WriteInteger('SolidityColour' + IntToStr(i),'A',(_SolidityColours[i]and $FF000000) shr 24);
    end;

    ini.WriteString('General','Palette',_Palette);

    INI.WriteBool('General','Gridlines',_GridlinesOnDef);
    INI.WriteBool('General','DispMidLeftText',_DisplayLeftMiddleText);

    INI.WriteString('General','DataFile',_DataFile);
    INI.WriteString('General','EmulatorPath',_EmulatorPath);
    INI.WriteInteger('General','EmuFileSettings',_EmulatorFilenameSettings);
    INI.WriteBool('General','Backup',_BackupFiles);
    INI.WriteBool('General','EmuDisplaySaveWarning',_EmulatorDisplaySaveWarning);
    INI.WriteInteger('General','LastPalTilEd',_LastPaletteTSA);
    INI.WriteInteger('General','LastPalTSA',_LastPaletteTileEditor);
    INI.WriteInteger('General','LastPalTitle',_LastPaletteTitleScreenEd);
    INI.WriteInteger('General','MapperWarnings',_MapperWarnings);

    INI.WriteInteger('General','UseOldOpenDialog',_UseOldOpenDialog);
    INI.WriteBool('General','AutoCheck',_AutoCheck);
    INI.WriteBool('General','DisableEnemyDeletePrompt',_DisableEnemyDeletePrompt);
    SetupMRU();
    INI.WriteString('Recent','RecentFile0',_RecentlyOpenedFiles[0]);
    INI.WriteString('Recent','RecentFile1',_RecentlyOpenedFiles[1]);
    INI.WriteString('Recent','RecentFile2',_RecentlyOpenedFiles[2]);
    INI.WriteString('Recent','RecentFile3',_RecentlyOpenedFiles[3]);
    INI.WriteString('Recent','RecentFile4',_RecentlyOpenedFiles[4]);
    INI.WriteString('IPS','Original',_OriginalROMFile);
    INI.WriteString('IPS','Output',_IPSOutput);
    INI.WriteBool('General','AutoObjMode',_AutoObjMode);
    INI.WriteBool('General','IconTrans',_IconTransparency);
    INI.WriteInteger('General','IconOpaque',_IconOpaque);

    INI.UpdateFile;
  finally
    FreeAndNil(INI);
  end;
  _Changed := False;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.Load
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.Load;
var
  INI : TMemINIFile;
  i : Integer;
begin
  INI := TMemINIFile.Create(_OptionsFilename);
  try
    _LeftTextColour := (INI.ReadInteger('LeftText','A',$FF) shl 24) + (INI.ReadInteger('LeftText','R',$FF) shl 16)
      + (INI.ReadInteger('LeftText','G',$00) shl 8) + (INI.ReadInteger('LeftText','B',$00));
    _MidTextColour := (INI.ReadInteger('MidText','A',$FF) shl 24) + (INI.ReadInteger('MidText','R',$00) shl 16)
      + (INI.ReadInteger('MidText','G',$FF) shl 8) + (INI.ReadInteger('MidText','B',$00));
    _GridlineColour := (INI.ReadInteger('Gridline','A',$FF) shl 24) + (INI.ReadInteger('Gridline','R',$FF) shl 16)
      + (INI.ReadInteger('Gridline','G',$FF) shl 8) + (INI.ReadInteger('Gridline','B',$FF));
//    _LeftTextColour := INI.ReadInteger('General','LeftTextColour',$FFFF0000);
    _SpecObjOutline := (INI.ReadInteger('SpecOutline','A',$FF) shl 24) + (INI.ReadInteger('SpecOutline','R',$FF) shl 16)
      + (INI.ReadInteger('SpecOutline','G',$00) shl 8) + (INI.ReadInteger('SpecOutline','B',$00));
    _Palette := ini.ReadString('General','Palette','fx3nespal.pal');
    _GridlinesOnDef := INI.ReadBool('General','Gridlines',True);
    _GridlinesEnabled := _GridlinesOnDef;
    _GridlinesWorldMap := _GridlinesOnDef;
    _DisplayLeftMiddleText := INI.ReadBool('General','DispMidLeftText', True);
    _DataFile := INI.ReadString('General','DataFile','Teenage Mutant Ninja Turtles (U) (!).ini');
    _BackupFiles := INI.ReadBool('General','Backup',True);
    _EmulatorFilenameSettings := INI.readInteger('General','emufilesettings',0);
    _EmulatorPath := INI.ReadString('General','EmulatorPath','');
    _EmulatorDisplaySaveWarning := INI.ReadBool('General','EmuDisplaySaveWarning',True);
    _LastPaletteTSA := INI.ReadInteger('General','LastPalTilEd',0);
    _LastPaletteTileEditor := INI.ReadInteger('General','LastPalTSA',0);
    _LastPaletteTitleScreenEd := INI.ReadInteger('General','LastPalTitle',0);
    _MapperWarnings := INI.ReadInteger('General','MapperWarnings',1);
    _AutoCheck := INI.ReadBool('General','AutoCheck',True);
    _OriginalROMFile := INI.ReadString('IPS','Original','');
    _IPSOutput := INI.ReadString('IPS','Output','');
    _AutoObjMode := INI.ReadBool('General','AutoObjMode',True);
    _IconTransparency := INI.ReadBool('General','IconTrans', False);
    _IconOpaque := INI.ReadInteger('General','IconOpaque',200);
    _DisableEnemyDeletePrompt := INI.ReadBool('General','DisableEnemyDeletePrompt', False);
    _UseOldOpenDialog := INI.ReadInteger('General','UseOldOpenDialog',uConsts.USECUSTOMOPENDIALOG);

    SetupMRU();
    for i := 0 to 15 do
    begin
      _SolidityColours[i] :=
        (INI.ReadInteger('SolidityColour' + IntToStr(i),'A',(SolidityColoursDefaults[i] and $FF000000) shr 24) shl 24) +
        (INI.ReadInteger('SolidityColour' + IntToStr(i),'R',(SolidityColoursDefaults[i] and $00FF0000) shr 16) shl 16) +
        (INI.ReadInteger('SolidityColour' + IntToStr(i),'G',(SolidityColoursDefaults[i] and $0000FF00) shr 8) shl 8) +
        (INI.ReadInteger('SolidityColour' + IntToStr(i),'B',SolidityColoursDefaults[i] and $0000FF));
    end;

    _RecentlyOpenedFiles[0] := (INI.ReadString('Recent','RecentFile0',''));
    _RecentlyOpenedFiles[1] := (INI.ReadString('Recent','RecentFile1',''));
    _RecentlyOpenedFiles[2] := (INI.ReadString('Recent','RecentFile2',''));
    _RecentlyOpenedFiles[3] := (INI.ReadString('Recent','RecentFile3',''));
    _RecentlyOpenedFiles[4] := (INI.ReadString('Recent','RecentFile4',''));
    CleanupMRU();
  finally
    FreeAndNil(INI);
  end;

end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetLeftTextColour
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: pLeftTextColour : TColor32
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetLeftTextColour(pLeftTextColour : TColor32);
begin
  _LeftTextColour := pLeftTextColour;
  _Changed := True;
end;

procedure TEditorConfig.SetSpecObjColour(pLeftTextColour : TColor32);
begin
  _SpecObjOutline := pLeftTextColour;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetMiddleTextColour
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: pMiddleTextColour : TColor32
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetMiddleTextColour(pMiddleTextColour : TColor32);
begin
  _MidTextColour := pMiddleTextColour;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetGridlineColour
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: pGridlineColour : TColor32
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetGridlineColour(pGridlineColour : TColor32);
begin
  _GridlineColour := pGridlineColour;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.GetFullPalette
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    String
-----------------------------------------------------------------------------}
function TEditorConfig.GetFullPalette: String;
begin
  result := ExtractFileDir(Application.ExeName) + '\Data\Palettes\' + _Palette;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetFullPalette
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetFullPalette(const Value: String);
begin
  _Palette := ExtractFileName(Value);
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.GetFullDataFilename
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    String
-----------------------------------------------------------------------------}
function TEditorConfig.GetFullDataFilename: String;
begin
  result := ExtractFileDir(Application.ExeName) + '\Data\' + _DataFile;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetFullDataFileName
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetFullDataFileName(const Value: String);
begin
  _DataFile := ExtractFileName(Value);
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetDataFile
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetDataFile(const Value: String);
begin
  _DataFile := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetDisplayLeftMiddleText
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetDisplayLeftMiddleText(const Value: Boolean);
begin
  _DisplayLeftMiddleText := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetGridlinesEnabled
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetGridlinesEnabled(const Value: Boolean);
begin
  _GridlinesEnabled := Value;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetOptionsFileName
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetOptionsFileName(const Value: String);
begin
  _OptionsFilename := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetPalette
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetPalette(const Value: String);
begin
  _Palette := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetGridlinesOnDef
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetGridlinesOnDef(const Value: Boolean);
begin
  _GridlinesOnDef := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetBackupFiles
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetBackupFiles(const Value: Boolean);
begin
  _BackupFiles := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetEmu83Filename
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetEmu83Filename(const Value: Byte);
begin
  _EmulatorFilenameSettings := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetEmulatorDisplaySaveWarning
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetEmulatorDisplaySaveWarning(const Value: Boolean);
begin
  _EmulatorDisplaySaveWarning := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetEmuPath
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetEmuPath(const Value: String);
begin
  _EmulatorPath := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetLastPaletteTileEditor
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Byte
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetLastPaletteTileEditor(const Value: Byte);
begin
  _LastPaletteTileEditor := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetLastPaletteTitleScreen
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Byte
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetLastPaletteTitleScreen(const Value: Byte);
begin
  _LastPaletteTitleScreenEd := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetMapperWarnings
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Byte
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetMapperWarnings(const Value: Byte);
begin
  _MapperWarnings := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.GetNumberOfRecentlyOpenedFiles
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    Integer
-----------------------------------------------------------------------------}
function TEditorConfig.GetNumberOfRecentlyOpenedFiles: Integer;
var
  i : Integer;
  count : Integer;
begin
  if Assigned(_RecentlyOpenedFiles) = True then
  begin
    count := 0;
    for i := 0 to _RecentlyOpenedFiles.Count - 1 do
    begin
      if _RecentlyOpenedFiles[i] <> '' then
        inc(Count);
    end;
    result := count;
  end
  else
    result := -1;

end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.GetRecentFile
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: index: Integer
  Result:    String
-----------------------------------------------------------------------------}
function TEditorConfig.GetRecentFile(index: Integer): String;
begin
  result := _RecentlyOpenedFiles[index];
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetRecentFile
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: index: Integer; const Value: String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetRecentFile(index: Integer; const Value: String);
begin
  _RecentlyOpenedFiles[index] := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetupMRU
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetupMRU;
var
  i, initcount : Integer;
begin
  if Assigned(_RecentlyOpenedFiles) = false then
    _RecentlyOpenedFiles := TStringList.Create;

  if _RecentlyOpenedFiles.Count < 5 then
  begin
    initcount := _RecentlyOpenedFiles.Count;
    for i := initcount to 4 do
      _RecentlyOpenedFiles.Add('');
  end;

end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetAutoCheck
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Boolean
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetAutoCheck(const Value: Boolean);
begin
  _AutoCheck := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.SetLastPaletteTSA
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: const Value: Byte
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.SetLastPaletteTSA(const Value: Byte);
begin
  _LastPaletteTSA := Value;
  _Changed := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.Destroy
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
destructor TEditorConfig.Destroy;
begin
  if Assigned(_RecentlyOpenedFiles) = true then
    FreeAndNil(_RecentlyOpenedFiles);

  inherited;
end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.AddRecentFile
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: pNewFile : String
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.AddRecentFile(pNewFile : String);
var
  i,index : Integer;
  TempString : String;
begin
  index := _RecentlyOpenedFiles.IndexOf(pNewFile);
  if index = -1 then
  begin
    for i := 3 downto 0 do
    begin
      _RecentlyOpenedFiles[i+1] := _RecentlyOpenedFiles[i];
    end;
    _RecentlyOpenedFiles[0] := pNewFile;
  end
  else
  begin
    if index > 0 then
    begin
      TempString := _RecentlyOpenedFiles[index];
      for i := index downto 1  do
      begin
        _RecentlyOpenedFiles[i] := _RecentlyOpenedFiles[i - 1];
      end;
      _RecentlyOpenedFiles[0] := TempString;
    end;
  end;
  _Changed := True;

end;

{-----------------------------------------------------------------------------
  Procedure: TEditorConfig.LoadDefaultSettings
  Author:    Dan
  Date:      05-Feb-2004
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TEditorConfig.LoadDefaultSettings;
var
  i : Integer;
begin
  _LeftTextColour := $FFFF0000;
  _MidTextColour := $FF00FF00;
  _GridlineColour := $FFFFFFFF;
  _SpecObjOutline := $FFFF0000;
//    _LeftTextColour := INI.ReadInteger('General','LeftTextColour',$FFFF0000);
  _Palette := 'fx3nespal.pal';
  _GridlinesOnDef := True;
  _DisplayLeftMiddleText := True;
  _BackupFiles := True;
  _EmulatorFilenameSettings := 0;
  _EmulatorPath := '';
  _EmulatorDisplaySaveWarning := True;
  _MapperWarnings := 1;
  _AutoCheck := True;
  _OriginalROMFile := '';
  _IPSOutput := '';
  _AutoObjMode := True;
  _IconTransparency := False;
  _IconOpaque := 200;
  _DisableEnemyDeletePrompt := False;
  for i := 0 to $F do
    _SolidityColours[i] := SolidityColoursDefaults[i];

end;

procedure TEditorConfig.SetOriginalROMFile(const Value : String);
begin
  _OriginalROMFile := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetIPSOutput(const Value : String);
begin
  _IPSOutput := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetAutoObjMode (const Value : Boolean);
begin
  _AutoObjMode := Value;
  _Changed := True;
end;

procedure TEditorConfig.CleanupMRU();
var
  i : Integer;
begin
  for i := 4 downto 0 do
  begin
    if FileExists(_RecentlyOpenedFiles[i]) = False then
    begin
      _RecentlyOpenedFiles[i] := '';
      _Changed := True;
    end;
  end;

end;

procedure TEditorConfig.SetIconTransparency(const Value: Boolean);
begin
  _IconTransparency := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetIconOpaque(const Value: Byte);
begin
  _IconOpaque := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetDisableEnemyDeletePrompt (const Value : Boolean);
begin
  _DisableEnemyDeletePrompt := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetGridlinesWorldMap(const Value : Boolean);
begin
  _GridlinesWorldMap := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetUseOldOpenDialog(const Value : Byte);
begin
  _UseOldOpenDialog := Value;
  _Changed := True;
end;

procedure TEditorConfig.SetSolidityColours(pIndex : Integer;const Value : TColor32);
begin

end;

function TEditorConfig.GetSolidityColours (pIndex : Integer) : TColor32;
begin
  result := _SolidityColours[pIndex];
end;

end.
