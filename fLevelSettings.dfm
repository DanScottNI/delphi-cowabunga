object frmLevelSettings: TfrmLevelSettings
  Left = 429
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Level Settings'
  ClientHeight = 398
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cmdOK: TButton
    Left = 272
    Top = 368
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 352
    Top = 368
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pgcPatternTableSettings: TPageControl
    Left = 8
    Top = 8
    Width = 417
    Height = 353
    ActivePage = tshGeneral
    MultiLine = True
    TabOrder = 2
    object tshGeneral: TTabSheet
      Caption = 'General'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblWidth: TLabel
        Left = 8
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Width:'
      end
      object lblHeight: TLabel
        Left = 224
        Top = 8
        Width = 35
        Height = 13
        Caption = 'Height:'
      end
      object lblRoomsUsed: TLabel
        Left = 8
        Top = 32
        Width = 63
        Height = 13
        Caption = 'Rooms Used:'
      end
      object txtWidth: TEdit
        Left = 80
        Top = 8
        Width = 49
        Height = 21
        MaxLength = 2
        TabOrder = 0
        Text = '0'
      end
      object txtHeight: TEdit
        Left = 296
        Top = 8
        Width = 49
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object lstRooms: TListBox
        Left = 80
        Top = 32
        Width = 145
        Height = 145
        ItemHeight = 13
        TabOrder = 2
        OnDblClick = lstRoomsDblClick
      end
    end
    object tshBGPatternTable: TTabSheet
      Caption = 'BG Pattern Table Settings'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblBGPatternTable: TLabel
        Left = 8
        Top = 8
        Width = 111
        Height = 13
        Caption = 'BG Pattern Table : (00)'
      end
      object imgBGPatternTable: TImage32
        Left = 8
        Top = 32
        Width = 256
        Height = 256
        Bitmap.ResamplerClassName = 'TNearestResampler'
        BitmapAlign = baTopLeft
        Scale = 2.000000000000000000
        ScaleMode = smScale
        TabOrder = 0
      end
      object scrBGSetting: TScrollBar
        Left = 144
        Top = 8
        Width = 121
        Height = 17
        PageSize = 0
        TabOrder = 1
        OnChange = scrBGSettingChange
      end
    end
    object tshSprPatternTable: TTabSheet
      Caption = 'Sprite Pattern Table Settings'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblSprPatternTable: TLabel
        Left = 8
        Top = 8
        Width = 114
        Height = 13
        Caption = 'Spr Pattern Table : (00)'
      end
      object imgSprPatternTable: TImage32
        Left = 8
        Top = 32
        Width = 256
        Height = 256
        Bitmap.ResamplerClassName = 'TNearestResampler'
        BitmapAlign = baTopLeft
        Scale = 2.000000000000000000
        ScaleMode = smScale
        TabOrder = 0
      end
      object scrSprSetting: TScrollBar
        Left = 144
        Top = 8
        Width = 121
        Height = 17
        PageSize = 0
        TabOrder = 1
        OnChange = scrSprSettingChange
      end
      object rdgInterLeave: TRadioGroup
        Left = 272
        Top = 8
        Width = 129
        Height = 65
        Caption = 'Interleave Type:'
        ItemIndex = 1
        Items.Strings = (
          'None'
          'Interleave-4')
        TabOrder = 2
        OnClick = rdgInterLeaveClick
      end
      object lstAvailableEnemies: TListBox
        Left = 272
        Top = 80
        Width = 121
        Height = 113
        ItemHeight = 13
        TabOrder = 3
      end
    end
    object tshSpriteChanges: TTabSheet
      Caption = 'Sprite Changes'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblSpriteChanges: TLabel
        Left = 8
        Top = 8
        Width = 77
        Height = 13
        Caption = 'Sprite Changes:'
      end
      object imgSpriteChange: TImage32
        Left = 8
        Top = 40
        Width = 256
        Height = 256
        Bitmap.ResamplerClassName = 'TNearestResampler'
        BitmapAlign = baTopLeft
        Scale = 2.000000000000000000
        ScaleMode = smScale
        TabOrder = 0
      end
      object rdgSpriteChange: TRadioGroup
        Left = 272
        Top = 40
        Width = 129
        Height = 65
        Caption = 'Interleave Type:'
        ItemIndex = 1
        Items.Strings = (
          'None'
          'Interleave-4')
        TabOrder = 1
        OnClick = rdgSpriteChangeClick
      end
      object txtSpriteChange1: TDanHexEdit
        Left = 96
        Top = 8
        Width = 49
        Height = 21
        MaxLength = 2
        TabOrder = 2
        Text = '00'
        OnEnter = txtSpriteChange1Enter
        OnKeyUp = txtSpriteChange1KeyUp
      end
      object txtSpriteChange2: TDanHexEdit
        Left = 152
        Top = 8
        Width = 49
        Height = 21
        MaxLength = 2
        TabOrder = 3
        Text = '00'
        OnEnter = txtSpriteChange1Enter
        OnKeyUp = txtSpriteChange1KeyUp
      end
      object txtSpriteChange3: TDanHexEdit
        Left = 208
        Top = 8
        Width = 49
        Height = 21
        MaxLength = 2
        TabOrder = 4
        Text = '00'
        OnEnter = txtSpriteChange1Enter
        OnKeyUp = txtSpriteChange1KeyUp
      end
      object txtSpriteChange4: TDanHexEdit
        Left = 264
        Top = 8
        Width = 49
        Height = 21
        MaxLength = 2
        TabOrder = 5
        Text = '00'
        OnEnter = txtSpriteChange1Enter
        OnKeyUp = txtSpriteChange1KeyUp
      end
    end
  end
end
