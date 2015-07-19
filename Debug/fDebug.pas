unit fDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, cROMData;

type
  TfrmDebug = class(TForm)
    btnOK: TButton;
    pgcDebug: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    lvwBoss: TListView;
    btnCSVBoss: TButton;
    SaveDialog: TSaveDialog;
    lvwEntrances: TListView;
    btnEntranceCSV: TButton;
    btnEnemyCSV: TButton;
    lvwEnemy: TListView;
    TabSheet8: TTabSheet;
    lvwWorldMapEnemy: TListView;
    btnWorldMapEnemyCSV: TButton;
    lvwSpecialObj: TListView;
    btnCRC: TButton;
    procedure btnCSVBossClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEnemyCSVClick(Sender: TObject);
    procedure btnWorldMapEnemyCSVClick(Sender: TObject);
    procedure btnEntranceCSVClick(Sender: TObject);
    procedure btnCRCClick(Sender: TObject);
  private
    _ROMData : TTMNTROM;
    procedure LoadBossData;
    procedure LoadEnemyData;
    procedure LoadSpecialObjects;
    procedure LoadExits;
    procedure LoadEntrances;
    procedure LoadWorldMapEnemyData;
    { Private declarations }
  public
      constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    { Public declarations }
  end;

var
  frmDebug: TfrmDebug;

implementation

{$R *.dfm}

uses utilCommon;

{ TfrmDebug }

procedure TfrmDebug.btnCRCClick(Sender: TObject);
begin
  MessageDlg(IntToHex(_ROMData.CalculateCRCArea(_ROMData.ExitSpaceStart, _ROMData.ExitSpaceEnd),6), mtInformation, [mbOK], 0);
end;

procedure TfrmDebug.btnCSVBossClick(Sender: TObject);
var
  str : TStringList;
begin
  str := TStringList.Create;
  try
    if SaveDialog.Execute(self.Handle) then
    begin
      utilCommon.ListViewToCSV(lvwBoss,str,SaveDialog.Filename);
    end;
  finally
    FreeAndNil(str);
  end;
end;

procedure TfrmDebug.LoadBossData;
var
  i,x,z : Integer;
begin
  lvwBoss.Items.BeginUpdate;
  // Loop through every level, and every side stage within each level,
  // then add items to
  for i := 0 to _ROMData.Levels.Count-1 do
  begin
    for x:= 0 to _ROMData.Levels[i].SideScroll.Count-1 do
    begin
      if _ROMData.Levels[i].SideScroll[x].Boss.Count > 0 then
      begin
        for z := 0 to _ROMData.Levels[i].SideScroll[x].Boss.Count - 1 do
        begin
          with lvwBoss.Items.Add do
          begin
            Caption := IntToStr(i);
            SubItems.Add(IntToStr(x));
            SubItems.Add(IntToStr(z));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].Offset,5));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].ScreenY,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].ScreenX,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].X,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].Y,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].ID,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].SpriteID,2));
            if _ROMData.Levels[i].SideScroll[x].Boss[z].WorldBoss = true then
              SubItems.Add('Yes')
            else
              SubItems.Add('No');
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Boss[z].WorldBossIndex,2));
          end;
        end;
      end;
    end;
  end;
  lvwBoss.Items.EndUpdate;
end;

procedure TfrmDebug.LoadEnemyData;
var
  i,x,z : Integer;
begin
  lvwEnemy.Items.BeginUpdate;
  // Loop through every level, and every side stage within each level,
  // then add items to
  for i := 0 to _ROMData.Levels.Count-1 do
  begin
    for x:= 0 to _ROMData.Levels[i].SideScroll.Count-1 do
    begin
      if _ROMData.Levels[i].SideScroll[x].Enemies.Count > 0 then
      begin
        for z := 0 to _ROMData.Levels[i].SideScroll[x].Enemies.Count - 1 do
        begin
          with lvwEnemy.Items.Add do
          begin
            Caption := IntToStr(i);
            SubItems.Add(IntToStr(x));
            SubItems.Add(IntToStr(z));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Enemies[z].Offset,5));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Enemies[z].ScreenID,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Enemies[z].X,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Enemies[z].Y,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Enemies[z].ID,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Enemies[z].SpriteID,2));
          end;
        end;
      end;
    end;
  end;
  lvwEnemy.Items.EndUpdate;
end;

procedure TfrmDebug.LoadEntrances;
begin
end;

procedure TfrmDebug.LoadExits;
var
  i,x,z : Integer;
