unit fEditorMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  shellAPI, gr32, Menus, Dialogs, GR32_Image, JvComponent,
  JvDragDrop, AbBase, AbBrowse, AbZBrows, AbZipper, ImgList,
  StdCtrls, ComCtrls, ToolWin, GR32_Layers, FileCtrl,uConsts,
  cROMData,cConfiguration, JvComponentBase, ActnList;//memcheck;

type
  TfrmEditorMain = class(TForm)
    tlbToolbar: TToolBar;
    tlbOpenROM: TToolButton;
    StatusBar: TStatusBar;
    ActionList: TActionList;
    actAbout: TAction;
    actPreferences: TAction;
    ImageList: TImageList;
    actOpenROM: TAction;
    actSaveROM: TAction;
    actCloseROM: TAction;
    tlbSaveROM: TToolButton;
    tlbCloseROM: TToolButton;
    actEnableGridlines: TAction;
    AbZipper: TAbZipper;
    tlbSep1: TToolButton;
    tlbMapEditingMode: TToolButton;
    tlbObjectEditingMode: TToolButton;
    actSetMapEditingMode: TAction;
    actObjectEditingMode: TAction;
    actProperties: TAction;
    JvDropTarget: TJvDropTarget;
    actTSAEditor: TAction;
    tlbTSA: TToolButton;
    tlbSep2: TToolButton;
    actKeyboardLayout: TAction;
    Bitmap32List: TBitmap32List;
    actGoToLevel: TAction;
    tlbGoToLevel: TToolButton;
    actDebugROMViewer: TAction;
    actBackupManager: TAction;
    tlbEnableGridlines: TToolButton;
    sep3: TToolButton;
    OpenDialog: TOpenDialog;
    actLevelSettings: TAction;
    actDistribute: TAction;
    actLevelMap: TAction;
    actAddEnemy: TAction;
    MainMenu: TMainMenu;
    mnuFile: TMenuItem;             
    mnuOpenROM: TMenuItem;
    mnuRecent: TMenuItem;
    mnuRecentItem1: TMenuItem;
    mnuRecentItem2: TMenuItem;
    mnuRecentItem3: TMenuItem;
    mnuRecentItem4: TMenuItem;
    mnuRecentItem5: TMenuItem;
    mnuSaveROM: TMenuItem;
    mnuSaveAsIPS: TMenuItem;
    mnuCloseROM: TMenuItem;
    N1: TMenuItem;
    mnuBackupManager: TMenuItem;
    mnuPreferences: TMenuItem;
    mnuProperties: TMenuItem;
    mnuLaunchAssociatedEmulator: TMenuItem;
    N2: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuMapEditingMode: TMenuItem;
    mnuObjectEditingMode: TMenuItem;
    N7: TMenuItem;
    mnuAddNewEnemy: TMenuItem;
    mnuView: TMenuItem;
    mnuEnemies: TMenuItem;
    mnuObjects: TMenuItem;
    mnuGridlines: TMenuItem;
    N4: TMenuItem;
    mnuEnemyViewDefault: TMenuItem;
    mnuEnemyViewSpriteChange1: TMenuItem;
    mnuEnemyViewSpriteChange2: TMenuItem;
    mnuEnemyViewSpriteChange3: TMenuItem;
    mnuEnemyViewSpriteChange4: TMenuItem;
    N6: TMenuItem;
    mnuLevelMap: TMenuItem;
    mnuGotolevel: TMenuItem;
    mnuTools: TMenuItem;
    mnu32x32TSAEditor: TMenuItem;
    mnuLevelSettings: TMenuItem;
    mnuDebugROMViewer: TMenuItem;
    mnuHelp: TMenuItem;
    mnuKeyboardLayout: TMenuItem;
    N5: TMenuItem;
    mnuVisitRockAndRollHomepage: TMenuItem;
    N3: TMenuItem;
    mnuAbout: TMenuItem;
    actPaletteEditor: TAction;
    mnuPaletteEditor: TMenuItem;
    tlbPaletteEditor: TToolButton;
    actSolidityEditor: TAction;
    mnuSolidityEditor: TMenuItem;
    tlbAddNewEnemy: TToolButton;
    tlbSolidityEditor: TToolButton;
    mnuBossData: TMenuItem;
    actWorldMapEditor: TAction;
    mnuWorldMapEditor: TMenuItem;
    mnuExits: TMenuItem;
    mnuEntranceDebug: TMenuItem;
    mnuEntrances: TMenuItem;
    actScrollEditor: TAction;
    mnuScrollEditor: TMenuItem;
    imgTiles: TImage32;
    scrTiles: TScrollBar;
    imgScreen: TImage32;
    scrLevel: TScrollBar;
    scrLevelV: TScrollBar;
    actWorldScreenCount: TAction;
    mnuWorldScreenCount: TMenuItem;
    mnuExitDebug: TMenuItem;
    Debug1: TMenuItem;
    actDebug: TAction;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure actOpenROMExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actAboutExecute(Sender: TObject);
    procedure imgScreenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure scrTilesChange(Sender: TObject);
    procedure scrTilesScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure imgTilesMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure actPreferencesExecute(Sender: TObject);
    procedure mnuRecentItem1Click(Sender: TObject);
    procedure actSaveROMExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure scrLevelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actObjectEditingModeExecute(Sender: TObject);
    procedure actSetMapEditingModeExecute(Sender: TObject);
    procedure mnuLaunchAssociatedEmulatorClick(Sender: TObject);
    procedure JvDropTargetDragDrop(Sender: TJvDropTarget;
      var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
    procedure actTSAEditorExecute(Sender: TObject);
    procedure actCloseROMExecute(Sender: TObject);
    procedure imgScreenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure imgScreenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
//    procedure actSoundEffectsExecute(Sender: TObject);
    procedure actKeyboardLayoutExecute(Sender: TObject);
    procedure mnuVisitRockAndRollHomepageClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure actGoToLevelExecute(Sender: TObject);
    procedure actDebugROMViewerExecute(Sender: TObject);
    procedure mnuEnemiesClick(Sender: TObject);
    procedure actBackupManagerExecute(Sender: TObject);
    procedure actPropertiesExecute(Sender: TObject);
    procedure actEnableGridlinesExecute(Sender: TObject);
    procedure scrLevelVChange(Sender: TObject);
    procedure actLevelSettingsExecute(Sender: TObject);
    procedure mnuEnemyViewDefaultClick(Sender: TObject);
    procedure actDistributeExecute(Sender: TObject);
    procedure actLevelMapExecute(Sender: TObject);
    procedure actAddEnemyExecute(Sender: TObject);
    procedure scrTilesKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure actPaletteEditorExecute(Sender: TObject);
    procedure actSolidityEditorExecute(Sender: TObject);
    procedure actWorldMapEditorExecute(Sender: TObject);
    procedure actScrollEditorExecute(Sender: TObject);
    procedure actWorldScreenCountExecute(Sender: TObject);
    procedure actDebugExecute(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    _EditorConfig : TEditorConfig;
    _EnemyView : Byte;
    _CurTileLeft, _CurTileMid : Byte;
    _EditingMode : Byte;
    TSA : TForm;
    _CurTSABlock : Integer;
    _Obj : TObjDetect;
    procedure SetIconTransparency();
    procedure SetVisibleStatus(pVisible : Boolean);
    procedure DisplayScreenInfo;
    procedure SetTileScrMax;
    procedure SetLevelScrMax;
    procedure LoadROM(pFilename,pDataFile : String;pAutoCheck : Boolean);
    procedure CreateRecentMenu();
    procedure SetEmuMenuText();
    procedure BackupFile();
    procedure SetupLevel();
    procedure ExecuteEmulator;
    procedure ClearImageIndex;
    procedure SynchronizeRoomScrollbars;
    function CalculateRoomNo(): Integer;
    function AutoCheckROMType(pFilename : String) : String;
    procedure CloseROM(pDisableCancel : Boolean);
    procedure LoadEmulatorIcon;
    { Private declarations }
  public
    procedure RedrawScreen;
    procedure DrawLevelData();
    procedure DrawTileSelector();
    procedure UpdateTitleCaption;
    property CurTSABlock : Integer read _CurTSABlock write _CurTSABlock;
    property CurTileLeft : Byte read _CurTileLeft write _CurTileLeft;
    property CurTileMid : Byte read _CurTileMid write _CurTileMid;
    property CurrentObject : TObjDetect read _Obj write _Obj;
    { Public declarations }
  end;

var
  frmEditorMain: TfrmEditorMain;

implementation

uses fAbout, fPreferences, uLunarCompress, fDebug,
  fOpenDialog,fTSAEditor,fFileProperties,fKeyboardLayouts, fGoToLevel,
  fDebugROMViewer,fBackupManagement,iNESImage,MemINIHexFile,uresourcestrings,
  fLevelSettings, fDistribution, fEnemyProperties,fLevelMap,
  fSpecialObjProperties,fPaletteEditor,fSolidityEditor,fWorldMapEditor,
  fScrollEditor,fEntranceProperties,fWorldScreenNumbers;

{$R *.dfm}


procedure TfrmEditorMain.SetVisibleStatus(pVisible : Boolean);
begin
  scrTiles.Visible := pVisible;
  scrLevel.Visible := pVisible;
  imgScreen.Visible := pVisible;
  imgTiles.Visible := pVisible;
  scrLevelV.Visible := pVisible;
  mnuLaunchAssociatedEmulator.Enabled := pVisible;
  actSetMapEditingMode.Enabled := pVisible;
  actObjectEditingMode.Enabled := pVisible;
  actSolidityEditor.Enabled := pVisible;
  actSaveROM.Enabled := pVisible;
  actCloseROM.Enabled := pVisible;
  actProperties.Enabled := pVisible;
  actTSAEditor.Enabled := pVisible;
  actGoToLevel.Enabled := pVisible;
  actDebugROMViewer.Enabled := pVisible;
  actLevelSettings.Enabled := pVisible;
  actDistribute.Enabled := pVisible;
  actAddEnemy.Enabled := pVisible;
  actPaletteEditor.Enabled := pVisible;
  actWorldMapEditor.Enabled := pVisible;
  mnuEnemies.Enabled := pVisible;
  mnuObjects.Enabled := pVisible;
  mnuGridlines.Enabled := pVisible;
  actEnableGridlines.Enabled := pVisible;
  actLevelMap.Enabled := pVisible;
  actScrollEditor.Enabled := pVisible;
  actWorldScreenCount.Enabled := pVisible;
  mnuEnemyViewDefault.Enabled := pVisible;
  mnuEnemyViewSpriteChange1.Enabled := pVisible;
  mnuEnemyViewSpriteChange2.Enabled := pVisible;
  mnuEnemyViewSpriteChange3.Enabled := pVisible;
  mnuEnemyViewSpriteChange4.Enabled := pVisible;
//  tvwLevels.Visible := pVisible;
  if pVisible = False then
  begin
    Statusbar.Panels[0].Text := RES_ROMNOTLOADED;
    Statusbar.Panels[0].Width := ClientWidth;
    Statusbar.Panels[1].Width := 0;
    Statusbar.Panels[2].Width := 0;
  end
  else
  begin
    Statusbar.Panels[0].Width := 125;
    Statusbar.Panels[1].Width := 300;
    Statusbar.Panels[2].Width := 50;
  end;

end;


procedure TfrmEditorMain.FormCreate(Sender: TObject);
begin
  if DEBUG = true then
  begin
//    MemCheckLogFileName := ExtractFileDir(Application.EXEName) + '\memory.log';
//    memchk();
  end
  else
  begin
    mnuDebugROMViewer.Visible := False;
  end;
  // Reset variables to defaults.
  _Obj.ObjType := -1;
  _Obj.ObjIndex := -1;
  _CurTSABlock := -1;

  _EditorConfig := TEditorConfig.Create(ExtractFileDir(Application.ExeName) + '\options.ini');

  SetVisibleStatus(False);
  _EnemyView := 0;
  Caption := APPLICATIONTITLE;
  Application.Title := APPLICATIONTITLE;
  CreateRecentMenu();
  SetEmuMenuText;
  ClearImageIndex;
  UpdateTitleCaption();
  // to whether the gridlines are actually on.
  actEnableGridlines.Checked := _EditorConfig.GridlinesOn;
    // Now look up the commandline parameters. If the user has
  // passed a ROM's filename along with EXE name, open the ROM.
  if ParamCount = 1 then
    if FileExists(ParamStr(1)) then
      LoadROM(ParamStr(1),_EditorConfig.FullDataFileName, _EditorConfig.AutoCheck);

end;

procedure TfrmEditorMain.actOpenROMExecute(Sender: TObject);
var
  OpDlg : TfrmOpenDialog;
//  OpDlgNew : TfrmOpenDialogNew;
begin
  if _EditorConfig.UseOldOpenDialog = uConsts.USECUSTOMOPENDIALOG then
  begin
    OpDlg := TfrmOpenDialog.Create(self, _EditorConfig);
    try
      OpDlg.OpenDir := ExtractFileDir(_EditorConfig.RecentFile[0]);
      OpDlg.ShowModal;

      if FileExists(OpDlg.Filename) = True then
        LoadROM(OpDlg.FileName,OpDlg.DataFile,OpDlg.AutoCheck);
    finally
      FreeAndNil(OpDlg);
    end;
  end
  else
  begin
    if OpenDialog.Execute then
    begin
      if FileExists(OpenDialog.Filename) = True then
        LoadROM(OpenDialog.FileName,_EditorConfig.FullDataFileName,_EditorConfig.AutoCheck);
    end;
  end;
end;

procedure TfrmEditorMain.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseROM(true);
  if Assigned(_EditorConfig) then
  begin
    if _EditorConfig.Changed = True then
      _EditorConfig.Save;

    FreeAndNil(_EditorConfig);
  end;

end;

procedure TfrmEditorMain.CloseROM(pDisableCancel : Boolean);
var
  MsgRes : Integer;
begin
  if _EditorConfig.Changed = True then
    _EditorConfig.Save;

  if Assigned(_ROMData) = True then
  begin
    if _ROMData.Changed = True then
    begin
      if pDisableCancel = True then
        MsgRes := MessageDlg(RES_ROMCHANGESSAVE,mtConfirmation,[mbYes, mbNo],0)
      else
        MsgRes := MessageDlg(RES_ROMCHANGESSAVE,mtConfirmation,[mbYes, mbNo,mbCancel],0);
      if MsgRes = mrYes then
        _ROMData.Save;

      if MsgRes <> mrCancel then
      begin
        if CurTSABlock > -1 then
          FreeAndNil(TSA);
        _CurTSABlock := -1;
        FreeAndNil(_ROMData);
        UpdateTitleCaption;
        if pDisableCancel = False then
          SetVisibleStatus(False);
      end;
    end
    else
    begin
      if CurTSABlock > -1 then
        FreeAndNil(TSA);
      _CurTSABlock := -1;
      FreeAndNil(_ROMData);
      UpdateTitleCaption;
      if pDisableCancel = False then
        SetVisibleStatus(False);
    end;
  end;

end;

procedure TfrmEditorMain.actAboutExecute(Sender: TObject);
var
  About : TfrmAbout;
begin
  About := TfrmAbout.Create(self);
  try
    About.ShowModal;
  finally
    FreeAndNil(About);
  end;
end;

procedure TfrmEditorMain.DrawLevelData();
var
  TempBitmap : Tbitmap32;
  Filter : Byte;
  i : Integer;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 256;
    TempBitmap.Height := 192;
    filter := 0;

    if mnuEnemies.Checked = True then
      Filter := Filter + uConsts.VIEWENEMIES;
    if mnuObjects.Checked = True then
      Filter := Filter + uConsts.VIEWSPECIALOBJECTS;
    if mnuBossData.Checked = True then
      Filter := Filter + uConsts.VIEWBOSSDATA;
    if mnuExits.Checked = True then
      Filter := Filter + uConsts.VIEWEXITDATA;
    if mnuEntrances.Checked = True then
      Filter := Filter + uConsts.VIEWENTRANCEDATA;


    _ROMData.DrawScreen(TempBitmap, _ROMData.Room,0,0, Filter,Bitmap32List,_EnemyView);

    if _EditorConfig.GridlinesOn = True then
    begin
      for i := 1 to 7 do
        TempBitmap.Line(i*32,0,i*32,TempBitmap.Height,_EditorConfig.GridlineColour);
      for i := 1 to 5 do
        TempBitmap.Line(0,i*32,TempBitmap.Width,i*32,_EditorConfig.GridlineColour);
    end;
    imgScreen.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmEditorMain.SetIconTransparency();
var
  i : Integer;
begin
  for i := 0 to Bitmap32List.Bitmaps.Count - 1 do
  begin
    if _EditorConfig.DrawTransparentIcons = True then
      Bitmap32List.Bitmap[i].DrawMode := dmBlend
    else
      Bitmap32List.Bitmap[i].DrawMode := dmOpaque;

    Bitmap32List.Bitmap[i].MasterAlpha := _EditorConfig.IconTransparency;
  end;

end;

procedure TfrmEditorMain.DrawTileSelector();
var
  TempBitmap : TBitmap32;
  tlFont : TFont;
  i : integer;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 32;
    TempBitmap.Height := 32 * 6;
    _ROMData.DrawTileSelector(TempBitmap,scrTiles.Position);
    tlFont := TFont.Create;
    tlFont.Name := 'Tahoma';
    tlFont.Size := 7;
    tlFont.Color := wincolor(_EditorConfig.LeftTextColour);
    TempBitmap.Font := tlFont;

    for i := 1 to 5 do
      TempBitmap.Line(0,i*32,32,i*32,clwhite32);

    if (CurTileLeft >= scrTiles.Position) and (CurTileLeft <= scrTiles.Position + 5) then
    begin
      if CurTileLeft = CurTileMid then
      begin
        TempBitmap.Line(0,(CurTileLeft - scrTiles.Position)*32,0,(CurTileLeft - scrTiles.Position)* 32 + 32,_EditorConfig.LeftTextColour);
        TempBitmap.Line(0,(CurTileLeft - scrTiles.Position)*32,32,(CurTileLeft - scrTiles.Position)* 32,_EditorConfig.LeftTextColour);
      end
      else
        TempBitmap.FrameRectS(0,(CurTileLeft - scrTiles.Position)*32,32,(CurTileLeft-scrTiles.Position)* 32 + 32,_EditorConfig.LeftTextColour);
      if _EditorConfig.DispLeftMidText = true then
        TempBitmap.Textout(1,(CurTileLeft - scrTiles.Position)*32,RES_LEFT);
    end;
    TempBitmap.Font.Color := wincolor(_EditorConfig.MiddleTextColour);
    if (CurTileMid >= scrTiles.Position) and (CurTileMid <= scrTiles.Position + 5) then
    begin
      if CurTileLeft = CurTileMid then
      begin
        TempBitmap.Line(31,(CurTileMid - scrTiles.Position)*32,31,(CurTileMid-scrTiles.Position)* 32 + 32,_EditorConfig.MiddleTextColour);
        TempBitmap.Line(0,(CurTileMid - scrTiles.Position)*32+31,32,(CurTileMid-scrTiles.Position)* 32+31,_EditorConfig.MiddleTextColour);
      end
      else
        TempBitmap.FrameRectS(0,(CurTileMid - scrTiles.Position)*32,32,(CurTileMid-scrTiles.Position)* 32 + 32,_EditorConfig.MiddleTextColour);
      if _EditorConfig.DispLeftMidText = true then
        TempBitmap.Textout(1,(CurTileMid - scrTiles.Position)*32+16,RES_MIDDLE);
    end;

    imgTiles.Bitmap := TempBitmap;
  finally
    FreeAndNil(tlFont);
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmEditorMain.SetLevelScrMax;
begin
  scrLevel.Max := _ROMData.CurrSideScroll.Width - 1;
  scrLevelV.Max := _ROMData.CurrSideScroll.Height -1;


  if _ROMData.CurrSideScroll.Width = 1 then
    scrLevel.Enabled := False
  else
    scrLevel.Enabled := True;

  if _ROMData.CurrSideScroll.Height = 1 then
    scrLevelV.Enabled := False
  else
    scrLevelV.Enabled := True;


end;

procedure TfrmEditorMain.SetTileScrMax;
begin

//  scrTiles.Max := ROMData.CurrLevel.NumberOfTiles - 8;

  if _ROMData.CurrSideScroll.MaxTiles > 0 then
    scrTiles.Max := _ROMData.CurrSideScroll.MaxTiles - 5
  else if _ROMData.CurrLevel.MaxTiles > _ROMData.CurrSideScroll.MaxTiles then
    scrTiles.Max := _ROMData.CurrLevel.MaxTiles - 5;

end;

procedure TfrmEditorMain.DisplayScreenInfo;
begin
  StatusBar.Panels[1].Text := RES_LEVELNO + IntToStr(_ROMData.CurrentLevel+1) + '-' + IntToStr(_ROMData.CurrentSideScroll+1) + RES_SCREENNO + IntToHex(_ROMData.Room,2) + RES_SCREENID + IntToHex(_ROMData.CurrSideScroll.RoomNumbers[_ROMData.Room],2);
  if _ROMData.BossPresent = True then
    StatusBar.Panels[1].Text := StatusBar.Panels[1].Text + ' Boss Present';
end;

procedure TfrmEditorMain.imgScreenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;Layer: TCustomLayer);
var
  CurTilePos : Integer;
  EnemyProp : TfrmEnemyProperties;
  SpecProp : TfrmSpecialObjProperties;
  EntProp : TfrmEntranceProperties;
begin

  // Check if the stage is marked as glitched. If it is
  // don't allow any editing of the stage.
  if _ROMData.CurrSideScroll.Glitched = True then
  begin
    showmessage(RES_STAGEGLITCHED);
    exit;
  end;

  if _EditingMode = MAPEDITINGMODE then
  begin
    if button = mbLeft then
    begin
      if ssShift in Shift then
        _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32] := _CurTileMid
      else
        _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32] := _CurTileLeft;
      DrawLevelData();
    end
    else if button = mbRight then
    begin
      CurTilePos := _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32];
      if ssShift in Shift then
        CurTileMid := CurTilePos
      else
        CurTileLeft := CurTilePos;
      if CurTilePos > scrTiles.Max then CurTilePos := scrTiles.Max;
      if (CurTilePos <= scrTiles.Position) or (CurTilePos >= scrTiles.Position + 5) then
        scrTiles.Position := CurTilePos;
      DrawTileSelector();
    end
    else if Button = mbMiddle then
    begin
      if ssShift in Shift then
        _CurTileMid := _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32]
      else
        _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32] := _CurTileMid;
      DrawLevelData();
    end;

  end
  else if _EditingMode = OBJECTEDITINGMODE then
  begin
    // Detect what type of object (if any), is under the mouse
    // when you clicked.
    _Obj := _ROMData.DetectObjectUnderMouse(x div 2,y div 2);
    // If the object is an enemy..
    if _Obj.ObjType = uConsts.OBJENEMY then
    begin
      if (ssRight in Shift)  then
      begin
        if ssCtrl in Shift then
        begin

          if _EditorConfig.DisableEnemyDeletePrompt = False then
          begin
            if MessageDlg(RES_ENEMYDELETESURE,mtConfirmation,[mbYes, mbNo],0) = mrYes then
              _ROMData.DeleteEnemy(_Obj.ObjIndex)
          end
          else
            _ROMData.DeleteEnemy(_Obj.ObjIndex);
          DisplayScreenInfo;
          DrawLevelData;
          UpdateTitleCaption;

        end
        else if ssShift in Shift then
        begin

          EnemyProp := TfrmEnemyProperties.Create(self, _ROMData);
          try
            EnemyProp.ID := _Obj.ObjIndex;
            EnemyProp.Sprites := _EnemyView;
            if EnemyProp.ShowModal = mrOk then
            begin
              
              SynchronizeRoomScrollbars;
              DrawLevelData;
              UpdateTitleCaption;
            end;
          finally
            FreeAndNil(EnemyProp);
          end;

        end
        else
        begin
          if _ROMData.CurrSideScroll.Enemies.Count > 0 then
          begin
            _ROMData.CurrSideScroll.Enemies[_Obj.ObjIndex].IncrementID;
          end;

          DrawLevelData;
          UpdateTitleCaption;
        end;
        _Obj.ObjIndex := -1;
        _Obj.ObjType := -1;
      end;

    end
    // If the object is a special object...
    else if _Obj.ObjType = uConsts.OBJSPECIAL then
    begin
      if ssRight in Shift then
      begin
        if ssShift in Shift then
        begin
          SpecProp := TfrmSpecialObjProperties.Create(self);
          try
            if SpecProp.ShowModal = mrOk then
            begin
              DrawLevelData;
              UpdateTitleCaption;
            end;
          finally
            FreeAndNil(SpecProp);
          end;
        end
        else
        begin
          _ROMData.IncrementSpecialObjID(_Obj.ObjIndex);
          DrawLevelData;
          UpdateTitleCaption;
        end;
      end;

    end
    // If the object is an entrance....
    else if _Obj.ObjType = uConsts.OBJENTRANCE then
    begin
      if (ssRight in Shift) then
      begin

        if (ssSHift in Shift) then
        begin
          EntProp := TfrmEntranceProperties.Create(self, _ROMData);
          try
            EntProp.ID := _Obj.ObjIndex;
            EntProp.ShowModal;
          finally
            FreeAndNil(EntProp);
          end;
          _Obj.ObjType := -1;
          _Obj.ObjIndex := -1;
        end;

      end;
    end
    // If the object is a boss...
    else if _Obj.ObjType = uConsts.OBJBOSS then
    begin

    end;
  end;

  UpdateTitleCaption();
