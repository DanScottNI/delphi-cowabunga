unit fTSAEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image, GR32, GR32_Layers, ComCtrls, cROMData, cConfiguration;

type
  TfrmTSA = class(TForm)
    imgTSA: TImage32;
    StatusBar: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgTSAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgTSAMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
 private
    _ROMData : TTMNTROM;
    _EditorConfig : TEditorConfig;
    TileX, TileY : Integer;
    { Private declarations }
  public
    procedure DrawPatternTable();
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM;
      EditorConfig: TEditorConfig);
    { Public declarations }
  end;

var
  frmTSA: TfrmTSA;

implementation

uses fEditorMain, fTileEditor;

{$R *.dfm}

procedure TfrmTSA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmEditorMain.CurTSABlock := -1;
  frmEditorMain.UpdateTitleCaption;
  frmEditorMain.DrawTileSelector;
  Action := caFree;
end;

procedure TfrmTSA.DrawPatternTable();
var
  TSA : TBitmap32;
begin
  TSA := TBitmap32.Create;
  try
    TSA.Width := 128;
    TSA.Height := 128;
    _ROMData.DrawTSAPatternTable(TSA,_EditorConfig.LastPaletteTSA, False);
    TSA.FrameRectS(TileX,TileY,TileX+8,TileY + 8,clRed32);
    imgTSA.Bitmap := TSA;
  finally
    FreeAndNil(TSA);
  end;
end;

procedure TfrmTSA.FormShow(Sender: TObject);
begin
  DrawPatternTable();
  frmEditorMain.CurTSABlock := 0;
end;

procedure TfrmTSA.imgTSAMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
var
  TilEd : Tfrm16x16TileEditor;
//  Erase : TfrmErasePatRange;
begin
  if (Button = mbMiddle) or ((ssShift in Shift) and (Button = mbLeft)) then
  begin

    TileX := ((X div 2) div 8) * 8;
    TileY := ((y div 2) div 8) * 8;
    //showmessage(IntToStr(Y));
    frmEditorMain.CurTSABlock := (((y div 16) * 16 * 16) + ((X div 16) * 16)) div 16;
//    showmessage(IntToStr(Tile div 32));
    DrawPatternTable();
    TilEd := Tfrm16x16TileEditor.Create(self, _ROMData, _EditorConfig);
    try
      TilEd.TileID := frmEditorMain.CurTSABlock;
      if TilEd.ShowModal = mrOK then
      begin
        _ROMData.SavePatternTable();
        DrawPatternTable();
        frmEditorMain.RedrawScreen;
        frmEditorMain.UpdateTitleCaption;
      end;
    finally
      FreeAndNil(TilEd);
    end;
  end
  else if button = mbLeft then
  begin
    TileX := ((X div 2) div 8) * 8;
    TileY := ((y div 2) div 8) * 8;

    frmEditorMain.CurTSABlock := (((y div 16) * 16 * 16) + ((X div 16) * 16)) div 16;

  end
  else if button = mbRight then
  begin
{    if ssShift in Shift then
    begin
      Erase := TfrmErasePatRange.Create(self);
      try
        Erase.Mode := 0;
        if Erase.ShowModal = mrOk then
        begin
          CVROM.SavePatternTable();
          DrawPatternTable();
          frmStake.RedrawScreen;
        end;
      finally
        FreeAndNil(Erase);
      end;
    end
    else}
    begin
      if _EditorConfig.LastPaletteTSA = 3 then
        _EditorConfig.LastPaletteTSA := 0
      else
        _EditorConfig.LastPaletteTSA := _EditorConfig.LastPaletteTSA + 1;
    end;
  end;
  DrawPatternTable();

end;

procedure TfrmTSA.imgTSAMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
  StatusBar.Panels[0].Text := 'Selected: ' + IntToHex(frmEditorMain.CurTSABlock,2);
  StatusBar.Panels[1].Text := IntToHex((((y div 16) * 16 * 16) + ((X div 16) * 16)) div 16,2);
end;

constructor TfrmTSA.Create(AOwner: TComponent;ROMData : TTMNTROM; EditorConfig : TEditorConfig);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
  _EditorConfig := EditorConfig;
end;

end.
