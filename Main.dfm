object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MIDIPLEX Sequencer'
  ClientHeight = 522
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object splitH: TSplitter
    Left = 0
    Top = 185
    Width = 742
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 227
  end
  object panTop: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 185
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Log: TMemo
      Left = 0
      Top = 0
      Width = 509
      Height = 129
      Align = alClient
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      Lines.Strings = (
        'File not opened')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object panMiddle: TPanel
      Left = 0
      Top = 129
      Width = 742
      Height = 56
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 7
        Top = 7
        Width = 67
        Height = 13
        Caption = 'Choose track:'
        Enabled = False
      end
      object TrkCh: TComboBox
        Left = 80
        Top = 4
        Width = 256
        Height = 21
        Style = csDropDownList
        Enabled = False
        TabOrder = 0
        OnChange = TrkChChange
      end
      object BAddTrack: TButton
        Left = 339
        Top = 6
        Width = 58
        Height = 17
        Caption = 'Add track'
        Enabled = False
        TabOrder = 1
        OnClick = BAddTrackClick
      end
      object BDelTrack: TButton
        Left = 400
        Top = 6
        Width = 72
        Height = 17
        Caption = 'Delete track'
        Enabled = False
        TabOrder = 2
        OnClick = BDelTrackClick
      end
      object panToolbar: TPanel
        Left = 0
        Top = 29
        Width = 185
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 3
      end
      object bPlay: TBitBtn
        Left = 7
        Top = 33
        Width = 26
        Height = 22
        Glyph.Data = {
          3E020000424D3E0200000000000036000000280000000D0000000D0000000100
          180000000000080200000000000000000000000000000000000000FF0000FF00
          00FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          000000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF000000FF0000FF0000FF0000000000000000000000FF0000
          FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF0000FF000000000000
          0000000000000000FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF00
          00FF0000000000000000000000000000000000FF0000FF0000FF0000FF0000FF
          000000FF0000FF0000FF0000000000000000000000000000000000000000FF00
          00FF0000FF0000FF000000FF0000FF0000FF0000000000000000000000000000
          000000000000000000FF0000FF0000FF000000FF0000FF0000FF000000000000
          000000000000007F7F7F00000000FF0000FF0000FF0000FF000000FF0000FF00
          00FF000000000000000000007F7F7F00000000FF0000FF0000FF0000FF0000FF
          000000FF0000FF0000FF000000000000007F7F7F00000000FF0000FF0000FF00
          00FF0000FF0000FF000000FF0000FF0000FF000000007F7F7F00000000FF0000
          FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF0000FF000000000000
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF00
          00FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000}
        TabOrder = 4
        OnClick = bPlayClick
      end
      object bStop: TBitBtn
        Left = 33
        Top = 33
        Width = 26
        Height = 22
        Glyph.Data = {
          3E020000424D3E0200000000000036000000280000000D0000000D0000000100
          180000000000080200000000000000000000000000000000000000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
          00FF0000FF0000FF000000FF0000FF0000000000000000000000000000000000
          000000000000000000000000FF0000FF000000FF0000FF000000000000000000
          0000000000000000000000000000000000000000FF0000FF000000FF0000FF00
          00000000000000000000000000000000000000000000000000000000FF0000FF
          000000FF0000FF00000000000000000000000000000000000000000000000000
          00000000FF0000FF000000FF0000FF0000000000000000000000000000000000
          000000000000000000000000FF0000FF000000FF0000FF000000000000000000
          000000000000000000000000007F7F7F00000000FF0000FF000000FF0000FF00
          0000000000000000000000000000000000000000007F7F7F00000000FF0000FF
          000000FF0000FF000000007F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F
          00000000FF0000FF000000FF0000FF0000000000000000000000000000000000
          000000000000000000000000FF0000FF000000FF0000FF0000FF0000FF0000FF
          0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000FF0000FF00
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000}
        TabOrder = 5
        OnClick = bStopClick
      end
    end
    object panVisual: TPanel
      Left = 509
      Top = 0
      Width = 233
      Height = 129
      Align = alRight
      BevelOuter = bvLowered
      TabOrder = 2
      object imgVU: TImage
        Left = 1
        Top = 1
        Width = 231
        Height = 127
        Align = alClient
        ExplicitLeft = 6
        ExplicitTop = 6
        ExplicitWidth = 219
        ExplicitHeight = 112
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 503
    Width = 742
    Height = 19
    Panels = <
      item
        Width = 160
      end
      item
        Width = 120
      end
      item
        Bevel = pbNone
        Width = 50
      end>
  end
  object Events: TStringGrid
    Left = 25
    Top = 188
    Width = 717
    Height = 315
    Align = alClient
    ColCount = 1
    DefaultColWidth = 40
    DefaultRowHeight = 16
    Enabled = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    PopupMenu = PopEdit
    TabOrder = 2
    OnClick = EventsClick
    OnDblClick = BEditEvntClick
    OnKeyPress = EventsKeyPress
    OnMouseUp = EventsMouseUp
  end
  object panLeft: TPanel
    Left = 0
    Top = 188
    Width = 25
    Height = 315
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 3
    object BAddEvnt: TSpeedButton
      Left = 0
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Add event'
      Enabled = False
      Flat = True
      Glyph.Data = {
        E2020000424DE20200000000000036000000280000000C000000130000000100
        180000000000AC02000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF008000008000008000FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF00800000FF00008000FF00FFFF00FFFF
        00FFFF00FF000000000000000000FF00FFFF00FF00800000FF00008000FF00FF
        FF00FFFF00FF00000000000000000000800000800000800000800000FF000080
        000080000080000080000000007F7F7F00000000800000FF0000FF0000FF0000
        FF0000FF0000FF0000FF000080000000007F7F7F000000008000008000008000
        00800000FF00008000008000008000008000FF00FF0000007F7F7F0000000000
        0000000000800000FF00008000FF00FFFF00FFFF00FFFF00FFFF00FF00000000
        000000000000000000800000FF00008000FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000000000008000008000008000FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FF000000FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FF000000FF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FF0000
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF
        00FF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000
        FF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000
        00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF000000000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = BAddEvntClick
    end
    object BEditEvnt: TSpeedButton
      Left = 0
      Top = 25
      Width = 25
      Height = 25
      Hint = 'Edit event'
      Enabled = False
      Flat = True
      Glyph.Data = {
        E2020000424DE20200000000000036000000280000000C000000130000000100
        180000000000AC0200000000000000000000000000000000000000FF0000FF00
        00FF0000FF0000FF0000FF00CC483F00FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF00CC483FEAD999CC483F00FF0000FF0000FF0000
        FF0000FF00000000000000000000CC483FEAD999EAD999EAD999CC483F00FF00
        00FF0000FF00000000000000000000CC483FEAD999EAD999CC483FEAD999EAD9
        99CC483F00FF0000FF000000007F7F7F000000CC483FEAD999CC483F00FF00CC
        483FEAD999EAD999CC483F00FF000000007F7F7F000000000000CC483F000000
        00FF0000FF00CC483FEAD999EAD999CC483F00FF000000007F7F7F0000000000
        0000000000FF0000FF0000FF00CC483FEAD999CC483F00FF0000FF0000000000
        000000000000000000FF0000FF0000FF0000FF00CC483F00FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000000000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000000000000000FF0000FF0000000000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000000000000000FF0000FF000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000FF0000
        FF0000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
        00FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF000000
        0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        FF0000000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000000000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF00
        00FF0000FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = BEditEvntClick
    end
    object BDelEvnt: TSpeedButton
      Left = 0
      Top = 50
      Width = 25
      Height = 25
      Hint = 'Delete event'
      Enabled = False
      Flat = True
      Glyph.Data = {
        96020000424D960200000000000036000000280000000A000000130000000100
        180000000000600200000000000000000000000000000000000000FF0000FF00
        00FF0000FF0015008800FF0000FF0000FF0015008800FF00000000FF0000FF00
        00FF001500880000FF15008800FF001500880000FF150088000000FF00000000
        0000000000001500880000FF1500880000FF15008800FF000000000000000000
        0000000000000000001500880000FF15008800FF0000FF0000000000007F7F7F
        0000000000001500880000FF1500880000FF15008800FF0000000000007F7F7F
        0000001500880000FF15008800FF001500880000FF150088000000FF00000000
        7F7F7F00000015008800000000FF0000FF0015008800FF00000000FF0000FF00
        00000000000000000000000000FF0000FF0000FF0000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000000000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000000000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000000000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000000000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000000000000000FF00000000FF0000FF00
        00FF0000FF0000000000000000000000000000FF0000FF00000000FF0000FF00
        00FF0000FF0000000000000000000000000000FF0000FF00000000FF0000FF00
        00FF0000FF0000000000000000000000FF0000FF0000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF00000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BDelEvntClick
    end
    object BDelEvntRange: TSpeedButton
      Left = 0
      Top = 75
      Width = 25
      Height = 25
      Hint = 'Delete range of events'
      Enabled = False
      Flat = True
      Glyph.Data = {
        26040000424D2604000000000000360000002800000010000000150000000100
        180000000000F00300000000000000000000000000000000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000000000000015008800FF0000FF
        0000FF0015008800FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        00000000001500880000FF15008800FF001500880000FF15008800FF0000FF00
        00FF0000FF0000FF0000FF0000FF000000007F7F7F0000001500880000FF1500
        880000FF15008800FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        00007F7F7F0000000000001500880000FF15008800FF0000FF0000FF00000000
        00000000000000FF0000FF0000FF0000FF000000007F7F7F1500880000FF1500
        880000FF15008800FF0000000000000000000000000000000000FF0000FF0000
        FF0000FF001500880000FF1500880000001500880000FF1500880000007F7F7F
        00000000000000000000000000FF0000FF0000FF0000FF001500880000000000
        0000FF0015008800FF000000007F7F7F00000000000000000000000000FF0000
        FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF00000000
        7F7F7F00000000000000000000FF0000FF0000FF0000FF0000FF000000000000
        0000FF0000FF0000FF0000FF0000FF0000000000000000000000000000FF0000
        FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000FF0000
        FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000FF0000
        FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF000000000000000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000FF0000
        000000000000000000000000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF000000000000000000000000000000000000000000000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000
        000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000000000000000000000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = BDelEvntRangeClick
    end
    object BMoveUp: TSpeedButton
      Left = 0
      Top = 150
      Width = 25
      Height = 25
      Hint = 'Move event up'
      Enabled = False
      Flat = True
      Glyph.Data = {
        E2020000424DE20200000000000036000000280000000B000000130000000100
        180000000000AC0200000000000000000000000000000000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000A5D500FF0000FF0000FF0000000000FF
        0000FF0000FF0000FF0000FF0000FF0000A5D500F2FF00A5D500FF0000FF0000
        000000FF0000000000000000000000FF0000FF0000A5D500F2FF00A5D500FF00
        00FF0000000000000000000000000000000000000000A5D500A5D500F2FF00A5
        D500A5D500FF000000000000007F7F7F00000000000000A5D500F2FF00A5D500
        F2FF00A5D500F2FF00A5D50000000000007F7F7F00000000000000000000A5D5
        00F2FF00F2FF00F2FF00A5D500FF0000000000FF000000007F7F7F0000000000
        0000000000A5D500F2FF00A5D500FF0000FF0000000000FF0000FF0000000000
        000000000000000000FF0000A5D500FF0000FF0000FF0000000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000000000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000000000FF0000FF0000
        000000FF0000FF0000FF0000FF0000000000000000FF0000FF0000000000FF00
        00FF0000000000FF0000FF0000FF0000FF0000000000000000FF0000FF000000
        0000FF0000FF0000000000FF0000FF0000FF0000FF0000000000000000FF0000
        FF0000000000FF0000FF0000000000FF0000FF0000FF0000FF00000000000000
        00FF0000000000000000FF0000FF0000000000FF0000FF0000FF0000FF000000
        0000000000000000000000FF0000FF0000FF0000000000FF0000FF0000FF0000
        FF0000000000000000000000000000FF0000FF0000FF0000000000FF0000FF00
        00FF0000FF0000000000000000000000FF0000FF0000FF0000FF0000000000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000
        000000FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF00
        00FF00000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BMoveUpClick
    end
    object BMoveDown: TSpeedButton
      Left = 0
      Top = 175
      Width = 25
      Height = 25
      Hint = 'Move event down'
      Enabled = False
      Flat = True
      Glyph.Data = {
        E2020000424DE20200000000000036000000280000000B000000130000000100
        180000000000AC0200000000000000000000000000000000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000A5D500FF0000FF0000FF0000000000FF
        0000FF0000FF0000FF0000FF0000FF0000A5D500F2FF00A5D500FF0000FF0000
        000000FF0000000000000000000000FF0000A5D500F2FF00F2FF00F2FF00A5D5
        00FF0000000000000000000000000000000000A5D500F2FF00A5D500F2FF00A5
        D500F2FF00A5D50000000000007F7F7F00000000000000000000A5D500A5D500
        F2FF00A5D500A5D500FF000000000000007F7F7F000000000000000000000000
        00A5D500F2FF00A5D500FF0000FF0000000000FF000000007F7F7F0000000000
        0000000000A5D500F2FF00A5D500FF0000FF0000000000FF0000FF0000000000
        000000000000000000FF0000A5D500FF0000FF0000FF0000000000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000000000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000000000FF0000FF0000
        000000FF0000FF0000FF0000FF0000000000000000FF0000FF0000000000FF00
        00FF0000000000FF0000FF0000FF0000FF0000000000000000FF0000FF000000
        0000FF0000FF0000000000FF0000FF0000FF0000FF0000000000000000FF0000
        FF0000000000FF0000FF0000000000FF0000FF0000FF0000FF00000000000000
        00FF0000000000000000FF0000FF0000000000FF0000FF0000FF0000FF000000
        0000000000000000000000FF0000FF0000FF0000000000FF0000FF0000FF0000
        FF0000000000000000000000000000FF0000FF0000FF0000000000FF0000FF00
        00FF0000FF0000000000000000000000FF0000FF0000FF0000FF0000000000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000
        000000FF0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF00
        00FF00000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BMoveDownClick
    end
    object BDelEvntT: TSpeedButton
      Left = 0
      Top = 100
      Width = 25
      Height = 25
      Hint = 'Delete event with time saving'
      Enabled = False
      Flat = True
      Glyph.Data = {
        7A030000424D7A0300000000000036000000280000000E000000130000000100
        180000000000440300000000000000000000000000000000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0015008800FF0000FF0000FF001500
        8800FF00000000FF0000FF0000FF0000FF0000FF0000FF0000FF001500880000
        FF15008800FF001500880000FF150088000000FF0000FF0000FF0000FF0000FF
        000000000000000000001500880000FF1500880000FF15008800FF00000000FF
        0000FF0000FF0000FF000000000000000000000000000000001500880000FF15
        008800FF0000FF00000000FF0000FF0000FF0000FF000000007F7F7F00000000
        00001500880000FF1500880000FF15008800FF00000000FF0000FF0000FF0000
        3A75003A75003A750000001500880000FF15008800FF001500880000FF150088
        000000FF0000FF00005BB7FFFFFFC3C3C3FFFFFF003A75000000150088000000
        00FF0000FF0015008800FF00000000FF00005BB7C3C3C3FFFFFFFFFFFFFFFFFF
        C3C3C3003A7500000000000000FF0000FF0000FF0000FF000000005BB7FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003A7500000000FF0000FF0000FF
        0000FF000000005BB7C3C3C3FFFFFFFFFFFF000000000000000000C3C3C3003A
        7500000000FF0000FF0000000000FF000000005BB7FFFFFFFFFFFFFFFFFF0000
        00FFFFFFFFFFFFFFFFFF003A7500000000FF0000FF0000000000FF00000000FF
        00005BB7C3C3C3FFFFFF000000FFFFFFC3C3C3005BB700000000000000FF0000
        FF0000000000FF00000000FF0000FF00005BB7FFFFFFC3C3C3FFFFFF005BB700
        FF0000000000000000FF0000FF0000000000FF00000000FF0000FF0000FF0000
        5BB7005BB7005BB700FF0000FF0000000000000000FF0000000000000000FF00
        000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000000000
        00000000000000FF0000FF00000000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000000000000000FF0000FF00000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000FF0000FF
        0000FF00000000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000
        0000000000FF0000FF0000FF0000FF00000000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF000000}
      ParentShowHint = False
      ShowHint = True
      OnClick = BDelEvntTClick
    end
    object BDelEvntRangeT: TSpeedButton
      Left = 0
      Top = 125
      Width = 25
      Height = 25
      Hint = 'Delete range of events with time saving'
      Enabled = False
      Flat = True
      Glyph.Data = {
        26040000424D2604000000000000360000002800000010000000150000000100
        180000000000F00300000000000000000000000000000000000000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000000000000015008800FF0000FF
        0000FF0015008800FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        00000000001500880000FF15008800FF001500880000FF15008800FF0000FF00
        00FF0000FF0000FF0000FF0000FF000000007F7F7F0000001500880000FF1500
        880000FF15008800FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000
        00007F7F7F0000000000001500880000FF15008800FF0000FF0000FF00000000
        00000000000000FF0000FF0000FF0000FF000000007F7F7F1500880000FF1500
        880000FF15008800FF00000000000000000000000000000000003A75003A7500
        3A7500FF001500880000FF1500880000001500880000FF1500880000007F7F7F
        000000000000005BB7FFFFFFC3C3C3FFFFFF003A7500FF001500880000000000
        0000FF0015008800FF000000007F7F7F000000005BB7C3C3C3FFFFFFFFFFFFFF
        FFFFC3C3C3003A7500FF0000000000000000FF0000FF0000FF0000FF00000000
        005BB7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003A750000000000
        0000FF0000FF0000FF0000FF0000FF00005BB7C3C3C3FFFFFFFFFFFF00000000
        0000000000C3C3C3003A7500000000000000FF0000FF0000FF0000FF0000FF00
        005BB7FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF003A750000000000
        0000FF0000FF0000FF0000FF0000FF0000FF00005BB7C3C3C3FFFFFF000000FF
        FFFFC3C3C3005BB700FF0000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF00005BB7FFFFFFC3C3C3FFFFFF005BB700FF0000FF000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF00000000005BB7005BB700
        5BB700FF0000FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF000000000000000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000FF0000
        000000000000000000000000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF000000000000000000000000000000000000000000000000000000
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000
        000000000000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000000000000000000000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000000000000000000000
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000000000000000FF0000FF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = BDelEvntRangeTClick
    end
  end
  object Progress: TProgressBar
    Left = 282
    Top = 488
    Width = 298
    Height = 17
    TabOrder = 4
  end
  object OpenDialog: TOpenDialog
    Filter = 
      'All supported MIDI formats|*.mid;*.midi;*.kar;*.rmi;*.rmid;*.orc' +
      ';*.mds;*.mids;*.xmi;*.cmf;*.mus;*.mdi;*.raw;*.syx|Standard MIDI ' +
      '(*.mid;*.midi;*.kar)|*.mid;*.midi;*.kar|RIFF MIDI (*.rmi;*.rmid;' +
      '*.orc)|*.rmi;*.rmid;*.orc|MIDI Stream (*.mds;*.mids)|*.mds;*.mid' +
      's|Miles Extended MIDI (*.xmi)|*.xmi|Creative Music File (*.cmf)|' +
      '*.cmf|AdLib MUS (*.mus)|*.mus|AdLib MDI (*.mdi)|*.mdi|Raw MIDI d' +
      'ata (Standard)|*.raw|System Exclusive data|*.syx'
    Title = 'Open MIDI File'
    Left = 256
    Top = 40
  end
  object MainMenu: TMainMenu
    Left = 320
    Top = 40
    object MFile: TMenuItem
      Caption = '&File'
      object MNew: TMenuItem
        Caption = '&New'
        ShortCut = 16462
        OnClick = MNewClick
      end
      object MOpen: TMenuItem
        Caption = '&Open'
        ShortCut = 16463
        OnClick = BtOpenClick
      end
      object MSave: TMenuItem
        Caption = '&Save'
        Enabled = False
        ShortCut = 16467
        OnClick = MSaveClick
      end
      object MSaveAs: TMenuItem
        Caption = 'Save &as...'
        Enabled = False
        ShortCut = 32851
        OnClick = MSaveAsClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MExit: TMenuItem
        Caption = '&Exit'
        OnClick = MExitClick
      end
    end
    object MEdit: TMenuItem
      Caption = '&Edit'
      Enabled = False
      object MCut: TMenuItem
        Caption = 'Cut'
        Enabled = False
        ShortCut = 16472
        OnClick = PCutClick
      end
      object MCopy: TMenuItem
        Caption = 'Copy'
        Enabled = False
        ShortCut = 16451
        OnClick = PCopyClick
      end
      object MPaste: TMenuItem
        Caption = 'Paste'
        Enabled = False
        ShortCut = 16470
        OnClick = PPasteClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MFind: TMenuItem
        Caption = 'Find...'
        Enabled = False
        ShortCut = 16454
        OnClick = MFindClick
      end
      object MFindNext: TMenuItem
        Caption = 'Find next'
        Enabled = False
        ShortCut = 114
      end
      object MReplace: TMenuItem
        Caption = 'Replace'
        Enabled = False
        ShortCut = 16456
      end
      object Changechannel1: TMenuItem
        Caption = 'Change channel'
        Visible = False
        OnClick = Changechannel1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MAddEvnt: TMenuItem
        Caption = 'Add event'
        Enabled = False
        ShortCut = 45
        OnClick = BAddEvntClick
      end
      object MEditEvnt: TMenuItem
        Caption = 'Edit event'
        Enabled = False
        OnClick = BEditEvntClick
      end
      object MDelEvnt: TMenuItem
        Caption = 'Delete event'
        Enabled = False
        ShortCut = 46
        OnClick = BDelEvntClick
      end
      object MDelEvntRange: TMenuItem
        Caption = 'Delete range of events'
        Enabled = False
        OnClick = BDelEvntRangeClick
      end
      object MDelEvntT: TMenuItem
        Caption = 'Delete event with time saving'
        Enabled = False
        ShortCut = 16452
        OnClick = BDelEvntTClick
      end
      object MDelEvntRangeT: TMenuItem
        Caption = 'Delete range with time saving'
        Enabled = False
        OnClick = BDelEvntRangeTClick
      end
      object MMoveUp: TMenuItem
        Caption = 'Move event up'
        Enabled = False
        ShortCut = 16422
        OnClick = BMoveUpClick
      end
      object MMoveDown: TMenuItem
        Caption = 'Move event down'
        Enabled = False
        ShortCut = 16424
        OnClick = BMoveDownClick
      end
    end
    object MTrack: TMenuItem
      Caption = '&Track'
      Enabled = False
      object MAddTrack: TMenuItem
        Caption = 'Add track'
        ShortCut = 32813
        OnClick = BAddTrackClick
      end
      object MDelTrack: TMenuItem
        Caption = 'Delete track'
        ShortCut = 32836
        OnClick = BDelTrackClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MMerge1: TMenuItem
        Caption = 'Merge tracks by ticks'
        Enabled = False
        OnClick = MMerge1Click
      end
      object MMerge2: TMenuItem
        Caption = 'Merge tracks by order'
        Enabled = False
        OnClick = MMerge2Click
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object MSplit1: TMenuItem
        Caption = 'Split track by channels'
        Enabled = False
        OnClick = MSplit1Click
      end
      object MSplit2: TMenuItem
        Caption = 'Split track by program'
        Enabled = False
        OnClick = MSplit2Click
      end
      object MSplit3: TMenuItem
        Caption = 'Split track by note'
        Enabled = False
      end
    end
    object MActions: TMenuItem
      Caption = '&Actions'
      Enabled = False
      object MChangeType: TMenuItem
        Caption = 'Change MIDI &Type'
        OnClick = MChangeTypeClick
      end
      object MChangeDivision: TMenuItem
        Caption = 'Change &division'
        OnClick = MChangeDivisionClick
      end
      object MCalcLen: TMenuItem
        Caption = 'Calculate song &length'
        OnClick = MCalcLenClick
      end
      object MConvert: TMenuItem
        Caption = 'Convert events...'
        object MFormatMID: TMenuItem
          Caption = 'Standard MIDI'
          OnClick = MFormatMIDClick
        end
        object MFormatXMI: TMenuItem
          Caption = 'Extended MIDI'
          OnClick = MFormatXMIClick
        end
        object MFormatMUS: TMenuItem
          Caption = 'AdLib MUS'
          OnClick = MFormatMUSClick
        end
        object MFormatMDI: TMenuItem
          Caption = 'AdLib MDI'
          OnClick = MFormatMDIClick
        end
        object MFormatCMF: TMenuItem
          Caption = 'Creative Music File'
          OnClick = MFormatCMFClick
        end
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MOptimize: TMenuItem
        Caption = 'Optimize song size'
        Enabled = False
        OnClick = MOptimizeClick
      end
    end
    object MSettings: TMenuItem
      Caption = '&Settings'
      object MProfile: TMenuItem
        Caption = 'Event view profile...'
        object MProfileMID: TMenuItem
          Caption = 'Standard MIDI'
          OnClick = MProfileMIDClick
        end
        object MProfileXMI: TMenuItem
          Caption = 'Extended MIDI'
          OnClick = MProfileXMIClick
        end
        object MProfileMUS: TMenuItem
          Caption = 'AdLib MUS'
          OnClick = MProfileMUSClick
        end
        object MProfileMDI: TMenuItem
          Caption = 'AdLib MDI'
          OnClick = MProfileMDIClick
        end
        object MProfileCMF: TMenuItem
          Caption = 'Creative Music File'
          OnClick = MProfileCMFClick
        end
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object MMIDIOut: TMenuItem
        Caption = 'MIDI Output'
        object MSynth: TMenuItem
          Caption = 'Internal Synth'
          Enabled = False
        end
        object MWin32: TMenuItem
          Caption = 'Win32 MIDI'
          Checked = True
        end
      end
      object MOutConf: TMenuItem
        Caption = 'MIDI Output options'
      end
      object MLoopSong: TMenuItem
        Caption = 'Loop song'
        OnClick = MLoopSongClick
      end
    end
    object N2: TMenuItem
      Caption = '&?'
      object MAbout: TMenuItem
        Caption = 'About'
        OnClick = MAboutClick
      end
    end
  end
  object PopEvnt: TPopupMenu
    Left = 56
    Top = 192
    object Evnt144: TMenuItem
      Caption = 'Note On'
      ShortCut = 16433
      OnClick = Evnt144Click
    end
    object Evnt128: TMenuItem
      Caption = 'Note Off'
      ShortCut = 16434
      OnClick = Evnt128Click
    end
    object Evnt224: TMenuItem
      Caption = 'Pitch Bend'
      OnClick = Evnt224Click
    end
    object Evnt192: TMenuItem
      Caption = 'Program Change'
      ShortCut = 16435
      OnClick = Evnt192Click
    end
    object Evnt176: TMenuItem
      Caption = 'Control Change'
      object MSB: TMenuItem
        Caption = 'MSB'
        object BankSelect1: TMenuItem
          Caption = 'Bank select'
          OnClick = BankSelect1Click
        end
        object Modulation1: TMenuItem
          Caption = 'Modulation wheel'
          OnClick = Modulation1Click
        end
        object Breath1: TMenuItem
          Caption = 'Breath controller'
          OnClick = Breath1Click
        end
        object DX7Aftertouch1: TMenuItem
          Caption = 'DX7 Aftertouch'
          OnClick = DX7Aftertouch1Click
        end
        object Foot1: TMenuItem
          Caption = 'Foot controller'
          OnClick = Foot1Click
        end
        object PortamentoTime1: TMenuItem
          Caption = 'Portamento time'
          OnClick = PortamentoTime1Click
        end
        object Volume1: TMenuItem
          Caption = 'Channel volume'
          ShortCut = 16436
          OnClick = Volume1Click
        end
        object Balance1: TMenuItem
          Caption = 'Balance'
          OnClick = Balance1Click
        end
        object Panning1: TMenuItem
          Caption = 'Panning'
          ShortCut = 16437
          OnClick = Panning1Click
        end
        object Expression1: TMenuItem
          Caption = 'Expression controller'
          OnClick = Expression1Click
        end
        object Effect11: TMenuItem
          Caption = 'Effect controller 1'
          OnClick = Effect11Click
        end
        object Effect21: TMenuItem
          Caption = 'Effect controller 2'
          OnClick = Effect21Click
        end
        object Generalpurpose11: TMenuItem
          Caption = 'General purpose 1'
          OnClick = Generalpurpose11Click
        end
        object Generalpurpose31: TMenuItem
          Caption = 'General purpose 2'
          OnClick = Generalpurpose31Click
        end
        object Generalpurpose32: TMenuItem
          Caption = 'General purpose 3'
          OnClick = Generalpurpose32Click
        end
        object Generalpurpose41: TMenuItem
          Caption = 'General purpose 4'
          OnClick = Generalpurpose41Click
        end
      end
      object LSB: TMenuItem
        Caption = 'LSB'
        object BankselectLSB1: TMenuItem
          Caption = 'Bank select'
          OnClick = BankselectLSB1Click
        end
        object ModulationLSB1: TMenuItem
          Caption = 'Modulation wheel'
          OnClick = ModulationLSB1Click
        end
        object BreathLSB1: TMenuItem
          Caption = 'Breath controller'
          OnClick = BreathLSB1Click
        end
        object DX7AftertouchLSB1: TMenuItem
          Caption = 'DX7 Aftertouch'
          OnClick = DX7AftertouchLSB1Click
        end
        object FootLSB1: TMenuItem
          Caption = 'Foot controller'
          OnClick = FootLSB1Click
        end
        object PortamentotimeLSB1: TMenuItem
          Caption = 'Portamento time'
          OnClick = PortamentotimeLSB1Click
        end
        object VolumeLSB1: TMenuItem
          Caption = 'Channel volume'
          OnClick = VolumeLSB1Click
        end
        object BalanceLSB1: TMenuItem
          Caption = 'Balance'
          OnClick = BalanceLSB1Click
        end
        object PanningLSB1: TMenuItem
          Caption = 'Panning'
          OnClick = PanningLSB1Click
        end
        object ExpressionLSB1: TMenuItem
          Caption = 'Expression controller'
          OnClick = ExpressionLSB1Click
        end
        object Effect1LSB1: TMenuItem
          Caption = 'Effect controller 1'
          OnClick = Effect1LSB1Click
        end
        object Effect2LSB1: TMenuItem
          Caption = 'Effect controller 2'
          OnClick = Effect2LSB1Click
        end
        object Generalpurpose1LSB1: TMenuItem
          Caption = 'General purpose 1'
          OnClick = Generalpurpose1LSB1Click
        end
        object Generalpurpose2LSB1: TMenuItem
          Caption = 'General purpose 2'
          OnClick = Generalpurpose2LSB1Click
        end
        object Generalpurpose3LSB1: TMenuItem
          Caption = 'General purpose 3'
          OnClick = Generalpurpose3LSB1Click
        end
        object Generalpurpose4LSB1: TMenuItem
          Caption = 'General purpose 4'
          OnClick = Generalpurpose4LSB1Click
        end
      end
      object Switch: TMenuItem
        Caption = 'Switches'
        object SustainSW1: TMenuItem
          Caption = 'Damper pedal (Sustain)'
          OnClick = SustainSW1Click
        end
        object Portamento1: TMenuItem
          Caption = 'Portamento'
          OnClick = Portamento1Click
        end
        object Sustenutopedal1: TMenuItem
          Caption = 'Sustenuto pedal'
          OnClick = Sustenutopedal1Click
        end
        object Softpedal1: TMenuItem
          Caption = 'Soft pedal'
          OnClick = Softpedal1Click
        end
        object Legato1: TMenuItem
          Caption = 'Legato footswitch'
          OnClick = Legato1Click
        end
        object Hold21: TMenuItem
          Caption = 'Hold 2'
          OnClick = Hold21Click
        end
      end
      object Soundcontrol1: TMenuItem
        Caption = 'Sound'
        object Soundvariation1: TMenuItem
          Caption = 'Sound variation'
          OnClick = Soundvariation1Click
        end
        object Harmonique1: TMenuItem
          Caption = 'Timbre/harmonic intensity'
          OnClick = Harmonique1Click
        end
        object Releasetime1: TMenuItem
          Caption = 'Release time'
          OnClick = Releasetime1Click
        end
        object Attacktime1: TMenuItem
          Caption = 'Attack time'
          OnClick = Attacktime1Click
        end
        object Cutoff1: TMenuItem
          Caption = 'Brightness (cutoff)'
          OnClick = Cutoff1Click
        end
        object Decaytime1: TMenuItem
          Caption = 'Decay time'
          OnClick = Decaytime1Click
        end
        object Vibratorate1: TMenuItem
          Caption = 'Vibrato rate'
          OnClick = Vibratorate1Click
        end
        object Vibratodepth1: TMenuItem
          Caption = 'Vibrato depth'
          OnClick = Vibratodepth1Click
        end
        object Vibratodelay1: TMenuItem
          Caption = 'Vibrato delay'
          OnClick = Vibratodelay1Click
        end
        object Soundcontroller101: TMenuItem
          Caption = 'Sound controller 10'
          OnClick = Soundcontroller101Click
        end
        object Generalpurpose51: TMenuItem
          Caption = 'General purpose 5'
          OnClick = Generalpurpose51Click
        end
        object Generalpurpose61: TMenuItem
          Caption = 'General purpose 6'
          OnClick = Generalpurpose61Click
        end
        object Generalpurpose71: TMenuItem
          Caption = 'General purpose 7'
          OnClick = Generalpurpose71Click
        end
        object Generalpurpose81: TMenuItem
          Caption = 'General purpose 8'
          OnClick = Generalpurpose81Click
        end
        object Portamento2: TMenuItem
          Caption = 'Portamento control'
          OnClick = Portamento2Click
        end
        object HiResvelocityprefix1: TMenuItem
          Caption = 'Hi-res velocity prefix'
          OnClick = HiResvelocityprefix1Click
        end
      end
      object Effects1: TMenuItem
        Caption = 'Effects'
        object Reverbdepth1: TMenuItem
          Caption = 'Reverb depth'
          OnClick = Reverbdepth1Click
        end
        object remolodepth1: TMenuItem
          Caption = 'Tremolo depth'
          OnClick = remolodepth1Click
        end
        object Chorusdepth1: TMenuItem
          Caption = 'Chorus depth'
          OnClick = Chorusdepth1Click
        end
        object Detunedepth1: TMenuItem
          Caption = 'Detune depth'
          OnClick = Detunedepth1Click
        end
        object Phaserdepth1: TMenuItem
          Caption = 'Phaser depth'
          OnClick = Phaserdepth1Click
        end
      end
      object DataEntry1: TMenuItem
        Caption = 'Data Entry'
        object DataEntryMSB1: TMenuItem
          Caption = 'Data entry MSB'
          OnClick = DataEntryMSB1Click
        end
        object DataEntryLSB1: TMenuItem
          Caption = 'Data entry LSB'
          OnClick = DataEntryLSB1Click
        end
        object DataEntry11: TMenuItem
          Caption = 'Data entry +1'
          OnClick = DataEntry11Click
        end
        object DataEntry12: TMenuItem
          Caption = 'Data entry -1'
          OnClick = DataEntry12Click
        end
        object NRPNLSB1: TMenuItem
          Caption = 'Non-registered parameter number LSB'
          OnClick = NRPNLSB1Click
        end
        object NonRegisteredParameterNumberMSB1: TMenuItem
          Caption = 'Non-registered parameter number MSB'
          OnClick = NonRegisteredParameterNumberMSB1Click
        end
        object RegisteredParameterNumberLSB1: TMenuItem
          Caption = 'Registered parameter number LSB'
          OnClick = RegisteredParameterNumberLSB1Click
        end
        object RegisteredParameterNumberMSB1: TMenuItem
          Caption = 'Registered parameter number MSB'
          OnClick = RegisteredParameterNumberMSB1Click
        end
      end
      object MIDIDevice1: TMenuItem
        Caption = 'MIDI Device'
        object AllSoundOff1: TMenuItem
          Caption = 'All sound off'
          OnClick = AllSoundOff1Click
        end
        object Allnotesoff1: TMenuItem
          Caption = 'All notes off'
          OnClick = Allnotesoff1Click
        end
        object ResetAllControllers1: TMenuItem
          Caption = 'Reset all controllers'
          OnClick = ResetAllControllers1Click
        end
        object Localcontrol1: TMenuItem
          Caption = 'Local control switch'
          OnClick = Localcontrol1Click
        end
        object Omnimodeon1: TMenuItem
          Caption = 'Omni mode on'
          OnClick = Omnimodeon1Click
        end
        object Omnimodeoff1: TMenuItem
          Caption = 'Omni mode off'
          OnClick = Omnimodeoff1Click
        end
        object Monomodeon1: TMenuItem
          Caption = 'Mono mode on'
          OnClick = Monomodeon1Click
        end
        object Polymodeon1: TMenuItem
          Caption = 'Poly mode on'
          OnClick = Polymodeon1Click
        end
      end
      object Nonstandard1: TMenuItem
        Caption = 'Non-standard'
        object CreativeMusicFile1: TMenuItem
          Caption = 'Creative Music File'
          object Amplitudevibratodepthcontrol1: TMenuItem
            Caption = 'Amplitude+vibrato depth'
            OnClick = Amplitudevibratodepthcontrol1Click
          end
          object Setmarkerbyte1: TMenuItem
            Caption = 'Set marker byte'
            OnClick = Setmarkerbyte1Click
          end
          object Rhythmmodechange1: TMenuItem
            Caption = 'Rhythm mode change'
            OnClick = Rhythmmodechange1Click
          end
          object ransposeup1: TMenuItem
            Caption = 'Transpose up'
            OnClick = ransposeup1Click
          end
          object ransposedown1: TMenuItem
            Caption = 'Transpose down'
            OnClick = ransposedown1Click
          end
        end
        object XMIDI1: TMenuItem
          Caption = 'Extended MIDI'
          object Loopstart1: TMenuItem
            Caption = 'Loop start'
            OnClick = Loopstart1Click
          end
          object Loopend1: TMenuItem
            Caption = 'Loop end'
            OnClick = Loopend1Click
          end
        end
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Other1: TMenuItem
        Caption = 'Other'
        OnClick = Other1Click
      end
    end
    object Evnt160: TMenuItem
      Caption = 'Key Pressure'
      OnClick = Evnt160Click
    end
    object Evnt208: TMenuItem
      Caption = 'Channel Pressure'
      OnClick = Evnt208Click
    end
    object Evnt240: TMenuItem
      Caption = 'System'
      object MSystem15: TMenuItem
        Caption = 'Meta Event'
        object MMeta0: TMenuItem
          Caption = 'Sequence number'
          OnClick = MMeta0Click
        end
        object MMeta1: TMenuItem
          Caption = 'Text (comment)'
          OnClick = MMeta1Click
        end
        object MMeta2: TMenuItem
          Caption = 'Copyright notice'
          OnClick = MMeta2Click
        end
        object MMeta3: TMenuItem
          Caption = 'Track name'
          OnClick = MMeta3Click
        end
        object MMeta4: TMenuItem
          Caption = 'Instrument name'
          OnClick = MMeta4Click
        end
        object MMeta5: TMenuItem
          Caption = 'Lyrics'
          OnClick = MMeta5Click
        end
        object MMeta6: TMenuItem
          Caption = 'Marker'
          OnClick = MMeta6Click
        end
        object MMeta7: TMenuItem
          Caption = 'Cue Point'
          OnClick = MMeta7Click
        end
        object MMeta32: TMenuItem
          Caption = 'MIDI channel'
          OnClick = MMeta32Click
        end
        object MMeta33: TMenuItem
          Caption = 'MIDI port'
          OnClick = MMeta33Click
        end
        object MMeta47: TMenuItem
          Caption = 'End of track'
          OnClick = MMeta47Click
        end
        object MMeta81: TMenuItem
          Caption = 'Tempo'
          OnClick = MMeta81Click
        end
        object MMeta84: TMenuItem
          Caption = 'SMPTE offset'
          OnClick = MMeta84Click
        end
        object MMeta88: TMenuItem
          Caption = 'Time signature'
          OnClick = MMeta88Click
        end
        object MMeta89: TMenuItem
          Caption = 'Key signature'
          OnClick = MMeta89Click
        end
        object MMeta127: TMenuItem
          Caption = 'Sequencer specific'
          OnClick = MMeta127Click
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object MMetaOther: TMenuItem
          Caption = 'Other'
          OnClick = MMetaOtherClick
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object MSystem0: TMenuItem
        Caption = 'SysEx Message'
        OnClick = MSystem0Click
      end
      object MSystem1: TMenuItem
        Caption = 'Quarter Frame'
        OnClick = MSystem1Click
      end
      object MSystem2: TMenuItem
        Caption = 'Song Position Pointer'
        OnClick = MSystem2Click
      end
      object MSystem3: TMenuItem
        Caption = 'Song Select'
        OnClick = MSystem3Click
      end
      object MSystem6: TMenuItem
        Caption = 'Tune Request'
        OnClick = MSystem6Click
      end
      object MSystem7: TMenuItem
        Caption = 'EOX'
        OnClick = MSystem7Click
      end
      object MSystem8: TMenuItem
        Caption = 'Timing Clock'
        OnClick = MSystem8Click
      end
      object MSystem10: TMenuItem
        Caption = 'Start'
        OnClick = MSystem10Click
      end
      object MSystem11: TMenuItem
        Caption = 'Continue'
        OnClick = MSystem11Click
      end
      object MSystem12: TMenuItem
        Caption = 'Stop'
        OnClick = MSystem12Click
      end
      object MSystem14: TMenuItem
        Caption = 'Active Sensing'
        OnClick = MSystem14Click
      end
    end
  end
  object PopEdit: TPopupMenu
    Left = 104
    Top = 192
    object PCut: TMenuItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = PCutClick
    end
    object PCopy: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = PCopyClick
    end
    object PPaste: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = PPasteClick
    end
    object PDel: TMenuItem
      Caption = 'Delete'
      ShortCut = 46
      OnClick = BDelEvntClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object PCopyText: TMenuItem
      Caption = 'Copy text'
      ShortCut = 32835
      OnClick = PCopyTextClick
    end
  end
  object Shortcuts: TActionList
    Left = 152
    Top = 192
    object Action1: TAction
      Caption = 'Note On'
      ShortCut = 16433
      OnExecute = Evnt144Click
    end
    object Action2: TAction
      Caption = 'Note Off'
      ShortCut = 16434
      OnExecute = Evnt128Click
    end
    object Action3: TAction
      Caption = 'Program Change'
      ShortCut = 16435
      OnExecute = Evnt192Click
    end
    object Action4: TAction
      Caption = 'Volume Control'
      ShortCut = 16436
      OnExecute = Volume1Click
    end
    object Action5: TAction
      Caption = 'Pan Control'
      ShortCut = 16437
      OnExecute = Panning1Click
    end
  end
  object SaveDialog: TSaveDialog
    Filter = 
      'Standard MIDI (*.mid;*.midi;*.kar)|*.mid;*.midi;*.kar|RIFF MIDI ' +
      '(*.rmi;*.rmid)|*.rmi;*.rmid|AdLib MDI (*.mdi)|*.mdi|Raw MIDI dat' +
      'a (Standard)|*.raw|System Exclusive data|*.syx'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save MIDI File'
    Left = 384
    Top = 40
  end
  object VisualTimer: TTimer
    Interval = 18
    OnTimer = VisualTimerTimer
    Left = 528
    Top = 48
  end
end