end;

procedure TfrmEditorMain.scrTilesChange(Sender: TObject);
begin
  DrawTileSelector;
end;

procedure TfrmEditorMain.scrTilesScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  DrawTileSelector();
end;

procedure TfrmEditorMain.imgTilesMouseDown(Sender: TObject;
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
    if Button = mbMiddle then
    begin

    end
    else if Button = mbRight then
    begin
      _ROMData.IncrementTileAttributes((y div (32*2)) + scrTiles.Position,x div (16*2),(y mod (32 * 2)) div (16*2));
      DrawLevelData();
    end
    else if Button = mbLeft then
    begin
      if ssShift in Shift then
      begin

      end
      else
      begin
        _ROMData.EditTSA((y div (32*2)) + scrTiles.Position,x div 16,(y mod (32*2)) div 16,_CurTSABlock);
//        ROMData.EditTSA((y div (32*2)) + scrTiles.Position,x div (16*2),(y mod (32*2)) div (16*2),_CurTSABlock);
        DrawLevelData();
        end;

    end;
  end;

  UpdateTitleCaption;

  DrawTileSelector();
end;

procedure TfrmEditorMain.actPreferencesExecute(Sender: TObject);
var
  Pref : TfrmPreferences;
begin
  Pref := TfrmPreferences.Create(self, _ROMData,_EditorConfig);
  try

    if Pref.ShowModal = mrOk then
    begin
      _EditorConfig.Save;
      SetEmuMenuText();
      if _ROMData <> nil then
      begin
        _ROMData.LoadPaletteFile(_EditorConfig.FullPaletteName);
        _ROMData.RefreshOnScreenTiles(scrTiles.Position);
        SetIconTransparency;
        DrawLevelData();
        DrawTileSelector();
        actEnableGridlines.Checked := _EditorConfig.GridlinesOn;
      end;
    end;
  finally
    FreeAndNil(Pref);
  end;
end;

procedure TfrmEditorMain.LoadROM(pFilename,pDataFile : String;pAutoCheck : Boolean);
var
  TempFilename : String;
begin
  // If the ROM file does not exist then exit the subroutine.
  if FileExists(pFilename) = False then
    exit;
  // Transfer the datafile's filename over to another variable.
  TempFilename := pDataFile;
  // If the user wants to automatically check the ROM type then
  // check it. If there is no matches, reset the TempFileName variable
  // back to pDataFile (Usually the default datafile).
  if pAutoCheck = True then
  begin
    TempFilename := AutoCheckROMType(pFilename);
    if TempFilename = '' then
      TempFilename := pDataFile
    else
      TempFilename := ExtractFileDir(Application.ExeName) + '\Data\' + TempFilename;
  end;

  // If the datafile does not exist, then exit the subroutine.
  if FileExists(TempFileName) = False then
    exit;

  // First check if the ROM is already loaded.
  if assigned(_ROMData) = True then
  begin
    FreeAndNil(_ROMData);
  end;
  _EditorConfig.AddRecentFile(pFilename);

  CreateRecentMenu();
  _ROMData := TTMNTROM.Create(pFilename, TempFilename, ExtractFileDir(Application.ExeName) + '\Data');
  if _ROMData.IsValidROM = false then
  begin
    // If the user elects to not load the ROM, then
    // display a prompt informing the user that the ROM will
    // not be loaded, free the ROM, and exit the subroutine.
    if _EditorConfig.MapperWarnings = 0 then
    begin
        Messagebox(handle,PChar(RES_NOTVALIDROM),PChar(Application.Title),0);
        FreeAndNil(_ROMData);
        exit;
    end
    // If the user has elected to be prompted about the
    // ROM not conforming to the standard Mega Man settings
    // tell the user, and give them the choice of whether or not to load it.
    else if _EditorConfig.MapperWarnings = 1 then
    begin

      if MessageBox(Handle,PChar(RES_NOTVALIDROMCONTINUE),
            PChar(Application.Title),MB_YESNO) = IDNO	then
      begin
        FreeAndNil(_ROMData);
        exit;
      end;
    end;

  end;
  // If the palette specified exists, then load it.
  if FileExists(_EditorConfig.FullPaletteName) = True then
    _ROMData.LoadPaletteFile(_EditorConfig.FullPaletteName)
  else
    _ROMData.LoadDefaultPalette;
  _ROMData.CurrentLevel := 0;
  StatusBar.Panels[2].Text := ExtractFileName(_ROMData.DataFile);
  SetVisibleStatus(True);
  actSetMapEditingMode.Execute;
  SetIconTransparency;
  SetEmuMenuText();
  SetupLevel;
  UpdateTitleCaption();
  _CurTSABlock := -1;
{  TestSettings.NTPointer := $1E3E0;
  TestSettings.StartOffset := $7d0d;
  TestSettings.NameTableAddress := $2000;
  TestSettings.Bank := 1;
  TestNameTable := TNameTable.Create(TestSettings);
  TestNameTable.DumpDecompressedData(ExtractFileDir(Application.ExeName) + '\dump.bin');
  FreeAndNil(TestNameTable);}
//  ShowMessage(IntToStr(ROMData.CalculateTotalEnemies));
end;

procedure TfrmEditorMain.SetupLevel();
begin
  if _ROMData.CurrLevel.Properties['WorldLevelDataPointer'] = nil then
    actWorldMapEditor.Enabled := False
  else
    actWorldMapEditor.Enabled := True;

  SetTileScrMax;
  //  scrTiles.Position := ROMData.CurrLevel.StartTSAAt;
  scrLevel.Position := 0;
  scrLevelV.Position := 0;
  scrTiles.Position := 0;
  DrawLevelData();
  DrawTileSelector();

  DisplayScreenInfo;
  SetLevelScrMax;

  UpdateTitleCaption();
end;

procedure TfrmEditorMain.CreateRecentMenu();
var
  Bitmap : TBitmap;
begin
  if _EditorConfig.NumberOfRecentlyOpenedFiles = 0 then
    mnuRecent.Visible := False
  else
    mnuRecent.Visible := True;

  if _EditorConfig.RecentFile[0] = '' then
    mnuRecentItem1.Visible := False
  else
    mnuRecentItem1.Visible := True;

  if _EditorConfig.RecentFile[1] = '' then
    mnuRecentItem2.Visible := False
  else
    mnuRecentItem2.Visible := True;

  if _EditorConfig.RecentFile[2] = '' then
    mnuRecentItem3.Visible := False
  else
    mnuRecentItem3.Visible := True;
  if _EditorConfig.RecentFile[3] = '' then
    mnuRecentItem4.Visible := False
  else
    mnuRecentItem4.Visible := True;
  if _EditorConfig.RecentFile[4] = '' then
    mnuRecentItem5.Visible := False
  else
    mnuRecentItem5.Visible := True;

  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := 500;
    Bitmap.Height :=  40;
    mnuRecentItem1.Caption := MinimizeName(_EditorConfig.RecentFile[0],Bitmap.Canvas,500);
    mnuRecentItem2.Caption := MinimizeName(_EditorConfig.RecentFile[1],Bitmap.Canvas,500);
    mnuRecentItem3.Caption := MinimizeName(_EditorConfig.RecentFile[2],Bitmap.Canvas,500);
    mnuRecentItem4.Caption := MinimizeName(_EditorConfig.RecentFile[3],Bitmap.Canvas,500);
    mnuRecentItem5.Caption := MinimizeName(_EditorConfig.RecentFile[4],Bitmap.Canvas,500);
  finally
    FreeAndNil(Bitmap);
  end;

end;

procedure TfrmEditorMain.mnuRecentItem1Click(Sender: TObject);
begin
  LoadROM(_EditorConfig.RecentFile[TMenuItem(sender).MenuIndex],_EditorConfig.FullDataFileName, _EditorConfig.AutoCheck);
end;

procedure TfrmEditorMain.SetEmuMenuText();
begin
  if (_EditorConfig.EmulatorPath <> '') and (FileExists(_EditorConfig.EmulatorPath) = True) then
  begin
    mnuLaunchAssociatedEmulator.Caption := RES_LAUNCHEMU + ExtractFileName(_EditorConfig.EmulatorPath);
    mnuLaunchAssociatedEmulator.Enabled := True;
  end
  else
  begin
    mnuLaunchAssociatedEmulator.Caption := RES_NOEMUASSOC;
    mnuLaunchAssociatedEmulator.Enabled := False;
  end;
  LoadEmulatorIcon;
  if Assigned(_ROMData) = False then
    mnuLaunchAssociatedEmulator.Enabled := False;
end;

procedure TfrmEditorMain.BackupFile();
begin
  if DirectoryExists(ExtractFileDir(Application.Exename)+'\Backups') = false then
  begin
    CreateDir(ExtractFileDir(Application.Exename)+'\Backups');
  end;

  AbZipper.FileName := ExtractFileDir(Application.Exename)+'\Backups\TMNT ' + formatdatetime('dd-mm-yyyy hh-nn-ss',now) + '.zip';
  AbZipper.AddFiles(_ROMData.Filename,0);
  AbZipper.ZipfileComment := RES_ZIPCREATEDON + DateTimeToStr(Now);
end;

procedure TfrmEditorMain.actSaveROMExecute(Sender: TObject);
begin
  if _EditorConfig.BackupFilesWhenSaving = True then
    BackupFile();
  if Assigned(_ROMData) then
  begin
    if _ROMData.Save = True then
      messagebox(Handle,PChar(RES_CHANGESSAVED),PChar(APPLICATIONTITLE),0)
    else
      messagebox(Handle,PChar(RES_CHANGESAVEFAIL),PChar(APPLICATIONTITLE),0);
    
    UpdateTitleCaption();
  end;

end;

procedure TfrmEditorMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if assigned(_ROMData) = True then
  begin
    if ssShift in Shift then
    begin
      if Key = VK_PRIOR	then
      begin
{        if ROMData.CurrentSideScroll = ROMData.CurrLevel.SideScroll.Count - 1 then
          ROMData.CurrentSideScroll := 0
        else
          ROMData.CurrentSideScroll := ROMData.CurrentSideScroll + 1;}
        scrLevel.Position := 0;
        scrLevelV.Position := 0;
        if (_ROMData.CurrentSideScroll = _ROMData.CurrLevel.SideScroll.Count -1) then
          _ROMData.CurrentSideScroll := 0
        else
          _ROMData.CurrentSideScroll := _ROMData.CurrentSideScroll + 1;
      end
      else if Key = VK_NEXT	then
      begin
        scrLevel.Position := 0;
        scrLevelV.Position := 0;
        if _ROMData.CurrentSideScroll = 0 then
          _ROMData.CurrentSideScroll := _ROMData.CurrLevel.SideScroll.Count -1
        else
            _ROMData.CurrentSideScroll  := _ROMData.CurrentSideScroll - 1;
      end
      else
        exit;
    end
    else
    begin

      if Key = VK_PRIOR	then
      begin
        scrLevel.Position := 0;
        scrLevelV.Position := 0;
        if _ROMData.CurrentLevel = _ROMData.Levels.Count - 1 then
          _ROMData.CurrentLevel := 0
        else
          _ROMData.CurrentLevel := _ROMData.CurrentLevel + 1;
      end
      else if Key = VK_NEXT	then
      begin
        scrLevel.Position := 0;
        scrLevelV.Position := 0;
        if _ROMData.CurrentLevel = 0 then
          _ROMData.CurrentLevel := _ROMData.Levels.Count - 1
        else
          _ROMData.CurrentLevel  := _ROMData.CurrentLevel - 1;
      end
      else
        exit;
    end;

    SetupLevel;
    if CurTSABlock > -1 then
      TfrmTSA(TSA).DrawPatternTable;
  end;
end;

procedure TfrmEditorMain.scrLevelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_PRIOR) or (Key = VK_NEXT) then
    Key := 0;
