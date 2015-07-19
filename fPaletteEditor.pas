unit fPaletteEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32_Image, GR32, GR32_Layers, Spin, cROMData;

type
  TfrmPaletteEditor = class(TForm)
    imgNESColours: TImage32;
    lblCurrentPalette: TLabel;
    lbl303F: TLabel;
    lbl202F: TLabel;
    lbl101F: TLabel;
    lbl000F: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    lblPaletteIndex: TLabel;
    cbPaletteIndex: TComboBox;
    imgBGPal1: TImage32;
    imgBGPal2: TImage32;
    imgBGPal3: TImage32;
    imgBGPal4: TImage32;
    procedure FormShow(Sender: TObject);
    procedure cbPaletteIndexChange(Sender: TObject);
    procedure imgBGPal1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    _ROMData : TTMNTROM;  
    _TileX, _TileY : Integer;
    _CurColour : Byte;
    _IgnoreChanges : Boolean;
    _Changed : Boolean;  
    procedure DrawNESColours;
    procedure DrawBGPalette;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    property Change : Boolean read _Changed write _Changed;
    { Public declarations }
  end;

var
  frmPaletteEditor: TfrmPaletteEditor;

implementation

{$R *.dfm}

uses fEditorMain;

procedure TfrmPaletteEditor.DrawNESColours;
var
  i,x : Integer;     
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 287;
    TempBitmap.Height := 74;

    for i := 0 to 3 do
      for x :=0 to 15 do
        TempBitmap.FillRect(x*18,i*18 + 1,(x*18)+17,i*18+18,_ROMData.NESPal[(i*16) + x]);

    tempbitmap.Line(0,0,0,74, clBlack32);


    if _TileX = 0 then
      TempBitmap.FrameRectS(_TileX,_TileY,_TileX+18,_TileY+19,clRed32)
    else
      TempBitmap.FrameRectS(_TileX-1,_TileY,_TileX+18,_TileY+19,clRed32);

    imgNESColours.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;


end;

procedure TfrmPaletteEditor.DrawBGPalette;
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 100;
    TempBitmap.Height := 25;

    TempBitmap.FillRect(0,0,25,25, _ROMData.NESPal[_ROMData.Palette[0,0]]);
    TempBitmap.FillRect(25,0,50,25, _ROMData.NESPal[_ROMData.Palette[0,1]]);
    TempBitmap.FillRect(50,0,75,25, _ROMData.NESPal[_ROMData.Palette[0,2]]);
    TempBitmap.FillRect(75,0,100,25, _ROMData.NESPal[_ROMData.Palette[0,3]]);
    imgBGPal1.Bitmap := TempBitmap;
    imgBGPal1.Hint := '$' + IntToHex(_ROMData.Palette[0,0],2) + ' $' +
      IntToHex(_ROMData.Palette[0,1],2) + ' $' + IntToHex(_ROMData.Palette[0,2],2) +
        ' $' + IntToHex(_ROMData.Palette[0,3],2);

    TempBitmap.FillRect(0,0,25,25, _ROMData.NESPal[_ROMData.Palette[1,0]]);
    TempBitmap.FillRect(25,0,50,25, _ROMData.NESPal[_ROMData.Palette[1,1]]);
    TempBitmap.FillRect(50,0,75,25, _ROMData.NESPal[_ROMData.Palette[1,2]]);
    TempBitmap.FillRect(75,0,100,25, _ROMData.NESPal[_ROMData.Palette[1,3]]);
    imgBGPal2.Bitmap := TempBitmap;
    imgBGPal2.Hint := '$' + IntToHex(_ROMData.Palette[1,0],2) + ' $' +
      IntToHex(_ROMData.Palette[1,1],2) + ' $' + IntToHex(_ROMData.Palette[1,2],2) +
        ' $' + IntToHex(_ROMData.Palette[1,3],2);

    TempBitmap.FillRect(0,0,25,25, _ROMData.NESPal[_ROMData.Palette[2,0]]);
    TempBitmap.FillRect(25,0,50,25, _ROMData.NESPal[_ROMData.Palette[2,1]]);
    TempBitmap.FillRect(50,0,75,25, _ROMData.NESPal[_ROMData.Palette[2,2]]);
    TempBitmap.FillRect(75,0,100,25, _ROMData.NESPal[_ROMData.Palette[2,3]]);
    imgBGPal3.Bitmap := TempBitmap;
    imgBGPal3.Hint := '$' + IntToHex(_ROMData.Palette[2,0],2) + ' $' +
      IntToHex(_ROMData.Palette[2,1],2) + ' $' + IntToHex(_ROMData.Palette[2,2],2) +
        ' $' + IntToHex(_ROMData.Palette[2,3],2);

    TempBitmap.FillRect(0,0,25,25, _ROMData.NESPal[_ROMData.Palette[3,0]]);
    TempBitmap.FillRect(25,0,50,25, _ROMData.NESPal[_ROMData.Palette[3,1]]);
    TempBitmap.FillRect(50,0,75,25, _ROMData.NESPal[_ROMData.Palette[3,2]]);
    TempBitmap.FillRect(75,0,100,25, _ROMData.NESPal[_ROMData.Palette[3,3]]);
    imgBGPal4.Bitmap := TempBitmap;
    imgBGPal4.Hint := '$' + IntToHex(_ROMData.Palette[3,0],2) + ' $' +
      IntToHex(_ROMData.Palette[3,1],2) + ' $' + IntToHex(_ROMData.Palette[3,2],2) +
        ' $' + IntToHex(_ROMData.Palette[3,3],2);

  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmPaletteEditor.FormShow(Sender: TObject);
begin
  _Changed := False;
  DrawNESColours;
  _IgnoreChanges := True;
  cbPaletteIndex.ItemIndex := _ROMData.CurrSideScroll.PaletteSetting;
  _IgnoreChanges := False;
  DrawBGPalette;
end;

procedure TfrmPaletteEditor.cbPaletteIndexChange(Sender: TObject);
begin
  _Changed := True;
  // Load the new BG palette.
  _ROMData.LoadBGPalette(cbPaletteIndex.ItemIndex);
  // Update the on-screen display.
  TfrmEditorMain(Owner).RedrawScreen;
end;

procedure TfrmPaletteEditor.imgBGPal1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  _Changed := True;
  if X div 25 = 0 then
  begin
    showmessage('This palette entry is not editable.');
    exit;
  end;
  _ROMData.Palette[TImage32(sender).Tag,x div 25] := _CurColour;
  DrawBGPalette;
end;

constructor TfrmPaletteEditor.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
