object frmDistribution: TfrmDistribution
  Left = 183
  Top = 203
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Hack Distribution'
  ClientHeight = 121
  ClientWidth = 504
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
  object lblOriginalFile: TLabel
    Left = 8
    Top = 8
    Width = 66
    Height = 13
    Caption = 'Original ROM:'
  end
  object lblOutputPatch: TLabel
    Left = 8
    Top = 32
    Width = 68
    Height = 13
    Caption = 'Output Patch:'
  end
  object lblPatchFormat: TLabel
    Left = 8
    Top = 56
    Width = 68
    Height = 13
    Caption = 'Patch Format:'
  end
  object txtOriginalROM: TEdit
    Left = 112
    Top = 8
    Width = 353
    Height = 21
    TabOrder = 0
  end
  object txtOutputPatch: TEdit
    Left = 112
    Top = 32
    Width = 353
    Height = 21
    Hint = 
      '(If left unspecified, patch is dumped to the same directory and ' +
      #13#10'with same name as ROM)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object cbPatchFormat: TComboBox
    Left = 112
    Top = 56
    Width = 353
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = 'IPS'
    Items.Strings = (
      'IPS')
  end
  object cmdOK: TButton
    Left = 344
    Top = 88
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 424
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object cmdOriginal: TButton
    Left = 472
    Top = 8
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 5
    OnClick = cmdOriginalClick
  end
  object cmdOutput: TButton
    Left = 472
    Top = 32
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 6
    OnClick = cmdOutputClick
  end
  object OpenDialog: TOpenDialog
    Filter = 'iNES Image (*.nes)|*.nes|All Files (*.*)|*.*'
    Title = 'Please select the original unmodified ROM'
    Left = 88
    Top = 88
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.ips'
    Filter = 'IPS File (*.ips)|*.ips'
    Title = 'Please enter the name of your patch'
    Left = 122
    Top = 90
  end
end