end;

procedure TfrmEditorMain.actObjectEditingModeExecute(Sender: TObject);
begin
  actObjectEditingMode.Checked := True;
  actSetMapEditingMode.Checked := False;
  // Set the toolbar buttons
  tlbMapEditingMode.Down := actSetMapEditingMode.Checked;
  tlbObjectEditingMode.Down := actObjectEditingMode.Checked;
  _EditingMode := OBJECTEDITINGMODE;
  Statusbar.Panels[0].Text := RES_OBJEDIT;
end;

procedure TfrmEditorMain.actSetMapEditingModeExecute(Sender: TObject);
begin
  actObjectEditingMode.Checked := False;
  actSetMapEditingMode.Checked := True;
  // Set the toolbar buttons
  tlbMapEditingMode.Down := actSetMapEditingMode.Checked;
  tlbObjectEditingMode.Down := actObjectEditingMode.Checked;
  _EditingMode := MAPEDITINGMODE;
  Statusbar.Panels[0].Text := RES_MAPEDIT;
end;

procedure TfrmEditorMain.ExecuteEmulator;
begin
  if Assigned(_ROMData) = False then
  begin
    messagebox(handle,PChar(RES_LOADROMFIRST),PChar(Application.Title),0);
    exit;
  end;

  if (FileExists(_EditorConfig.EmulatorPath) = false) or (_EditorConfig.EmulatorPath = '') then
  begin
    messagebox(handle,PChar(RES_NOEMUASSOCIATED),PChar(Application.Title),0);
    exit;
  end;

  if _EditorConfig.EmulatorDisplaySaveWarning = true then
    if MessageDlg(RES_WARNINGWILLSAVE + CRLF + CRLF + RES_WARNINGDISABLED,mtWarning,[mbYes, mbNo],0) = mrNo then
      exit;

  _ROMData.Save;
  if _EditorConfig.EmulatorFileSettings = 0 then
    ShellExecute(Handle,'open',PChar(_EditorConfig.EmulatorPath),PChar(' ' + _ROMData.Filename),'',SW_SHOW)
  else if _EditorConfig.EmulatorFileSettings = 1 then
    ShellExecute(Handle,'open',PChar(_EditorConfig.EmulatorPath),PChar(' ' + ExtractShortPathName(_ROMData.Filename)),'',SW_SHOW)
  else if _EditorConfig.EmulatorFileSettings = 2 then
    ShellExecute(Handle,'open',PChar(_EditorConfig.EmulatorPath),PChar(' "' + _ROMData.Filename + '"'),'',SW_SHOW);
