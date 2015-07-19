object frmDebugROMViewer: TfrmDebugROMViewer
  Left = 229
  Top = 114
  BorderStyle = bsSingle
  Caption = 'Debug ROM Viewer'
  ClientHeight = 416
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DrawGrid: TDrawGrid
    Left = 0
    Top = 0
    Width = 775
    Height = 416
    Align = alClient
    ColCount = 35
    DefaultColWidth = 20
    FixedCols = 0
    RowCount = 33
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    GridLineWidth = 0
    ParentFont = False
    TabOrder = 0
    OnDrawCell = DrawGridDrawCell
    OnSelectCell = DrawGridSelectCell
  end
end
