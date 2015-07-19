object frmWorldScreenCount: TfrmWorldScreenCount
  Left = 372
  Top = 362
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'World Screen Count'
  ClientHeight = 191
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
  object lblWorld1: TLabel
    Left = 8
    Top = 8
    Width = 41
    Height = 13
    Caption = 'World 1:'
  end
  object lblWorld2: TLabel
    Left = 8
    Top = 32
    Width = 41
    Height = 13
    Caption = 'World 2:'
  end
  object lblWorld3: TLabel
    Left = 8
    Top = 56
    Width = 41
    Height = 13
    Caption = 'World 3:'
  end
  object lblWorld4: TLabel
    Left = 8
    Top = 80
    Width = 41
    Height = 13
    Caption = 'World 4:'
  end
  object lblWorld5: TLabel
    Left = 8
    Top = 104
    Width = 41
    Height = 13
    Caption = 'World 5:'
  end
  object lblWorld6: TLabel
    Left = 8
    Top = 128
    Width = 41
    Height = 13
    Caption = 'World 6:'
  end
  object lblWorld1Count: TLabel
    Left = 200
    Top = 8
    Width = 12
    Height = 13
    Caption = '00'
  end
  object lblWorld3Count: TLabel
    Left = 200
    Top = 56
    Width = 12
    Height = 13
    Caption = '00'
  end
  object lblWorld2Count: TLabel
    Left = 200
    Top = 32
    Width = 12
    Height = 13
    Caption = '00'
  end
  object lblWorld4Count: TLabel
    Left = 200
    Top = 80
    Width = 12
    Height = 13
    Caption = '00'
  end
  object lblWorld5Count: TLabel
    Left = 200
    Top = 104
    Width = 12
    Height = 13
    Caption = '00'
  end
  object lblWorld6Count: TLabel
    Left = 200
    Top = 128
    Width = 12
    Height = 13
    Caption = '00'
  end
  object scrWorld1: TScrollBar
    Left = 72
    Top = 8
    Width = 121
    Height = 17
    PageSize = 0
    TabOrder = 0
  end
  object scrWorld2: TScrollBar
    Left = 72
    Top = 32
    Width = 121
    Height = 17
    PageSize = 0
    TabOrder = 1
  end
  object scrWorld3: TScrollBar
    Left = 72
    Top = 56
    Width = 121
    Height = 17
    PageSize = 0
    TabOrder = 2
  end
  object scrWorld4: TScrollBar
    Left = 72
    Top = 80
    Width = 121
    Height = 17
    PageSize = 0
    TabOrder = 3
  end
  object scrWorld5: TScrollBar
    Left = 72
    Top = 104
    Width = 121
    Height = 17
    PageSize = 0
    TabOrder = 4
  end
  object scrWorld6: TScrollBar
    Left = 72
    Top = 128
    Width = 121
    Height = 17
    PageSize = 0
    TabOrder = 5
  end
  object cmdOK: TButton
    Left = 56
    Top = 160
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object cmdCancel: TButton
    Left = 136
    Top = 160
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 7
  end
end
