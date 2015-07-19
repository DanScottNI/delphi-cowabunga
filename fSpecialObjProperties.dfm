object frmSpecialObjProperties: TfrmSpecialObjProperties
  Left = 232
  Top = 231
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Special Object Properties'
  ClientHeight = 168
  ClientWidth = 314
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
  object lblRoom: TLabel
    Left = 8
    Top = 32
    Width = 31
    Height = 13
    Caption = 'Room:'
  end
  object lblID: TLabel
    Left = 8
    Top = 8
    Width = 15
    Height = 13
    Caption = 'ID:'
  end
  object lblUnknownX: TLabel
    Left = 184
    Top = 56
    Width = 57
    Height = 13
    Caption = 'Unknown X:'
  end
  object lblUnknownY: TLabel
    Left = 184
    Top = 80
    Width = 57
    Height = 13
    Caption = 'Unknown Y:'
  end
  object lblUnknown1: TLabel
    Left = 8
    Top = 104
    Width = 57
    Height = 13
    Caption = 'Unknown 1:'
  end
  object lblUnknown2: TLabel
    Left = 184
    Top = 104
    Width = 57
    Height = 13
    Caption = 'Unknown 2:'
  end
  object lblX: TLabel
    Left = 8
    Top = 56
    Width = 10
    Height = 13
    Caption = 'X:'
  end
  object lblY: TLabel
    Left = 8
    Top = 80
    Width = 10
    Height = 13
    Caption = 'Y:'
  end
  object cmdOK: TButton
    Left = 152
    Top = 136
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 232
    Top = 136
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object txtX1: TDanHexEdit
    Left = 256
    Top = 56
    Width = 49
    Height = 21
    MaxLength = 2
    TabOrder = 2
  end
  object txtUnknownY: TDanHexEdit
    Left = 256
    Top = 80
    Width = 49
    Height = 21
    MaxLength = 2
    TabOrder = 3
  end
  object txtUnknown1: TDanHexEdit
    Left = 80
    Top = 104
    Width = 49
    Height = 21
    MaxLength = 2
    TabOrder = 4
  end
  object txtUnknown2: TDanHexEdit
    Left = 256
    Top = 104
    Width = 49
    Height = 21
    MaxLength = 2
    TabOrder = 5
  end
  object cbID: TComboBox
    Left = 80
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
  end
  object cbRoom: TComboBox
    Left = 80
    Top = 32
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
  end
  object cmdScreenSelect: TButton
    Left = 232
    Top = 32
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 8
  end
end
