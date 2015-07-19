object frmWorldMapEditor: TfrmWorldMapEditor
  Left = 392
  Top = 142
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'World Map Editor'
  ClientHeight = 589
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgScreen: TImage32
    Left = 4
    Top = 36
    Width = 512
    Height = 512
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    ParentShowHint = False
    Scale = 2.000000000000000000
    ScaleMode = smScale
    ShowHint = True
    TabOrder = 0
    OnMouseDown = imgScreenMouseDown
  end
  object scrLevelV: TScrollBar
    Left = 516
    Top = 36
    Width = 17
    Height = 512
    Kind = sbVertical
    PageSize = 0
    TabOrder = 1
    OnChange = scrLevelChange
  end
  object scrLevel: TScrollBar
    Left = 4
    Top = 548
    Width = 512
    Height = 17
    PageSize = 0
    TabOrder = 2
    OnChange = scrLevelChange
  end
  object imgTiles: TImage32
    Left = 540
    Top = 36
    Width = 64
    Height = 512
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 3
    OnMouseDown = imgTilesMouseDown
  end
  object scrTiles: TScrollBar
    Left = 604
    Top = 36
    Width = 17
    Height = 512
    Kind = sbVertical
    PageSize = 0
    TabOrder = 4
    OnChange = scrTilesChange
    OnScroll = scrTilesScroll
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 628
    Height = 29
    TabOrder = 5
    object tlbMapEditingMode: TToolButton
      Left = 0
      Top = 0
      Action = actMapEditingMode
    end
    object tlbObjectEditingMode: TToolButton
      Left = 23
      Top = 0
      Action = actObjEditingMode
    end
    object tlbViewGridlines: TToolButton
      Left = 46
      Top = 0
      Action = actViewGridlines
    end
    object tlbTSAEditor: TToolButton
      Left = 69
      Top = 0
      Action = actTSAEditor
    end
    object tlbPaletteEditor: TToolButton
      Left = 92
      Top = 0
      Action = actPaletteEditor
    end
    object tlbWorldMapSettings: TToolButton
      Left = 115
      Top = 0
      Action = actWorldMapSettings
    end
    object tlbMinimapEditor: TToolButton
      Left = 138
      Top = 0
      Action = actMinimapEditor
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 570
    Width = 628
    Height = 19
    Panels = <
      item
        Width = 125
      end
      item
        Alignment = taCenter
        Width = 300
      end
      item
        Width = 50
      end>
  end
  object MainMenu: TMainMenu
    Left = 220
    Top = 332
    object mnuFile: TMenuItem
      Caption = 'File'
      object mnuExit: TMenuItem
        Caption = 'Exit'
      end
    end
    object mnuEdit: TMenuItem
      Caption = 'Edit'
      object mnuMapEditingMode: TMenuItem
        Action = actMapEditingMode
        AutoCheck = True
      end
      object mnuObjectEditingMode: TMenuItem
        Action = actObjEditingMode
        AutoCheck = True
      end
    end
    object mnuView: TMenuItem
      Caption = 'View'
      object mnuViewGridlines: TMenuItem
        Action = actViewGridlines
      end
      object mnuViewEnemies: TMenuItem
        AutoCheck = True
        Caption = 'Enemies'
        Checked = True
        OnClick = mnuViewEnemiesClick
      end
      object mnuViewEntrances: TMenuItem
        AutoCheck = True
        Caption = 'Entrances'
        Checked = True
        OnClick = mnuViewEnemiesClick
      end
    end
    object mnuTools: TMenuItem
      Caption = 'Tools'
      object mnuTSAEditor: TMenuItem
        Action = actTSAEditor
      end
      object mnuPaletteEditor: TMenuItem
        Action = actPaletteEditor
      end
      object mnuWorldMapSettings: TMenuItem
        Action = actWorldMapSettings
      end
      object mnuMinimapEditor: TMenuItem
        Action = actMinimapEditor
      end
    end
  end
  object ActionList: TActionList
    Left = 364
    Top = 316
    object actWorldMapSettings: TAction
      Caption = 'World Map Settings'
    end
    object actPaletteEditor: TAction
      Caption = 'Palette Editor'
    end
    object actTSAEditor: TAction
      Caption = 'TSA Editor'
    end
    object actViewGridlines: TAction
      Caption = 'Gridlines'
    end
    object actMapEditingMode: TAction
      AutoCheck = True
      Caption = 'Map Editing Mode'
    end
    object actObjEditingMode: TAction
      AutoCheck = True
      Caption = 'Object Editing Mode'
    end
    object actMinimapEditor: TAction
      Caption = 'Minimap Editor'
    end
  end
end