end;

procedure TfrmEditorMain.mnuLaunchAssociatedEmulatorClick(
  Sender: TObject);
begin
  ExecuteEmulator();
  UpdateTitleCaption;
end;

procedure TfrmEditorMain.UpdateTitleCaption;
var
  AppTitleBarText : String;
begin
  if Assigned(_ROMData) = True then
  begin
    AppTitleBarText := APPLICATIONTITLE + ' - [' + ExtractFilename(_ROMData.Filename) + ']';
    if _ROMData.Changed = True then
      Caption := AppTitleBarText + ' *'
    else
      Caption := AppTitleBarText;
  end
  else
  begin
    Caption := APPLICATIONTITLE;
  end;
end;

procedure TfrmEditorMain.ClearImageIndex;
begin
  mnuMapEditingMode.ImageIndex := -1;
  mnuObjectEditingMode.ImageIndex := -1;
  mnuGridlines.ImageIndex := -1;
end;

procedure TfrmEditorMain.JvDropTargetDragDrop(Sender: TJvDropTarget;
  var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
var
  Files : TStringList;
begin
  Files := TStringList.Create;
  try
    sender.GetFilenames(Files);
    LoadROM(Files[0],_EditorConfig.FullDataFileName,_EditorConfig.AutoCheck);
  finally
    FreeAndNil(Files);
  end;

end;

procedure TfrmEditorMain.actTSAEditorExecute(Sender: TObject);
begin
  if CurTSABlock = -1 then
    TSA := TfrmTSA.Create(self, _ROMData, _EditorConfig);

  TSA.Show;
  DrawTileSelector();
end;

procedure TfrmEditorMain.actCloseROMExecute(Sender: TObject);
begin

  CloseROM(false);
end;

procedure TfrmEditorMain.imgScreenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
  TempX, TempY : Integer;
begin

  if _EditingMode = OBJECTEDITINGMODE then
  begin
    if (_Obj.ObjIndex > -1) then
    begin
      if (_Obj.ObjType = OBJENEMY) and (mnuEnemies.Checked = true) then
      begin
        if ssLeft in Shift then
        begin

          if (X >= imgScreen.Width) or (X < 0) then exit;
          if (Y >= imgScreen.Height) or (Y < 0) then exit;

          if ssCtrl in Shift then
          begin
            TempX := X div 2;
            TempY := Y div 2;
          end
          else
          begin
            TempX := (X div 2) and $F8;
            TempY := (Y div 2) and $FE;
          end;

          if _ROMData.CurrSideScroll.Enemies[_Obj.ObjIndex].X  <> TempX then
          begin
            _ROMData.CurrSideScroll.Enemies[_Obj.ObjIndex].X := TempX;
            _ROMData.Changed := True;
          end;
          if _ROMData.CurrSideScroll.Enemies[_Obj.ObjIndex].Y <> TempY then
          begin
            _ROMData.CurrSideScroll.Enemies[_Obj.ObjIndex].Y := TempY;
            _ROMData.Changed := True;
          end;

          DrawLevelData;
          UpdateTitleCaption;

        end;
      end
      else if (_Obj.ObjType = OBJSPECIAL) and (mnuObjects.Checked = True) then
      begin
        if ssLeft in Shift then
        begin
          if (X >= imgScreen.Width) or (X < 0) then exit;
          if (Y >= imgScreen.Height) or (Y < 0) then exit;

          if ssCtrl in Shift then
          begin
            TempX := X div 2;
            TempY := Y div 2;
          end
          else
          begin
            TempX := (X div 2) and $F8;
            TempY := (Y div 2) and $FE;
          end;

          if _ROMData.CurrSideScroll.SpecialObjects[_Obj.ObjIndex].X  <> TempX then
          begin
            _ROMData.CurrSideScroll.SpecialObjects[_Obj.ObjIndex].X := TempX;
            _ROMData.Changed := True;
          end;

          if _ROMData.CurrSideScroll.SpecialObjects[_Obj.ObjIndex].Y <> TempY then
          begin
            _ROMData.CurrSideScroll.SpecialObjects[_Obj.ObjIndex].Y := TempY;
            _ROMData.Changed := True;
          end;

          DrawLevelData;
          UpdateTitleCaption;

        end;
      end
      else if (_Obj.ObjType = uConsts.OBJENTRANCE) and (mnuEntrances.Checked = True) then
      begin
        if ssLeft in Shift then
        begin
          if (X >= imgScreen.Width) or (X < 0) then exit;
          if (Y >= imgScreen.Height) or (Y < 0) then exit;

          if ssCtrl in Shift then
          begin
            TempX := X div 2;
            TempY := Y div 2;
          end
          else
          begin
            TempX := (X div 2) and $F8;
            TempY := (Y div 2) and $FE;
          end;

          if _ROMData.CurrLevel.Entrances[_Obj.ObjIndex].DestX  <> TempX then
          begin
            _ROMData.CurrLevel.Entrances[_Obj.ObjIndex].DestX := TempX;
            _ROMData.Changed := True;
          end;

          if _ROMData.CurrLevel.Entrances[_Obj.ObjIndex].DestY <> TempY then
          begin
            _ROMData.CurrLevel.Entrances[_Obj.ObjIndex].DestY := TempY;
            _ROMData.Changed := True;
          end;

          DrawLevelData;
          UpdateTitleCaption;

        end;
      end
      else if (_Obj.ObjType = uConsts.OBJBOSS) and (mnuBossData.Checked = True) then
      begin
        if ssLeft in Shift then
        begin
          if (X >= imgScreen.Width) or (X < 0) then exit;
          if (Y >= imgScreen.Height) or (Y < 0) then exit;

          if ssCtrl in Shift then
          begin
            TempX := X div 2;
            TempY := Y div 2;
          end
          else
          begin
            TempX := (X div 2) and $F8;
            TempY := (Y div 2) and $FE;
          end;

          if _ROMData.CurrSideScroll.Boss[_Obj.ObjIndex].X  <> TempX then
          begin
            _ROMData.CurrSideScroll.Boss[_Obj.ObjIndex].X := TempX;
            _ROMData.Changed := True;
          end;

          if _ROMData.CurrSideScroll.Boss[_Obj.ObjIndex].Y <> TempY then
          begin
            _ROMData.CurrSideScroll.Boss[_Obj.ObjIndex].Y := TempY;
            _ROMData.Changed := True;
          end;

          DrawLevelData;
          UpdateTitleCaption;

        end;
      end;

    end;
  end
  else if _EditingMode = MAPEDITINGMODE then
  begin
    if ssLeft in Shift  then
    begin
      if ssShift in Shift then
        _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32] := _CurTileMid
      else
        _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32] := _CurTileLeft;

      DrawLevelData();
    end
    else if ssRight in Shift then
    begin
      if ssShift in Shift then
        _CurTileMid := _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32]
      else
        _CurTileLeft := _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32];
    end
    else if ssMiddle in Shift then
    begin
      if ssShift in Shift then
        _CurTileMid := _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32]
      else
        _ROMData.RoomData[(x div 2) div 32,(y div 2) div 32] := _CurTileMid;

      DrawLevelData();
    end;

    
  end;

