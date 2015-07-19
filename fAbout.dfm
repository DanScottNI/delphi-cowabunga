object frmAbout: TfrmAbout
  Left = 313
  Top = 184
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'About Editor'
  ClientHeight = 248
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblHomepage: TLabel
    Left = 8
    Top = 215
    Width = 58
    Height = 13
    Cursor = crHandPoint
    Hint = 'http://dan.panicus.org'
    Caption = 'Dan'#39's Space'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    OnClick = lblHomepageClick
    OnMouseEnter = lblHomepageMouseEnter
    OnMouseLeave = lblHomepageMouseLeave
  end
  object cmdOK: TButton
    Left = 403
    Top = 215
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object pgcAbout: TPageControl
    Left = 8
    Top = 8
    Width = 465
    Height = 193
    ActivePage = tshAbout
    Style = tsFlatButtons
    TabOrder = 1
    object tshAbout: TTabSheet
      Caption = 'About'
      object lblDescription: TLabel
        Left = 4
        Top = 4
        Width = 483
        Height = 75
        Caption = 
          'Cowabunga is a level editor for the NES game, Teenage '#13#10'Mutant N' +
          'inja Turtles. It was written by Dan (danscotthack@gmail.com).'#13#10#13 +
          #10'This program is not in any way associated with Konami, '#13#10'Ninten' +
          'do, or any other stupid companies.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
    end
    object tshSpecialThanksGreetings: TTabSheet
      Caption = 'Special Thanks/Greetings'
      ImageIndex = 1
      object lblThanks: TLabel
        Left = 4
        Top = 4
        Width = 126
        Height = 105
        Caption = 
          'Special Thanks To:'#13#10#13#10'- John'#13#10'- Martin Strand'#13#10'- FuSoYa'#13#10'- Ultim' +
          'a 4701'#13#10'- The Fake God'
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
      object lblGreetings: TLabel
        Left = 168
        Top = 4
        Width = 273
        Height = 135
        Caption = 
          'Greetings To (in no particular order):'#13#10#13#10'- Disch               ' +
          '     - JCE3000GT'#13#10'- Gil-Galad                - Gavin'#13#10'- DahrkDai' +
          'z                - Mogster'#13#10'- Atma                     - bbitmas' +
          'ter'#13#10'- Muldoon                  - Vagla'#13#10'- Dragonsbretheren     ' +
          '    - windwaker'#13#10'- Sliver-X'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
    object tshTripnSlipProgInfo: TTabSheet
      Caption = 'Program Information'
      ImageIndex = 2
      object lblComponents: TLabel
        Left = 4
        Top = 4
        Width = 203
        Height = 75
        Caption = 
          'Components used in Cowabunga:'#13#10#13#10'- Turbopower Abbrevia'#13#10'- Jedi-V' +
          'CL v3.0 Beta'#13#10'- Graphics32'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object lblCompiled: TLabel
        Left = 0
        Top = 88
        Width = 182
        Height = 15
        Caption = 'Compiled Under Delphi 2007'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
