object frmEnemyProperties: TfrmEnemyProperties
  Left = 387
  Top = 348
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Enemy Properties'
  ClientHeight = 175
  ClientWidth = 360
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
  object lblID: TLabel
    Left = 8
    Top = 8
    Width = 15
    Height = 13
    Caption = 'ID:'
  end
  object lblScreen: TLabel
    Left = 8
    Top = 40
    Width = 31
    Height = 13
    Caption = 'Room:'
  end
  object cbEnemyList: TComboBox
    Left = 64
    Top = 8
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
  end
  object cmdOK: TButton
    Left = 200
    Top = 144
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 280
    Top = 144
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object grpUnknownBits: TGroupBox
    Left = 8
    Top = 72
    Width = 345
    Height = 65
    Caption = 'Unknown Bits'
    TabOrder = 3
    object chkUnknownBit1: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Unknown Bit 1'
      TabOrder = 0
    end
    object chkUnknownBit2: TCheckBox
      Left = 104
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Unknown Bit 2'
      TabOrder = 1
    end
    object chkUnknownBit3: TCheckBox
      Left = 208
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Unknown Bit 3'
      TabOrder = 2
    end
    object chkUnknownBit5: TCheckBox
      Left = 104
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Unknown Bit 5'
      TabOrder = 3
    end
    object chkUnknownBit4: TCheckBox
      Left = 8
      Top = 40
      Width = 89
      Height = 17
      Caption = 'Unknown Bit 4'
      TabOrder = 4
    end
  end
  object cmdScreenSelect: TButton
    Left = 136
    Top = 40
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = cmdScreenSelectClick
  end
  object chkFollowEnemy: TCheckBox
    Left = 168
    Top = 32
    Width = 185
    Height = 33
    Caption = 'Follow Enemy When Changing Room'
    Checked = True
    State = cbChecked
    TabOrder = 5
    WordWrap = True
  end
  object cbScreen: TComboBox
    Left = 64
    Top = 40
    Width = 65
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 6
  end
end
