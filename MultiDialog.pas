unit MultiDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, MIDIConsts, ExtCtrls, ActnList, Menus,
  CheckLst;

type
  TEditDialog = class(TForm)
    PageControl1: TPageControl;
    Range: TTabSheet;
    RangeFrom: TSpinEdit;
    Label1: TLabel;
    RangeTo: TSpinEdit;
    Label2: TLabel;
    bOk: TButton;
    bCancel: TButton;
    TNote: TTabSheet;
    Velocity: TTrackBar;
    Note: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    VelLabel: TLabel;
    DeltaTime: TSpinEdit;
    StaticText1: TStaticText;
    Empty: TTabSheet;
    StaticText2: TStaticText;
    Chn: TComboBox;
    ProgChange: TTabSheet;
    CProgram: TComboBox;
    Label5: TLabel;
    Aftertouch: TTabSheet;
    ANote: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Pressure: TTrackBar;
    PrLabel: TLabel;
    Pitch: TTabSheet;
    Label8: TLabel;
    PitchBend: TTrackBar;
    PbLabel: TLabel;
    Str: TTabSheet;
    Label9: TLabel;
    StrEdit: TMemo;
    Ctrl: TTabSheet;
    Label10: TLabel;
    Label11: TLabel;
    Control: TSpinEdit;
    CVal: TSpinEdit;
    CtrlLevel: TTabSheet;
    Label12: TLabel;
    Level: TTrackBar;
    LvLabel: TLabel;
    CtrlVal: TTabSheet;
    Label13: TLabel;
    CtrlValue: TSpinEdit;
    CtrlSwitch: TTabSheet;
    Switch: TRadioGroup;
    HexEdit: TTabSheet;
    HexMemo: TMemo;
    Label14: TLabel;
    CharMemo: TMemo;
    Panel1: TPanel;
    EditMode: TPanel;
    Keys: TActionList;
    HexKeys: TPopupMenu;
    Tab1: TMenuItem;
    Right1: TMenuItem;
    KEsc: TAction;
    CharMenu: TPopupMenu;
    Tab2: TMenuItem;
    Ins1: TMenuItem;
    Ins2: TMenuItem;
    Right2: TMenuItem;
    Left1: TMenuItem;
    Left2: TMenuItem;
    Panel2: TPanel;
    Up1: TMenuItem;
    Down1: TMenuItem;
    Up2: TMenuItem;
    Down2: TMenuItem;
    ScrollBar: TScrollBar;
    ScrollTimer: TTimer;
    N01: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    A1: TMenuItem;
    B1: TMenuItem;
    C1: TMenuItem;
    D1: TMenuItem;
    E1: TMenuItem;
    F1: TMenuItem;
    Del1: TMenuItem;
    Backspace1: TMenuItem;
    SMPTE: TTabSheet;
    TimeSign: TTabSheet;
    KeySign: TTabSheet;
    Label15: TLabel;
    S_H: TSpinEdit;
    Label16: TLabel;
    S_M: TSpinEdit;
    Label17: TLabel;
    S_S: TSpinEdit;
    S_F: TSpinEdit;
    Label18: TLabel;
    S_FF: TSpinEdit;
    Label19: TLabel;
    Label20: TLabel;
    T_N: TSpinEdit;
    Panel3: TPanel;
    T_D: TSpinEdit;
    Label21: TLabel;
    T_C: TSpinEdit;
    Label22: TLabel;
    T_32: TSpinEdit;
    Label23: TLabel;
    KeyRadio: TRadioGroup;
    Label24: TLabel;
    KeyVal: TSpinEdit;
    KeyMsg: TLabel;
    MIDIType: TTabSheet;
    MType: TRadioGroup;
    Division: TTabSheet;
    DRes: TRadioGroup;
    DVal: TSpinEdit;
    Label25: TLabel;
    Label26: TLabel;
    DSMPTE: TSpinEdit;
    Search: TTabSheet;
    EType: TComboBox;
    Label27: TLabel;
    EVal1: TComboBox;
    Label28: TLabel;
    EVal2: TComboBox;
    Label29: TLabel;
    Label30: TLabel;
    EText: TEdit;
    EDelta: TSpinEdit;
    ETickOp: TComboBox;
    FChn: TComboBox;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    EVal1Op: TComboBox;
    EVal2Op: TComboBox;
    NoteDur: TSpinEdit;
    lNoteDur: TLabel;
    lNoteDurRes: TLabel;
    seVal1: TSpinEdit;
    seVal2: TSpinEdit;
    Tracks: TTabSheet;
    clbTracks: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure VelocityChange(Sender: TObject);
    procedure ChnChange(Sender: TObject);
    procedure PressureChange(Sender: TObject);
    procedure PitchBendChange(Sender: TObject);
    procedure LevelChange(Sender: TObject);
    procedure KRightExecute(Sender: TObject);
    procedure KTabExecute(Sender: TObject);
    procedure KEscExecute(Sender: TObject);
    procedure Tab2Click(Sender: TObject);
    procedure Ins1Click(Sender: TObject);
    procedure Right2Click(Sender: TObject);
    procedure Left1Click(Sender: TObject);
    procedure CharMemoClick(Sender: TObject);
    procedure HexMemoClick(Sender: TObject);
    procedure Left2Click(Sender: TObject);
    procedure Up1Click(Sender: TObject);
    procedure Down1Click(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure ScrollTimerTimer(Sender: TObject);
    procedure Del1Click(Sender: TObject);
    procedure Backspace1Click(Sender: TObject);
    procedure N01Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N91Click(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure KeyValChange(Sender: TObject);
    procedure DResClick(Sender: TObject);
    procedure RangeToChange(Sender: TObject);
    procedure RangeFromChange(Sender: TObject);
    procedure ETypeChange(Sender: TObject);
    procedure EVal1Change(Sender: TObject);
    procedure EVal2Change(Sender: TObject);
    procedure ETickOpChange(Sender: TObject);
    procedure FChnChange(Sender: TObject);
    procedure clbTracksClickCheck(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    HexArray: Array of Byte;
    AllTracks: Boolean;
    MinTracks: Integer;
    procedure ChangeHeight(Cnt: Integer);
    procedure FillHex;
    procedure EditHex(B: Byte);
  end;

var
  EditDialog: TEditDialog;

implementation

{$R *.dfm}

uses
  Main;

procedure TEditDialog.KEscExecute(Sender: TObject);
begin
  bCancel.Click;
end;

procedure TEditDialog.KeyValChange(Sender: TObject);
begin
  case KeyVal.Value of
    -128..-1:
      KeyMsg.Caption:='flat(s)';
    0:
      KeyMsg.Caption:='Key of C';
    1..127:
      KeyMsg.Caption:='sharp(s)';
  end;
end;

procedure TEditDialog.KTabExecute(Sender: TObject);
begin
  EditDialog.ActiveControl:=CharMemo;
end;

procedure TEditDialog.Tab2Click(Sender: TObject);
begin
  EditDialog.ActiveControl:=HexMemo;
end;

procedure TEditDialog.A1Click(Sender: TObject);
begin
  EditHex(10);
end;

procedure TEditDialog.B1Click(Sender: TObject);
begin
  EditHex(11);
end;

procedure TEditDialog.Backspace1Click(Sender: TObject);
var
  P,I: Integer;
  Pn: TPoint;
  Sc: Integer;
begin
  P:=((HexMemo.CaretPos.X+1) div 3)+(HexMemo.CaretPos.Y*8)-1;
  Sc:=ScrollBar.Position;
  if P<0 then Exit;
  Pn.X:=HexMemo.CaretPos.X;
  Pn.Y:=HexMemo.CaretPos.Y;
  for I:=P+1 to Length(HexArray)-1 do
    HexArray[I-1]:=HexArray[I];
  SetLength(HexArray, Length(HexArray)-1);
  if (Pn.Y=HexMemo.Lines.Count-1) and (Pn.X=3) then begin
    Pn.Y:=Pn.Y-1;
    Pn.X:=23;
  end else
    Pn.X:=Pn.X-3;
  FillHex;
  if HexMemo.Lines.Count-8>=0 then
    ScrollBar.Max:=HexMemo.Lines.Count-8
  else
    ScrollBar.Max:=0;
  HexMemo.CaretPos:=Pn;
  ScrollBar.Position:=Sc;
  ScrollBarChange(Sender);
end;

procedure TEditDialog.C1Click(Sender: TObject);
begin
  EditHex(12);
end;

procedure TEditDialog.ChangeHeight(Cnt: Integer);
begin
  ClientHeight:=(28*(Cnt+2))+10;
  bOk.Top:=ClientHeight-bOk.Height-6;
  bCancel.Top:=ClientHeight-bCancel.Height-6;
end;

procedure TEditDialog.ChnChange(Sender: TObject);
var
  I: Byte;
  V1,V2: Integer;
begin
  V1:=CProgram.ItemIndex;
  CProgram.Items.Clear;
  for I := 0 to 127 do
    CProgram.Items.Add(IntToStr(I) + ': ' + MainForm.GetInstName(I, Chn.ItemIndex));
  CProgram.ItemIndex:=V1;
  V1:=Note.ItemIndex;
  V2:=ANote.ItemIndex;
  Note.Clear;
  ANote.Clear;
  if Chn.ItemIndex<>9 then
    for I:=127 downto 0 do begin
      Note.Items.Add(IntToStr(I)+': '+NoteNum(I));
      ANote.Items.Add(IntToStr(I)+': '+NoteNum(I));
    end
  else
    for I:=0 to 127 do begin
      Note.Items.Add(IntToStr(I)+': '+DrumTable[I]);
      ANote.Items.Add(IntToStr(I)+': '+DrumTable[I]);
    end;
  Note.ItemIndex:=V1;
  ANote.ItemIndex:=V2;
  ETypeChange(Sender);
end;

procedure TEditDialog.FChnChange(Sender: TObject);
begin
  if FChn.ItemIndex>0 then
    Chn.ItemIndex:=FChn.ItemIndex-1
  else
    Chn.ItemIndex:=0;
  ChnChange(Sender);
end;

procedure TEditDialog.F1Click(Sender: TObject);
begin
  EditHex(15);
end;

procedure TEditDialog.FillHex;
var
  I: Integer;
  S: String;
begin
  HexMemo.Text:='';
  CharMemo.Text:='';
  for I:=0 to Length(HexArray)-1 do begin
    HexMemo.Text:=
    HexMemo.Text+IntToHex(HexArray[I], 2);
    case HexArray[I] of
      0..31,127:
        CharMemo.Text:=
        CharMemo.Text+'.';
      32..126,128..255:
        CharMemo.Text:=
        CharMemo.Text+AnsiChar(HexArray[I]);
    end;
    if I mod 8 = 7 then begin
      HexMemo.Text:=EditDialog.HexMemo.Text+#13#10;
      CharMemo.Text:=EditDialog.CharMemo.Text+#13#10;
    end else
      HexMemo.Text:=EditDialog.HexMemo.Text+' ';
  end;
  if HexMemo.Lines.Count-8>=0 then
    ScrollBar.Max:=HexMemo.Lines.Count-8
  else
    ScrollBar.Max:=0;
  S := CharMemo.Text;
  if (Length(S) > 0) and (S[Length(S)-1] = #13) and (S[Length(S)] = #10) then
    Delete(S, Length(S)-1, 2);
  CharMemo.Text := S;
  S := HexMemo.Text;
  if (Length(S) > 0) and (S[Length(S)-1] = #13) and (S[Length(S)] = #10) then
    Delete(S, Length(S)-1, 2);
  HexMemo.Text := S;
end;

procedure TEditDialog.FormCreate(Sender: TObject);
var
  Margin: Integer;
begin
  Margin:=20;
  ClientWidth:=305;
  ClientHeight:=146;
  EditDialog.PageControl1.Top:=EditDialog.PageControl1.Top-Margin;
  DeltaTime.Top:=DeltaTime.Top-Margin;
  Chn.Top:=Chn.Top-Margin;
  StaticText1.Top:=StaticText1.Top-Margin;
  StaticText2.Top:=StaticText2.Top-Margin;
  bOk.Top:=bOk.Top-Margin;
  bCancel.Top:=bCancel.Top-Margin;
  EditDialog.Height:=EditDialog.Height-Margin;
end;

procedure TEditDialog.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if CanClose then
    bOk.Enabled := True;
end;

procedure TEditDialog.Ins1Click(Sender: TObject);
begin
  if EditMode.Caption='Insert' then
    EditMode.Caption:='Overwrite'
  else
    EditMode.Caption:='Insert';
end;

procedure TEditDialog.LevelChange(Sender: TObject);
begin
  LvLabel.Caption:=IntToStr(Level.Position);
end;

procedure TEditDialog.N01Click(Sender: TObject);
begin
  EditHex(0);
end;

procedure TEditDialog.N11Click(Sender: TObject);
begin
  EditHex(1);
end;

procedure TEditDialog.N21Click(Sender: TObject);
begin
  EditHex(2);
end;

procedure TEditDialog.N31Click(Sender: TObject);
begin
  EditHex(3);
end;

procedure TEditDialog.N41Click(Sender: TObject);
begin
  EditHex(4);
end;

procedure TEditDialog.N51Click(Sender: TObject);
begin
  EditHex(5);
end;

procedure TEditDialog.N61Click(Sender: TObject);
begin
  EditHex(6);
end;

procedure TEditDialog.N71Click(Sender: TObject);
begin
  EditHex(7);
end;

procedure TEditDialog.N81Click(Sender: TObject);
begin
  EditHex(8);
end;

procedure TEditDialog.N91Click(Sender: TObject);
begin
  EditHex(9);
end;

procedure TEditDialog.PitchBendChange(Sender: TObject);
begin
  PbLabel.Caption:=IntToStr(PitchBend.Position);
end;

procedure TEditDialog.PressureChange(Sender: TObject);
begin
  PrLabel.Caption:=IntToStr(Pressure.Position);
end;

procedure TEditDialog.VelocityChange(Sender: TObject);
begin
  VelLabel.Caption:=IntToStr(Velocity.Position);
end;

procedure TEditDialog.Left1Click(Sender: TObject);
var
  P: TPoint;
  LF: Boolean;
begin
  P:=CharMemo.CaretPos;
  LF:=False;
  if (P.Y<HexMemo.Lines.Count-7) and (P.X=0) then LF:=True;
  if P.X=0 then begin
    if P.Y>0 then
      P.X:=P.X-3
  end else
    P.X:=P.X-1;
  CharMemo.CaretPos:=P;
  if LF then begin
    HexMemo.Perform(WM_VSCROLL, SB_LINEUP, 0);
    CharMemo.Perform(WM_VSCROLL, SB_LINEUP, 0);
  end;
end;

procedure TEditDialog.RangeFromChange(Sender: TObject);
begin
  if RangeFrom.Value>RangeTo.Value then
    RangeFrom.Value:=RangeFrom.Value-1;
  if RangeFrom.Value<RangeFrom.MinValue then
    RangeFrom.Value:=RangeFrom.MinValue;
end;

procedure TEditDialog.RangeToChange(Sender: TObject);
begin
  if RangeFrom.Value>RangeTo.Value then
    RangeTo.Value:=RangeTo.Value+1;
  if RangeTo.Value<RangeTo.MinValue then
    RangeTo.Value:=RangeTo.MinValue;
end;

procedure TEditDialog.Right2Click(Sender: TObject);
var
  P: TPoint;
  LF: Boolean;
begin
  P:=CharMemo.CaretPos;
  LF:=False;
  if (P.Y>=7) and (P.X>6) then LF:=True;
  if P.X=7 then
    P.X:=P.X+3
  else
    P.X:=P.X+1;
  CharMemo.CaretPos:=P;
  if LF then begin
    HexMemo.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    CharMemo.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TEditDialog.ScrollBarChange(Sender: TObject);
var
  SPos: Cardinal;
begin
  SPos:=(ScrollBar.Position shl 16) or SB_THUMBPOSITION;
  HexMemo.Perform(WM_VSCROLL, SPos, 0);
  CharMemo.Perform(WM_VSCROLL, SPos, 0);
end;

procedure TEditDialog.ScrollTimerTimer(Sender: TObject);
var
  SPos: Cardinal;
begin
  if EditDialog.ActiveControl=CharMemo then
    SPos:=GetScrollPos(CharMemo.Handle, SB_VERT)
  else
    SPos:=GetScrollPos(HexMemo.Handle, SB_VERT);
  ScrollBar.Position:=SPos;
end;

procedure TEditDialog.CharMemoClick(Sender: TObject);
var
  P: TPoint;
begin
  P:=CharMemo.CaretPos;
  if P.X=8 then
    P.X:=P.X+2;
  CharMemo.CaretPos:=P;
end;

procedure TEditDialog.Left2Click(Sender: TObject);
var
  P: TPoint;
  LF: Boolean;
begin
  P:=HexMemo.CaretPos;
  LF:=False;
  if (P.Y<HexMemo.Lines.Count-7) and (P.X=0) then LF:=True;
  case P.X of
    0:
      if P.Y>0 then P.X:=P.X-3;
    3,6,9,12,15,18,21:
      P.X:=P.X-2;
    else
      P.X:=P.X-1;
  end;
  HexMemo.CaretPos:=P;
  if LF then begin
    HexMemo.Perform(WM_VSCROLL, SB_LINEUP, 0);
    CharMemo.Perform(WM_VSCROLL, SB_LINEUP, 0);
  end;
end;

procedure TEditDialog.KRightExecute(Sender: TObject);
var
  P: TPoint;
  LF: Boolean;
begin
  P:=HexMemo.CaretPos;
  LF:=False;
  if (P.Y>=7) and (P.X>21) then LF:=True;
  case P.X of
    1,4,7,10,13,16,19: P.X:=P.X+2;
    22..23: P.X:=P.X+3;
    else
      P.X:=P.X+1;
  end;
  HexMemo.CaretPos:=P;
  if LF then begin
    HexMemo.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    CharMemo.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TEditDialog.Up1Click(Sender: TObject);
var
  P: TPoint;
begin
  if EditDialog.ActiveControl=CharMemo then begin
    P:=CharMemo.CaretPos;
    if P.Y>0 then P.Y:=P.Y-1;
    CharMemo.CaretPos:=P;
    P.X:=HexMemo.CaretPos.X;
    HexMemo.CaretPos:=P;
  end else begin
    P:=HexMemo.CaretPos;
    if P.Y>0 then P.Y:=P.Y-1;
    HexMemo.CaretPos:=P;
    P.X:=CharMemo.CaretPos.X;
    CharMemo.CaretPos:=P;
  end;
  if P.Y<HexMemo.Lines.Count-7 then begin
    HexMemo.Perform(WM_VSCROLL, SB_LINEUP, 0);
    CharMemo.Perform(WM_VSCROLL, SB_LINEUP, 0);
  end;
end;

procedure TEditDialog.D1Click(Sender: TObject);
begin
  EditHex(13);
end;

procedure TEditDialog.Del1Click(Sender: TObject);
var
  P,I: Integer;
  Pn: TPoint;
  Sc: Integer;
begin
  P:=(HexMemo.CaretPos.X div 3)+(HexMemo.CaretPos.Y*8);
  Sc:=ScrollBar.Position;
  if P=Length(HexArray) then Exit;
  Pn.X:=HexMemo.CaretPos.X;
  Pn.Y:=HexMemo.CaretPos.Y;
  for I:=P+1 to Length(HexArray)-1 do
    HexArray[I-1]:=HexArray[I];
  SetLength(HexArray, Length(HexArray)-1);
  if P=Length(HexArray) then Pn.X:=Pn.X-3;
  FillHex;
  if HexMemo.Lines.Count-8>=0 then
    ScrollBar.Max:=HexMemo.Lines.Count-8
  else
    ScrollBar.Max:=0;
  HexMemo.CaretPos:=Pn;
  ScrollBar.Position:=Sc;
  ScrollBarChange(Sender);
end;

procedure TEditDialog.Down1Click(Sender: TObject);
var
  P: TPoint;
begin
  if EditDialog.ActiveControl=CharMemo then begin
    P:=CharMemo.CaretPos;
    if P.Y<CharMemo.Lines.Count-1 then P.Y:=P.Y+1;
    CharMemo.CaretPos:=P;
    P.X:=HexMemo.CaretPos.X;
    HexMemo.CaretPos:=P;
  end else begin
    P:=HexMemo.CaretPos;
    if P.Y<HexMemo.Lines.Count-1 then P.Y:=P.Y+1;
    HexMemo.CaretPos:=P;
    P.X:=CharMemo.CaretPos.X;
    CharMemo.CaretPos:=P;
  end;
  if P.Y>7 then begin
    HexMemo.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    CharMemo.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TEditDialog.DResClick(Sender: TObject);
begin
  case DRes.ItemIndex of
    0: begin
      DVal.MaxValue:=32767;
      Label26.Enabled:=False;
      DSMPTE.Enabled:=False;
    end;
    1: begin
      DVal.MaxValue:=255;
      Label26.Enabled:=True;
      DSMPTE.Enabled:=True;
    end;
  end;
end;

procedure TEditDialog.E1Click(Sender: TObject);
begin
  EditHex(14);
end;

procedure TEditDialog.EditHex(B: Byte);
var
  P,I: Integer;
  Pn: TPoint;
  Sc: Integer;
begin
  Sc:=ScrollBar.Position;
  Pn.X:=HexMemo.CaretPos.X;
  Pn.Y:=HexMemo.CaretPos.Y;
  P:=((HexMemo.CaretPos.X+1) div 3)+(HexMemo.CaretPos.Y*8);
  if EditMode.Caption='Overwrite' then begin
    if P>=Length(HexArray) then
      Exit;
    case HexMemo.CaretPos.X of
      0,2,3,5,6,8,9,11,12,14,15,17,18,20,21,23,24,26,27:
        HexArray[P]:=(HexArray[P] and 15) or (B shl 4);
      1,4,7,10,13,16,19,22,25:
        HexArray[P]:=(HexArray[P] and 240) or (B and 15);
  end;
  end else begin
    case HexMemo.CaretPos.X of
      0,2,3,5,6,8,9,11,12,14,15,17,18,20,21,23,24,26,27: begin
        SetLength(HexArray, Length(HexArray)+1);
        for I:=Length(HexArray)-1 downto P+1 do
          HexArray[I]:=HexArray[I-1];
        HexArray[P]:=0;

        HexArray[P]:=(HexArray[P] and 15) or (B shl 4);
      end;
      1,4,7,10,13,16,19,22,25:
        HexArray[P]:=(HexArray[P] and 240) or (B and 15);
    end;
  end;
  FillHex;
  if HexMemo.Lines.Count-8>=0 then
    ScrollBar.Max:=HexMemo.Lines.Count-8
  else
    ScrollBar.Max:=0;
  HexMemo.CaretPos:=Pn;
  ScrollBar.Position:=Sc;
  ScrollBarChange(nil);
  KRightExecute(nil);
end;

procedure TEditDialog.ETickOpChange(Sender: TObject);
begin
  EDelta.Enabled:=(ETickOp.ItemIndex>0);
end;

procedure TEditDialog.ETypeChange(Sender: TObject);
var
  I: Integer;
begin
  EVal1.Clear;
  EVal2.Clear;
  EVal1.Visible := True;
  EVal2.Visible := True;
  seVal1.Visible := False;
  seVal2.Visible := False;
  StaticText4.Enabled := EType.ItemIndex < 7;
  FChn.Enabled := EType.ItemIndex < 7;
  Label29.Enabled:=False;
  EVal2.Enabled:=False;
  EVal1Op.Enabled:=False;
  EVal2Op.Enabled:=False;
  Label30.Enabled:=False;
  EText.Enabled:=False;
  case EType.ItemIndex of
    0..1,5: begin
      Label29.Enabled:=True;
      EVal2.Visible := False;
      EVal1Op.Enabled:=True;
      EVal2Op.Enabled:=True;
      if Chn.ItemIndex<>9 then
        for I:=127 downto 0 do begin
          EVal1.Items.Add(IntToStr(I)+': '+NoteNum(I));
        end
      else
        for I:=0 to 127 do begin
          EVal1.Items.Add(IntToStr(I)+': '+DrumTable[I]);
        end;
      seVal2.MinValue := 0;
      seVal2.MaxValue := 127;
      if Chn.ItemIndex<>9 then
        EVal1.ItemIndex:=127-48
      else
        EVal1.ItemIndex:=48;
      if EType.ItemIndex<>1 then
        seVal2.Value := 127
      else
        seVal2.Value := 0;
      seVal2.Enabled := True;
      seVal2.Visible := True;
    end;
    2: begin
      EVal1.Visible := False;
      seVal1.MinValue := 0;
      seVal1.MaxValue := 16383;
      seVal1.Value := 8192;
      EVal1Op.Enabled:=True;
      seVal1.Enabled := True;
      seVal1.Visible := True;
    end;
    3: begin
      for I := 0 to 127 do
        EVal1.Items.Add(IntToStr(I) + ': ' + MainForm.GetInstName(I, Chn.ItemIndex));
      EVal1.ItemIndex:=0;
      EVal1Op.Enabled:=True;
    end;
    4: begin
      Label29.Enabled:=True;
      EVal2.Visible := False;
      for I:=0 to 127 do
        EVal1.Items.Add(ControlTable[I]);
      EVal1.ItemIndex:=7;
      EVal1Op.Enabled:=True;
      EVal2Op.Enabled:=True;
      seVal2.MinValue := 0;
      seVal2.MaxValue := 127;
      seVal2.Value := 127;
      seVal2.Enabled := True;
      seVal2.Visible := True;
    end;
    6: begin
      EVal1.Visible := False;
      seVal1.MinValue := 0;
      seVal1.MaxValue := 127;
      seVal1.Value := 127;
      EVal1Op.Enabled:=True;
      seVal1.Enabled := True;
      seVal1.Visible := True;
    end;
    7: begin
      Label29.Enabled:=True;
      EVal2.Enabled:=True;
      for I:=0 to 15 do
        EVal1.Items.Add(SystemTable[I]);
      EVal1.ItemIndex:=0;
      EVal1Op.ItemIndex:=1;
    end;
  end;
  EVal1Change(Sender);
end;

procedure TEditDialog.EVal1Change(Sender: TObject);
var
  I: Integer;
begin
  if EType.ItemIndex <> 7 then
    Exit;
  Label29.Enabled:=False;
  EVal2.Clear;
  EVal2.Visible := True;
  EVal2.Enabled:=False;
  EVal2Op.Enabled:=False;
  seVal2.Visible := False;
  Label30.Enabled := False;
  EText.Enabled := False;
  case EVal1.ItemIndex of
    2: begin
      Label29.Enabled:=True;
      EVal2.Visible := False;
      seVal2.MinValue := 0;
      seVal2.MaxValue := 16383;
      seVal2.Value := 0;
      EVal2Op.Enabled:=True;
      seVal2.Enabled := True;
      seVal2.Visible := True;
    end;
    3: begin
      Label29.Enabled:=True;
      EVal2.Visible := False;
      seVal2.MinValue := 0;
      seVal2.MaxValue := 127;
      seVal2.Value := 0;
      EVal2Op.Enabled:=True;
      seVal2.Enabled := True;
      seVal2.Visible := True;
    end;
    15: begin
      Label29.Enabled:=True;
      EVal2.Enabled:=True;
      for I:=0 to 127 do
        EVal2.Items.Add(IntToStr(I)+': '+MetaTable[I]);
      EVal2.ItemIndex:=1;
    end;
  end;
  EVal2Change(Sender);
end;

procedure TEditDialog.EVal2Change(Sender: TObject);
begin
  if (EType.ItemIndex=7) and (EVal1.ItemIndex=15) then begin
    Label30.Enabled:=False;
    EText.Enabled:=False;
    case EVal2.ItemIndex of
      1..7: begin
        Label30.Enabled:=True;
        EText.Enabled:=True;
      end;
    end;
  end;
end;

procedure TEditDialog.HexMemoClick(Sender: TObject);
var
  P: TPoint;
begin
  P:=HexMemo.CaretPos;
  if P.X in [2,5,8,11,14,17,20] then
    P.X:=P.X+1;
  if P.X=23 then
    P.X:=P.X+2;
  HexMemo.CaretPos:=P;
end;

procedure TEditDialog.clbTracksClickCheck(Sender: TObject);
var
  Accept, Diff: Boolean;
  Cnt, I: Integer;
begin
  Accept := False;
  if clbTracks.Count > 0 then
  begin
    if AllTracks <> clbTracks.Checked[0] then
    begin
      AllTracks := clbTracks.Checked[0];
      if AllTracks then
        clbTracks.CheckAll(cbChecked)
      else
        clbTracks.CheckAll(cbUnchecked);
    end
    else
    begin
      Diff := False;
      for I := 2 to clbTracks.Count - 1 do
        if clbTracks.Checked[I] <> clbTracks.Checked[1] then
        begin
          Diff := True;
          Break;
        end;
      AllTracks := (not Diff) and clbTracks.Checked[1];
      clbTracks.Checked[0] := AllTracks;
    end;
    Cnt := 0;
    for I := 1 to clbTracks.Count - 1 do
    begin
      if clbTracks.Checked[I] then
        Inc(Cnt);
      if Cnt >= MinTracks then
      begin
        Accept := True;
        Break;
      end;
    end;
  end;
  bOk.Enabled := Accept;
end;

end.
