program LevelEditor;

uses
  Forms,
  fEditorMain in 'fEditorMain.pas' {frmEditorMain},
  fAbout in 'fAbout.pas' {frmAbout},
  fPreferences in 'fPreferences.pas' {frmPreferences},
  fOpenDialog in 'fOpenDialog.pas' {frmOpenDialog},
  fTSAEditor in 'fTSAEditor.pas' {frmTSA},
  fKeyboardLayouts in 'fKeyboardLayouts.pas' {frmKeyboardLayout},
  fTileEditor in 'fTileEditor.pas' {frm16x16TileEditor},
  fGoToLevel in 'fGoToLevel.pas' {frmGoToLevel},
  fBackupManagement in 'fBackupManagement.pas' {frmBackupManagement},
  fFileProperties in 'fFileProperties.pas' {frmFileProperties},
  fLevelSettings in 'fLevelSettings.pas' {frmLevelSettings},
  fDistribution in 'fDistribution.pas' {frmDistribution},
  fEnemyProperties in 'fEnemyProperties.pas' {frmEnemyProperties},
  fLevelMap in 'fLevelMap.pas' {frmLevelMap},
  fSpecialObjProperties in 'fSpecialObjProperties.pas' {frmSpecialObjProperties},
  fPaletteEditor in 'fPaletteEditor.pas' {frmPaletteEditor},
  fSolidityEditor in 'fSolidityEditor.pas' {frmSolidityEditor},
  fWorldMapEditor in 'fWorldMapEditor.pas' {frmWorldMapEditor},
  uLunarcompress in 'uLunarcompress.pas',
  uResourcestrings in 'uResourcestrings.pas',
  uConsts in 'uConsts.pas',
  fScrollEditor in 'fScrollEditor.pas' {frmScrollEditor},
  fEntranceProperties in 'fEntranceProperties.pas' {frmEntranceProperties},
  fBossProperties in 'fBossProperties.pas' {frmBossProperties},
  fWorldScreenNumbers in 'fWorldScreenNumbers.pas' {frmWorldScreenCount},
  uToday in 'uToday.pas',
  cSpecobj in 'Classes\cSpecobj.pas',
  cBoss in 'Classes\cBoss.pas',
  cConfiguration in 'Classes\cConfiguration.pas',
  cEnemy in 'Classes\cEnemy.pas',
  cEntrance in 'Classes\cEntrance.pas',
  cLevel in 'Classes\cLevel.pas',
  cNameTable in 'Classes\cNameTable.pas',
  cROMdata in 'Classes\cROMdata.pas',
  cSolidity in 'Classes\cSolidity.pas',
  fDebugROMViewer in 'Debug\fDebugROMViewer.pas' {frmDebugROMViewer},
  fDebug in 'Debug\fDebug.pas' {frmDebug},
  cWorldEnemy in 'Classes\cWorldEnemy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cowabunga';
  Application.CreateForm(TfrmEditorMain, frmEditorMain);
  Application.Run;
end.
