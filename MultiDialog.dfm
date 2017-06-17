object EditDialog: TEditDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 211
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = -5
    Top = -5
    Width = 433
    Height = 273
    ActivePage = Search
    TabOrder = 2
    TabStop = False
    object Range: TTabSheet
      Tag = 2
      Caption = 'Range'
      object Label1: TLabel
        Left = 13
        Top = 10
        Width = 28
        Height = 13
        Caption = 'From:'
      end
      object Label2: TLabel
        Left = 161
        Top = 10
        Width = 16
        Height = 13
        Caption = 'To:'
      end
      object RangeFrom: TSpinEdit
        Left = 47
        Top = 7
        Width = 81
        Height = 22
        MaxValue = 1
        MinValue = 1
        TabOrder = 0
        Value = 1
        OnChange = RangeFromChange
      end
      object RangeTo: TSpinEdit
        Left = 183
        Top = 7
        Width = 81
        Height = 22
        MaxValue = 1
        MinValue = 1
        TabOrder = 1
        Value = 1
        OnChange = RangeToChange
      end
    end
    object TNote: TTabSheet
      Tag = 2
      Caption = 'Note'
      ImageIndex = 1
      object Label3: TLabel
        Left = 38
        Top = 38
        Width = 27
        Height = 13
        Caption = 'Note:'
      end
      object Label4: TLabel
        Left = 24
        Top = 66
        Width = 41
        Height = 13
        Caption = 'Velocity:'
      end
      object VelLabel: TLabel
        Left = 261
        Top = 66
        Width = 39
        Height = 13
        Caption = 'VelLabel'
      end
      object lNoteDur: TLabel
        Left = 20
        Top = 94
        Width = 45
        Height = 13
        Caption = 'Duration:'
        Visible = False
      end
      object lNoteDurRes: TLabel
        Left = 161
        Top = 94
        Width = 8
        Height = 13
        Caption = '()'
      end
      object Velocity: TTrackBar
        Left = 65
        Top = 62
        Width = 193
        Height = 24
        Max = 127
        TabOrder = 1
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = VelocityChange
      end
      object Note: TComboBox
        Left = 71
        Top = 35
        Width = 130
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
      object NoteDur: TSpinEdit
        Left = 71
        Top = 91
        Width = 84
        Height = 22
        MaxValue = 2147483647
        MinValue = 0
        TabOrder = 2
        Value = 0
        Visible = False
      end
    end
    object Empty: TTabSheet
      Caption = 'Empty'
      ImageIndex = 2
    end
    object ProgChange: TTabSheet
      Caption = 'ProgChange'
      ImageIndex = 3
      object Label5: TLabel
        Left = 21
        Top = 38
        Width = 44
        Height = 13
        Caption = 'Program:'
      end
      object CProgram: TComboBox
        Left = 71
        Top = 35
        Width = 155
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
    end
    object Aftertouch: TTabSheet
      Caption = 'Aftertouch'
      ImageIndex = 4
      object Label6: TLabel
        Left = 38
        Top = 67
        Width = 27
        Height = 13
        Caption = 'Note:'
      end
      object Label7: TLabel
        Left = 19
        Top = 38
        Width = 46
        Height = 13
        Caption = 'Pressure:'
      end
      object PrLabel: TLabel
        Left = 260
        Top = 38
        Width = 35
        Height = 13
        Caption = 'PrLabel'
      end
      object ANote: TComboBox
        Left = 71
        Top = 64
        Width = 130
        Height = 21
        Style = csDropDownList
        TabOrder = 1
      end
      object Pressure: TTrackBar
        Left = 65
        Top = 34
        Width = 193
        Height = 24
        Max = 127
        TabOrder = 0
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = PressureChange
      end
    end
    object Pitch: TTabSheet
      Caption = 'Pitch'
      ImageIndex = 5
      object Label8: TLabel
        Left = 10
        Top = 38
        Width = 54
        Height = 13
        Caption = 'Pitch Bend:'
      end
      object PbLabel: TLabel
        Left = 255
        Top = 38
        Width = 37
        Height = 13
        Caption = 'PbLabel'
      end
      object PitchBend: TTrackBar
        Left = 65
        Top = 34
        Width = 189
        Height = 24
        Max = 16383
        TabOrder = 0
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = PitchBendChange
      end
    end
    object Str: TTabSheet
      Caption = 'Str'
      ImageIndex = 6
      object Label9: TLabel
        Left = 38
        Top = 38
        Width = 26
        Height = 13
        Caption = 'Text:'
      end
      object StrEdit: TMemo
        Left = 71
        Top = 35
        Width = 220
        Height = 106
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
    object Ctrl: TTabSheet
      Caption = 'Ctrl'
      ImageIndex = 7
      object Label10: TLabel
        Left = 13
        Top = 38
        Width = 51
        Height = 13
        Caption = 'Controller:'
      end
      object Label11: TLabel
        Left = 150
        Top = 38
        Width = 30
        Height = 13
        Caption = 'Value:'
      end
      object Control: TSpinEdit
        Left = 71
        Top = 35
        Width = 64
        Height = 22
        MaxValue = 127
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object CVal: TSpinEdit
        Left = 185
        Top = 35
        Width = 64
        Height = 22
        MaxValue = 127
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
    object CtrlLevel: TTabSheet
      Caption = 'CtrlLevel'
      ImageIndex = 8
      object Label12: TLabel
        Left = 35
        Top = 38
        Width = 29
        Height = 13
        Caption = 'Level:'
      end
      object LvLabel: TLabel
        Left = 255
        Top = 38
        Width = 36
        Height = 13
        Caption = 'LvLabel'
      end
      object Level: TTrackBar
        Left = 65
        Top = 34
        Width = 189
        Height = 24
        Max = 127
        TabOrder = 0
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = LevelChange
      end
    end
    object CtrlVal: TTabSheet
      Caption = 'CtrlVal'
      ImageIndex = 9
      object Label13: TLabel
        Left = 34
        Top = 38
        Width = 30
        Height = 13
        Caption = 'Value:'
      end
      object CtrlValue: TSpinEdit
        Left = 71
        Top = 35
        Width = 81
        Height = 22
        MaxValue = 127
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
    end
    object CtrlSwitch: TTabSheet
      Caption = 'CtrlSwitch'
      ImageIndex = 10
      object Switch: TRadioGroup
        Left = 11
        Top = 33
        Width = 280
        Height = 51
        Caption = 'Switch'
        Columns = 2
        Items.Strings = (
          'Off'
          'On')
        TabOrder = 0
      end
    end
    object HexEdit: TTabSheet
      Caption = 'HexEdit'
      ImageIndex = 11
      object Label14: TLabel
        Left = 11
        Top = 38
        Width = 27
        Height = 13
        Caption = 'Data:'
      end
      object HexMemo: TMemo
        Left = 45
        Top = 35
        Width = 187
        Height = 106
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Lucida Console'
        Font.Style = []
        Lines.Strings = (
          '30 31 32 33 34 35 36 37'
          '38 39 00 00 00 00 00 00'
          '00 00 00 00 00 00 00 00'
          '00 00 00 00 00 00 00 00')
        ParentFont = False
        PopupMenu = HexKeys
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        WordWrap = False
        OnClick = HexMemoClick
      end
      object CharMemo: TMemo
        Left = 221
        Top = 35
        Width = 82
        Height = 106
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Lucida Console'
        Font.Style = []
        Lines.Strings = (
          '01234567'
          '89      '
          '        '
          '        ')
        ParentFont = False
        PopupMenu = CharMenu
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 3
        WordWrap = False
        OnClick = CharMemoClick
      end
      object Panel1: TPanel
        Left = 214
        Top = 37
        Width = 9
        Height = 102
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 2
        object Panel2: TPanel
          Left = 3
          Top = -1
          Width = 1
          Height = 104
          BevelOuter = bvNone
          TabOrder = 0
        end
      end
      object EditMode: TPanel
        Left = 158
        Top = 9
        Width = 62
        Height = 18
        BevelOuter = bvLowered
        Caption = 'Insert'
        TabOrder = 0
      end
      object ScrollBar: TScrollBar
        Left = 284
        Top = 37
        Width = 17
        Height = 102
        Kind = sbVertical
        Max = 1
        PageSize = 0
        TabOrder = 4
        OnChange = ScrollBarChange
      end
    end
    object SMPTE: TTabSheet
      Caption = 'SMPTE'
      ImageIndex = 12
      object Label15: TLabel
        Left = 14
        Top = 38
        Width = 32
        Height = 13
        Caption = 'Hours:'
      end
      object Label16: TLabel
        Left = 116
        Top = 38
        Width = 41
        Height = 13
        Caption = 'Minutes:'
      end
      object Label17: TLabel
        Left = 209
        Top = 38
        Width = 44
        Height = 13
        Caption = 'Seconds:'
      end
      object Label18: TLabel
        Left = 7
        Top = 66
        Width = 39
        Height = 13
        Caption = 'Frames:'
      end
      object Label19: TLabel
        Left = 116
        Top = 66
        Width = 87
        Height = 13
        Caption = 'Fractional frames:'
      end
      object S_H: TSpinEdit
        Left = 52
        Top = 35
        Width = 58
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object S_M: TSpinEdit
        Left = 163
        Top = 35
        Width = 40
        Height = 22
        MaxValue = 59
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object S_S: TSpinEdit
        Left = 259
        Top = 35
        Width = 40
        Height = 22
        MaxValue = 59
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object S_F: TSpinEdit
        Left = 52
        Top = 63
        Width = 58
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object S_FF: TSpinEdit
        Left = 209
        Top = 63
        Width = 58
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
    end
    object TimeSign: TTabSheet
      Caption = 'TimeSign'
      ImageIndex = 13
      object Label20: TLabel
        Left = 26
        Top = 38
        Width = 55
        Height = 13
        Caption = 'Numerator:'
      end
      object Label21: TLabel
        Left = 16
        Top = 61
        Width = 65
        Height = 26
        Caption = 'Denominator:              2^x:'
        WordWrap = True
      end
      object Label22: TLabel
        Left = 139
        Top = 38
        Width = 92
        Height = 13
        Caption = 'Clocks/metronome:'
      end
      object Label23: TLabel
        Left = 139
        Top = 68
        Width = 100
        Height = 13
        Caption = 'Notated 32nd notes:'
      end
      object T_N: TSpinEdit
        Left = 87
        Top = 35
        Width = 46
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object Panel3: TPanel
        Left = 87
        Top = 60
        Width = 46
        Height = 2
        BevelOuter = bvLowered
        TabOrder = 1
      end
      object T_D: TSpinEdit
        Left = 87
        Top = 65
        Width = 46
        Height = 22
        MaxValue = 31
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object T_C: TSpinEdit
        Left = 245
        Top = 35
        Width = 46
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object T_32: TSpinEdit
        Left = 245
        Top = 65
        Width = 46
        Height = 22
        MaxValue = 255
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
    end
    object KeySign: TTabSheet
      Caption = 'KeySign'
      ImageIndex = 14
      object Label24: TLabel
        Left = 34
        Top = 42
        Width = 30
        Height = 13
        Caption = 'Value:'
      end
      object KeyMsg: TLabel
        Left = 74
        Top = 64
        Width = 36
        Height = 13
        Caption = 'keymsg'
      end
      object KeyRadio: TRadioGroup
        Left = 132
        Top = 31
        Width = 65
        Height = 50
        Items.Strings = (
          'Major'
          'Minor')
        TabOrder = 1
      end
      object KeyVal: TSpinEdit
        Left = 71
        Top = 39
        Width = 50
        Height = 22
        MaxValue = 127
        MinValue = -128
        TabOrder = 0
        Value = 0
        OnChange = KeyValChange
      end
    end
    object MIDIType: TTabSheet
      Caption = 'MIDIType'
      ImageIndex = 15
      object MType: TRadioGroup
        Left = 50
        Top = 5
        Width = 209
        Height = 79
        Items.Strings = (
          '0 = Single multi-channel track'
          '1 = Multi-track (track per channel)'
          '2 = Multi-song (track per pattern)')
        TabOrder = 0
      end
    end
    object Division: TTabSheet
      Caption = 'Division'
      ImageIndex = 16
      object Label25: TLabel
        Left = 20
        Top = 10
        Width = 30
        Height = 13
        Caption = 'Value:'
      end
      object Label26: TLabel
        Left = 14
        Top = 38
        Width = 36
        Height = 13
        Caption = 'SMPTE:'
      end
      object DRes: TRadioGroup
        Left = 120
        Top = 3
        Width = 69
        Height = 54
        Caption = 'Resolution'
        Items.Strings = (
          'PPQN'
          'TPF')
        TabOrder = 2
        OnClick = DResClick
      end
      object DVal: TSpinEdit
        Left = 56
        Top = 7
        Width = 58
        Height = 22
        MaxValue = 32767
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object DSMPTE: TSpinEdit
        Left = 56
        Top = 35
        Width = 58
        Height = 22
        MaxValue = 128
        MinValue = 1
        TabOrder = 1
        Value = 1
      end
    end
    object Search: TTabSheet
      Caption = 'Search'
      ImageIndex = 17
      object Label27: TLabel
        Left = 8
        Top = 38
        Width = 57
        Height = 13
        Caption = 'Event type:'
      end
      object Label28: TLabel
        Left = 26
        Top = 65
        Width = 39
        Height = 13
        Caption = 'Value 1:'
      end
      object Label29: TLabel
        Left = 26
        Top = 92
        Width = 39
        Height = 13
        Caption = 'Value 2:'
      end
      object Label30: TLabel
        Left = 39
        Top = 119
        Width = 26
        Height = 13
        Caption = 'Text:'
      end
      object seVal2: TSpinEdit
        Left = 120
        Top = 89
        Width = 171
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 11
        Value = 0
        Visible = False
      end
      object seVal1: TSpinEdit
        Left = 120
        Top = 62
        Width = 171
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
        Visible = False
      end
      object EType: TComboBox
        Left = 71
        Top = 35
        Width = 119
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 5
        Text = 'Note On'
        OnChange = ETypeChange
        Items.Strings = (
          'Note On'
          'Note Off'
          'Pitch Bend'
          'Program Change'
          'Control Change'
          'Key Pressure'
          'Channel Pressure'
          'System')
      end
      object EVal1: TComboBox
        Left = 120
        Top = 62
        Width = 171
        Height = 21
        Style = csDropDownList
        TabOrder = 7
        OnChange = EVal1Change
      end
      object EVal2: TComboBox
        Left = 120
        Top = 89
        Width = 171
        Height = 21
        Style = csDropDownList
        TabOrder = 10
        OnChange = EVal2Change
      end
      object EText: TEdit
        Left = 71
        Top = 116
        Width = 220
        Height = 21
        TabOrder = 12
      end
      object EDelta: TSpinEdit
        Left = 120
        Top = 7
        Width = 70
        Height = 22
        Enabled = False
        MaxValue = 2147483647
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object ETickOp: TComboBox
        Left = 71
        Top = 7
        Width = 46
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 1
        Text = 'any'
        OnChange = ETickOpChange
        Items.Strings = (
          'any'
          '='
          '!='
          '>'
          '<'
          '>='
          '<=')
      end
      object FChn: TComboBox
        Left = 249
        Top = 7
        Width = 45
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'any'
        OnChange = FChnChange
        Items.Strings = (
          'any'
          '1'
          '2'
          '3'
          '4'
          '5'
          '6'
          '7'
          '8'
          '9'
          '10'
          '11'
          '12'
          '13'
          '14'
          '15'
          '16')
      end
      object StaticText3: TStaticText
        Left = 10
        Top = 10
        Width = 57
        Height = 17
        Caption = 'Delta-time:'
        TabOrder = 0
      end
      object StaticText4: TStaticText
        Left = 198
        Top = 10
        Width = 47
        Height = 17
        Caption = 'Channel:'
        TabOrder = 3
      end
      object EVal1Op: TComboBox
        Left = 71
        Top = 62
        Width = 46
        Height = 21
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 6
        Text = '='
        Items.Strings = (
          'any'
          '='
          '!='
          '>'
          '<'
          '>='
          '<=')
      end
      object EVal2Op: TComboBox
        Left = 71
        Top = 89
        Width = 46
        Height = 21
        Style = csDropDownList
        ItemIndex = 1
        TabOrder = 9
        Text = '='
        Items.Strings = (
          'any'
          '='
          '!='
          '>'
          '<'
          '>='
          '<=')
      end
    end
    object Tracks: TTabSheet
      Caption = 'Tracks'
      ImageIndex = 18
      object clbTracks: TCheckListBox
        Left = 5
        Top = 6
        Width = 297
        Height = 191
        OnClickCheck = clbTracksClickCheck
        ItemHeight = 13
        TabOrder = 0
      end
    end
  end
  object bOk: TButton
    Left = 76
    Top = 115
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object bCancel: TButton
    Left = 157
    Top = 115
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object DeltaTime: TSpinEdit
    Left = 70
    Top = 26
    Width = 81
    Height = 22
    MaxValue = 2147483647
    MinValue = 0
    TabOrder = 0
    Value = 1
  end
  object StaticText1: TStaticText
    Left = 10
    Top = 29
    Width = 57
    Height = 17
    Caption = 'Delta-time:'
    TabOrder = 5
  end
  object StaticText2: TStaticText
    Left = 195
    Top = 29
    Width = 47
    Height = 17
    Caption = 'Channel:'
    TabOrder = 6
  end
  object Chn: TComboBox
    Left = 248
    Top = 26
    Width = 45
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = '1'
    OnChange = ChnChange
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16')
  end
  object Keys: TActionList
    Left = 216
    Top = 144
    object KEsc: TAction
      Caption = 'KEsc'
      ShortCut = 27
      OnExecute = KEscExecute
    end
  end
  object HexKeys: TPopupMenu
    Left = 96
    Top = 144
    object Ins1: TMenuItem
      Caption = 'Ins'
      ShortCut = 45
      Visible = False
      OnClick = Ins1Click
    end
    object Tab1: TMenuItem
      Caption = 'Tab'
      ShortCut = 9
      Visible = False
      OnClick = KTabExecute
    end
    object Left2: TMenuItem
      Caption = 'Left'
      ShortCut = 37
      Visible = False
      OnClick = Left2Click
    end
    object Right1: TMenuItem
      Caption = 'Right'
      ShortCut = 39
      Visible = False
      OnClick = KRightExecute
    end
    object Up1: TMenuItem
      Caption = 'Up'
      ShortCut = 38
      Visible = False
      OnClick = Up1Click
    end
    object Down1: TMenuItem
      Caption = 'Down'
      ShortCut = 40
      Visible = False
      OnClick = Down1Click
    end
    object Del1: TMenuItem
      Caption = 'Del'
      ShortCut = 46
      Visible = False
      OnClick = Del1Click
    end
    object Backspace1: TMenuItem
      Caption = 'Backspace'
      ShortCut = 8
      Visible = False
      OnClick = Backspace1Click
    end
    object N01: TMenuItem
      Caption = '0'
      ShortCut = 48
      Visible = False
      OnClick = N01Click
    end
    object N11: TMenuItem
      Caption = '1'
      ShortCut = 49
      Visible = False
      OnClick = N11Click
    end
    object N21: TMenuItem
      Caption = '2'
      ShortCut = 50
      Visible = False
      OnClick = N21Click
    end
    object N31: TMenuItem
      Caption = '3'
      ShortCut = 51
      Visible = False
      OnClick = N31Click
    end
    object N41: TMenuItem
      Caption = '4'
      ShortCut = 52
      Visible = False
      OnClick = N41Click
    end
    object N51: TMenuItem
      Caption = '5'
      ShortCut = 53
      Visible = False
      OnClick = N51Click
    end
    object N61: TMenuItem
      Caption = '6'
      ShortCut = 54
      Visible = False
      OnClick = N61Click
    end
    object N71: TMenuItem
      Caption = '7'
      ShortCut = 55
      Visible = False
      OnClick = N71Click
    end
    object N81: TMenuItem
      Caption = '8'
      ShortCut = 56
      Visible = False
      OnClick = N81Click
    end
    object N91: TMenuItem
      Caption = '9'
      ShortCut = 57
      Visible = False
      OnClick = N91Click
    end
    object A1: TMenuItem
      Caption = 'A'
      ShortCut = 65
      Visible = False
      OnClick = A1Click
    end
    object B1: TMenuItem
      Caption = 'B'
      ShortCut = 66
      Visible = False
      OnClick = B1Click
    end
    object C1: TMenuItem
      Caption = 'C'
      ShortCut = 67
      Visible = False
      OnClick = C1Click
    end
    object D1: TMenuItem
      Caption = 'D'
      ShortCut = 68
      Visible = False
      OnClick = D1Click
    end
    object E1: TMenuItem
      Caption = 'E'
      ShortCut = 69
      Visible = False
      OnClick = E1Click
    end
    object F1: TMenuItem
      Caption = 'F'
      ShortCut = 70
      Visible = False
      OnClick = F1Click
    end
  end
  object CharMenu: TPopupMenu
    Left = 152
    Top = 144
    object Ins2: TMenuItem
      Caption = 'Ins'
      ShortCut = 45
      Visible = False
      OnClick = Ins1Click
    end
    object Tab2: TMenuItem
      Caption = 'Tab'
      ShortCut = 9
      Visible = False
      OnClick = Tab2Click
    end
    object Left1: TMenuItem
      Caption = 'Left'
      ShortCut = 37
      Visible = False
      OnClick = Left1Click
    end
    object Right2: TMenuItem
      Caption = 'Right'
      ShortCut = 39
      Visible = False
      OnClick = Right2Click
    end
    object Up2: TMenuItem
      Caption = 'Up'
      ShortCut = 38
      Visible = False
      OnClick = Up1Click
    end
    object Down2: TMenuItem
      Caption = 'Down'
      ShortCut = 40
      Visible = False
      OnClick = Down1Click
    end
  end
  object ScrollTimer: TTimer
    Interval = 10
    OnTimer = ScrollTimerTimer
    Left = 272
    Top = 144
  end
end
