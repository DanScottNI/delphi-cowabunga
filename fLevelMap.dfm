object frmLevelMap: TfrmLevelMap
  Left = 345
  Top = 244
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Level Map'
  ClientHeight = 419
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgLevelMap: TImage32
    Left = 0
    Top = 0
    Width = 400
    Height = 400
    Align = alClient
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 0
    OnMouseMove = imgLevelMapMouseMove
    OnMouseUp = imgLevelMapMouseUp
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 400
    Width = 400
    Height = 19
    Panels = <
      item
        Text = 'Index: 0'
        Width = 50
      end
      item
        Text = 'ID: None'
        Width = 50
      end>
  end
end
