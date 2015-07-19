object frmScrollEditor: TfrmScrollEditor
  Left = 192
  Top = 114
  Caption = 'Scroll Editor'
  ClientHeight = 383
  ClientWidth = 543
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
  object lblWidth: TLabel
    Left = 8
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Width:'
  end
  object lblHeight: TLabel
    Left = 184
    Top = 8
    Width = 35
    Height = 13
    Caption = 'Height:'
  end
  object imgLevelMap: TImage32
    Left = 8
    Top = 40
    Width = 529
    Height = 305
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 0
  end
  object cmdOk: TButton
    Left = 384
    Top = 352
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cmdCancel: TButton
    Left = 464
    Top = 352
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object txtWidth: TEdit
    Left = 48
    Top = 8
    Width = 50
    Height = 21
    MaxLength = 2
    TabOrder = 3
    Text = '00'
    OnChange = txtHeightChange
    OnKeyPress = txtHeightKeyPress
  end
  object txtHeight: TEdit
    Left = 232
    Top = 8
    Width = 50
    Height = 21
    MaxLength = 2
    TabOrder = 4
    Text = '00'
    OnChange = txtHeightChange
    OnKeyPress = txtHeightKeyPress
  end
end
