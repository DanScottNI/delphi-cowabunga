object frmSolidityEditor: TfrmSolidityEditor
  Left = 231
  Top = 309
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Solidity Editor'
  ClientHeight = 356
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblUpToTile: TLabel
    Left = 8
    Top = 272
    Width = 51
    Height = 13
    Caption = 'Up To Tile:'
  end
  object lblTileType: TLabel
    Left = 8
    Top = 296
    Width = 47
    Height = 13
    Caption = 'Tile Type:'
  end
  object lblHighlight: TLabel
    Left = 304
    Top = 272
    Width = 256
    Height = 49
    AutoSize = False
    Caption = 'Highlighted Tile: $00'
    WordWrap = True
  end
  object lvwSolidityData: TListView
    Left = 8
    Top = 8
    Width = 289
    Height = 257
    Columns = <
      item
        Caption = 'Tile Range.'
        Width = 65
      end
      item
        AutoSize = True
        Caption = 'Tile Type.'
      end>
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GridLines = True
    HideSelection = False
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvwSolidityDataClick
    OnSelectItem = lvwSolidityDataSelectItem
  end
  object txtUpToTile: TDanHexEdit
    Left = 64
    Top = 272
    Width = 50
    Height = 21
    MaxLength = 2
    TabOrder = 1
    Text = '00'
  end
  object cmdOK: TButton
    Left = 408
    Top = 328
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 488
    Top = 328
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object cmdEdit: TButton
    Left = 208
    Top = 296
    Width = 75
    Height = 21
    Caption = '&Edit'
    TabOrder = 4
    OnClick = cmdEditClick
  end
  object cbTileType: TComboBox
    Left = 64
    Top = 296
    Width = 137
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
  end
  object imgTSA: TImage32
    Left = 304
    Top = 8
    Width = 256
    Height = 256
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 6
    OnMouseMove = imgTSAMouseMove
  end
  object chkDrawColours: TCheckBox
    Left = 8
    Top = 320
    Width = 225
    Height = 17
    Caption = 'Draw colours to represent solidity settings'
    TabOrder = 7
    OnClick = chkDrawColoursClick
  end
end
