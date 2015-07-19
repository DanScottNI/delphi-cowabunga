object frmPaletteEditor: TfrmPaletteEditor
  Left = 283
  Top = 246
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Palette Editor'
  ClientHeight = 207
  ClientWidth = 425
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
  object lblCurrentPalette: TLabel
    Left = 80
    Top = 88
    Width = 159
    Height = 13
    Caption = 'Palette Colour Under Mouse: $00'
  end
  object lbl303F: TLabel
    Left = 368
    Top = 63
    Width = 34
    Height = 13
    Caption = '30 - 3F'
  end
  object lbl202F: TLabel
    Left = 368
    Top = 45
    Width = 34
    Height = 13
    Caption = '20 - 2F'
  end
  object lbl101F: TLabel
    Left = 368
    Top = 27
    Width = 34
    Height = 13
    Caption = '10 - 1F'
  end
  object lbl000F: TLabel
    Left = 368
    Top = 9
    Width = 34
    Height = 13
    Caption = '00 - 0F'
  end
  object lblPaletteIndex: TLabel
    Left = 8
    Top = 112
    Width = 69
    Height = 13
    Caption = 'Palette Index:'
  end
  object imgNESColours: TImage32
    Left = 80
    Top = 8
    Width = 286
    Height = 73
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 0
  end
  object cmdOK: TButton
    Left = 262
    Top = 176
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cmdCancel: TButton
    Left = 342
    Top = 176
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object cbPaletteIndex: TComboBox
    Left = 88
    Top = 112
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = '00'
    OnChange = cbPaletteIndexChange
    Items.Strings = (
      '00'
      '01'
      '02'
      '03'
      '04'
      '05'
      '06'
      '07'
      '08'
      '09'
      '0A'
      '0B'
      '0C'
      '0D'
      '0E'
      '0F'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16')
  end
  object imgBGPal1: TImage32
    Left = 8
    Top = 144
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 4
    OnMouseUp = imgBGPal1MouseUp
  end
  object imgBGPal2: TImage32
    Tag = 1
    Left = 112
    Top = 144
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 5
    OnMouseUp = imgBGPal1MouseUp
  end
  object imgBGPal3: TImage32
    Tag = 2
    Left = 216
    Top = 144
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 6
    OnMouseUp = imgBGPal1MouseUp
  end
  object imgBGPal4: TImage32
    Tag = 3
    Left = 320
    Top = 144
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    ShowHint = True
    TabOrder = 7
    OnMouseUp = imgBGPal1MouseUp
  end
end
