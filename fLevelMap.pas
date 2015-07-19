unit fLevelMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image, GR32, ComCtrls, GR32_Layers, cROMData;

type
  TfrmLevelMap = class(TForm)
    imgLevelMap: TImage32;
    StatusBar: TStatusBar;
    procedure FormShow(Sender: TObject);
    procedure imgLevelMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure FormCreate(Sender: TObject);
    procedure imgLevelMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    _ROMData : TTMNTROM;  
    _SelectedScreen : Integer;
    _ClickedScreen : Integer;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TTMNTROM);
    property SelectedScreen : Integer read _SelectedScreen write _SelectedScreen;
    property ClickedScreen : Integer read _ClickedScreen write _ClickedScreen;
    { Public declarations }
  end;

var
  frmLevelMap: TfrmLevelMap;

implementation

uses  uConsts;

{$R *.dfm}

procedure TfrmLevelMap.FormShow(Sender: TObject);
var
  LevelMap : TBitmap32;
begin
  self.ClientHeight := (_ROMData.CurrSideScroll.Height * (LEVELMAPBLOCKSIZE * 2)) + StatusBar.Height;
  self.ClientWidth := _ROMData.CurrSideScroll.Width * (LEVELMAPBLOCKSIZE * 2);
  self.StatusBar.ClientWidth :=_ROMData.CurrSideScroll.Width * (LEVELMAPBLOCKSIZE * 2);
  StatusBar.Panels[0].Width := StatusBar.ClientWidth div 2;
  StatusBar.Panels[1].Width := StatusBar.ClientWidth div 2;
  LevelMap := TBitmap32.Create;
  try
    LevelMap.Width := _ROMData.CurrSideScroll.Width * LEVELMAPBLOCKSIZE;
    LevelMap.Height := _ROMData.CurrSideScroll.Height * LEVELMAPBLOCKSIZE;
    _ROMData.DrawLevelMap(LevelMap,_SelectedScreen);
    imgLevelMap.Bitmap := LevelMap;
  finally
    FreeAndNil(LevelMap);
  end;
end;

procedure TfrmLevelMap.imgLevelMapMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  Statusbar.Panels[1].Text := 'ID: N/A';
  Statusbar.Panels[0].Text := 'Index: N/A';
  if (X div (LEVELMAPBLOCKSIZE * 2)) > _ROMData.CurrSideScroll.Width -1 then exit;
  if (Y div (LEVELMAPBLOCKSIZE * 2)) > _ROMData.CurrSideScroll.Height -1 then exit;
  Statusbar.Panels[1].Text := 'ID: ' +
    IntToHex(_ROMData.CurrSideScroll.RoomNumbers[((Y div (LEVELMAPBLOCKSIZE * 2))
      * _ROMData.CurrSideScroll.Width) + (X div (LEVELMAPBLOCKSIZE * 2))],2);

  Statusbar.Panels[0].Text := 'Index: ' + IntToHex(((Y div (LEVELMAPBLOCKSIZE * 2))
    * _ROMData.CurrSideScroll.Width) + (X div (LEVELMAPBLOCKSIZE * 2)),2);
end;

procedure TfrmLevelMap.FormCreate(Sender: TObject);
begin
  _SelectedScreen := -1;
end;

procedure TfrmLevelMap.imgLevelMapMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if (X div (LEVELMAPBLOCKSIZE * 2)) > _ROMData.CurrSideScroll.Width -1 then exit;
  if (Y div (LEVELMAPBLOCKSIZE * 2)) > _ROMData.CurrSideScroll.Height -1 then exit;
  _ClickedScreen := ((Y div (LEVELMAPBLOCKSIZE * 2))
      * _ROMData.CurrSideScroll.Width) + (X div (LEVELMAPBLOCKSIZE * 2));
  modalresult := mrOk;
end;

constructor TfrmLevelMap.Create(AOwner: TComponent;ROMData : TTMNTROM);
begin
  inherited Create(AOwner);
  _ROMData := ROMData;
end;

end.
