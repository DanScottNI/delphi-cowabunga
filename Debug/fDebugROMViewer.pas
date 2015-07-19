unit fDebugROMViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, math, StdCtrls, cROMData;

type
  TfrmDebugROMViewer = class(TForm)
    DrawGrid: TDrawGrid;
    procedure FormShow(Sender: TObject);
    procedure DrawGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    _TMNTROM : TTMNTROM;
    { Public declarations }
  end;

var
  frmDebugROMViewer: TfrmDebugROMViewer;

implementation

{$R *.dfm}

procedure TfrmDebugROMViewer.FormShow(Sender: TObject);
begin
  DrawGrid.ColWidths[0] := 80;
  DrawGrid.ColWidths[1] := 1;
  DrawGrid.ColWidths[34] := 1;
  DrawGrid.Col := 2;
  DrawGrid.RowCount := floor(simpleroundto(_TMNTROM.ROM.ROMSize / $20,0));
end;

procedure TfrmDebugROMViewer.DrawGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ACol = 0 then CanSelect := False;
  if ACol = 1 then CanSelect := False;
  if ACol = 34 then CanSelect := False;
end;

procedure TfrmDebugROMViewer.DrawGridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin

  DrawGrid.Canvas.Brush.Color := clWindow;
  DrawGrid.Canvas.FillRect(Rect);

  if gdSelected in State   then
  begin
    DrawGrid.Canvas.Brush.Color := clFuchsia;
    DrawGrid.Canvas.FillRect(Rect);
  end;
  

  if ACol = 0 then
  begin

    DrawGrid.Font.Color := clBlack;

    DrawGrid.Canvas.TextOut(Rect.Left +4,Rect.Top+4,IntToHex(ARow * 32,8));
  end;

  if (ACol > 1) and (Acol < 34) then
  begin

    if (ARow * 32) + (Acol - 2) < _TMNTROM.ROM.ROMSize then
    begin
      DrawGrid.Canvas.Brush.Color := clWindow;
      DrawGrid.Canvas.FillRect(Rect);
      DrawGrid.Canvas.TextOut(Rect.Left,Rect.Top+4,IntToHex(_TMNTROM.ROM[(ARow * 32) + (Acol - 2)],2));
    end;
  end;

  if (ACol = 34) or (ACol = 1) then
  begin
    DrawGrid.Canvas.Brush.Color := clBlack;
    DrawGrid.Canvas.FillRect(Rect);
  end;

  Caption := 'Debug ROM Viewer O:' + IntToHex((DrawGrid.Col - 2) + (DrawGrid.Row * 32),8);
end;



end.