end;

procedure TfrmEditorMain.imgScreenMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if _EditingMode  = MAPEDITINGMODE then
  begin
    UpdateTitleCaption;
  end
  else if _EditingMode = OBJECTEDITINGMODE then
  begin
    _Obj.ObjIndex := -1;
    _Obj.ObjType := -1;
    UpdateTitleCaption;
  end;
end;

procedure TfrmEditorMain.actKeyboardLayoutExecute(Sender: TObject);
var
  KeyboardLayout : TfrmKeyboardLayout;
begin
  KeyboardLayout := TfrmKeyboardLayout.Create(self);
  try
    JvDropTarget.AcceptDrag := False;
    KeyboardLayout.ShowModal;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(KeyboardLayout);
  end;

end;

procedure TfrmEditorMain.mnuVisitRockAndRollHomepageClick(
  Sender: TObject);
begin
  ShellExecute(GetDesktopWindow(), 'open', PChar('http://dan.panicus.org'), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmEditorMain.RedrawScreen;
begin
  _ROMData.RefreshOnScreenTiles(scrTiles.Position);
  DrawLevelData();
  DrawTileSelector();
  if CurTSABlock > -1 then
    TfrmTSA(TSA).DrawPatternTable;
end;

procedure TfrmEditorMain.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmEditorMain.actGoToLevelExecute(Sender: TObject);
var
  GoToLevel : TfrmGotoLevel;
begin
  GotoLevel := TfrmGotoLevel.Create(self, _ROMData);
  try
    JvDropTarget.AcceptDrag := False;
    if GotoLevel.ShowModal = mrOk then
    begin
      if GotoLevel.Level <> _ROMData.CurrentLevel then
      begin
        _ROMData.CurrentSideScroll := GotoLevel.Level;
        SetupLevel();
        if CurTSABlock > -1 then
          TfrmTSA(TSA).DrawPatternTable;
      end;

    end;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(GotoLevel);
  end;
end;

procedure TfrmEditorMain.actDebugExecute(Sender: TObject);
var
  frmDebug : TfrmDebug;
begin
  frmDebug := TfrmDebug.Create(self,_ROMData);
  try
    frmDebug.ShowModal;
  finally
    FreeAndNil(frmDebug);
  end;
end;

procedure TfrmEditorMain.actDebugROMViewerExecute(Sender: TObject);
var
  DebugROM : TfrmDebugROMViewer;
begin
  DebugROM := TfrmDebugROMViewer.Create(self);
  try
    JvDropTarget.AcceptDrag := False;
    DebugROM.ShowModal;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(DebugROM);
  end;
end;

procedure TfrmEditorMain.mnuEnemiesClick(Sender: TObject);
begin
  DrawLevelData();
end;

procedure TfrmEditorMain.actBackupManagerExecute(Sender: TObject);
var
  Backup : TfrmBackupManagement;
begin
  Backup := TfrmBackupManagement.Create(self);
  try
    JvDropTarget.AcceptDrag := False;
    Backup.ShowModal;
    JvDropTarget.AcceptDrag := True;    
  finally
    FreeAndNil(Backup);
  end;
end;

procedure TfrmEditorMain.actPropertiesExecute(Sender: TObject);
var
  Prop : TfrmFileProperties;
begin
  Prop := TfrmFileProperties.Create(self, _ROMData);
  try
    JvDropTarget.AcceptDrag := False;
    Prop.ShowModal;
    JvDropTarget.AcceptDrag := True;
    UpdateTitleCaption;
  finally
    FreeAndNil(Prop);
  end;
end;

procedure TfrmEditorMain.actEnableGridlinesExecute(Sender: TObject);
begin
  _EditorConfig.GridlinesOn := not(_EditorConfig.GridlinesOn);
  tlbEnableGridlines.Down := _EditorConfig.GridlinesOn;
  mnuGridlines.Checked := _EditorConfig.GridlinesOn;
  DrawLevelData();
end;

function TfrmEditorMain.AutoCheckROMType(pFilename : String) : String;
var
  DataFiles : TStringList;
  INI : TMemINIHexFile;
  i : Integer;
  Loc : Integer;
  Auto1,Auto2,Auto3,Auto4 : Byte;
  TempROM : TiNESImage;
begin
  result := '';
  DataFiles := TStringList.Create;
  try
    DataFiles.LoadFromFile(ExtractFileDir(Application.ExeName) + '\Data\data.dat');

    for i := 0 to DataFiles.Count -1 do
    begin
      INI := TMemINIHexFile.Create(ExtractFileDir(Application.ExeName) + '\Data\' + DataFiles[i]);
      try
        Loc := INI.ReadHexValue('AutoCheck','Location');
        Auto1 := INI.ReadHexValue('AutoCheck','Auto1');
        Auto2 := INI.ReadHexValue('AutoCheck','Auto2');
        Auto3 := INI.ReadHexValue('AutoCheck','Auto3');
        Auto4 := INI.ReadHexValue('AutoCheck','Auto4');
        TempROM := TiNESImage.Create(pFilename);
        if TempROM.ROM[Loc] = Auto1 then
          if TempROM.ROM[Loc+1] = Auto2 then
            if TempROM.ROM[Loc+2] = Auto3 then
              if TempROM.ROM[Loc+3] = Auto4 then
              begin
                result := DataFiles[i];
                break;
              end;
      finally
        FreeAndNil(TempROM);
        FreeAndNil(INI);
      end;
    end;
  finally
    FreeAndNil(DataFiles);
  end;

end;

procedure TfrmEditorMain.LoadEmulatorIcon;
var
  Icon : TIcon;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  IconIndex : word;
begin
  if FileExists(_EditorConfig.EmulatorPath) = True then
  begin

    //get the associated icon for this file
    StrCopy(@Buffer, pchar(_EditorConfig.EmulatorPath));
    IconIndex := 0;
    IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);

    begin

      //now that we have an icon, add it to the image list.
      Icon := TIcon.Create;
      try
        Icon.Handle := IconHandle;
        mnuLaunchAssociatedEmulator.ImageIndex := ImageList.AddIcon(Icon);
      finally
        FreeAndNil(Icon);
      end;

    end;
  end
  else
  begin
    // Insert the number of the default NES emulator icon here.
    mnuLaunchAssociatedEmulator.ImageIndex := 7;
  end;

end;

procedure TfrmEditorMain.scrLevelVChange(Sender: TObject);
begin
  _ROMData.Room := CalculateRoomNo;
  DrawLevelData();
  DisplayScreenInfo;
  UpdateTitleCaption();
end;

function TfrmEditorMain.CalculateRoomNo : Integer;
begin
  result := ((scrLevelV.Position) * (scrLevel.Max + 1)) + scrLevel.Position;
end;

procedure TfrmEditorMain.SynchronizeRoomScrollbars;
begin
  scrLevel.Position := (_ROMData.Room mod _ROMData.CurrSideScroll.Width);
  scrLevelV.Position := (_ROMData.Room div _ROMData.CurrSideScroll.Height);
end;

procedure TfrmEditorMain.actLevelSettingsExecute(Sender: TObject);
var
  LevSettings : TfrmLevelSettings;
begin
  LevSettings := TfrmLevelSettings.Create(self, _ROMData);
  try
    JvDropTarget.AcceptDrag := False;
    if LevSettings.ShowModal = mrOk then
    begin

      if _ROMData.CurrSideScroll.PatternTableBGSetting <> LevSettings.scrBGSetting.Position then
      begin
        _ROMData.SavePatternTable;
        _ROMData.CurrSideScroll.PatternTableBGSetting := LevSettings.scrBGSetting.Position;
        _ROMData.LoadPatternTable;
      end;

      RedrawScreen;

      UpdateTitleCaption;
    end;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(LevSettings);
  end;
end;

procedure TfrmEditorMain.mnuEnemyViewDefaultClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := True;
  _EnemyView := TMenuItem(Sender).Tag;
  DrawLevelData;
end;

procedure TfrmEditorMain.actDistributeExecute(Sender: TObject);
var
  Distrib : TfrmDistribution;
begin
  Distrib := TfrmDistribution.Create(self, _ROMData,_EditorConfig);
  try
    if Distrib.ShowModal = mrOk then
      UpdateTitleCaption;

  finally
    FreeAndNil(Distrib);
  end;
end;

procedure TfrmEditorMain.actLevelMapExecute(Sender: TObject);
var
  LevelMap : TfrmLevelMap;
begin
  LevelMap := TfrmLevelMap.Create(self, _ROMData);
  try
    LevelMap.ShowModal;
  finally
    FreeAndNil(LevelMap);
  end;
end;

procedure TfrmEditorMain.actAddEnemyExecute(Sender: TObject);
begin
  if _ROMData.AddEnemy = False then
  begin
    showmessage(RES_ENEMYLIMITREACHED);
  end
  else
  begin
    DrawLevelData();
    UpdateTitleCaption;
  end;
end;

procedure TfrmEditorMain.scrTilesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_PRIOR) or (key = VK_NEXT) then key := 0;
end;

