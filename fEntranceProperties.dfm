object frmEntranceProperties: TfrmEntranceProperties
  Left = 378
  Top = 387
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Entrance Properties'
  ClientHeight = 130
  ClientWidth = 218
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
  object lblEntranceID: TLabel
    Left = 8
    Top = 8
    Width = 61
    Height = 13
    Caption = 'Entrance ID:'
  end
  object lblScreen: TLabel
    Left = 8
    Top = 32
    Width = 37
    Height = 13
    Caption = 'Screen:'
  end
  object cbScreen: TComboBox
    Left = 64
    Top = 32
    Width = 49
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object chkFollow: TCheckBox
    Left = 8
    Top = 64
    Width = 201
    Height = 17
    Caption = 'Follow when changing screen'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object cmdOK: TButton
    Left = 56
    Top = 96
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 2
  end
  object cmdCancel: TButton
    Left = 136
    Top = 96
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object cmdScreenSelect: TButton
    Left = 120
    Top = 32
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 4
  end
end
