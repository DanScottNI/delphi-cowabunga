object frmDebug: TfrmDebug
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Debug Information'
  ClientHeight = 556
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 799
    Top = 521
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object pgcDebug: TPageControl
    Left = 8
    Top = 8
    Width = 866
    Height = 507
    ActivePage = TabSheet6
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'World'
    end
    object TabSheet2: TTabSheet
      Caption = 'Side Scrolling Level'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'Enemy'
      ImageIndex = 2
      DesignSize = (
        858
        479)
      object btnEnemyCSV: TButton
        Left = 780
        Top = 451
        Width = 75
        Height = 25
        Caption = 'CSV'
        TabOrder = 0
        OnClick = btnEnemyCSVClick
      end
      object lvwEnemy: TListView
        Left = 8
        Top = 8
        Width = 847
        Height = 441
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'World.'
          end
          item
            Caption = 'Stage.'
          end
          item
            Caption = 'Enemy ID.'
          end
          item
            Caption = 'Offset.'
          end
          item
            Caption = 'Screen ID.'
            Width = 75
          end
          item
            Caption = 'X.'
          end
          item
            Caption = 'Y.'
          end
          item
            Caption = 'ID.'
          end
          item
            Caption = 'Sprite ID.'
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Special Objects'
      ImageIndex = 3
      DesignSize = (
        858
        479)
      object lvwSpecialObj: TListView
        Left = 8
        Top = 8
        Width = 847
        Height = 441
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'World.'
          end
          item
            Caption = 'Stage.'
          end
          item
            Caption = 'Special Obj ID.'
          end
          item
            Caption = 'Offset.'
          end
          item
            Caption = 'Screen ID.'
            Width = 75
          end
          item
            Caption = 'X.'
          end
          item
            Caption = 'Y.'
          end
          item
            Caption = 'Unknown X.'
          end
          item
            Caption = 'Unknown Y.'
          end
          item
            Caption = 'Unknown 1.'
          end
          item
            Caption = 'Unknown 2.'
          end
          item
            Caption = 'ID.'
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Boss Data'
      ImageIndex = 4
      DesignSize = (
        858
        479)
      object lvwBoss: TListView
        Left = 8
        Top = 8
        Width = 847
        Height = 441
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'World.'
          end
          item
            Caption = 'Stage.'
          end
          item
            Caption = 'Boss.'
          end
          item
            Caption = 'Offset.'
          end
          item
            Caption = 'Unknown 1.'
            Width = 75
          end
          item
            Caption = 'Screen ID.'
            Width = 75
          end
          item
            Caption = 'X.'
          end
          item
            Caption = 'Y.'
          end
          item
            Caption = 'ID.'
          end
          item
            Caption = 'Sprite ID.'
          end
          item
            Caption = 'World Boss.'
            Width = 75
          end
          item
            Caption = 'World Boss Index.'
            Width = 125
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object btnCSVBoss: TButton
        Left = 780
        Top = 451
        Width = 75
        Height = 25
        Caption = 'CSV'
        TabOrder = 1
        OnClick = btnCSVBossClick
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Entrances/Exits'
      ImageIndex = 5
      object lvwEntrances: TListView
        Left = 3
        Top = 3
        Width = 852
        Height = 442
        Columns = <
          item
            Caption = 'World.'
          end
          item
            Caption = 'Stage.'
          end
          item
            Caption = 'Entrance/Exit Number.'
          end
          item
            Caption = 'Offset.'
          end
          item
            Caption = 'Source Screen.'
          end
          item
            Caption = 'Source X.'
          end
          item
            Caption = 'Source Y.'
          end
          item
            Caption = 'Entrance to Level.'
          end
          item
            Caption = 'Dest ID.'
          end
          item
            Caption = 'Dest X.'
          end
          item
            Caption = 'Dest Y.'
          end
          item
            Caption = 'Dest Screen X1.'
          end
          item
            Caption = 'Dest Screen X2.'
          end
          item
            Caption = 'Dest Screen Y1.'
          end
          item
            Caption = 'Dest Screen Y2.'
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object btnEntranceCSV: TButton
        Left = 780
        Top = 451
        Width = 75
        Height = 25
        Caption = 'CSV'
        TabOrder = 1
        OnClick = btnEntranceCSVClick
      end
      object btnCRC: TButton
        Left = 699
        Top = 451
        Width = 75
        Height = 25
        Caption = '&CRC'
        TabOrder = 2
        OnClick = btnCRCClick
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'World Map Enemy'
      ImageIndex = 7
      DesignSize = (
        858
        479)
      object lvwWorldMapEnemy: TListView
        Left = 8
        Top = 3
        Width = 847
        Height = 441
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = 'World.'
          end
          item
            Caption = 'Enemy ID.'
          end
          item
            Caption = 'Offset.'
          end
          item
            Caption = 'Screen ID.'
            Width = 75
          end
          item
            Caption = 'X.'
          end
          item
            Caption = 'Y.'
          end
          item
            Caption = 'ID.'
          end
          item
            Caption = 'Sprite ID.'
          end>
        GridLines = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
      object btnWorldMapEnemyCSV: TButton
        Left = 780
        Top = 450
        Width = 75
        Height = 25
        Caption = 'CSV'
        TabOrder = 1
        OnClick = btnWorldMapEnemyCSVClick
      end
    end
  end
  object SaveDialog: TSaveDialog
    Title = 'Save Comma Separated Values File'
    Left = 768
    Top = 520
  end
end