procedure TfrmEditorMain.actPaletteEditorExecute(Sender: TObject);
var
  Pal : TfrmPaletteEditor;
begin
  Pal := TfrmPaletteEditor.Create(self, _ROMData);
  try
    JvDropTarget.AcceptDrag := False;
    if Pal.ShowModal = mrOk then
    begin
      _ROMData.CurrSideScroll.PaletteSetting := Pal.cbPaletteIndex.ItemIndex;
      _ROMData.SaveBGPalette;
    end
    else
    begin
      if Pal.Change = True then
      begin
        _ROMData.LoadBGPalette;
        RedrawScreen;
      end;
    end;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(Pal);
  end;

end;

procedure TfrmEditorMain.actSolidityEditorExecute(Sender: TObject);
var
  Solid : TfrmSolidityEditor;
begin
  Solid := TfrmSolidityEditor.Create(self, _ROMData, _EditorConfig);
  try
    JvDropTarget.AcceptDrag := False;
    if Solid.ShowModal = mrok then
      UpdateTitleCaption;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(Solid);
  end;
end;

procedure TfrmEditorMain.actWorldMapEditorExecute(Sender: TObject);
var
  WorldMap : TfrmWorldMapEditor;
begin
  WorldMap := TfrmWorldMapEditor.Create(self, _ROMData,_EditorConfig);
  try
    JvDropTarget.AcceptDrag := False;
    if _CurTSABlock > -1 then
    begin
      FreeAndNil(TSA);
      _CurTSABlock := -1;
    end;
    WorldMap.ShowModal;
    UpdateTitleCaption;
    JvDropTarget.AcceptDrag := True;
  finally
    FreeAndNil(WorldMap);
  end;
end;

procedure TfrmEditorMain.actScrollEditorExecute(Sender: TObject);
var
  ScrEd : TfrmScrollEditor;
begin
  ScrEd := TfrmScrollEditor.Create(self, _ROMData);
  try
    ScrEd.ShowModal;
  finally
    FreeAndNil(ScrEd);
  end;
end;

procedure TfrmEditorMain.actWorldScreenCountExecute(Sender: TObject);
var
  CountEd : TfrmWorldScreenCount;
begin
  CountEd := TfrmWorldScreenCount.Create(self, _ROMData);
  try
    CountEd.ShowModal;
  finally
    FreeAndNil(CountEd);
  end;
end;

procedure TfrmEditorMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  resize := False;
end;

end.