begin
  lvwEntrances.Items.BeginUpdate;
  for i := 0 to _ROMData.Levels.Count-1 do
  begin
    for x:= 0 to _ROMData.Levels[i].SideScroll.Count-1 do
    begin
      if _ROMData.Levels[i].SideScroll[x].Exits.Count > 0 then
      begin
        for z := 0 to _ROMData.Levels[i].SideScroll[x].Exits.Count - 1 do
        begin
          with lvwEntrances.Items.Add do
          begin
            Caption := IntToStr(i);
            SubItems.Add(IntToStr(x));
            SubItems.Add(IntToStr(z));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].Offset,5));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].SourceScreen,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].SourceX,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].SourceY,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].EntranceToLevel,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestID,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestX,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestY,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestScreenX1,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestScreenX2,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestScreenY1,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].Exits[z].DestScreenY2,2));
          end;
        end;
      end;
    end;
  end;

  for i := 0 to _ROMData.Levels.Count-1 do
  begin

      if _ROMData.Levels[i].Entrances.Count > 0 then
      begin
        for z := 0 to _ROMData.Levels[i].Entrances.Count - 1 do
        begin
          with lvwEntrances.Items.Add do
          begin
            Caption := IntToStr(i);
            SubItems.Add('N/A');
            SubItems.Add(IntToStr(z));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].Offset,5));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].SourceScreen,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].SourceX,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].SourceY,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].EntranceToLevel,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestID,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestX,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestY,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestScreenX1,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestScreenX2,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestScreenY1,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].Entrances[z].DestScreenY2,2));
          end;
        end;
      end;
  end;

  lvwEntrances.Items.EndUpdate;
end;

procedure TfrmDebug.LoadSpecialObjects;
var
  i,x,z : Integer;
begin
  lvwSpecialObj.Items.BeginUpdate;
  // Loop through every level, and every side stage within each level,
  // then add items to
  for i := 0 to _ROMData.Levels.Count-1 do
  begin
    for x:= 0 to _ROMData.Levels[i].SideScroll.Count-1 do
    begin
      if _ROMData.Levels[i].SideScroll[x].SpecialObjects.Count > 0 then
      begin
        for z := 0 to _ROMData.Levels[i].SideScroll[x].SpecialObjects.Count - 1 do
        begin
          with lvwSpecialObj.Items.Add do
          begin
            Caption := IntToStr(i);
            SubItems.Add(IntToStr(x));
            SubItems.Add(IntToStr(z));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].Offset,5));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].ScreenID,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].X,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].Y,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].UnknownX,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].UnknownY,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].Unknown1,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].Unknown2,2));
            SubItems.Add(IntToHex(_ROMData.Levels[i].SideScroll[x].SpecialObjects[z].ID,2));

          end;
        end;
      end;
    end;
  end;
  lvwSpecialObj.Items.EndUpdate;
end;

procedure TfrmDebug.LoadWorldMapEnemyData;
var
  i,z : Integer;
begin
  lvwWorldMapEnemy.Items.BeginUpdate;
  // Loop through every level, and every side stage within each level,
  // then add items to
  for i := 0 to _ROMData.Levels.Count-1 do
  begin
    if _ROMData.Levels[i].NoWorldMap = false then
    begin
      for z := 0 to _ROMData.Levels[i].Enemies.Count - 1 do
      begin
        with lvwWorldMapEnemy.Items.Add do
        begin
          Caption := IntToStr(i);
          SubItems.Add(IntToStr(z));
          SubItems.Add(IntToHex(_ROMData.Levels[i].Enemies[z].Offset,5));
          SubItems.Add(IntToHex(_ROMData.Levels[i].Enemies[z].ScreenID,2));
          SubItems.Add(IntToHex(_ROMData.Levels[i].Enemies[z].X,2));
          SubItems.Add(IntToHex(_ROMData.Levels[i].Enemies[z].Y,2));
          SubItems.Add(IntToHex(_ROMData.Levels[i].Enemies[z].ID,2));
          SubItems.Add(IntToHex(_ROMData.Levels[i].Enemies[z].SpriteID,2));
        end;
      end;
    end;
  end;
  lvwWorldMapEnemy.Items.EndUpdate;
end;

procedure TfrmDebug.btnEnemyCSVClick(Sender: TObject);
var
  str : TStringList;
begin
  str := TStringList.Create;
  try
    if SaveDialog.Execute(self.Handle) then
    begin
      utilCommon.ListViewToCSV(lvwEnemy,str,SaveDialog.Filename);
    end;
  finally
    FreeAndNil(str);
  end;
end;

procedure TfrmDebug.btnEntranceCSVClick(Sender: TObject);
var
  str : TStringList;
begin
  str := TStringList.Create;
  try
    if SaveDialog.Execute(self.Handle) then
    begin
      utilCommon.ListViewToCSV(lvwEntrances,str,SaveDialog.Filename);
    end;
  finally
    FreeAndNil(str);
  end;

end;

procedure TfrmDebug.btnWorldMapEnemyCSVClick(Sender: TObject);
var
  str : TStringList;
begin
  str := TStringList.Create;
  try
    if SaveDialog.Execute(self.Handle) then
    begin
      utilCommon.ListViewToCSV(lvwWorldMapEnemy,str,SaveDialog.Filename);
    end;
  finally
    FreeAndNil(str);
  end;

end;

constructor TfrmDebug.Create(AOwner: TComponent; ROMData: TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

procedure TfrmDebug.FormShow(Sender: TObject);
begin
  LoadBossData;
  LoadEnemyData;
  LoadSpecialObjects;
  LoadExits;
  LoadEntrances;
  LoadWorldMapEnemyData;
end;

end.
