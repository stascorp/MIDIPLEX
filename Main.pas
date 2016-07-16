unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, MIDIConsts, Grids, Math, Menus, Buttons,
  ActnList, MultiDialog, ClipBrd, MMSystem, ValEdit, IFFTrees;

const
  WM_EVENTIDX = WM_USER + 110;
  WM_TRACKIDX = WM_USER + 111;
  WM_SETVU = WM_USER + 112;

type
  FILE_VERSION = record
    Version: record case Boolean of
      True: (dw: DWORD);
      False: (w: record
        Minor, Major: Word;
      end;)
    end;
    Release, Build: Word;
    bDebug, bPrerelease, bPrivate, bSpecial: Boolean;
  end;
  TPlayerInfo = record
    TrackID, TrackPos: Integer;
    Notify: Boolean;
    MSec: Int64;
    Send: Boolean;
    Cmd: DWORD;
  end;
  Command = record
    Ticks: UInt64;
    Status: Byte;
    BParm1, BParm2: Byte;
    Value: Int64;
    Len: UInt64;
    DataArray: Array of Byte;
    DataString: AnsiString;
    RunStatMode: Boolean;
    PlayerInfo: TPlayerInfo;
  end;
  Chunk = record
    Title: AnsiString;
    Data: Array of Command;
  end;
  TSearchEvent = record
    dtOp: Byte;
    dt: UInt64;
    chan: Byte;
    evnt: Byte;
    v1Op: Byte;
    v1: Word;
    v2Op: Byte;
    v2: Word;
    Text: String;
  end;
type
  TMainForm = class(TForm)
    OpenDialog: TOpenDialog;
    panTop: TPanel;
    Log: TMemo;
    panMiddle: TPanel;
    TrkCh: TComboBox;
    Label1: TLabel;
    StatusBar: TStatusBar;
    BAddTrack: TButton;
    BDelTrack: TButton;
    splitH: TSplitter;
    Events: TStringGrid;
    MainMenu: TMainMenu;
    MFile: TMenuItem;
    MOpen: TMenuItem;
    MSave: TMenuItem;
    MSaveAs: TMenuItem;
    N1: TMenuItem;
    MExit: TMenuItem;
    MEdit: TMenuItem;
    MChangeType: TMenuItem;
    MChangeDivision: TMenuItem;
    MNew: TMenuItem;
    N2: TMenuItem;
    MAbout: TMenuItem;
    N3: TMenuItem;
    MEditEvnt: TMenuItem;
    MDelEvnt: TMenuItem;
    MTrack: TMenuItem;
    MAddTrack: TMenuItem;
    MDelTrack: TMenuItem;
    MAddEvnt: TMenuItem;
    MDelEvntRange: TMenuItem;
    MSplit1: TMenuItem;
    MSplit2: TMenuItem;
    panLeft: TPanel;
    BAddEvnt: TSpeedButton;
    BEditEvnt: TSpeedButton;
    BDelEvnt: TSpeedButton;
    BDelEvntRange: TSpeedButton;
    PopEvnt: TPopupMenu;
    Evnt144: TMenuItem;
    Evnt128: TMenuItem;
    Evnt160: TMenuItem;
    Evnt176: TMenuItem;
    Evnt192: TMenuItem;
    Evnt208: TMenuItem;
    Evnt224: TMenuItem;
    Evnt240: TMenuItem;
    MSystem0: TMenuItem;
    MSystem1: TMenuItem;
    MSystem2: TMenuItem;
    MSystem7: TMenuItem;
    MSystem8: TMenuItem;
    MSystem10: TMenuItem;
    MSystem11: TMenuItem;
    MSystem12: TMenuItem;
    MSystem14: TMenuItem;
    MSystem15: TMenuItem;
    MSystem3: TMenuItem;
    MSystem6: TMenuItem;
    MMeta0: TMenuItem;
    MMeta1: TMenuItem;
    MMeta2: TMenuItem;
    MMeta3: TMenuItem;
    MMeta4: TMenuItem;
    MMeta5: TMenuItem;
    MMeta6: TMenuItem;
    MMeta7: TMenuItem;
    MMeta32: TMenuItem;
    MMeta33: TMenuItem;
    MMeta81: TMenuItem;
    MMeta84: TMenuItem;
    MMeta88: TMenuItem;
    MMeta89: TMenuItem;
    MMeta127: TMenuItem;
    MMetaOther: TMenuItem;
    MMeta47: TMenuItem;
    MSB: TMenuItem;
    LSB: TMenuItem;
    Switch: TMenuItem;
    DataEntry1: TMenuItem;
    BankSelect1: TMenuItem;
    Modulation1: TMenuItem;
    Breath1: TMenuItem;
    DX7Aftertouch1: TMenuItem;
    Foot1: TMenuItem;
    PortamentoTime1: TMenuItem;
    Volume1: TMenuItem;
    Balance1: TMenuItem;
    Panning1: TMenuItem;
    Expression1: TMenuItem;
    Effect11: TMenuItem;
    Effect21: TMenuItem;
    Generalpurpose11: TMenuItem;
    Generalpurpose31: TMenuItem;
    Generalpurpose32: TMenuItem;
    Generalpurpose41: TMenuItem;
    BankselectLSB1: TMenuItem;
    ModulationLSB1: TMenuItem;
    BreathLSB1: TMenuItem;
    DX7AftertouchLSB1: TMenuItem;
    FootLSB1: TMenuItem;
    PortamentotimeLSB1: TMenuItem;
    VolumeLSB1: TMenuItem;
    BalanceLSB1: TMenuItem;
    PanningLSB1: TMenuItem;
    ExpressionLSB1: TMenuItem;
    Effect1LSB1: TMenuItem;
    Effect2LSB1: TMenuItem;
    Generalpurpose1LSB1: TMenuItem;
    Generalpurpose2LSB1: TMenuItem;
    Generalpurpose3LSB1: TMenuItem;
    Generalpurpose4LSB1: TMenuItem;
    SustainSW1: TMenuItem;
    Portamento1: TMenuItem;
    Sustenutopedal1: TMenuItem;
    Softpedal1: TMenuItem;
    Legato1: TMenuItem;
    Hold21: TMenuItem;
    Soundvariation1: TMenuItem;
    Harmonique1: TMenuItem;
    Localcontrol1: TMenuItem;
    DataEntryMSB1: TMenuItem;
    DataEntryLSB1: TMenuItem;
    DataEntry11: TMenuItem;
    DataEntry12: TMenuItem;
    NRPNLSB1: TMenuItem;
    NonRegisteredParameterNumberMSB1: TMenuItem;
    RegisteredParameterNumberLSB1: TMenuItem;
    RegisteredParameterNumberMSB1: TMenuItem;
    Effects1: TMenuItem;
    Releasetime1: TMenuItem;
    Attacktime1: TMenuItem;
    Cutoff1: TMenuItem;
    Decaytime1: TMenuItem;
    Vibratorate1: TMenuItem;
    Vibratodepth1: TMenuItem;
    Vibratodelay1: TMenuItem;
    Soundcontroller101: TMenuItem;
    Generalpurpose51: TMenuItem;
    Generalpurpose61: TMenuItem;
    Generalpurpose71: TMenuItem;
    Generalpurpose81: TMenuItem;
    Portamento2: TMenuItem;
    HiResvelocityprefix1: TMenuItem;
    Reverbdepth1: TMenuItem;
    remolodepth1: TMenuItem;
    Chorusdepth1: TMenuItem;
    Detunedepth1: TMenuItem;
    Phaserdepth1: TMenuItem;
    MIDIDevice1: TMenuItem;
    AllSoundOff1: TMenuItem;
    ResetAllControllers1: TMenuItem;
    Allnotesoff1: TMenuItem;
    Omnimodeoff1: TMenuItem;
    Omnimodeon1: TMenuItem;
    Monomodeon1: TMenuItem;
    Polymodeon1: TMenuItem;
    Nonstandard1: TMenuItem;
    CreativeMusicFile1: TMenuItem;
    Other1: TMenuItem;
    Setmarkerbyte1: TMenuItem;
    Rhythmmodechange1: TMenuItem;
    ransposeup1: TMenuItem;
    ransposedown1: TMenuItem;
    PopEdit: TPopupMenu;
    PCut: TMenuItem;
    PCopy: TMenuItem;
    PPaste: TMenuItem;
    PDel: TMenuItem;
    N5: TMenuItem;
    MCut: TMenuItem;
    MCopy: TMenuItem;
    MPaste: TMenuItem;
    BMoveUp: TSpeedButton;
    BMoveDown: TSpeedButton;
    MMoveUp: TMenuItem;
    MMoveDown: TMenuItem;
    BDelEvntT: TSpeedButton;
    BDelEvntRangeT: TSpeedButton;
    MDelEvntT: TMenuItem;
    MDelEvntRangeT: TMenuItem;
    Amplitudevibratodepthcontrol1: TMenuItem;
    Soundcontrol1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Shortcuts: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    SaveDialog: TSaveDialog;
    Progress: TProgressBar;
    MActions: TMenuItem;
    MSplit3: TMenuItem;
    MOptimize: TMenuItem;
    N4: TMenuItem;
    MFind: TMenuItem;
    MFindNext: TMenuItem;
    MReplace: TMenuItem;
    Changechannel1: TMenuItem;
    XMIDI1: TMenuItem;
    Loopstart1: TMenuItem;
    Loopend1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    MMerge1: TMenuItem;
    MMerge2: TMenuItem;
    MCalcLen: TMenuItem;
    MProfile: TMenuItem;
    MConvert: TMenuItem;
    MProfileMID: TMenuItem;
    MProfileMDI: TMenuItem;
    MProfileCMF: TMenuItem;
    MFormatMID: TMenuItem;
    MFormatMDI: TMenuItem;
    MFormatCMF: TMenuItem;
    MFormatMUS: TMenuItem;
    MProfileMUS: TMenuItem;
    N11: TMenuItem;
    PCopyText: TMenuItem;
    MSettings: TMenuItem;
    MMIDIOut: TMenuItem;
    MSynth: TMenuItem;
    MWin32: TMenuItem;
    panVisual: TPanel;
    imgVU: TImage;
    N12: TMenuItem;
    MOutConf: TMenuItem;
    MLoopSong: TMenuItem;
    VisualTimer: TTimer;
    panToolbar: TPanel;
    bPlay: TBitBtn;
    bStop: TBitBtn;
    MFormatXMI: TMenuItem;
    MProfileXMI: TMenuItem;
    MW32Mapper: TMenuItem;
    N13: TMenuItem;
    MW32Refresh: TMenuItem;
    MShowVars: TMenuItem;
    procedure BtOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrkChChange(Sender: TObject);
    procedure EventsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MExitClick(Sender: TObject);
    procedure BDelTrackClick(Sender: TObject);
    procedure BAddTrackClick(Sender: TObject);
    procedure BAddEvntClick(Sender: TObject);
    procedure EventsClick(Sender: TObject);
    procedure EventsKeyPress(Sender: TObject; var Key: Char);
    procedure BMoveUpClick(Sender: TObject);
    procedure BMoveDownClick(Sender: TObject);
    procedure BDelEvntClick(Sender: TObject);
    procedure BDelEvntTClick(Sender: TObject);
    procedure Evnt144Click(Sender: TObject);
    procedure Evnt128Click(Sender: TObject);
    procedure Evnt224Click(Sender: TObject);
    procedure Evnt192Click(Sender: TObject);
    procedure Evnt208Click(Sender: TObject);
    procedure Evnt160Click(Sender: TObject);
    procedure MSystem0Click(Sender: TObject);
    procedure MSystem1Click(Sender: TObject);
    procedure MSystem2Click(Sender: TObject);
    procedure MSystem3Click(Sender: TObject);
    procedure MSystem6Click(Sender: TObject);
    procedure MSystem7Click(Sender: TObject);
    procedure MSystem8Click(Sender: TObject);
    procedure MSystem10Click(Sender: TObject);
    procedure MSystem11Click(Sender: TObject);
    procedure MSystem12Click(Sender: TObject);
    procedure MSystem14Click(Sender: TObject);
    procedure MMeta0Click(Sender: TObject);
    procedure MMeta1Click(Sender: TObject);
    procedure MMeta2Click(Sender: TObject);
    procedure MMeta3Click(Sender: TObject);
    procedure MMeta4Click(Sender: TObject);
    procedure MMeta5Click(Sender: TObject);
    procedure MMeta6Click(Sender: TObject);
    procedure MMeta7Click(Sender: TObject);
    procedure MMeta32Click(Sender: TObject);
    procedure MMeta33Click(Sender: TObject);
    procedure MMeta47Click(Sender: TObject);
    procedure MMeta81Click(Sender: TObject);
    procedure MMeta84Click(Sender: TObject);
    procedure MMeta88Click(Sender: TObject);
    procedure MMeta89Click(Sender: TObject);
    procedure MMeta127Click(Sender: TObject);
    procedure BankSelect1Click(Sender: TObject);
    procedure Modulation1Click(Sender: TObject);
    procedure Breath1Click(Sender: TObject);
    procedure DX7Aftertouch1Click(Sender: TObject);
    procedure Foot1Click(Sender: TObject);
    procedure PortamentoTime1Click(Sender: TObject);
    procedure Volume1Click(Sender: TObject);
    procedure Balance1Click(Sender: TObject);
    procedure Panning1Click(Sender: TObject);
    procedure Expression1Click(Sender: TObject);
    procedure Effect11Click(Sender: TObject);
    procedure Effect21Click(Sender: TObject);
    procedure Generalpurpose11Click(Sender: TObject);
    procedure Generalpurpose31Click(Sender: TObject);
    procedure Generalpurpose32Click(Sender: TObject);
    procedure Generalpurpose41Click(Sender: TObject);
    procedure BankselectLSB1Click(Sender: TObject);
    procedure ModulationLSB1Click(Sender: TObject);
    procedure BreathLSB1Click(Sender: TObject);
    procedure DX7AftertouchLSB1Click(Sender: TObject);
    procedure FootLSB1Click(Sender: TObject);
    procedure PortamentotimeLSB1Click(Sender: TObject);
    procedure VolumeLSB1Click(Sender: TObject);
    procedure BalanceLSB1Click(Sender: TObject);
    procedure PanningLSB1Click(Sender: TObject);
    procedure ExpressionLSB1Click(Sender: TObject);
    procedure Effect1LSB1Click(Sender: TObject);
    procedure Effect2LSB1Click(Sender: TObject);
    procedure Generalpurpose1LSB1Click(Sender: TObject);
    procedure Generalpurpose2LSB1Click(Sender: TObject);
    procedure Generalpurpose3LSB1Click(Sender: TObject);
    procedure Generalpurpose4LSB1Click(Sender: TObject);
    procedure SustainSW1Click(Sender: TObject);
    procedure Portamento1Click(Sender: TObject);
    procedure Sustenutopedal1Click(Sender: TObject);
    procedure Softpedal1Click(Sender: TObject);
    procedure Legato1Click(Sender: TObject);
    procedure Hold21Click(Sender: TObject);
    procedure Soundvariation1Click(Sender: TObject);
    procedure Harmonique1Click(Sender: TObject);
    procedure Releasetime1Click(Sender: TObject);
    procedure Attacktime1Click(Sender: TObject);
    procedure Cutoff1Click(Sender: TObject);
    procedure Decaytime1Click(Sender: TObject);
    procedure Vibratorate1Click(Sender: TObject);
    procedure Vibratodepth1Click(Sender: TObject);
    procedure Vibratodelay1Click(Sender: TObject);
    procedure Soundcontroller101Click(Sender: TObject);
    procedure Generalpurpose51Click(Sender: TObject);
    procedure Generalpurpose61Click(Sender: TObject);
    procedure Generalpurpose71Click(Sender: TObject);
    procedure Generalpurpose81Click(Sender: TObject);
    procedure Portamento2Click(Sender: TObject);
    procedure HiResvelocityprefix1Click(Sender: TObject);
    procedure Reverbdepth1Click(Sender: TObject);
    procedure remolodepth1Click(Sender: TObject);
    procedure Chorusdepth1Click(Sender: TObject);
    procedure Detunedepth1Click(Sender: TObject);
    procedure Phaserdepth1Click(Sender: TObject);
    procedure DataEntry11Click(Sender: TObject);
    procedure DataEntry12Click(Sender: TObject);
    procedure NRPNLSB1Click(Sender: TObject);
    procedure NonRegisteredParameterNumberMSB1Click(Sender: TObject);
    procedure RegisteredParameterNumberLSB1Click(Sender: TObject);
    procedure RegisteredParameterNumberMSB1Click(Sender: TObject);
    procedure DataEntryMSB1Click(Sender: TObject);
    procedure DataEntryLSB1Click(Sender: TObject);
    procedure AllSoundOff1Click(Sender: TObject);
    procedure ResetAllControllers1Click(Sender: TObject);
    procedure Localcontrol1Click(Sender: TObject);
    procedure Allnotesoff1Click(Sender: TObject);
    procedure Omnimodeoff1Click(Sender: TObject);
    procedure Omnimodeon1Click(Sender: TObject);
    procedure Monomodeon1Click(Sender: TObject);
    procedure Polymodeon1Click(Sender: TObject);
    procedure Amplitudevibratodepthcontrol1Click(Sender: TObject);
    procedure Setmarkerbyte1Click(Sender: TObject);
    procedure Rhythmmodechange1Click(Sender: TObject);
    procedure ransposeup1Click(Sender: TObject);
    procedure ransposedown1Click(Sender: TObject);
    procedure MNewClick(Sender: TObject);
    procedure BEditEvntClick(Sender: TObject);
    procedure BDelEvntRangeClick(Sender: TObject);
    procedure BDelEvntRangeTClick(Sender: TObject);
    procedure Other1Click(Sender: TObject);
    procedure MMetaOtherClick(Sender: TObject);
    procedure MShowVarsClick(Sender: TObject);
    procedure MChangeTypeClick(Sender: TObject);
    procedure MChangeDivisionClick(Sender: TObject);
    procedure MSaveAsClick(Sender: TObject);
    procedure MSaveClick(Sender: TObject);
    procedure MSplit1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MSplit2Click(Sender: TObject);
    procedure MSplit3Click(Sender: TObject);
    procedure MOptimizeClick(Sender: TObject);
    procedure PCopyClick(Sender: TObject);
    procedure PCutClick(Sender: TObject);
    procedure PPasteClick(Sender: TObject);
    procedure MFindClick(Sender: TObject);
    procedure MFindNextClick(Sender: TObject);
    procedure MReplaceClick(Sender: TObject);
    procedure Changechannel1Click(Sender: TObject);
    procedure Loopstart1Click(Sender: TObject);
    procedure Loopend1Click(Sender: TObject);
    procedure MCalcLenClick(Sender: TObject);
    procedure MMerge2Click(Sender: TObject);
    procedure MMerge1Click(Sender: TObject);
    procedure MFormatMIDClick(Sender: TObject);
    procedure MFormatMDIClick(Sender: TObject);
    procedure MFormatCMFClick(Sender: TObject);
    procedure MFormatMUSClick(Sender: TObject);
    procedure MProfileMIDClick(Sender: TObject);
    procedure MProfileMDIClick(Sender: TObject);
    procedure MProfileCMFClick(Sender: TObject);
    procedure MProfileMUSClick(Sender: TObject);
    procedure PCopyTextClick(Sender: TObject);
    procedure bPlayClick(Sender: TObject);
    procedure bStopClick(Sender: TObject);
    procedure MLoopSongClick(Sender: TObject);
    procedure VisualTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MAboutClick(Sender: TObject);
    procedure MFormatXMIClick(Sender: TObject);
    procedure MProfileXMIClick(Sender: TObject);
    procedure MW32RefreshClick(Sender: TObject);
    procedure MW32MapperClick(Sender: TObject);
    procedure MOutConfClick(Sender: TObject);
  private
    { Private declarations }
    procedure OnEventChange(var Msg: TMessage); message WM_EVENTIDX;
    procedure OnTrackChange(var Msg: TMessage); message WM_TRACKIDX;
    procedure OnVUChange(var Msg: TMessage); message WM_SETVU;
  public
    { Public declarations }
    function LoadFile(FileName, Fmt: String): Boolean;
    function SaveFile(FileName: String): Boolean;
    function DetectFile(var F: TMemoryStream): String;
    function DetectMIDI(var F: TMemoryStream): Boolean;
    function DetectRMI(var F: TMemoryStream): Boolean;
    function DetectMIDS(var F: TMemoryStream): Boolean;
    function DetectXMI(var F: TMemoryStream): Boolean;
    function DetectCMF(var F: TMemoryStream): Boolean;
    function DetectMUS(var F: TMemoryStream): Boolean;
    function ReadMIDI(var F: TMemoryStream): Boolean;
    function ReadRMI(var F: TMemoryStream): Boolean;
    function ReadMIDS(var F: TMemoryStream): Boolean;
    function ReadXMI(var F: TMemoryStream): Boolean;
    function ReadCMF(var F: TMemoryStream): Boolean;
    function ReadMUS(var F: TMemoryStream; FileName: String): Boolean;
    function ReadRaw(var F: TMemoryStream): Boolean;
    function ReadSYX(var F: TMemoryStream): Boolean;
    procedure ReadTrackData(var F: TMemoryStream; var Trk: Chunk);
    procedure ReadTrackData_MIDS(var F: TMemoryStream; var Trk: Chunk);
    procedure ReadTrackData_XMI(var F: TMemoryStream; var Trk: Chunk);
    procedure ReadTrackData_MUS(var F: TMemoryStream; var Trk: Chunk);
    procedure ReadTrackData_SYX(var F: TMemoryStream; var Trk: Chunk);
    procedure WriteMIDI(var F: TMemoryStream);
    procedure WriteRMI(var F: TMemoryStream);
    procedure WriteXMI(var F: TMemoryStream);
    procedure WriteCMF(var F: TMemoryStream);
    procedure WriteMUS(var F: TMemoryStream; FileName: String);
    procedure WriteRaw(var F: TMemoryStream);
    procedure WriteSYX(var F: TMemoryStream);
    procedure WriteTrackData(var F: TMemoryStream; var Trk: Chunk);
    procedure WriteTrackData_XMI(var F: TMemoryStream; var Trk: Chunk);
    procedure WriteTrackData_MUS(var F: TMemoryStream; var Trk: Chunk);
    procedure WriteTrackData_SYX(var F: TMemoryStream; var Trk: Chunk);
    procedure ConvertEvents(DestProfile: AnsiString);
    procedure Convert_XMI_MID;
    procedure Convert_MID_XMI;
    procedure Convert_MUS_MID;
    procedure Convert_MUS_MDI;
    procedure Convert_MDI_MID;
    procedure Convert_MID_MUS;
    procedure Convert_MDI_MUS;
    procedure Convert_CMF_MID;
    procedure Convert_CMF_MDI;
    procedure Convert_MDI_CMF;
    procedure ConvertTicks(RelToAbs: Boolean; var Data: Array of Command);
    procedure MergeTracksByTicks;
    procedure MergeTracksByOrder;
    procedure CalculateEvnts;
    procedure RefTrackList;
    procedure ChkButtons;
    procedure FillEvents(Idx: Integer);
    procedure LogSongInfo;
    procedure AddTrack;
    procedure DelTrack(Idx: Integer);
    procedure NewEvent(Trk, Idx: Integer; E, Parm: Byte);
    procedure AddEvent(E, Parm: Byte);
    function DelEvent(Trk, Idx: Integer; TimeSave: Boolean): Boolean;
    function DelRange(Trk, From, Count: Integer; TimeSave: Boolean): Boolean;
    function TimeBetween(Trk, Idx1, Idx2: Integer): UInt64;
    procedure CopyEvent(SrcTrk, SrcIdx, DestTrk, DestIdx: Integer);
    procedure CopyBufRange(Trk, From, Count: Integer);
  end;

var
  MainForm: TMainForm;
  WidTable: Array[0..4] of Integer = (40, 56, 24, 172, 320);
  Opened: Boolean = False;
  Container, EventFormat, EventProfile, EventViewProfile: AnsiString;
  // Container (smf, rmi, xmi, cmf, mus, raw, syx, mids)
  // EventFormat (mid, xmi, mus)
  // EventProfile (mid, mdi, xmi, cmf, mus)
  // EventViewProfile = EventProfile
  SongData: TValueListEditor;
  TrackData: Array of Chunk;
  // Clipboard
  BCopyBuf: Boolean = False;
  DCopyBuf: Array of Command;
  // Search
  SearchEv: TSearchEvent;
  // Player
  MIDIDev: DWORD = MIDI_MAPPER;
  MIDIOut: HMIDIOUT;
  MIDIThr: THandle;
  MIDIThrId: Cardinal;
  PlayData: Array of Command;
  LoopEnabled: Boolean = False;
  LoopPoint, LoopEnd: Integer;
  // Visual
  vChangeEvent: Boolean = False;
  vEvntIndex: Integer;
  vChangeTrack: Boolean = False;
  vTrkIndex: Integer;
  VU: Array[0..15] of Byte;

implementation

{$R *.dfm}

procedure SongData_PutInt(Name: String; Val: Integer);
var
  Row: Integer;
begin
  if SongData.FindRow(Name, Row) then
  begin
    SongData.Cells[1, Row] := IntToStr(Val);
    Exit;
  end;
  SongData.InsertRow(Name, IntToStr(Val), True);
end;

procedure SongData_PutDWord(Name: String; Val: Cardinal);
var
  Row: Integer;
begin
  if SongData.FindRow(Name, Row) then
  begin
    SongData.Cells[1, Row] := IntToStr(Val);
    Exit;
  end;
  SongData.InsertRow(Name, IntToStr(Val), True);
end;

procedure SongData_PutStr(Name, Val: String);
var
  Row: Integer;
begin
  if SongData.FindRow(Name, Row) then
  begin
    SongData.Cells[1, Row] := Val;
    Exit;
  end;
  SongData.InsertRow(Name, Val, True);
end;

function SongData_GetByte(Name: String; var B: Byte): Boolean;
var
  Row, Code: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  Val(SongData.Cells[1, Row], B, Code);
  Result := Code = 0;
end;

function SongData_GetSInt(Name: String; var I: ShortInt): Boolean;
var
  Row, Code: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  Val(SongData.Cells[1, Row], I, Code);
  Result := Code = 0;
end;

function SongData_GetInt(Name: String; var I: Integer): Boolean;
var
  Row, Code: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  Val(SongData.Cells[1, Row], I, Code);
  Result := Code = 0;
end;

function SongData_GetWord(Name: String; var W: Word): Boolean;
var
  Row, Code: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  Val(SongData.Cells[1, Row], W, Code);
  Result := Code = 0;
end;

function SongData_GetDWord(Name: String; var DW: Cardinal): Boolean;
var
  Row, Code: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  Val(SongData.Cells[1, Row], DW, Code);
  Result := Code = 0;
end;

function SongData_GetStr(Name: String; var S: String): Boolean;
var
  Row: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  S := SongData.Cells[1, Row];
  Result := True;
end;

function SongData_Delete(Name: String): Boolean;
var
  Row: Integer;
begin
  Result := False;
  if not SongData.FindRow(Name, Row) then
    Exit;
  SongData.Strings.Delete(Row - 1);
  Result := True;
end;

function GetFiles(const StartDir, Mask: String; const List: TStrings): Boolean;
var
  SRec: TSearchRec;
  Res: Integer;
begin
  if not Assigned(List) then
  begin
    Result := False;
    Exit;
  end;
  Res := FindFirst(StartDir + Mask, faAnyfile, SRec);
  if Res = 0 then
  try
    while res = 0 do
    begin
      if (SRec.Attr and faDirectory <> faDirectory) then
        List.Add(StartDir + SRec.Name);
      Res := FindNext(SRec);
    end;
  finally
    FindClose(SRec)
  end;
  Result := (List.Count > 0);
end;

function ReadVarVal(var F: TMemoryStream; var Error: Byte): UInt64;
var
  B, I: Byte;
begin
  Result := 0;
  Error := 0;
  if F.Position >= F.Size then begin
    Error := 2;
    Exit;
  end else
    F.ReadBuffer(B, 1);
  I := 7;
  Result := B and 127;
  while (B shr 7) = 1 do begin
    if F.Position >= F.Size then begin
      Error := 2;
      Exit;
    end else
      F.ReadBuffer(B, 1);
    if I + 7 <= 64 then
      Inc(I, 7)
    else begin
      Error := 1;
      Break;
    end;
    Result := (Result shl 7) or (B and 127);
  end;
end;

function ReadVarVal_XMI(var F: TMemoryStream; var Error: Byte): UInt64;
var
  B: Byte;
begin
  Result := 0;
  Error := 0;
  if F.Position >= F.Size then begin
    Error := 2;
    Exit;
  end else
    F.ReadBuffer(B, 1);
  while B = $7F do begin
    Result := Result + B;
    if F.Position >= F.Size then begin
      Error := 2;
      Exit;
    end else
      F.ReadBuffer(B, 1);
  end;
  if B >= $80 then
    F.Seek(-1, soCurrent)
  else
    Result := Result + B;
end;

function ReadVarVal_MUS(var F: TMemoryStream; var Error: Byte): UInt64;
var
  B: Byte;
begin
  Result := 0;
  Error := 0;
  if F.Position >= F.Size then begin
    Error := 2;
    Exit;
  end else
    F.ReadBuffer(B, 1);
  while B = $F8 do begin
    Result := Result + $F0;
    if F.Position >= F.Size then begin
      Error := 2;
      Exit;
    end else
      F.ReadBuffer(B, 1);
  end;
  Result := Result + B;
end;

procedure WriteVarVal(var F: TMemoryStream; Val: UInt64);
var
  I: Integer;
  A: Array of Byte;
begin
  while True do begin
    SetLength(A, Length(A)+1);
    A[Length(A)-1]:=Val and 127;
    Val:=Val shr 7;
    if Val=0 then
      Break;
  end;
  for I:=Length(A)-1 downto 0 do begin
    if I>0 then
      A[I]:=A[I] or 128;
    F.WriteBuffer(A[I],1);
  end;
end;

procedure WriteVarVal_XMI(var F: TMemoryStream; Val: UInt64);
var
  B: Byte;
begin
  B := $7F;
  while Val > B do
  begin
    F.WriteBuffer(B, 1);
    Val := Val - B;
  end;
  if Val > 0 then
    F.WriteBuffer(Val, 1);
end;

procedure WriteVarVal_MUS(var F: TMemoryStream; Val: UInt64);
var
  B: Byte;
begin
  B := $F8;
  while Val >= $F0 do begin
    Val := Val - $F0;
    F.WriteBuffer(B, 1);
  end;
  B := Val;
  F.WriteBuffer(B, 1);
end;

function GetMyVersion(var FileVersion: FILE_VERSION): Boolean;
type
  VS_VERSIONINFO = record
    wLength, wValueLength, wType: Word;
    szKey: Array[1..16] of WideChar;
    Padding1: Word;
    Value: VS_FIXEDFILEINFO;
    Padding2, Children: Word;
  end;
  PVS_VERSIONINFO = ^VS_VERSIONINFO;
const
  VFF_DEBUG = 1;
  VFF_PRERELEASE = 2;
  VFF_PRIVATE = 8;
  VFF_SPECIAL = 32;
var
  hResourceInfo: HRSRC;
  VersionInfo: PVS_VERSIONINFO;
begin
  Result := False;

  hResourceInfo := FindResource(hInstance, PWideChar(1), PWideChar($10));
  if hResourceInfo = 0 then
    Exit;

  VersionInfo := Pointer(LoadResource(hInstance, hResourceInfo));
  if VersionInfo = nil then
    Exit;

  FileVersion.Version.dw := VersionInfo.Value.dwFileVersionMS;
  FileVersion.Release := Word(VersionInfo.Value.dwFileVersionLS shr 16);
  FileVersion.Build := Word(VersionInfo.Value.dwFileVersionLS);
  FileVersion.bDebug := (VersionInfo.Value.dwFileFlags and VFF_DEBUG) = VFF_DEBUG;
  FileVersion.bPrerelease := (VersionInfo.Value.dwFileFlags and VFF_PRERELEASE) = VFF_PRERELEASE;
  FileVersion.bPrivate := (VersionInfo.Value.dwFileFlags and VFF_PRIVATE) = VFF_PRIVATE;
  FileVersion.bSpecial := (VersionInfo.Value.dwFileFlags and VFF_SPECIAL) = VFF_SPECIAL;

  Result := True;
end;

procedure TMainForm.MAboutClick(Sender: TObject);
var
  FV: FILE_VERSION;
  S: String;
begin
  GetMyVersion(FV);
  S := 'MIDIPLEX Sequencer ';
  S := S + Format('v%d.%d.%d', [FV.Version.w.Major, FV.Version.w.Minor, FV.Release]);
  S := S + #13#10#13#10 +
  'Copyright (C) Stas''M Corp. 2012-2016' + #13#10;
  S := S + #13#10 +
  'Project development was started in Apr 2012 by Stas''M.'#13#10 +
  'The main goal is to provide exclusive editing features that ' +
  'other sequencers don''t, for example low level MIDI event modification, ' +
  'support for old and some exotic music formats, and much more!'#13#10 +
  'However it''s in development for now - this is early alpha version.' +
  #13#10;
  S := S + #13#10 + 'Software is licensed under GNU GPL v3, see LICENSE file.';
  MessageBox(Handle, PWideChar(S), 'About', MB_ICONINFORMATION or MB_OK);
end;

function TMainForm.DetectMIDI(var F: TMemoryStream): Boolean;
var
  Head: Array[0..3] of AnsiChar;
begin
  Result := False;
  if F.Size < 14 then
    Exit;
  F.Seek(0, soFromBeginning);
  F.ReadBuffer(Head, 4);
  Result := (Head = 'MThd') or (Head = 'MTrk');
end;

function TMainForm.DetectRMI(var F: TMemoryStream): Boolean;
var
  Nodes: IFFNodes;
begin
  IFFGetNodes('RIFF', F.Memory, 0, F.Size, Nodes);
  Result := IFFSearchNode(Nodes, 'RIFF', 'RMID') > 0;
end;

function TMainForm.DetectMIDS(var F: TMemoryStream): Boolean;
var
  Nodes: IFFNodes;
begin
  IFFGetNodes('RIFF', F.Memory, 0, F.Size, Nodes);
  Result := IFFSearchNode(Nodes, 'RIFF', 'MIDS') > 0;
end;

function TMainForm.DetectXMI(var F: TMemoryStream): Boolean;
var
  Nodes: IFFNodes;
begin
  IFFGetNodes('IFF', F.Memory, 0, F.Size, Nodes);
  Result := (IFFSearchNode(Nodes, 'CAT ', 'XMID') > 0)
         or (IFFSearchNode(Nodes, 'FORM', 'XMID') > 0);
end;

function TMainForm.DetectCMF(var F: TMemoryStream): Boolean;
var
  Head: Array[0..3] of AnsiChar;
begin
  Result := False;
  if F.Size < 36 then
    Exit;
  F.Seek(0, soFromBeginning);
  F.ReadBuffer(Head, 4);
  Result := Head = 'CTMF';
end;

function TMainForm.DetectMUS(var F: TMemoryStream): Boolean;
var
  W: Word;
begin
  Result := False;
  if F.Size < 70 then
    Exit;
  F.Seek(0, soFromBeginning);
  F.ReadBuffer(W, 2);
  Result := W = 1;
end;

function TMainForm.ReadMIDI(var F: TMemoryStream): Boolean;
type
  TrackInfo = record
    Offset, Size: Cardinal;
  end;
label
  Done;
var
  Nodes: IFFNodes;
  B: Byte;
  I: Integer;
  Ver, Tracks, Division: Word;
  SMPTE: ShortInt;
  TracksInfo: Array of TrackInfo;
  TrackStream: TMemoryStream;
begin
  Result := False;
  // Checking file size
  if F.Size < 14 then begin
    Log.Lines.Add('[-] Error: Wrong file size.');
    Exit;
  end;
  IFFGetNodes('OIFF', F.Memory, 0, F.Size, Nodes);
  if Length(Nodes) = 0 then begin
    Log.Lines.Add('[-] Error: Wrong file header.');
    Exit;
  end;
  // Checking header
  if (Nodes[0].Name <> 'MThd')
  and (Nodes[0].Name <> 'MTrk')
  then begin
    Log.Lines.Add('[-] Error: Wrong MIDI header.');
    Exit;
  end;
  if Nodes[0].Name = 'MThd' then
  begin
    // Reading header size
    if Nodes[0].Size < 6 then begin
      Log.Lines.Add('[-] Error: MIDI header too small ('+IntToStr(Nodes[0].Size)+' bytes).');
      Exit;
    end;
    if Nodes[0].Size > 255 then begin
      Log.Lines.Add('[-] Error: MIDI header too big ('+IntToStr(Nodes[0].Size)+' bytes).');
      Exit;
    end;
    if (Nodes[0].Size > 6) and (Nodes[0].Size <= 255) then
      Log.Lines.Add('[*] Warning: Non-standart MIDI header size ('+IntToStr(Nodes[0].Size)+' bytes).');
    // Reading version
    F.Seek(Nodes[0].DataOffs, soFromBeginning);
    F.ReadBuffer(B, 1);
    Ver := B shl 8;
    F.ReadBuffer(B, 1);
    Ver := Ver or B;
    SongData_PutInt('MIDIType', Ver);
    if Ver > 2 then
      Log.Lines.Add('[*] Warning: Unknown MIDI Type.');
    // Reading track count
    F.ReadBuffer(B, 1);
    Tracks := B shl 8;
    F.ReadBuffer(B, 1);
    Tracks := Tracks or B;
    if (Ver = 0) and (Tracks > 1) then
      Log.Lines.Add('[*] Warning: MIDI Type 0 supports only one track.');
    // Reading speed value
    F.ReadBuffer(SMPTE, 1);
    F.ReadBuffer(B, 1);
    Division := B;
    if SMPTE >= 0 then
      Division := Division or (SMPTE shl 8);
    SongData_PutDWord('InitTempo', 500000);
    SongData_PutInt('SMPTE', SMPTE);
    SongData_PutInt('Division', Division);

    if Tracks = 0 then
      goto Done;

    Log.Lines.Add('[*] Checking tracks...');
    SetLength(TrackData, 0);
    if Tracks > Length(Nodes) - 1 then
    begin
      Log.Lines.Add('[*] Warning: Missing tracks ('+IntToStr(Tracks - Length(Nodes) + 1)+' out of '+IntToStr(Tracks)+').');
      Tracks := Length(Nodes) - 1;
    end;

    for I := 0 to Tracks - 1 do
    begin
      if Nodes[I+1].Name <> 'MTrk' then
      begin
        Log.Lines.Add('[*] Warning: Track #'+IntToStr(I)+' has incorrect chunk name "'+Nodes[I+1].Name+'", skipping.');
        Continue;
      end;
      SetLength(TracksInfo, Length(TracksInfo) + 1);
      TracksInfo[High(TracksInfo)].Offset := Nodes[I+1].DataOffs;
      TracksInfo[High(TracksInfo)].Size := Nodes[I+1].Size;
      Log.Lines.Add('[+] Track #'+IntToStr(I)+' found ('+IntToStr(Nodes[I+1].Size)+' bytes).');
    end;
  end
  else
  begin
    // Load tracks without header
    Log.Lines.Add('[*] Warning: MIDI header not found, using default settings.');
    SongData_PutInt('MIDIType', 1);
    SongData_PutInt('SMPTE', 0);
    SongData_PutInt('Division', 96);
    SongData_PutDWord('InitTempo', 500000);

    Log.Lines.Add('[*] Checking tracks...');
    Tracks := 0;
    for I := 0 to Length(Nodes) - 1 do
    begin
      if Nodes[I].Name <> 'MTrk' then
      begin
        Log.Lines.Add('[*] Warning: Track #'+IntToStr(I)+' has incorrect chunk name "'+Nodes[I].Name+'", skipping.');
        Continue;
      end;
      SetLength(TracksInfo, Length(TracksInfo) + 1);
      TracksInfo[High(TracksInfo)].Offset := Nodes[I].DataOffs;
      TracksInfo[High(TracksInfo)].Size := Nodes[I].Size;
      Inc(Tracks);
      Log.Lines.Add('[+] Track #'+IntToStr(I)+' found ('+IntToStr(Nodes[I].Size)+' bytes).');
    end;
  end;

  SetLength(TrackData, Length(TracksInfo));
  for I := 0 to Length(TracksInfo) - 1 do begin
    // Reading track #I
    Log.Lines.Add('[*] Reading track '+IntToStr(I)+'...');
    if F.Size < TracksInfo[I].Offset + TracksInfo[I].Size then
    begin
      if F.Size - TracksInfo[I].Offset < 0 then
      begin
        Log.Lines.Add('[-] Error: Track '+IntToStr(I)+' is incomplete.');
        Continue;
      end;
      Log.Lines.Add('[*] Warning: Track '+IntToStr(I)+' is incomplete.');
      TracksInfo[I].Size := F.Size - TracksInfo[I].Offset;
    end;
    TrackStream := TMemoryStream.Create;
    TrackStream.SetSize(TracksInfo[I].Size);
    F.Seek(TracksInfo[I].Offset, soFromBeginning);
    F.ReadBuffer(TrackStream.Memory^, TrackStream.Size);
    TrackData[I].Title := '';
    SetLength(TrackData[I].Data, 0);
    ReadTrackData(TrackStream, TrackData[I]);
    TrackStream.Free;
    Log.Lines.Add('[+] '+IntToStr(Length(TrackData[I].Data))+' events found.');
    {if (Length(Trk.Data)>0) and (Trk.Size>0) then
      if Trk.Size div 256>0 then begin
        if ((Length(Trk.Data) mod (Trk.Size div 256))=0) and
        (Length(TrackData)>0) then
          Progress.Position:=Round((I/Length(TrackData) +
          (F.Position-Trk.Offset)/(Trk.Size*Length(TrackData)))*100);
      end else begin
        if ((Length(Trk.Data) mod 1)=0) and
        (Length(TrackData)>0) then
          Progress.Position:=Round((I/Length(TrackData) +
          (F.Position-Trk.Offset)/(Trk.Size*Length(TrackData)))*100);
      end;}
  end;
  Done:
  if Length(Nodes) > Tracks + 1 then
    Log.Lines.Add('[*] Warning: Additional data was found after the end of last track (additional data processing is disabled).');
  Result := True;
  Log.Lines.Add('');
  if Nodes[0].Name = 'MThd' then
    Log.Lines.Add('[*] Information:')
  else
    Log.Lines.Add('[*] Default settings:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

function TMainForm.ReadRMI(var F: TMemoryStream): Boolean;
var
  Nodes, FNodes, WNodes: IFFNodes;
  M: TMemoryStream;
begin
  Result := False;
  Log.Lines.Add('[*] Reading RIFF MIDI file...');
  IFFGetNodes('RIFF', F.Memory, 0, F.Size, Nodes);
  if IFFSearchNode(Nodes, 'RIFF') = 0 then begin
    Log.Lines.Add('[-] Error: No RIFF chunks found.');
    Exit;
  end;
  IFFSearchNode(Nodes, FNodes, 'RIFF', 'RMID');
  if Length(FNodes) = 0 then begin
    Log.Lines.Add('[-] Error: RIFF RMID chunk not found.');
    Exit;
  end;
  if F.Size < FNodes[0].DataOffs + FNodes[0].Size then
    Log.Lines.Add('[*] Warning: RIFF tree is truncated.');
  if IFFSearchNode(Nodes, WNodes, 'RIFF', 'WAVE') > 0 then
  begin
    IFFGetNodes('RIFF', F.Memory, WNodes[0].DataOffs, WNodes[0].Size, WNodes);
    if IFFSearchNode(WNodes, 'voyl') > 0 then
      Log.Lines.Add('[*] Digital Orchestrator Pro samples detected.');
  end;
  IFFGetNodes('RIFF', F.Memory, FNodes[0].DataOffs, FNodes[0].Size, Nodes);
  IFFSearchNode(Nodes, FNodes, 'data');
  if Length(FNodes) = 0 then begin
    Log.Lines.Add('[-] Error: Data chunk not found.');
    Exit;
  end;
  if F.Size < FNodes[0].DataOffs + FNodes[0].Size then begin
    if F.Size - FNodes[0].DataOffs < 0 then
    begin
      Log.Lines.Add('[-] Error: Data chunk is truncated.');
      Exit;
    end;
    Log.Lines.Add('[*] Warning: Data chunk is truncated.');
    FNodes[0].Size := F.Size - FNodes[0].DataOffs;
  end;

  if IFFSearchNode(Nodes, 'RIFF', 'DLS ') > 0 then
    Log.Lines.Add('[*] DLS instrument bank detected.');

  F.Seek(FNodes[0].DataOffs, soFromBeginning);
  M := TMemoryStream.Create;
  M.SetSize(FNodes[0].Size);
  F.ReadBuffer(M.Memory^, M.Size);
  Result := ReadMIDI(M);
  M.Free;
end;

function TMainForm.ReadMIDS(var F: TMemoryStream): Boolean;
var
  Nodes, FNodes: IFFNodes;
  M: TMemoryStream;
  Division: Word;
begin
  Result := False;
  Log.Lines.Add('[*] Reading MIDI Stream file...');
  IFFGetNodes('RIFF', F.Memory, 0, F.Size, Nodes);
  if IFFSearchNode(Nodes, 'RIFF') = 0 then begin
    Log.Lines.Add('[-] Error: No RIFF chunks found.');
    Exit;
  end;
  IFFSearchNode(Nodes, FNodes, 'RIFF', 'MIDS');
  if Length(FNodes) = 0 then begin
    Log.Lines.Add('[-] Error: RIFF MIDS chunk not found.');
    Exit;
  end;
  if F.Size < FNodes[0].DataOffs + FNodes[0].Size then
    Log.Lines.Add('[*] Warning: RIFF tree is truncated.');
  IFFGetNodes('RIFF', F.Memory, FNodes[0].DataOffs, FNodes[0].Size, Nodes);
  IFFSearchNode(Nodes, FNodes, 'fmt ');
  if Length(FNodes) = 0 then begin
    Log.Lines.Add('[-] Error: Format chunk not found.');
    Exit;
  end;
  if FNodes[0].Size < 12 then begin
    Log.Lines.Add('[-] Error: Wrong format chunk size.');
    Exit;
  end;
  if F.Size < FNodes[0].DataOffs + FNodes[0].Size then begin
    Log.Lines.Add('[-] Error: Format chunk is truncated.');
    Exit;
  end;
  F.Seek(FNodes[0].DataOffs, soFromBeginning);
  F.ReadBuffer(Division, 2);
  SongData_PutDWord('InitTempo', 500000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', Division);
  IFFSearchNode(Nodes, FNodes, 'data');
  if Length(FNodes) = 0 then begin
    Log.Lines.Add('[-] Error: Data chunk not found.');
    Exit;
  end;
  if F.Size < FNodes[0].DataOffs + FNodes[0].Size then begin
    if F.Size - FNodes[0].DataOffs < 0 then
    begin
      Log.Lines.Add('[-] Error: Data chunk is truncated.');
      Exit;
    end;
    Log.Lines.Add('[*] Warning: Data chunk is truncated.');
    FNodes[0].Size := F.Size - FNodes[0].DataOffs;
  end;

  SetLength(TrackData, 1);
  TrackData[0].Title := '';
  SetLength(TrackData[0].Data, 0);

  F.Seek(FNodes[0].DataOffs, soFromBeginning);
  M := TMemoryStream.Create;
  M.SetSize(FNodes[0].Size);
  F.ReadBuffer(M.Memory^, M.Size);
  ReadTrackData_MIDS(M, TrackData[0]);
  M.Free;

  Log.Lines.Add('[+] '+IntToStr(Length(TrackData[0].Data))+' events found.');
  SongData_PutInt('MIDIType', 0);
  Result := True;
  Log.Lines.Add('');
  Log.Lines.Add('[*] Information:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

function TMainForm.ReadXMI(var F: TMemoryStream): Boolean;
type
  TrackInfo = record
    Offset, Size: Cardinal;
  end;
var
  Nodes, FNodes, NodeData: IFFNodes;
  Tracks: Word;
  TracksInfo: Array of TrackInfo;
  I: Integer;
  M: TMemoryStream;
begin
  Result := False;
  Log.Lines.Add('[*] Reading Extended MIDI file...');
  IFFGetNodes('IFF', F.Memory, 0, F.Size, Nodes);
  if IFFSearchNode(Nodes, 'CAT ', 'XMID') > 0 then begin
    // Standard multi-song XMIDI
    Tracks := 0;
    if (Nodes[0].Name = 'FORM') and (Nodes[0].Sub = 'XDIR') then
    begin
      // with header
      IFFGetNodes('IFF', F.Memory, Nodes[0].DataOffs, Nodes[0].Size, FNodes);
      if IFFSearchNode(FNodes, NodeData, 'INFO') > 0 then
      begin
        if NodeData[0].Size >= 2 then
        begin
          if NodeData[0].DataOffs + NodeData[0].Size <= F.Size then begin
            F.Seek(NodeData[0].DataOffs, soFromBeginning);
            F.ReadBuffer(Tracks, 2);
          end else
            Log.Lines.Add('[*] Warning: XMIDI INFO chunk is truncated.');
        end else
          Log.Lines.Add('[*] Warning: XMIDI INFO chunk has wrong size.');
      end else
        Log.Lines.Add('[*] Warning: XMIDI INFO chunk not found.');

      Log.Lines.Add('[*] Checking tracks...');
      IFFSearchNode(Nodes, FNodes, 'CAT ', 'XMID');
      IFFGetNodes('IFF', F.Memory, FNodes[0].DataOffs, FNodes[0].Size, Nodes);
      IFFSearchNode(Nodes, FNodes, 'FORM', 'XMID');
      Nodes := FNodes;
      if Tracks > 0 then
      begin
        if Length(Nodes) > Tracks then
          Log.Lines.Add('[*] Warning: Additional XMIDI chunks found.');
        if Length(Nodes) < Tracks then
        begin
          Log.Lines.Add('[*] Warning: Missing XMIDI tracks ('+IntToStr(Tracks - Length(Nodes))+' out of '+IntToStr(Tracks)+').');
          Tracks := Length(Nodes);
        end;
      end else
        Tracks := Length(Nodes);
      for I := 0 to Tracks - 1 do
      begin
        IFFGetNodes('IFF', F.Memory, Nodes[I].DataOffs, Nodes[I].Size, NodeData);
        IFFSearchNode(NodeData, FNodes, 'EVNT');
        SetLength(TracksInfo, Length(TracksInfo) + 1);
        if Length(FNodes) > 0 then
        begin
          TracksInfo[High(TracksInfo)].Offset := FNodes[0].DataOffs;
          TracksInfo[High(TracksInfo)].Size := FNodes[0].Size;
        end else
        begin
          TracksInfo[High(TracksInfo)].Offset := Nodes[I].DataOffs;
          TracksInfo[High(TracksInfo)].Size := 0;
        end;
        Log.Lines.Add('[+] Track #'+IntToStr(I)+' found ('+IntToStr(TracksInfo[High(TracksInfo)].Size)+' bytes).');
      end;
    end;
  end else
    if IFFSearchNode(Nodes, 'FORM', 'XMID') > 0 then begin
      // Detached XMIDI chunks
      Log.Lines.Add('[*] Checking tracks...');
      IFFSearchNode(Nodes, FNodes, 'FORM', 'XMID');
      Nodes := FNodes;
      for I := 0 to Length(Nodes) - 1 do
      begin
        IFFGetNodes('IFF', F.Memory, Nodes[I].DataOffs, Nodes[I].Size, NodeData);
        IFFSearchNode(NodeData, FNodes, 'EVNT');
        SetLength(TracksInfo, Length(TracksInfo) + 1);
        if Length(FNodes) > 0 then
        begin
          TracksInfo[High(TracksInfo)].Offset := FNodes[0].DataOffs;
          TracksInfo[High(TracksInfo)].Size := FNodes[0].Size;
        end else
        begin
          TracksInfo[High(TracksInfo)].Offset := Nodes[I].DataOffs;
          TracksInfo[High(TracksInfo)].Size := 0;
        end;
        Log.Lines.Add('[+] Track #'+IntToStr(I)+' found ('+IntToStr(TracksInfo[High(TracksInfo)].Size)+' bytes).');
      end;
    end else
    begin
      Log.Lines.Add('[-] Error: XMIDI headers not found.');
      Exit;
    end;

  SongData_PutDWord('InitTempo', 500000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', 60);

  SetLength(TrackData, 0);
  for I := 0 to Length(TracksInfo) - 1 do
  begin
    // Reading track #I
    Log.Lines.Add('[*] Reading track '+IntToStr(I)+'...');
    if F.Size < TracksInfo[I].Offset + TracksInfo[I].Size then begin
      if F.Size - TracksInfo[I].Offset < 0 then
      begin
        Log.Lines.Add('[-] Error: Event data is truncated.');
        Continue;
      end;
      Log.Lines.Add('[*] Warning: Event data is truncated.');
      TracksInfo[I].Size := F.Size - TracksInfo[I].Offset;
    end;
    SetLength(TrackData, Length(TrackData) + 1);
    TrackData[High(TrackData)].Title := '';
    SetLength(TrackData[High(TrackData)].Data, 0);

    F.Seek(TracksInfo[I].Offset, soFromBeginning);
    M := TMemoryStream.Create;
    M.SetSize(TracksInfo[I].Size);
    F.ReadBuffer(M.Memory^, M.Size);
    ReadTrackData_XMI(M, TrackData[High(TrackData)]);
    M.Free;
    Log.Lines.Add('[+] '+IntToStr(Length(TrackData[High(TrackData)].Data))+' events found.');
  end;
  SongData_PutInt('MIDIType', 2);
  Result := True;
  Log.Lines.Add('');
  Log.Lines.Add('[*] Information:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

function TMainForm.ReadCMF(var F: TMemoryStream): Boolean;
type
  CMFInstrument = Array[0..15] of Byte;
  {packed record
    iModChar,
    iCarChar,
    iModScale,
    iCarScale,
    iModAttack,
    iCarAttack,
    iModSustain,
    iCarSustain,
    iModWaveSel,
    iCarWaveSel,
    iFeedback: Byte;
    Pad1: DWord;
    Pad2: Byte;
  end;}
var
  DW: Cardinal;
  W: Word;
  iOffsetInstruments,
  iOffsetMusic,
  iTicksPerQuarter,
  iTicksPerSecond,
  iOffsetTitle,
  iOffsetComposer,
  iOffsetRemarks,
  iInstrumentCount,
  iTempo: Word;
  iChannelInUse: Array[0..15] of Byte;
  dwInstrumentSize,
  dwDataSize: DWord;
  Instruments: Array of CMFInstrument;
  MIDIData: TMemoryStream;
  S: String;
  sTitle, sComposer, sRemarks: AnsiString;
  I, J: Integer;
begin
  Result := False;
  Log.Lines.Add('[*] Reading Creative Music File...');
  if F.Size < 36 then begin
    Log.Lines.Add('[-] Error: Wrong file size.');
    Exit;
  end;

  F.Seek(0, soFromBeginning);
  F.ReadBuffer(DW, 4);
  if DW <> $464D5443 then begin // 'CTMF'
    Log.Lines.Add('[-] Error: Wrong header signature.');
    Exit;
  end;
  F.ReadBuffer(W, 2);
  if (W <> $0100) and (W <> $0101) then begin
    Log.Lines.Add('[-] Error: Unknown file version.');
    Exit;
  end;
  SongData_PutInt('CMF_Version', W);

  F.ReadBuffer(iOffsetInstruments, 2);
  F.ReadBuffer(iOffsetMusic, 2);
  F.ReadBuffer(iTicksPerQuarter, 2);
  F.ReadBuffer(iTicksPerSecond, 2);
  F.ReadBuffer(iOffsetTitle, 2);
  F.ReadBuffer(iOffsetComposer, 2);
  F.ReadBuffer(iOffsetRemarks, 2);
  F.ReadBuffer(iChannelInUse, 16);
  SongData_PutInt('CMF_TicksPerQuarter', iTicksPerQuarter);
  SongData_PutInt('CMF_TicksPerSecond', iTicksPerSecond);

  SongData_PutDWord('InitTempo', 1000000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', iTicksPerSecond);

  if W = $0100 then begin
    iInstrumentCount := 0;
    iTempo := 0;
    F.ReadBuffer(iInstrumentCount, 1);
  end else begin
    F.ReadBuffer(iInstrumentCount, 2);
    F.ReadBuffer(iTempo, 2);
  end;

  dwInstrumentSize := iInstrumentCount * 16;
  if iOffsetInstruments > 0 then
  begin
    if iOffsetInstruments + dwInstrumentSize > F.Size then
    begin
      Log.Lines.Add('[*] Warning: Instrument section is truncated.');
      if iOffsetInstruments >= F.Size then
        dwInstrumentSize := 0
      else
        dwInstrumentSize := F.Size - iOffsetInstruments;
    end;

    SetLength(Instruments, iInstrumentCount);
    FillChar(Instruments[0], iInstrumentCount * 16, 0);
    if dwInstrumentSize > 0 then
    begin
      F.Seek(iOffsetInstruments, soFromBeginning);
      F.ReadBuffer(Instruments[0], dwInstrumentSize);
    end;
  end else
    iInstrumentCount := 0;

  SongData_PutInt('CMF_Tempo', iTempo);

  for I := 0 to Length(Instruments) - 1 do
  begin
    S := '';
    for J := 0 to 10 do
      S := S + IntToStr(Instruments[I][J]) + ' ';
    SongData_PutStr('CMF_Inst#' + IntToStr(I), S);
  end;

  if iOffsetTitle >= F.Size then
  begin
    Log.Lines.Add('[*] Warning: Title string is out of file.');
    iOffsetTitle := 0;
  end;
  if iOffsetTitle > 0 then
    sTitle := PAnsiChar(Cardinal(F.Memory) + iOffsetTitle);

  SongData_PutStr('CMF_Title', sTitle);

  if iOffsetComposer >= F.Size then
  begin
    Log.Lines.Add('[*] Warning: Composer string is out of file.');
    iOffsetComposer := 0;
  end;
  if iOffsetComposer > 0 then
    sComposer := PAnsiChar(Cardinal(F.Memory) + iOffsetComposer);

  SongData_PutStr('CMF_Composer', sComposer);

  if iOffsetRemarks >= F.Size then
  begin
    Log.Lines.Add('[*] Warning: Remarks string is out of file.');
    iOffsetRemarks := 0;
  end;
  if iOffsetRemarks > 0 then
    sRemarks := PAnsiChar(Cardinal(F.Memory) + iOffsetRemarks);

  SongData_PutStr('CMF_Remarks', sRemarks);

  if iOffsetMusic >= F.Size then
    iOffsetMusic := 0;
  if iOffsetMusic > 0 then
  begin
    dwDataSize := F.Size - iOffsetMusic;
    if iOffsetTitle >= iOffsetMusic then
      dwDataSize := iOffsetTitle - iOffsetMusic
    else if iOffsetComposer >= iOffsetMusic then
      dwDataSize := iOffsetComposer - iOffsetMusic
    else if iOffsetRemarks >= iOffsetMusic then
      dwDataSize := iOffsetRemarks - iOffsetMusic
    else if iOffsetInstruments >= iOffsetMusic then
      dwDataSize := iOffsetInstruments - iOffsetMusic;

    SetLength(TrackData, 1);
    TrackData[0].Title := sTitle;
    SetLength(TrackData[0].Data, 0);
    MIDIData := TMemoryStream.Create;
    MIDIData.SetSize(dwDataSize);
    F.Seek(iOffsetMusic, soFromBeginning);
    F.ReadBuffer(MIDIData.Memory^, dwDataSize);
    ReadTrackData(MIDIData, TrackData[0]);
    MIDIData.Free;
    Log.Lines.Add('[+] '+IntToStr(Length(TrackData[0].Data))+' events found.');
  end else
    Log.Lines.Add('[*] Warning: Track data is missing.');

  SongData_PutInt('MIDIType', 0);
  Result := True;
  Log.Lines.Add('');
  Log.Lines.Add('[*] Information:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

function MUS_LoadBank(FileName: String): Boolean;
var
  M: TMemoryStream;
  W: Word;
  InstCnt, InstOff: Word;
  I, J: Integer;
  Name: Array[0..8] of AnsiChar;
  S: String;
begin
  Result := False;
  M := TMemoryStream.Create;
  try
    M.LoadFromFile(FileName);
  except
    M.Free;
    Exit;
  end;
  if M.Size < 6 then begin
    // Wrong file size
    M.Free;
    Exit;
  end;

  M.Seek(0, soFromBeginning);
  M.ReadBuffer(W, 2);
  if W <> 1 then begin
    // Wrong file version
    M.Free;
    Exit;
  end;
  M.ReadBuffer(InstCnt, 2);
  if M.Size < InstCnt * 65 + 6 then begin
    // Wrong file size
    M.Free;
    Exit;
  end;
  M.ReadBuffer(InstOff, 2);
  if InstOff <> InstCnt * 9 + 6 then begin
    // Wrong instrument offset
    M.Free;
    Exit;
  end;
  SongData_PutInt('SND_Version', W);
  for I := 0 to InstCnt - 1 do
  begin
    M.ReadBuffer(Name[0], 9);
    SongData_PutStr('SND_Name#'+IntToStr(I), PAnsiChar(@Name[0]));
  end;
  for I := 0 to InstCnt - 1 do
  begin
    S := '';
    for J := 0 to (13+13+2) - 1 do
    begin
      M.ReadBuffer(W, 2);
      S := S + IntToStr(W) + ' ';
    end;
    SongData_PutStr('SND_Data#'+IntToStr(I), S);
  end;
  M.Free;
  Result := True;
end;

function TMainForm.ReadMUS(var F: TMemoryStream; FileName: String): Boolean;
var
  MIDILength,
  totalTick, nrCommand,
  totalTickAct, nrCommandAct: DWORD;
  DW, InitTempo: Cardinal;
  Division, W: Word;
  tuneName: Array[0..29] of AnsiChar;
  Title, Bank: String;
  BankLoad: Boolean;
  I: Integer;
  Banks: TStringList;
  B: Byte;
begin
  Result := False;
  Log.Lines.Add('[*] Reading AdLib MUS file...');
  if F.Size < 70 then begin
    Log.Lines.Add('[-] Error: Wrong file size.');
    Exit;
  end;

  F.Seek(0, soFromBeginning);
  F.ReadBuffer(W, 2);
  if W <> 1 then begin
    Log.Lines.Add('[-] Error: Wrong file version.');
    Exit;
  end;
  SongData_PutInt('MUS_Version', W);

  F.ReadBuffer(DW, 4);
  SongData_PutInt('MUS_ID', DW);
  F.ReadBuffer(tuneName[0], 30);
  Title := PAnsiChar(@tuneName[0]);
  SongData_PutStr('MUS_TuneName', Title);

  F.Seek($24, soFromBeginning);
  F.ReadBuffer(B, 1);
  SongData_PutInt('MUS_TicksPerBeat', B);
  if B = 0 then
    B := 240;
  InitTempo := 60000000 div B;
  SongData_PutDWord('InitTempo', InitTempo);

  F.Seek($25, soFromBeginning);
  F.ReadBuffer(B, 1);
  SongData_PutInt('MUS_BeatPerMeasure', B);

  F.Seek($26, soFromBeginning);
  F.ReadBuffer(totalTick, 4);

  F.Seek($2E, soFromBeginning);
  F.ReadBuffer(nrCommand, 4);

  F.Seek($3A, soFromBeginning);
  F.ReadBuffer(B, 1);
  SongData_PutInt('MUS_Percussive', B);

  F.Seek($3B, soFromBeginning);
  F.ReadBuffer(B, 1);
  SongData_PutInt('MUS_PitchBendRange', B);

  F.Seek($3C, soFromBeginning);
  F.ReadBuffer(Division, 2);
  SongData_PutInt('MUS_BasicTempo', Division);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', Division);

  F.Seek($2A, soFromBeginning);
  F.ReadBuffer(MIDILength, 4);
  if F.Size > 70 + MIDILength then begin
    Log.Lines.Add('[*] Warning: File has some excess data.');
    F.SetSize(70 + MIDILength);
  end else
    if F.Size < 70 + MIDILength then
      Log.Lines.Add('[*] Warning: File seems to be truncated.');
  F.Seek($46, soFromBeginning);

  SetLength(TrackData, 1);
  TrackData[0].Title := Title;
  SetLength(TrackData[0].Data, 0);
  ReadTrackData_MUS(F, TrackData[0]);
  Log.Lines.Add('[+] '+IntToStr(Length(TrackData[0].Data))+' events found.');
  SongData_PutInt('MIDIType', 0);

  totalTickAct := 0;
  for I := 0 to Length(TrackData[0].Data) - 1 do
    totalTickAct := totalTickAct + TrackData[0].Data[I].Ticks;
  if totalTickAct <> totalTick then
    Log.Lines.Add('[*] Warning: Defined number of ticks in the header doesn''t correspond actual number of ticks.');

  nrCommandAct := 0;
  for I := 0 to Length(TrackData[0].Data) - 1 do
  begin
    if TrackData[0].Data[I].Ticks >= 240 then
      nrCommandAct := nrCommandAct + TrackData[0].Data[I].Ticks div 240;
    Inc(nrCommandAct);
  end;
  if nrCommandAct <> nrCommand then
    Log.Lines.Add('[*] Warning: Defined number of commands in the header doesn''t correspond actual number of commands.');

  Log.Lines.Add('[*] Looking for instrument bank file...');
  Bank := ChangeFileExt(FileName, '.snd');
  BankLoad := MUS_LoadBank(Bank);
  if not BankLoad then
  begin
    Bank := ChangeFileExt(FileName, '.tim');
    BankLoad := MUS_LoadBank(Bank);
  end;
  if not BankLoad then
  begin
    Banks := TStringList.Create;
    GetFiles(ExtractFilePath(FileName), '*.snd', Banks);
    for I := 0 to Banks.Count - 1 do
    begin
      Bank := Banks[I];
      BankLoad := MUS_LoadBank(Bank);
      if BankLoad then Break;
    end;
    Banks.Free;
  end;
  if not BankLoad then
  begin
    Banks := TStringList.Create;
    GetFiles(ExtractFilePath(FileName), '*.tim', Banks);
    for I := 0 to Banks.Count - 1 do
    begin
      Bank := Banks[I];
      BankLoad := MUS_LoadBank(Bank);
      if BankLoad then Break;
    end;
    Banks.Free;
  end;
  if BankLoad then
    Log.Lines.Add('[*] Loaded instrument bank: ' + Bank)
  else
    Log.Lines.Add('[*] Instrument bank file not found.');
  Result := True;
  Log.Lines.Add('');
  Log.Lines.Add('[*] Information:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

function TMainForm.ReadRaw(var F: TMemoryStream): Boolean;
begin
  //Result := False;
  Log.Lines.Add('[*] Reading raw MIDI data...');
  SetLength(TrackData, 1);
  TrackData[0].Title := '';
  SetLength(TrackData[0].Data, 0);

  F.Seek(0, soFromBeginning);
  if EventFormat = 'mid' then
    ReadTrackData(F, TrackData[0]);

  Log.Lines.Add('[+] '+IntToStr(Length(TrackData[0].Data))+' events found.');
  SongData_PutInt('MIDIType', 1);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', 96);
  SongData_PutDWord('InitTempo', 500000);
  Result := True;
  Log.Lines.Add('');
  Log.Lines.Add('[*] Default settings:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

function TMainForm.ReadSYX(var F: TMemoryStream): Boolean;
begin
  //Result := False;
  Log.Lines.Add('[*] Reading System Exclusive data...');
  SetLength(TrackData, 1);
  TrackData[0].Title := '';
  SetLength(TrackData[0].Data, 0);

  F.Seek(0, soFromBeginning);
  ReadTrackData_SYX(F, TrackData[0]);

  Log.Lines.Add('[+] '+IntToStr(Length(TrackData[0].Data))+' events found.');
  SongData_PutInt('MIDIType', 1);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', 96);
  SongData_PutDWord('InitTempo', 500000);
  Result := True;
  Log.Lines.Add('');
  Log.Lines.Add('[*] Default settings:');
  LogSongInfo;
  Progress.Position := 0;
  Log.Lines.Add('');
  RefTrackList;
  CalculateEvnts;
end;

procedure TMainForm.ReadTrackData(var F: TMemoryStream; var Trk: Chunk);
var
  J: Integer;
  Buf: Pointer;
  B: Byte;
  ReadTicks, StatByte: Boolean;
  Ticks: UInt64;
  Err: Byte;

  procedure ReadBuf(var Buf; Size: Cardinal);
  begin
    try
      F.ReadBuffer(Buf, Size);
    except
      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
    end;
  end;
begin
  StatByte := False;
  Ticks := 0;
  ReadTicks := True;
  while F.Position < F.Size do begin
    if ReadTicks then begin
      // Reading ticks count
      Ticks := ReadVarVal(F, Err);
      if Err=1 then
      begin
        Log.Lines.Add('[-] Error: Ticks count overflow at offset '+IntToStr(F.Position)+'.');
        Continue;
      end;
      if Err=2 then begin
        Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
        Break;
      end;
    end;
    // Reading status byte
    ReadBuf(B, 1);
    if (B < 128) and (not StatByte) then
    begin
      Log.Lines.Add('[-] Error: Status byte expected at offset '+IntToStr(F.Position-1)+'.');
      ReadTicks := False;
      Continue;
    end;
    ReadTicks := True;
    // Adding event
    SetLength(Trk.Data, Length(Trk.Data)+1);
    // Initializing structure
    Trk.Data[Length(Trk.Data)-1].Status:=0;
    Trk.Data[Length(Trk.Data)-1].BParm1:=0;
    Trk.Data[Length(Trk.Data)-1].BParm2:=0;
    Trk.Data[Length(Trk.Data)-1].Value:=0;
    Trk.Data[Length(Trk.Data)-1].Len:=0;
    Trk.Data[Length(Trk.Data)-1].RunStatMode:=False;
    Trk.Data[Length(Trk.Data)-1].Ticks:=Ticks;
    if B >= 128 then begin
      // Status byte found
      Trk.Data[Length(Trk.Data)-1].Status:=B;
      StatByte:=True;
    end;
    if StatByte and (B < 128) then begin
      // New status byte not found, but already set
      Trk.Data[Length(Trk.Data)-1].Status:=
      Trk.Data[Length(Trk.Data)-2].Status;
      Trk.Data[Length(Trk.Data)-1].RunStatMode:=True;
      B:=Trk.Data[Length(Trk.Data)-1].Status;
      F.Seek(F.Position - 1, 0);
    end;
    case B shr 4 of
      8..11: begin // NoteOff, NoteOn, PolyAfterTouch, Control (2 params)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm2:=B;
      end;
      12..13: begin // ProgramChange, ChanAfterTouch (1 param)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
      end;
      14: begin // Pitch Bend (1 param / 2 bytes)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm2:=B;
        Trk.Data[Length(Trk.Data)-1].Value:=
        Trk.Data[Length(Trk.Data)-1].BParm1+
        Trk.Data[Length(Trk.Data)-1].BParm2*128;
      end;
      15: begin // System
        case B and 15 of
          0,7: begin // SysEx and EOX
            Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
            if Err=2 then begin
              Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
              SetLength(Trk.Data, Length(Trk.Data)-1);
              Log.Lines.Add('[+] Fixed.');
              Break;
            end;
            if Err=1 then begin
              Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
              Trk.Data[Length(Trk.Data)-1].Len := 0;
            end else
              for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                ReadBuf(B, 1);
                if F.Position >= F.Size then begin
                  Trk.Data[Length(Trk.Data)-1].Len := Length(Trk.Data[Length(Trk.Data)-1].DataArray);
                  Log.Lines.Add('[-] Error: Incomplete event data (end of track reached).');
                  Break;
                end;
                SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
              end;
          end;
          1: begin // QuarterFrame
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
          end;
          2: begin // PSongPos
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm2:=B;
            Trk.Data[Length(Trk.Data)-1].Value:=
            Trk.Data[Length(Trk.Data)-1].BParm1*128 +
            Trk.Data[Length(Trk.Data)-1].BParm2;
          end;
          3: begin // SongSelect
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
          end;
          6: ; // TuneRequest
          8: ; // TimingClock
          10: ; // Start
          11: ; // Continue
          12: ; // Stop
          14: ; // ActiveSens
          15: begin // MetaEvnt
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
            case B of
              0: begin  // Track Number
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
              end;
              1..7: begin  // Text, Copyright, TrackName, InstrName, Lyrics, Marker, CuePoint
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  Buf:=AllocMem(Trk.Data[Length(Trk.Data)-1].Len + 1);
                  ZeroMemory(Buf, Trk.Data[Length(Trk.Data)-1].Len + 1);
                  ReadBuf(Buf^, Trk.Data[Length(Trk.Data)-1].Len);
                  Trk.Data[Length(Trk.Data)-1].DataString:=PAnsiChar(Buf);
                  FreeMem(Buf, Trk.Data[Length(Trk.Data)-1].Len + 1);
                end;
                if Trk.Data[Length(Trk.Data)-1].BParm1=3 then
                  if (Trk.Title='') and
                  (Trk.Data[Length(Trk.Data)-1].DataString<>'') then
                    Trk.Title:=Trk.Data[Length(Trk.Data)-1].DataString;
              end;
              32: begin // MIDI Channel
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
                  if not (Trk.Data[Length(Trk.Data)-1].Value in [0..15]) then begin
                    Log.Lines.Add('[-] Error: MIDI Channel is wrong at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                    Trk.Data[Length(Trk.Data)-1].Len:=1;
                    Trk.Data[Length(Trk.Data)-1].Value:=0;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              33: begin // MIDI Port
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
              end;
              81: begin  // Tempo
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
              end;
              84: begin  // SMPTE Offset
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  if Trk.Data[Length(Trk.Data)-1].Len<>5 then
                    Log.Lines.Add('[-] Error: SMPTE Offset is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    ReadBuf(B, 1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len<5 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 5);
                    for J:=Trk.Data[Length(Trk.Data)-1].Len to 4 do
                      Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                    Trk.Data[Length(Trk.Data)-1].Len:=5;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len>5 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 5);
                    Trk.Data[Length(Trk.Data)-1].Len:=5;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              88: begin  // TimeSignature
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  if Trk.Data[Length(Trk.Data)-1].Len<>4 then
                    Log.Lines.Add('[-] Error: Time Signature is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    ReadBuf(B, 1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len<4 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 4);
                    for J:=Trk.Data[Length(Trk.Data)-1].Len to 3 do
                      Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                    Trk.Data[Length(Trk.Data)-1].Len:=4;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len>4 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 4);
                    Trk.Data[Length(Trk.Data)-1].Len:=4;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              89: begin  // KeySignature
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  if Trk.Data[Length(Trk.Data)-1].Len<>2 then
                    Log.Lines.Add('[-] Error: Key Signature is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    ReadBuf(B, 1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len<2 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 2);
                    for J:=Trk.Data[Length(Trk.Data)-1].Len to 1 do
                      Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                    Trk.Data[Length(Trk.Data)-1].Len:=2;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len>2 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 2);
                    Trk.Data[Length(Trk.Data)-1].Len:=2;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              else begin
                // Custom meta event
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if F.Position >= F.Size then begin
                      Trk.Data[Length(Trk.Data)-1].Len := Length(Trk.Data[Length(Trk.Data)-1].DataArray);
                      Log.Lines.Add('[-] Error: Incomplete event data (end of track reached).');
                      Break;
                    end;
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.ReadTrackData_SYX(var F: TMemoryStream; var Trk: Chunk);
var
  B: Byte;
  Idx: Integer;

  procedure ReadBuf(var Buf; Size: Cardinal);
  begin
    try
      F.ReadBuffer(Buf, Size);
    except
      Log.Lines.Add('[-] Error: Incomplete data (end of file reached).');
    end;
  end;
begin
  while F.Position < F.Size do begin
    ReadBuf(B, 1);
    if B <> $F0 then
      Continue;
    // Adding event
    SetLength(Trk.Data, Length(Trk.Data)+1);
    // Initializing variables
    Idx := Length(Trk.Data)-1;
    Trk.Data[Idx].Status:=B;
    Trk.Data[Idx].BParm1:=0;
    Trk.Data[Idx].BParm2:=0;
    Trk.Data[Idx].Value:=0;
    Trk.Data[Idx].Len:=0;
    Trk.Data[Idx].RunStatMode:=False;
    while B <> $F7 do begin
      if F.Position >= F.Size then
        B := $F7
      else
        ReadBuf(B, 1);
      Inc(Trk.Data[Idx].Len);
      SetLength(Trk.Data[Idx].DataArray, Trk.Data[Idx].Len);
      Trk.Data[Idx].DataArray[Trk.Data[Idx].Len - 1] := B;
    end;
  end;
end;

procedure TMainForm.ReadTrackData_MIDS(var F: TMemoryStream; var Trk: Chunk);
var
  Sz, DW: LongWord;
  Tick: Boolean;
  I: Integer;

  procedure ReadBuf(var Buf; Size: Cardinal);
  begin
    try
      F.ReadBuffer(Buf, Size);
    except
      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
    end;
  end;
begin
  I := 0;
  F.Seek(4, soCurrent);
  while F.Position < F.Size do begin
    // Reading block size
    F.Seek(4, soCurrent);
    ReadBuf(Sz, 4);
    // Reading block
    Tick := True;
    while Sz > 0 do begin
      ReadBuf(DW, 4);
      if Tick then begin
        // Adding event
        I := Length(Trk.Data);
        SetLength(Trk.Data, I + 1);
        // Reading ticks
        Trk.Data[I].Ticks := DW;
        // Initializing variables
        Trk.Data[I].Status := 0;
        Trk.Data[I].BParm1 := 0;
        Trk.Data[I].BParm2 := 0;
        Trk.Data[I].Value := 0;
        Trk.Data[I].Len := 0;
        Trk.Data[I].RunStatMode := False;
      end else begin
        // Reading event
        case DW shr 24 of
          0: begin // MIDI event
            Trk.Data[I].Status := DW and $FF;
            case Trk.Data[I].Status shr 4 of
              8,9,10,11,14: begin
                Trk.Data[I].BParm1 := DW shr 8 and $FF;
                Trk.Data[I].BParm2 := DW shr 16 and $FF;
              end;
              12,13: begin
                Trk.Data[I].BParm1 := DW shr 8 and $FF;
              end;
            end;
          end;
          1: begin // Tempo change
            Trk.Data[I].Status := $FF;
            Trk.Data[I].BParm1 := $51;
            Trk.Data[I].Len := 3;
            Trk.Data[I].Value := DW and $FFFFFF;
            SetLength(Trk.Data[I].DataArray, 3);
            Trk.Data[I].DataArray[0] := DW shr 16 and $FF;
            Trk.Data[I].DataArray[1] := DW shr 8 and $FF;
            Trk.Data[I].DataArray[2] := DW and $FF;
          end;
        end;
      end;
      Tick := not Tick;
      Dec(Sz, 4);
    end;
  end;
end;

procedure TMainForm.ReadTrackData_XMI(var F: TMemoryStream; var Trk: Chunk);
var
  J: Integer;
  Buf: Pointer;
  B: Byte;
  Ticks: UInt64;
  Err: Byte;

  procedure ReadBuf(var Buf; Size: Cardinal);
  begin
    try
      F.ReadBuffer(Buf, Size);
    except
      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
    end;
  end;
begin
  while F.Position < F.Size do begin
    // Reading ticks count
    Ticks := ReadVarVal_XMI(F, Err);
    if Err=1 then
    begin
      Log.Lines.Add('[-] Error: Ticks count overflow at offset '+IntToStr(F.Position)+'.');
      Continue;
    end;
    if Err=2 then begin
      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
      Break;
    end;
    if F.Position >= F.Size then
      Break;
    // Reading status byte
    ReadBuf(B, 1);
    // Adding event
    SetLength(Trk.Data, Length(Trk.Data)+1);
    // Initializing structure
    Trk.Data[Length(Trk.Data)-1].Status:=B;
    Trk.Data[Length(Trk.Data)-1].BParm1:=0;
    Trk.Data[Length(Trk.Data)-1].BParm2:=0;
    Trk.Data[Length(Trk.Data)-1].Value:=0;
    Trk.Data[Length(Trk.Data)-1].Len:=0;
    Trk.Data[Length(Trk.Data)-1].RunStatMode:=False;
    Trk.Data[Length(Trk.Data)-1].Ticks:=Ticks;
    case B shr 4 of
      8: begin // NoteOff (unused in XMI)
        Trk.Data[Length(Trk.Data)-1].BParm1:=0;
        Trk.Data[Length(Trk.Data)-1].BParm2:=0;
      end;
      9: begin // XMI Note (3 params)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm2:=B;
        // Read note duration
        Trk.Data[Length(Trk.Data)-1].Len := ReadVarVal(F, Err);
        if Err=2 then begin
          Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
          SetLength(Trk.Data, Length(Trk.Data)-1);
          Log.Lines.Add('[+] Fixed.');
          Break;
        end;
        if Err=1 then begin
          Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
          Trk.Data[Length(Trk.Data)-1].Len := 0;
        end;
      end;
      10..11: begin // PolyAfterTouch, Control (2 params)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm2:=B;
      end;
      12..13: begin // ProgramChange, ChanAfterTouch (1 param)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
      end;
      14: begin // Pitch Bend (1 param / 2 bytes)
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm1:=B;
        ReadBuf(B, 1);
        if B>127 then begin
          Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
          B:=127;
        end;
        Trk.Data[Length(Trk.Data)-1].BParm2:=B;
        Trk.Data[Length(Trk.Data)-1].Value:=
        Trk.Data[Length(Trk.Data)-1].BParm1+
        Trk.Data[Length(Trk.Data)-1].BParm2*128;
      end;
      15: begin // System
        case B and 15 of
          0: begin // SysEx
            Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
            if Err=2 then begin
              Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
              SetLength(Trk.Data, Length(Trk.Data)-1);
              Log.Lines.Add('[+] Fixed.');
              Break;
            end;
            if Err=1 then begin
              Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
              Trk.Data[Length(Trk.Data)-1].Len := 0;
            end else
              for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                ReadBuf(B, 1);
                if F.Position >= F.Size then begin
                  Trk.Data[Length(Trk.Data)-1].Len := Length(Trk.Data[Length(Trk.Data)-1].DataArray);
                  Log.Lines.Add('[-] Error: Incomplete event data (end of track reached).');
                  Break;
                end;
                SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
              end;
          end;
          1: begin // QuarterFrame
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
          end;
          2: begin // PSongPos
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm2:=B;
            Trk.Data[Length(Trk.Data)-1].Value:=
            Trk.Data[Length(Trk.Data)-1].BParm1*128 +
            Trk.Data[Length(Trk.Data)-1].BParm2;
          end;
          3: begin // SongSelect
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
          end;
          6: ; // TuneRequest
          7: ; // EOX
          8: ; // TimingClock
          10: ; // Start
          11: ; // Continue
          12: ; // Stop
          14: ; // ActiveSens
          15: begin // MetaEvnt
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
            case B of
              0: begin  // Track Number
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
              end;
              1..7: begin  // Text, Copyright, TrackName, InstrName, Lyrics, Marker, CuePoint
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  Buf:=AllocMem(Trk.Data[Length(Trk.Data)-1].Len + 1);
                  ZeroMemory(Buf, Trk.Data[Length(Trk.Data)-1].Len + 1);
                  ReadBuf(Buf^, Trk.Data[Length(Trk.Data)-1].Len);
                  Trk.Data[Length(Trk.Data)-1].DataString:=PAnsiChar(Buf);
                  FreeMem(Buf, Trk.Data[Length(Trk.Data)-1].Len + 1);
                end;
                if Trk.Data[Length(Trk.Data)-1].BParm1=3 then
                  if (Trk.Title='') and
                  (Trk.Data[Length(Trk.Data)-1].DataString<>'') then
                    Trk.Title:=Trk.Data[Length(Trk.Data)-1].DataString;
              end;
              32: begin // MIDI Channel
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
                  if not (Trk.Data[Length(Trk.Data)-1].Value in [0..15]) then begin
                    Log.Lines.Add('[-] Error: MIDI Channel is wrong at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                    Trk.Data[Length(Trk.Data)-1].Len:=1;
                    Trk.Data[Length(Trk.Data)-1].Value:=0;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              33: begin // MIDI Port
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
              end;
              81: begin  // Tempo
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if J>0 then
                      Trk.Data[Length(Trk.Data)-1].Value:=
                      Trk.Data[Length(Trk.Data)-1].Value shl 8;
                    Trk.Data[Length(Trk.Data)-1].Value:=
                    Trk.Data[Length(Trk.Data)-1].Value or B;
                  end;
              end;
              84: begin  // SMPTE Offset
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  if Trk.Data[Length(Trk.Data)-1].Len<>5 then
                    Log.Lines.Add('[-] Error: SMPTE Offset is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    ReadBuf(B, 1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len<5 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 5);
                    for J:=Trk.Data[Length(Trk.Data)-1].Len to 4 do
                      Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                    Trk.Data[Length(Trk.Data)-1].Len:=5;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len>5 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 5);
                    Trk.Data[Length(Trk.Data)-1].Len:=5;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              88: begin  // TimeSignature
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  if Trk.Data[Length(Trk.Data)-1].Len<>4 then
                    Log.Lines.Add('[-] Error: Time Signature is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    ReadBuf(B, 1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len<4 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 4);
                    for J:=Trk.Data[Length(Trk.Data)-1].Len to 3 do
                      Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                    Trk.Data[Length(Trk.Data)-1].Len:=4;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len>4 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 4);
                    Trk.Data[Length(Trk.Data)-1].Len:=4;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              89: begin  // KeySignature
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else begin
                  if Trk.Data[Length(Trk.Data)-1].Len<>2 then
                    Log.Lines.Add('[-] Error: Key Signature is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    ReadBuf(B, 1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len<2 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 2);
                    for J:=Trk.Data[Length(Trk.Data)-1].Len to 1 do
                      Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                    Trk.Data[Length(Trk.Data)-1].Len:=2;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                  if Trk.Data[Length(Trk.Data)-1].Len>2 then begin
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 2);
                    Trk.Data[Length(Trk.Data)-1].Len:=2;
                    Log.Lines.Add('[+] Fixed.');
                  end;
                end;
              end;
              else begin
                // Custom meta event
                Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                if Err=2 then begin
                  Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                  SetLength(Trk.Data, Length(Trk.Data)-1);
                  Log.Lines.Add('[+] Fixed.');
                  Break;
                end;
                if Err=1 then begin
                  Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                  Trk.Data[Length(Trk.Data)-1].Len := 0;
                end else
                  for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                    ReadBuf(B, 1);
                    if F.Position >= F.Size then begin
                      Trk.Data[Length(Trk.Data)-1].Len := Length(Trk.Data[Length(Trk.Data)-1].DataArray);
                      Log.Lines.Add('[-] Error: Incomplete event data (end of track reached).');
                      Break;
                    end;
                    SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                    Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                    Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                  end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.ReadTrackData_MUS(var F: TMemoryStream; var Trk: Chunk);
var
  J: Integer;
  Buf: Pointer;
  B: Byte;
  StatByte: Boolean;
  Err: Byte;

  procedure ReadBuf(var Buf; Size: Cardinal);
  begin
    try
      F.ReadBuffer(Buf, Size);
    except
      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
    end;
  end;
begin
  StatByte := False;
  while F.Position < F.Size do begin
    // Adding event
    SetLength(Trk.Data, Length(Trk.Data)+1);
    // Initializing variables
    Trk.Data[Length(Trk.Data)-1].Status:=0;
    Trk.Data[Length(Trk.Data)-1].BParm1:=0;
    Trk.Data[Length(Trk.Data)-1].BParm2:=0;
    Trk.Data[Length(Trk.Data)-1].Value:=0;
    Trk.Data[Length(Trk.Data)-1].Len:=0;
    Trk.Data[Length(Trk.Data)-1].RunStatMode:=False;
    // Reading ticks count
    // modified (MUS format)
    Trk.Data[Length(Trk.Data)-1].Ticks := ReadVarVal_MUS(F, Err);
    if Err=2 then begin
      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
      SetLength(Trk.Data, Length(Trk.Data)-1);
      Log.Lines.Add('[+] Fixed.');
      Break;
    end;
    if Err=1 then
      Log.Lines.Add('[-] Error: Ticks count overflow at offset '+IntToStr(F.Position)+'.')
    else begin
      // Reading status byte
      ReadBuf(B, 1);
      if (B < 128) and (not StatByte) then
        Log.Lines.Add('[-] Error: Status byte expected at offset '+IntToStr(F.Position-1)+'.')
      else begin
        if B >= 128 then begin
          // Status byte found
          Trk.Data[Length(Trk.Data)-1].Status := B;
          StatByte := True;
        end;
        if StatByte and (B < 128) then begin
          // New status byte not found, but already set
          Trk.Data[Length(Trk.Data)-1].Status:=
          Trk.Data[Length(Trk.Data)-2].Status;
          Trk.Data[Length(Trk.Data)-1].RunStatMode := True;
          B := Trk.Data[Length(Trk.Data)-1].Status;
          F.Seek(F.Position - 1, 0);
        end;
        case B shr 4 of
          8,9,11: begin // NoteOff, NoteOn, Control (2 params)
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm2:=B;
          end;
          // modified (MUS format)
          10: begin // PolyAfterTouch (1 param)
            ReadBuf(B, 1);
            if B > 127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B := 127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1 := B;
            Trk.Data[Length(Trk.Data)-1].BParm2 := 64;
          end;
          12..13: begin // ProgramChange, ChanAfterTouch (1 param)
            ReadBuf(B, 1);
            if B > 127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B := 127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1 := B;
          end;
          14: begin // Pitch Bend (1 param / 2 bytes)
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm1:=B;
            ReadBuf(B, 1);
            if B>127 then begin
              Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
              B:=127;
            end;
            Trk.Data[Length(Trk.Data)-1].BParm2:=B;
            Trk.Data[Length(Trk.Data)-1].Value:=
            Trk.Data[Length(Trk.Data)-1].BParm1+
            Trk.Data[Length(Trk.Data)-1].BParm2*128;
          end;
          15: begin // System
            case B and 15 of
              // modified (MUS format)
              0: begin // SysEx / Set Speed
                Trk.Data[Length(Trk.Data)-1].Len := 0;
                repeat
                  ReadBuf(B, 1);
                  if F.Position >= F.Size then begin
                    Trk.Data[Length(Trk.Data)-1].Len := Length(Trk.Data[Length(Trk.Data)-1].DataArray);
                    Log.Lines.Add('[-] Error: Incomplete event data (end of track reached).');
                    Break;
                  end;
                  SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                  Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                  Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1] := B;
                until B = $F7;
                Trk.Data[Length(Trk.Data)-1].Len :=
                Length(Trk.Data[Length(Trk.Data)-1].DataArray);
              end;
              1: begin // QuarterFrame
                ReadBuf(B, 1);
                if B>127 then begin
                  Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
                  B:=127;
                end;
                Trk.Data[Length(Trk.Data)-1].BParm1:=B;
              end;
              2: begin // PSongPos
                ReadBuf(B, 1);
                if B>127 then begin
                  Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
                  B:=127;
                end;
                Trk.Data[Length(Trk.Data)-1].BParm1:=B;
                ReadBuf(B, 1);
                if B>127 then begin
                  Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
                  B:=127;
                end;
                Trk.Data[Length(Trk.Data)-1].BParm2:=B;
                Trk.Data[Length(Trk.Data)-1].Value:=
                Trk.Data[Length(Trk.Data)-1].BParm1*128 +
                Trk.Data[Length(Trk.Data)-1].BParm2;
              end;
              3: begin // SongSelect
                ReadBuf(B, 1);
                if B>127 then begin
                  Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
                  B:=127;
                end;
                Trk.Data[Length(Trk.Data)-1].BParm1:=B;
              end;
              6: ; // TuneRequest
              // modified (MUS format)
              7: ; // EOX
              8: ; // TimingClock
              10: ; // Start
              11: ; // Continue
              12: ; // Stop
              14: ; // ActiveSens
              15: begin // MetaEvnt
                ReadBuf(B, 1);
                if B>127 then begin
                  Log.Lines.Add('[-] Error: Parameter greater than 127 at offset '+IntToStr(F.Position-1)+'.');
                  B:=127;
                end;
                Trk.Data[Length(Trk.Data)-1].BParm1:=B;
                case B of
                  0: begin  // Track Number
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        ReadBuf(B, 1);
                        if J>0 then
                          Trk.Data[Length(Trk.Data)-1].Value:=
                          Trk.Data[Length(Trk.Data)-1].Value shl 8;
                        Trk.Data[Length(Trk.Data)-1].Value:=
                        Trk.Data[Length(Trk.Data)-1].Value or B;
                      end;
                  end;
                  1..7: begin  // Text, Copyright, TrackName, InstrName, Lyrics, Marker, CuePoint
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else begin
                      Buf:=AllocMem(Trk.Data[Length(Trk.Data)-1].Len + 1);
                      ZeroMemory(Buf, Trk.Data[Length(Trk.Data)-1].Len + 1);
                      ReadBuf(Buf^, Trk.Data[Length(Trk.Data)-1].Len);
                      Trk.Data[Length(Trk.Data)-1].DataString:=PAnsiChar(Buf);
                      FreeMem(Buf, Trk.Data[Length(Trk.Data)-1].Len + 1);
                    end;
                    if Trk.Data[Length(Trk.Data)-1].BParm1=3 then
                      if (Trk.Title='') and
                      (Trk.Data[Length(Trk.Data)-1].DataString<>'') then
                        Trk.Title:=Trk.Data[Length(Trk.Data)-1].DataString;
                  end;
                  32: begin // MIDI Channel
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else begin
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        ReadBuf(B, 1);
                        if J>0 then
                          Trk.Data[Length(Trk.Data)-1].Value:=
                          Trk.Data[Length(Trk.Data)-1].Value shl 8;
                        Trk.Data[Length(Trk.Data)-1].Value:=
                        Trk.Data[Length(Trk.Data)-1].Value or B;
                      end;
                      if not (Trk.Data[Length(Trk.Data)-1].Value in [0..15]) then begin
                        Log.Lines.Add('[-] Error: MIDI Channel is wrong at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                        Trk.Data[Length(Trk.Data)-1].Len:=1;
                        Trk.Data[Length(Trk.Data)-1].Value:=0;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                    end;
                  end;
                  33: begin // MIDI Port
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        ReadBuf(B, 1);
                        if J>0 then
                          Trk.Data[Length(Trk.Data)-1].Value:=
                          Trk.Data[Length(Trk.Data)-1].Value shl 8;
                        Trk.Data[Length(Trk.Data)-1].Value:=
                        Trk.Data[Length(Trk.Data)-1].Value or B;
                      end;
                  end;
                  81: begin  // Tempo
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        ReadBuf(B, 1);
                        if J>0 then
                          Trk.Data[Length(Trk.Data)-1].Value:=
                          Trk.Data[Length(Trk.Data)-1].Value shl 8;
                        Trk.Data[Length(Trk.Data)-1].Value:=
                        Trk.Data[Length(Trk.Data)-1].Value or B;
                      end;
                  end;
                  84: begin  // SMPTE Offset
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else begin
                      if Trk.Data[Length(Trk.Data)-1].Len<>5 then
                        Log.Lines.Add('[-] Error: SMPTE Offset is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                        Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                        ReadBuf(B, 1);
                        Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                      end;
                      if Trk.Data[Length(Trk.Data)-1].Len<5 then begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 5);
                        for J:=Trk.Data[Length(Trk.Data)-1].Len to 4 do
                          Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                        Trk.Data[Length(Trk.Data)-1].Len:=5;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                      if Trk.Data[Length(Trk.Data)-1].Len>5 then begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 5);
                        Trk.Data[Length(Trk.Data)-1].Len:=5;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                    end;
                  end;
                  88: begin  // TimeSignature
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else begin
                      if Trk.Data[Length(Trk.Data)-1].Len<>4 then
                        Log.Lines.Add('[-] Error: Time Signature is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                        Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                        ReadBuf(B, 1);
                        Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                      end;
                      if Trk.Data[Length(Trk.Data)-1].Len<4 then begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 4);
                        for J:=Trk.Data[Length(Trk.Data)-1].Len to 3 do
                          Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                        Trk.Data[Length(Trk.Data)-1].Len:=4;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                      if Trk.Data[Length(Trk.Data)-1].Len>4 then begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 4);
                        Trk.Data[Length(Trk.Data)-1].Len:=4;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                    end;
                  end;
                  89: begin  // KeySignature
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else begin
                      if Trk.Data[Length(Trk.Data)-1].Len<>2 then
                        Log.Lines.Add('[-] Error: Key Signature is wrong formatted at offset '+IntToStr(F.Position-Trk.Data[Length(Trk.Data)-1].Len)+'.');
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                        Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                        ReadBuf(B, 1);
                        Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                      end;
                      if Trk.Data[Length(Trk.Data)-1].Len<2 then begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 2);
                        for J:=Trk.Data[Length(Trk.Data)-1].Len to 1 do
                          Trk.Data[Length(Trk.Data)-1].DataArray[J]:=0;
                        Trk.Data[Length(Trk.Data)-1].Len:=2;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                      if Trk.Data[Length(Trk.Data)-1].Len>2 then begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray, 2);
                        Trk.Data[Length(Trk.Data)-1].Len:=2;
                        Log.Lines.Add('[+] Fixed.');
                      end;
                    end;
                  end;
                  else begin
                    // Custom meta event
                    Trk.Data[Length(Trk.Data)-1].Len:=ReadVarVal(F, Err);
                    if Err=2 then begin
                      Log.Lines.Add('[-] Error: Incomplete event (end of track reached).');
                      SetLength(Trk.Data, Length(Trk.Data)-1);
                      Log.Lines.Add('[+] Fixed.');
                      Break;
                    end;
                    if Err=1 then begin
                      Log.Lines.Add('[-] Error: Length overflow at offset '+IntToStr(F.Position)+'.');
                      Trk.Data[Length(Trk.Data)-1].Len := 0;
                    end else
                      for J:=0 to Trk.Data[Length(Trk.Data)-1].Len-1 do begin
                        SetLength(Trk.Data[Length(Trk.Data)-1].DataArray,
                        Length(Trk.Data[Length(Trk.Data)-1].DataArray)+1);
                        ReadBuf(B, 1);
                        Trk.Data[Length(Trk.Data)-1].DataArray[Length(Trk.Data[Length(Trk.Data)-1].DataArray)-1]:=B;
                      end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.WriteMIDI(var F: TMemoryStream);
label
  Done;
const
  Header = 'MThd';
  Track = 'MTrk';
var
  Ver, Division: Word;
  SMPTE: ShortInt;
  C, Cnt: Cardinal;
  I: Integer;
  TrkOffset: Cardinal;
  TrackStream: TMemoryStream;
begin
  Log.Lines.Add('[*] Writing MIDI header...');
  F.WriteBuffer(PAnsiChar(Header)^, 4);
  C := $06000000;
  F.WriteBuffer(C, 4);
  if not SongData_GetWord('MIDIType', Ver) then
  begin
    Log.Lines.Add('[-] MIDI Type is not defined.');
    Exit;
  end;
  C := (Ver shr 8) or ((Ver and $FF) shl 8);
  F.WriteBuffer(C, 2);
  C := Length(TrackData);
  C := (C shr 8) or ((C and $FF) shl 8);
  F.WriteBuffer(C, 2);
  if not SongData_GetSInt('SMPTE', SMPTE) then
    SMPTE := 0;
  if not SongData_GetWord('Division', Division) then
  begin
    Log.Lines.Add('[-] Division is not defined.');
    Exit;
  end;
  if SMPTE >= 0 then begin
    C := (Division shr 8) or ((Division and $FF) shl 8);
    F.WriteBuffer(C, 2);
  end else begin
    F.WriteBuffer(SMPTE, 1);
    F.WriteBuffer(Division, 1);
  end;
  Cnt := 0;
  if Length(TrackData) = 0 then
    goto Done;
  for I := 0 to Length(TrackData) - 1 do begin
    if (Ver = 0) and (I <> TrkCh.ItemIndex) then
      Continue;
    Log.Lines.Add('[*] Writing track '+IntToStr(I)+'...');
    F.WriteBuffer(PAnsiChar(Track)^, 4);
    C := 0;
    F.WriteBuffer(C, 4);
    TrkOffset := F.Position;
    TrackStream := TMemoryStream.Create;
    WriteTrackData(TrackStream, TrackData[I]);
    F.WriteBuffer(TrackStream.Memory^, TrackStream.Size);
    TrackStream.Free;
    {if (Length(TrackData[I].Data) > 0) and (TrackData[I].Size > 0) then
      if Length(TrackData[I].Data) div 256 > 0 then begin
        if ((J mod (Length(TrackData[I].Data) div 256)) = 0) and
        (Length(TrackData) > 0) then
          Progress.Position := Round((I / Length(TrackData) +
          J / (Length(TrackData[I].Data) * Length(TrackData))) * 100);
      end else begin
        if ((J mod 1) = 0) and (Length(TrackData) > 0) then
          Progress.Position := Round((I / Length(TrackData) +
          J / (Length(TrackData[I].Data) * Length(TrackData))) * 100);
      end;}
    C := F.Position - TrkOffset;
    Inc(Cnt);
    Log.Lines.Add('[+] Wrote ' + IntToStr(C) + ' bytes.');
    F.Seek(TrkOffset - 4, 0);
    C := (C shr 24) or ((C shr 8) and $FF00)
    or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
    F.WriteBuffer(C, 4);
    F.Seek(F.Size, 0);
  end;
  Done:
  // Write final track count
  F.Seek($A, soFromBeginning);
  C := Cnt;
  C := (C shr 8) or ((C and $FF) shl 8);
  F.WriteBuffer(C, 2);
  F.Seek(0, soFromEnd);
  Progress.Position := 0;
end;

procedure TMainForm.WriteRMI(var F: TMemoryStream);
const
  RIFF = 'RIFF';
  RMID = 'RMID';
  data = 'data';
var
  dw: DWORD;
  MIDI: TMemoryStream;
begin
  Log.Lines.Add('[*] Writing RIFF header...');

  F.WriteBuffer(PAnsiChar(RIFF)^, 4);
  dw := 0;
  F.WriteBuffer(dw, 4);
  F.WriteBuffer(PAnsiChar(RMID)^, 4);
  F.WriteBuffer(PAnsiChar(data)^, 4);

  Log.Lines.Add('[*] Writing RIFF data...');

  MIDI := TMemoryStream.Create;
  WriteMIDI(MIDI);

  dw := MIDI.Size;
  F.WriteBuffer(dw, 4);
  F.WriteBuffer(MIDI.Memory^, dw);
  if Odd(dw) then
  begin
    dw := 0;
    F.WriteBuffer(dw, 1);
  end;

  Log.Lines.Add('[*] Finalizing RIFF header...');

  F.Seek(4, soFromBeginning);
  dw := F.Size - 8;
  F.WriteBuffer(dw, 4);
  F.Seek(F.Size, soFromBeginning);
end;

procedure TMainForm.WriteXMI(var F: TMemoryStream);
const
  FORM = 'FORM';
  XDIR = 'XDIR';
  INFO = 'INFO';
  CAT  = 'CAT ';
  XMID = 'XMID';
  TIMB = 'TIMB';
  EVNT = 'EVNT';
var
  Ver: Word;
  C, Cnt: Cardinal;
  I, J: Integer;
  Track: TMemoryStream;
  Timbre: Array of Byte;
  Events: TMemoryStream;

  function TimbreAdded(B: Byte): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to Length(Timbre) - 1 do
      if (I mod 2 = 0) and (Timbre[I] = B) then
        Exit;
    Result := False;
  end;
begin
  Log.Lines.Add('[*] Writing Extended MIDI file...');

  if not SongData_GetWord('MIDIType', Ver) then
  begin
    Log.Lines.Add('[-] MIDI Type is not defined.');
    Exit;
  end;
  if Ver = 1 then
    Log.Lines.Add('[*] Warning: MIDI Type-1 is not supported by XMIDI.');

  Log.Lines.Add('[*] Writing XMIDI header...');
  F.WriteBuffer(PAnsiChar(FORM)^, 4);
  C := 14;
  C := (C shr 24) or ((C shr 8) and $FF00)
  or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
  F.WriteBuffer(C, 4);
  F.WriteBuffer(PAnsiChar(XDIR)^, 4);
  F.WriteBuffer(PAnsiChar(INFO)^, 4);
  C := 2;
  C := (C shr 24) or ((C shr 8) and $FF00)
  or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
  F.WriteBuffer(C, 4);
  C := 0; // track count
  F.WriteBuffer(C, 2);

  F.WriteBuffer(PAnsiChar(CAT)^, 4);
  C := 0; // catalog size
  F.WriteBuffer(C, 4);
  F.WriteBuffer(PAnsiChar(XMID)^, 4);

  Cnt := 0;
  for I := 0 to Length(TrackData) - 1 do begin
    if (Ver = 0) and (I <> TrkCh.ItemIndex) then
      Continue;
    Log.Lines.Add('[*] Writing track '+IntToStr(I)+'...');
    F.WriteBuffer(PAnsiChar(FORM)^, 4);
    Track := TMemoryStream.Create;
    SetLength(Timbre, 0);
    for J := 0 to Length(TrackData[I].Data) - 1 do
      case TrackData[I].Data[J].Status shr 4 of
        11:
          if TrackData[I].Data[J].BParm1 = 114 then
            if Odd(Length(Timbre)) then
            begin
              SetLength(Timbre, Length(Timbre) + 1);
              Timbre[Length(Timbre) - 1] := TrackData[I].Data[J].BParm2;
            end;
        12:
          if not TimbreAdded(TrackData[I].Data[J].BParm1) then
          begin
            if Odd(Length(Timbre)) then
            begin
              SetLength(Timbre, Length(Timbre) + 1);
              Timbre[Length(Timbre) - 1] := 0;
            end;
            SetLength(Timbre, Length(Timbre) + 1);
            Timbre[Length(Timbre) - 1] := TrackData[I].Data[J].BParm1;
          end;
      end;
    if Length(Timbre) > 0 then
    begin
      if Odd(Length(Timbre)) then
      begin
        SetLength(Timbre, Length(Timbre) + 1);
        Timbre[Length(Timbre) - 1] := 0;
      end;
      Track.WriteBuffer(PAnsiChar(TIMB)^, 4);
      C := 2 + Length(Timbre);
      C := (C shr 24) or ((C shr 8) and $FF00)
      or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
      Track.WriteBuffer(C, 4);
      C := Length(Timbre) div 2;
      Track.WriteBuffer(C, 2);
      Track.WriteBuffer(Timbre[0], Length(Timbre));
    end;
    Track.WriteBuffer(PAnsiChar(EVNT)^, 4);
    C := 0;
    Events := TMemoryStream.Create;
    WriteTrackData_XMI(Events, TrackData[I]);
    if Odd(Events.Size) then
      Events.WriteBuffer(C, 1);
    C := Events.Size;
    C := (C shr 24) or ((C shr 8) and $FF00)
    or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
    Track.WriteBuffer(C, 4);
    Track.WriteBuffer(Events.Memory^, Events.Size);
    Events.Free;
    C := Track.Size + 4;
    C := (C shr 24) or ((C shr 8) and $FF00)
    or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
    F.WriteBuffer(C, 4);
    F.WriteBuffer(PAnsiChar(XMID)^, 4);
    F.WriteBuffer(Track.Memory^, Track.Size);
    Log.Lines.Add('[+] Wrote ' + IntToStr(Track.Size) + ' bytes.');
    Track.Free;
    Inc(Cnt);
  end;
  // track count
  F.Seek($14, soFromBeginning);
  F.WriteBuffer(Cnt, 2);
  // catalog size
  F.Seek($1A, soFromBeginning);
  C := F.Size - $1E;
  C := (C shr 24) or ((C shr 8) and $FF00)
  or ((C shl 8) and $FF0000) or ((C and $FF) shl 24);
  F.WriteBuffer(C, 4);

  F.Seek(F.Size, soFromBeginning);
end;

procedure TMainForm.WriteCMF(var F: TMemoryStream);
const
  CTMF = 'CTMF';
var
  NewVer: Boolean;
  W: Word;
  B: Byte;
  iInstrumentCount: Word;
  iChannelInUse: Array[0..15] of Byte;
  MIDIData: TMemoryStream;
  S: String;
  I, J: Integer;
  SL: TStringList;
begin
  Log.Lines.Add('[*] Writing Creative Music File...');

  F.WriteBuffer(PAnsiChar(CTMF)^, 4);

  SongData_GetWord('CMF_Version', W);
  if W <> $0100 then
    W := $0101;
  NewVer := W <> $0100;
  F.WriteBuffer(W, 2);

  W := 0;
  F.WriteBuffer(W, 2); // iOffsetInstruments
  F.WriteBuffer(W, 2); // iOffsetMusic
  if not SongData_GetWord('CMF_TicksPerQuarter', W) then
  begin
    Log.Lines.Add('[*] Warning: Ticks Per Quarter is not defined.');
    W := 0;
  end;
  F.WriteBuffer(W, 2);
  if not SongData_GetWord('CMF_TicksPerSecond', W) then
  begin
    Log.Lines.Add('[-] Ticks Per Second is not defined.');
    Exit;
  end;
  F.WriteBuffer(W, 2);
  W := 0;
  F.WriteBuffer(W, 2); // iOffsetTitle
  F.WriteBuffer(W, 2); // iOffsetComposer
  F.WriteBuffer(W, 2); // iOffsetRemarks
  FillChar(iChannelInUse, 16, 0);
  F.WriteBuffer(iChannelInUse, 16);

  iInstrumentCount := 0;
  while SongData_GetStr('CMF_Inst#'+IntToStr(iInstrumentCount), S) do
    Inc(iInstrumentCount);

  if not NewVer then
    F.WriteBuffer(iInstrumentCount, 1)
  else begin
    F.WriteBuffer(iInstrumentCount, 2);
    if not SongData_GetWord('CMF_Tempo', W) then
    begin
      Log.Lines.Add('[*] Warning: Tempo is not defined.');
      W := 0;
    end;
    F.WriteBuffer(W, 2);
  end;

  if SongData_GetStr('CMF_Title', S) and (Length(S) > 0) then
  begin
    W := F.Position;
    F.Seek($E, soFromBeginning);
    F.WriteBuffer(W, 2);
    F.Seek(W, soFromBeginning);
    F.WriteBuffer(PAnsiChar(S)^, Length(S) + 1);
  end;

  if SongData_GetStr('CMF_Composer', S) and (Length(S) > 0) then
  begin
    W := F.Position;
    F.Seek($10, soFromBeginning);
    F.WriteBuffer(W, 2);
    F.Seek(W, soFromBeginning);
    F.WriteBuffer(PAnsiChar(S)^, Length(S) + 1);
  end;

  if SongData_GetStr('CMF_Remarks', S) and (Length(S) > 0) then
  begin
    W := F.Position;
    F.Seek($12, soFromBeginning);
    F.WriteBuffer(W, 2);
    F.Seek(W, soFromBeginning);
    F.WriteBuffer(PAnsiChar(S)^, Length(S) + 1);
  end;

  if iInstrumentCount > 0 then
  begin
    W := F.Position;
    F.Seek($6, soFromBeginning);
    F.WriteBuffer(W, 2);
    F.Seek(W, soFromBeginning);
    for I := 0 to iInstrumentCount - 1 do
    begin
      SongData_GetStr('CMF_Inst#'+IntToStr(I), S);
      SL := TStringList.Create;
      SL.Delimiter := ' ';
      SL.StrictDelimiter := True;
      SL.DelimitedText := S;
      for J := 0 to 11 - 1 do
      begin
        try
          B := StrToInt(SL[J]);
        except
          B := 0;
        end;
        F.WriteBuffer(B, 1);
      end;
      B := 0; // Padding
      F.WriteBuffer(B, 1);
      F.WriteBuffer(B, 1);
      F.WriteBuffer(B, 1);
      F.WriteBuffer(B, 1);
      F.WriteBuffer(B, 1);
      SL.Free;
    end;
  end;

  // MIDI Track
  I := TrkCh.ItemIndex;
  if Length(TrackData[I].Data) > 0 then
  begin
    MIDIData := TMemoryStream.Create;
    WriteTrackData(MIDIData, TrackData[I]);

    W := F.Position;
    F.Seek($8, soFromBeginning);
    F.WriteBuffer(W, 2);
    F.Seek(W, soFromBeginning);
    F.WriteBuffer(MIDIData.Memory^, MIDIData.Size);

    Log.Lines.Add('[+] Wrote ' + IntToStr(MIDIData.Size) + ' bytes.');
    MIDIData.Free;
    for J := 0 to Length(TrackData[I].Data) - 1 do
      if TrackData[I].Data[J].Status shr 4 = 9 then
        iChannelInUse[TrackData[I].Data[J].Status and $F] := 1;
    F.Seek($14, soFromBeginning);
    F.WriteBuffer(iChannelInUse, 16);
  end;
  Progress.Position := 0;
  F.Seek(0, soFromEnd);
end;

function MUS_SaveBank(FileName: String): Boolean;
var
  M: TMemoryStream;
  W, InstCnt: Word;
  I, J: Integer;
  S: String;
  A: AnsiString;
  Name: Array[0..8] of AnsiChar;
  SL: TStringList;
begin
  Result := False;
  InstCnt := 0;
  while SongData_GetStr('SND_Name#'+IntToStr(InstCnt), S)
    and SongData_GetStr('SND_Data#'+IntToStr(InstCnt), S)
  do
    Inc(InstCnt);

  if InstCnt = 0 then
    Exit;

  M := TMemoryStream.Create;
  if not SongData_GetWord('SND_Version', W) then
    W := 1;
  M.WriteBuffer(W, 2);
  M.WriteBuffer(InstCnt, 2);
  W := InstCnt * 9 + 6;
  M.WriteBuffer(W, 2);

  for I := 0 to InstCnt - 1 do
  begin
    FillChar(Name, Length(Name), 0);
    SongData_GetStr('SND_Name#'+IntToStr(I), S);
    A := S;
    Move(A[1], Name[0], Length(A));
    M.WriteBuffer(Name, Length(Name));
  end;

  for I := 0 to InstCnt - 1 do
  begin
    SongData_GetStr('SND_Data#'+IntToStr(I), S);
    SL := TStringList.Create;
    SL.Delimiter := ' ';
    SL.StrictDelimiter := True;
    SL.DelimitedText := S;
    for J := 0 to (13+13+2) - 1 do
    begin
      try
        W := StrToInt(SL[J]);
      except
        W := 0;
      end;
      M.WriteBuffer(W, 2);
    end;
    SL.Free;
  end;

  Result := True;
  try
    M.SaveToFile(FileName);
  except
    Result := False;
  end;
  M.Free;
end;

procedure TMainForm.WriteMUS(var F: TMemoryStream; FileName: String);
var
  I, J: Integer;
  dw, totalTick, nrCommand: DWORD;
  tuneName: Array[0..29] of AnsiChar;
  S, Bank: String;
  A: AnsiString;
  pad: Array[0..7] of Byte;
  MIDIData: TMemoryStream;
begin
  Log.Lines.Add('[*] Writing AdLib MUS file...');

  if not SongData_GetInt('MUS_Version', I) then
    I := 1;
  F.WriteBuffer(I, 2);
  if not SongData_GetDWord('MUS_ID', dw) then
    dw := 0;
  F.WriteBuffer(dw, 4);

  FillChar(tuneName, Length(tuneName), 0);
  SongData_GetStr('MUS_TuneName', S);
  if Length(S) > Length(tuneName) - 1 then
    SetLength(S, Length(tuneName) - 1);
  A := S;
  Move(A[1], tuneName[0], Length(A));
  F.WriteBuffer(tuneName[0], Length(tuneName));

  if not SongData_GetInt('MUS_TicksPerBeat', I) then
  begin
    Log.Lines.Add('[-] Ticks Per Beat is not defined.');
    Exit;
  end;
  F.WriteBuffer(I, 1);

  if not SongData_GetInt('MUS_BeatPerMeasure', I) then
  begin
    Log.Lines.Add('[-] Warning: Beat Per Measure is not defined.');
    I := 2;
  end;
  F.WriteBuffer(I, 1);

  dw := 0;
  F.WriteBuffer(dw, 4); // totalTick
  F.WriteBuffer(dw, 4); // dataSize
  F.WriteBuffer(dw, 4); // nrCommand

  // Padding
  FillChar(pad, 8, 0);
  F.WriteBuffer(pad, 8);

  if not SongData_GetInt('MUS_Percussive', I) then
  begin
    Log.Lines.Add('[-] Percussive is not defined.');
    Exit;
  end;
  F.WriteBuffer(I, 1);

  if not SongData_GetInt('MUS_PitchBendRange', I) then
  begin
    Log.Lines.Add('[-] Pitch Bend Range is not defined.');
    Exit;
  end;
  F.WriteBuffer(I, 1);

  if not SongData_GetInt('MUS_BasicTempo', I) then
  begin
    Log.Lines.Add('[-] Basic Tempo is not defined.');
    Exit;
  end;
  F.WriteBuffer(I, 2);

  // Padding
  F.WriteBuffer(pad, 8);

  // MIDI Track
  MIDIData := TMemoryStream.Create;
  I := TrkCh.ItemIndex;
  WriteTrackData_MUS(MIDIData, TrackData[I]);
  dw := MIDIData.Size;
  F.WriteBuffer(MIDIData.Memory^, dw);
  MIDIData.Free;
  Log.Lines.Add('[+] Wrote ' + IntToStr(dw) + ' bytes.');

  F.Seek($26, soFromBeginning);
  totalTick := 0;
  for J := 0 to Length(TrackData[I].Data) - 1 do
    totalTick := totalTick + TrackData[I].Data[J].Ticks;
  F.WriteBuffer(totalTick, 4);

  F.WriteBuffer(dw, 4); // dataSize

  nrCommand := 0;
  for J := 0 to Length(TrackData[I].Data) - 1 do
  begin
    if TrackData[I].Data[J].Ticks >= 240 then
      nrCommand := nrCommand + TrackData[I].Data[J].Ticks div 240;
    Inc(nrCommand);
  end;
  F.WriteBuffer(nrCommand, 4);

  F.Seek(0, soFromEnd);

  Log.Lines.Add('[*] Saving instrument bank file...');
  Bank := ChangeFileExt(FileName, '.snd');
  if not MUS_SaveBank(Bank) then
    Log.Lines.Add('[-] Failed to save instrument bank file.')
  else
    Log.Lines.Add('[*] Saved instrument bank: ' + Bank);

  Progress.Position := 0;
end;

procedure TMainForm.WriteRaw(var F: TMemoryStream);
var
  I: Integer;
begin
  Log.Lines.Add('[*] Writing raw MIDI data...');
  I := TrkCh.ItemIndex;
  if EventFormat = 'mid' then
    WriteTrackData(F, TrackData[I]);
  Log.Lines.Add('[+] Wrote ' + IntToStr(F.Size) + ' bytes.');
  Progress.Position := 0;
end;

procedure TMainForm.WriteSYX(var F: TMemoryStream);
var
  I: Integer;
begin
  Log.Lines.Add('[*] Writing System Exclusive data...');
  I := TrkCh.ItemIndex;
  WriteTrackData_SYX(F, TrackData[I]);
  Log.Lines.Add('[+] Wrote ' + IntToStr(F.Size) + ' bytes.');
  Progress.Position := 0;
end;

procedure TMainForm.WriteTrackData(var F: TMemoryStream; var Trk: Chunk);
var
  S: PAnsiChar;
  J, K: Integer;
begin
  for J := 0 to Length(Trk.Data) - 1 do begin
    WriteVarVal(F, Trk.Data[J].Ticks);
    if J = 0 then
      Trk.Data[J].RunStatMode := False
    else begin
      if Trk.Data[J].Status <> Trk.Data[J - 1].Status then
        Trk.Data[J].RunStatMode := False;
    end;
    if Trk.Data[J].Status >= $F0 then
      Trk.Data[J].RunStatMode := False;
    if not Trk.Data[J].RunStatMode then
      F.WriteBuffer(Trk.Data[J].Status, 1);
    case Trk.Data[J].Status shr 4 of
      8..11: begin
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
      end;
      12,13:
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
      14: begin
        Trk.Data[J].BParm1 := Trk.Data[J].Value and 127;
        Trk.Data[J].BParm2 := (Trk.Data[J].Value shr 7) and 127;
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
      end;
      15: begin
        case Trk.Data[J].Status and 15 of
          0,7: begin
            WriteVarVal(F, Length(Trk.Data[J].DataArray));
            for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
              F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
          end;
          1,3: F.WriteBuffer(Trk.Data[J].BParm1, 1);
          2: begin
            Trk.Data[J].BParm1 := (Trk.Data[J].Value shr 7) and 127;
            Trk.Data[J].BParm2 := Trk.Data[J].Value and 127;
            F.WriteBuffer(Trk.Data[J].BParm1, 1);
            F.WriteBuffer(Trk.Data[J].BParm2, 1);
          end;
          15: begin
            F.WriteBuffer(Trk.Data[J].BParm1, 1);
            case Trk.Data[J].BParm1 of
              0: begin
                SetLength(Trk.Data[J].DataArray, 2);
                Trk.Data[J].DataArray[0]:=
                (Trk.Data[J].Value shr 8) and $FF;
                Trk.Data[J].DataArray[1]:=
                Trk.Data[J].Value and $FF;
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
              1..7: begin
                WriteVarVal(F, Length(Trk.Data[J].DataString));
                S := PAnsiChar(Trk.Data[J].DataString);
                F.WriteBuffer(S^, Length(Trk.Data[J].DataString));
              end;
              32,33: begin
                WriteVarVal(F, 1);
                F.WriteBuffer(Trk.Data[J].Value, 1);
              end;
              81: begin
                SetLength(Trk.Data[J].DataArray, 3);
                Trk.Data[J].DataArray[0]:=
                (Trk.Data[J].Value shr 16) and $FF;
                Trk.Data[J].DataArray[1]:=
                (Trk.Data[J].Value shr 8) and $FF;
                Trk.Data[J].DataArray[2]:=
                Trk.Data[J].Value and $FF;
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
              else begin
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.WriteTrackData_XMI(var F: TMemoryStream; var Trk: Chunk);
var
  S: PAnsiChar;
  J, K: Integer;
begin
  for J := 0 to Length(Trk.Data) - 1 do begin
    WriteVarVal_XMI(F, Trk.Data[J].Ticks);
    F.WriteBuffer(Trk.Data[J].Status, 1);
    case Trk.Data[J].Status shr 4 of
      8,9: begin
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
        WriteVarVal(F, Trk.Data[J].Len);
      end;
      10,11: begin
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
      end;
      12,13:
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
      14: begin
        Trk.Data[J].BParm1 := Trk.Data[J].Value and 127;
        Trk.Data[J].BParm2 := (Trk.Data[J].Value shr 7) and 127;
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
      end;
      15: begin
        case Trk.Data[J].Status and 15 of
          0,7: begin
            WriteVarVal(F, Length(Trk.Data[J].DataArray));
            for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
              F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
          end;
          1,3: F.WriteBuffer(Trk.Data[J].BParm1, 1);
          2: begin
            Trk.Data[J].BParm1 := (Trk.Data[J].Value shr 7) and 127;
            Trk.Data[J].BParm2 := Trk.Data[J].Value and 127;
            F.WriteBuffer(Trk.Data[J].BParm1, 1);
            F.WriteBuffer(Trk.Data[J].BParm2, 1);
          end;
          15: begin
            F.WriteBuffer(Trk.Data[J].BParm1, 1);
            case Trk.Data[J].BParm1 of
              0: begin
                SetLength(Trk.Data[J].DataArray, 2);
                Trk.Data[J].DataArray[0]:=
                (Trk.Data[J].Value shr 8) and $FF;
                Trk.Data[J].DataArray[1]:=
                Trk.Data[J].Value and $FF;
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
              1..7: begin
                WriteVarVal(F, Length(Trk.Data[J].DataString));
                S := PAnsiChar(Trk.Data[J].DataString);
                F.WriteBuffer(S^, Length(Trk.Data[J].DataString));
              end;
              32,33: begin
                WriteVarVal(F, 1);
                F.WriteBuffer(Trk.Data[J].Value, 1);
              end;
              81: begin
                SetLength(Trk.Data[J].DataArray, 3);
                Trk.Data[J].DataArray[0]:=
                (Trk.Data[J].Value shr 16) and $FF;
                Trk.Data[J].DataArray[1]:=
                (Trk.Data[J].Value shr 8) and $FF;
                Trk.Data[J].DataArray[2]:=
                Trk.Data[J].Value and $FF;
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
              else begin
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.WriteTrackData_MUS(var F: TMemoryStream; var Trk: Chunk);
var
  S: PAnsiChar;
  J, K: Integer;
begin
  for J := 0 to Length(Trk.Data) - 1 do begin
    // modified (MUS format)
    WriteVarVal_MUS(F, Trk.Data[J].Ticks);
    if J = 0 then
      Trk.Data[J].RunStatMode := False
    else begin
      if Trk.Data[J].Status <> Trk.Data[J - 1].Status then
        Trk.Data[J].RunStatMode := False;
    end;
    if Trk.Data[J].Status >= $F0 then
      Trk.Data[J].RunStatMode := False;
    if not Trk.Data[J].RunStatMode then
      F.WriteBuffer(Trk.Data[J].Status, 1);
    case Trk.Data[J].Status shr 4 of
      // modified (MUS format)
      8,9,11: begin
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
      end;
      // modified (MUS format)
      10,12,13:
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
      14: begin
        Trk.Data[J].BParm1 := Trk.Data[J].Value and 127;
        Trk.Data[J].BParm2 := (Trk.Data[J].Value shr 7) and 127;
        F.WriteBuffer(Trk.Data[J].BParm1, 1);
        F.WriteBuffer(Trk.Data[J].BParm2, 1);
      end;
      15: begin
        case Trk.Data[J].Status and 15 of
          // modified (MUS format)
          0: begin
            if ((Length(Trk.Data[J].DataArray) > 0)
            and (Trk.Data[J].DataArray[Length(Trk.Data[J].DataArray) - 1] <> $F7))
            or (Length(Trk.Data[J].DataArray) = 0)
            then begin
              SetLength(Trk.Data[J].DataArray, Length(Trk.Data[J].DataArray) + 1);
              Trk.Data[J].DataArray[Length(Trk.Data[J].DataArray) - 1] := $F7;
              Trk.Data[J].Len := Length(Trk.Data[J].DataArray);
            end;
            for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
              F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
          end;
          // modified (MUS format)
          7: ;
          1,3: F.WriteBuffer(Trk.Data[J].BParm1, 1);
          2: begin
            Trk.Data[J].BParm1 := (Trk.Data[J].Value shr 7) and 127;
            Trk.Data[J].BParm2 := Trk.Data[J].Value and 127;
            F.WriteBuffer(Trk.Data[J].BParm1, 1);
            F.WriteBuffer(Trk.Data[J].BParm2, 1);
          end;
          15: begin
            F.WriteBuffer(Trk.Data[J].BParm1, 1);
            case Trk.Data[J].BParm1 of
              0: begin
                SetLength(Trk.Data[J].DataArray, 2);
                Trk.Data[J].DataArray[0]:=
                (Trk.Data[J].Value shr 8) and $FF;
                Trk.Data[J].DataArray[1]:=
                Trk.Data[J].Value and $FF;
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
              1..7: begin
                WriteVarVal(F, Length(Trk.Data[J].DataString));
                S := PAnsiChar(Trk.Data[J].DataString);
                F.WriteBuffer(S^, Length(Trk.Data[J].DataString));
              end;
              32,33: begin
                WriteVarVal(F, 1);
                F.WriteBuffer(Trk.Data[J].Value, 1);
              end;
              81: begin
                SetLength(Trk.Data[J].DataArray, 3);
                Trk.Data[J].DataArray[0]:=
                (Trk.Data[J].Value shr 16) and $FF;
                Trk.Data[J].DataArray[1]:=
                (Trk.Data[J].Value shr 8) and $FF;
                Trk.Data[J].DataArray[2]:=
                Trk.Data[J].Value and $FF;
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
              else begin
                WriteVarVal(F, Length(Trk.Data[J].DataArray));
                for K := 0 to Length(Trk.Data[J].DataArray) - 1 do
                  F.WriteBuffer(Trk.Data[J].DataArray[K], 1);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.WriteTrackData_SYX(var F: TMemoryStream; var Trk: Chunk);
var
  I: Integer;
  B: Byte;
begin
  for I := 0 to Length(Trk.Data) - 1 do
    if Trk.Data[I].Status = $F0 then begin
      B := $F0;
      F.WriteBuffer(B, 1);
      F.WriteBuffer(Trk.Data[I].DataArray[0], Trk.Data[I].Len);
      if (Trk.Data[I].Len > 0)
      and (Trk.Data[I].DataArray[Trk.Data[I].Len - 1] = $F7) then begin

      end else begin
        B := $F7;
        F.WriteBuffer(B, 1);
      end;
    end;
end;

procedure TMainForm.Convert_XMI_MID;
type
  NoteDur = packed record
    Chn: Byte;
    Note: Byte;
    Ticks: UInt64;
  end;
  PNoteDur = ^NoteDur;
var
  InitTempo, Tempo: Cardinal;
  I,J,K: Integer;
  Durations: TList;
  PDur: PNoteDur;
  MinDur: UInt64;
  MinDurFirst: Boolean;
begin
  Log.Lines.Add('[*] Converting Extended MIDI to Standard MIDI...');
  Application.ProcessMessages;
  if not SongData_GetDWord('InitTempo', InitTempo) then
    InitTempo := 500000;
  Tempo := InitTempo;
  for I := 0 to Length(TrackData)-1 do
  begin
    // Step 1: Convert note events to Note On/Off
    J := 0;
    Durations := TList.Create;
    while J < Length(TrackData[I].Data) do
    begin
      while TrackData[I].Data[J].Ticks > 0 do
      begin
        // Find notes with minimum duration
        // which can be turned off now
        MinDur := High(UInt64);
        for K := 0 to Durations.Count - 1 do
        begin
          PDur := Durations[K];
          if (PDur^.Ticks <= TrackData[I].Data[J].Ticks)
          and (PDur^.Ticks < MinDur) then
            MinDur := PDur^.Ticks;
        end;
        if MinDur < High(UInt64) then
        begin
          // Found notes which needs to off
          K := 0;
          MinDurFirst := True;
          while K < Durations.Count do
          begin
            PDur := Durations[K];
            if PDur^.Ticks = MinDur then
            begin
              // Adding NoteOff event
              NewEvent(I, J, $80, 0);
              TrackData[I].Data[J].Status := $80 or (PDur^.Chn and $F);
              TrackData[I].Data[J].BParm1 := PDur^.Note;
              if MinDurFirst then
                TrackData[I].Data[J].Ticks := PDur^.Ticks
              else
                TrackData[I].Data[J].Ticks := 0;
              Inc(J);
              MinDurFirst := False;
              Dispose(PDur);
              Durations.Delete(K);
              Continue;
            end;
            // Decreasing duration
            PDur^.Ticks := PDur^.Ticks - MinDur;
            Inc(K);
          end;
          TrackData[I].Data[J].Ticks := TrackData[I].Data[J].Ticks - MinDur;
        end
        else
        begin
          for K := 0 to Durations.Count - 1 do
          begin
            // Decrease all durations by ticks
            PDur := Durations[K];
            PDur^.Ticks := PDur^.Ticks - TrackData[I].Data[J].Ticks;
          end;
          Break;
        end;
      end;

      case TrackData[I].Data[J].Status shr 4 of
        8: begin // Note Off - unused
          DelEvent(I, J, True);
          Continue;
        end;
        9: begin // XMI Note
          // Read note duration
          if TrackData[I].Data[J].Len = 0 then
          begin
            // Adding NoteOff event
            NewEvent(I, J+1, $80, 0);
            TrackData[I].Data[J+1].Status := $80 or (TrackData[I].Data[J].Status and $F);
            TrackData[I].Data[J+1].BParm1 := TrackData[I].Data[J].BParm1;
            Inc(J);
          end
          else
          begin
            PDur := New(PNoteDur);
            PDur^.Chn := TrackData[I].Data[J].Status and $F;
            PDur^.Note := TrackData[I].Data[J].BParm1;
            PDur^.Ticks := TrackData[I].Data[J].Len;
            Durations.Add(PDur);
            TrackData[I].Data[J].Len := 0;
          end;
        end;
      end;
      if (Durations.Count > 0)
      and (J = High(TrackData[I].Data))
      and (TrackData[I].Data[J].Status = $FF)
      and (TrackData[I].Data[J].BParm1 = $2F) then
      begin
        TrackData[I].Data[J].Ticks := 0;
        for K := 0 to Durations.Count - 1 do
        begin
          PDur := Durations[K];
          if TrackData[I].Data[J].Ticks < PDur^.Ticks then
            TrackData[I].Data[J].Ticks := PDur^.Ticks;
        end;
        Continue;
      end;
      Inc(J);
    end;
    if Durations.Count > 0 then
      Log.Lines.Add('[*] Warning: There are '+IntToStr(Durations.Count)+' active notes at track end.');
    for J := 0 to Durations.Count - 1 do
    begin
      PDur := Durations[J];
      Dispose(PDur);
    end;
    Durations.Free;
    // Step 2: Shape the delay ticks using Tempo events as a reference
    for J := 0 to Length(TrackData[I].Data) - 1 do
    begin
      if TrackData[I].Data[J].Ticks > 0 then
        TrackData[I].Data[J].Ticks :=
        Round(TrackData[I].Data[J].Ticks * InitTempo / Tempo);
      if (TrackData[I].Data[J].Status = $FF)
      and (TrackData[I].Data[J].BParm1 = 81) then
        Tempo := TrackData[I].Data[J].Value;
    end;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MID_XMI;
type
  TNote = record
    Chan, Note: Byte;
    Index: Integer;
    Duration: UInt64;
  end;
  PNote = ^TNote;
const
  PPQN = 60;
var
  Ver, Division: Word;
  InitTempo, Tempo: Cardinal;
  I,J,K: Integer;
  Notes: TList;
  NoteDur: PNote;
begin
  Log.Lines.Add('[*] Converting Standard MIDI to Extended MIDI...');
  Application.ProcessMessages;
  if not SongData_GetDWord('InitTempo', InitTempo) then
    InitTempo := 500000;
  Tempo := InitTempo;
  SongData_GetWord('MIDIType', Ver);
  SongData_GetWord('Division', Division);
  if Ver = 1 then
  begin
    Log.Lines.Add('[*] Warning: MIDI Type-1 is not supported by XMIDI.');
    MergeTracksByTicks;
  end;
  for I := 0 to Length(TrackData)-1 do
  begin
    // Step 1: Flatten frequency at 120 Hz (Tempo 500000 @ 60 PPQN)
    for J := 0 to Length(TrackData[I].Data) - 1 do
    begin
      if TrackData[I].Data[J].Ticks > 0 then
        TrackData[I].Data[J].Ticks :=
        Round(TrackData[I].Data[J].Ticks * PPQN * Tempo / (Division * InitTempo));
      if (TrackData[I].Data[J].Status = $FF)
      and (TrackData[I].Data[J].BParm1 = 81) then
        Tempo := TrackData[I].Data[J].Value;
    end;
    // Step 2: Convert note on/off to durations
    Notes := TList.Create;
    J := 0;
    while J < Length(TrackData[I].Data) do
    begin
      if TrackData[I].Data[J].Ticks > 0 then
        for K := 0 to Notes.Count - 1 do
        begin
          NoteDur := Notes[K];
          NoteDur.Duration := NoteDur.Duration + TrackData[I].Data[J].Ticks;
        end;
      case TrackData[I].Data[J].Status shr 4 of
        8: begin // Note Off
          K := 0;
          while K < Notes.Count do
          begin
            NoteDur := Notes[K];
            if (TrackData[I].Data[J].Status and $F = NoteDur.Chan)
            and (TrackData[I].Data[J].BParm1 = NoteDur.Note) then
            begin
              TrackData[I].Data[NoteDur.Index].Len := NoteDur.Duration;
              Dispose(NoteDur);
              Notes.Delete(K);
              Continue;
            end;
            Inc(K);
          end;
        end;
        9: begin // Note On
          if TrackData[I].Data[J].BParm2 = 0 then
          begin // Velocity = 0 - this is Note Off
            K := 0;
            while K < Notes.Count do
            begin
              NoteDur := Notes[K];
              if (TrackData[I].Data[J].Status and $F = NoteDur.Chan)
              and (TrackData[I].Data[J].BParm1 = NoteDur.Note) then
              begin
                TrackData[I].Data[NoteDur.Index].Len := NoteDur.Duration;
                Dispose(NoteDur);
                Notes.Delete(K);
                Continue;
              end;
              Inc(K);
            end;
          end
          else
          begin
            New(NoteDur);
            NoteDur.Chan := TrackData[I].Data[J].Status and $F;
            NoteDur.Note := TrackData[I].Data[J].BParm1;
            NoteDur.Index := J;
            NoteDur.Duration := 0;
            Notes.Add(NoteDur);
          end;
        end;
      end;
      Inc(J);
    end;
    // Step 3: Remove note off events
    J := 0;
    while J < Length(TrackData[I].Data) do
    begin
      if TrackData[I].Data[J].Status shr 4 = 8 then
      begin
        DelEvent(I, J, True);
        // Update indexes
        for K := 0 to Notes.Count - 1 do
        begin
          NoteDur := Notes[K];
          if NoteDur.Index > J then
            Dec(NoteDur.Index);
        end;
        Continue;
      end;
      Inc(J);
    end;
    // Step 4: Turn off remaining notes
    for J := 0 to Notes.Count - 1 do
    begin
      NoteDur := Notes[J];
      TrackData[I].Data[NoteDur.Index].Len := NoteDur.Duration;
      Dispose(NoteDur);
    end;
    Notes.Free;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_PutInt('MIDIType', 2);
  SongData_PutInt('Division', PPQN);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MUS_MID;
var
  InitTempo: Cardinal;
  I, J: Integer;
  B: Byte;
  Division: Word;
  Rhythm: Boolean;
  SName: String;
begin
  Log.Lines.Add('[*] Converting AdLib MUS to Standard MIDI...');
  Application.ProcessMessages;
  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;
  if SongData_GetInt('MUS_Percussive', I) then
    Rhythm := I > 0
  else
    Rhythm := False;
  for I := 0 to Length(TrackData) - 1 do
  begin
    J := 0;
    while J < Length(TrackData[I].Data) do
    begin
      // Filter events on unused channels
      if TrackData[I].Data[J].Status shr 4 < 15 then // Not System event
        if (     Rhythm  and (TrackData[I].Data[J].Status and $F > 10))
        or ((not Rhythm) and (TrackData[I].Data[J].Status and $F > 8 ))
        then begin
          DelEvent(I, J, True);
          Continue;
        end;
      // Process events
      case TrackData[I].Data[J].Status shr 4 of
        8: // Note Off
        begin
          if Rhythm then
          begin
            // convert drums
            case TrackData[I].Data[J].Status and 15 of
              6: // ch06 - Bass Drum
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 36 then
                  B := 35
                else
                  B := 36;
                TrackData[I].Data[J].BParm1 := B;
              end;
              7: // ch07 - Snare Drum
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 40 then
                  B := 38
                else
                  B := 40;
                TrackData[I].Data[J].BParm1 := B;
              end;
              8: // ch08 - Tom
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                B := 45;
                if TrackData[I].Data[J].BParm1 < 39 then
                  B := 41;
                if TrackData[I].Data[J].BParm1 = 39 then
                  B := 43;
                if TrackData[I].Data[J].BParm1 = 40 then
                  B := 45;
                if TrackData[I].Data[J].BParm1 = 41 then
                  B := 47;
                if TrackData[I].Data[J].BParm1 = 42 then
                  B := 48;
                if TrackData[I].Data[J].BParm1 > 42 then
                  B := 50;
                TrackData[I].Data[J].BParm1 := B;
              end;
              9: // ch09 - Cymbal
              begin
                B := 57;
                if TrackData[I].Data[J].BParm1 <= 50 then
                  B := 49;
                if (TrackData[I].Data[J].BParm1 > 50) and
                (TrackData[I].Data[J].BParm1 <= 65) then
                  B := 57;
                if TrackData[I].Data[J].BParm1 > 65 then
                  B := 55;
                TrackData[I].Data[J].BParm1 := B;
              end;
              10: // ch10 - Hi-Hat
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 44 then
                  B := 42
                else
                  B := 44;
                TrackData[I].Data[J].BParm1 := B;
              end;
            end;
          end;
        end;
        9: // Note On
        begin
          if Rhythm then
          begin
            // convert drums
            case TrackData[I].Data[J].Status and 15 of
              6:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 36 then
                  B := 35
                else
                  B := 36;
                TrackData[I].Data[J].BParm1 := B;
              end;
              7:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 40 then
                  B := 38
                else
                  B := 40;
                TrackData[I].Data[J].BParm1 := B;
              end;
              8:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 < 39 then
                  B := 41;
                if TrackData[I].Data[J].BParm1 = 39 then
                  B := 43;
                if TrackData[I].Data[J].BParm1 = 40 then
                  B := 45;
                if TrackData[I].Data[J].BParm1 = 41 then
                  B := 47;
                if TrackData[I].Data[J].BParm1 = 42 then
                  B := 48;
                if TrackData[I].Data[J].BParm1 > 42 then
                  B := 50;
                TrackData[I].Data[J].BParm1 := B;
              end;
              9:
              begin
                if TrackData[I].Data[J].BParm1 <= 50 then
                  B := 49;
                if (TrackData[I].Data[J].BParm1 > 50) and
                (TrackData[I].Data[J].BParm1 <= 65) then
                  B := 57;
                if TrackData[I].Data[J].BParm1 > 65 then
                  B := 55;
                TrackData[I].Data[J].BParm1 := B;
              end;
              10:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 44 then
                  B := 42
                else
                  B := 44;
                TrackData[I].Data[J].BParm1 := B;
              end;
            end;
          end;
        end;
        10: // Poly Aftertouch -> Volume Change
        begin
          TrackData[I].Data[J].Status := $B0 or TrackData[I].Data[J].Status and $F;
          TrackData[I].Data[J].BParm2 := TrackData[I].Data[J].BParm1;
          TrackData[I].Data[J].BParm1 := 7;
        end;
        12: // Program Change
        begin
          if Rhythm and (TrackData[I].Data[J].Status and $F > 5) then
          begin // Unused on rhythm channels
            DelEvent(I, J, True);
            Continue;
          end;
          if SongData_GetStr('SND_Name#'+IntToStr(TrackData[I].Data[J].BParm1), SName) then
          begin // Insert instrument name
            NewEvent(I, J, $FF, $04);
            TrackData[I].Data[J].DataString := SName;
            Inc(J);
          end;
        end;
        15: // System Event
        begin
          case TrackData[I].Data[J].Status and $F of
            0: // SysEx
            begin
              if (TrackData[I].Data[J].Len = 5)
              and (TrackData[I].Data[J].DataArray[0] = $7F)
              then begin
                // Tempo
                TrackData[I].Data[J].Status := $FF;
                TrackData[I].Data[J].BParm1 := 81;

                if ((TrackData[I].Data[J].DataArray[3] / 128) +
                TrackData[I].Data[J].DataArray[2]) <> 0 then
                  TrackData[I].Data[J].Value :=
                  Round(InitTempo / ((TrackData[I].Data[J].DataArray[3] / 128) + TrackData[I].Data[J].DataArray[2]))
                else
                  TrackData[I].Data[J].Value := InitTempo;

                TrackData[I].Data[J].DataArray[0] := (TrackData[I].Data[J].Value shr 16) and $FF;
                TrackData[I].Data[J].DataArray[1] := (TrackData[I].Data[J].Value shr 8) and $FF;
                TrackData[I].Data[J].DataArray[2] := (TrackData[I].Data[J].Value) and $FF;

                SetLength(TrackData[I].Data[J].DataArray, 3);
                TrackData[I].Data[J].Len := 3;
              end;
            end;
            $C: // End Of Track
            begin
              TrackData[I].Data[J].Status := $FF;
              TrackData[I].Data[J].BParm1 := $2F;
            end;
          end;
        end;
      end;
      Inc(J);
    end;
    SongData_GetByte('MUS_PitchBendRange', B);
    if B > 1 then
    begin
      for J := 0 to 5 do
      begin
        NewEvent(I, J*5 + 0, $B0, $64);
        TrackData[I].Data[J*5 + 0].Status := $B0 or J;
        TrackData[I].Data[J*5 + 0].BParm2 := 0;
        NewEvent(I, J*5 + 1, $B0, $65);
        TrackData[I].Data[J*5 + 1].Status := $B0 or J;
        TrackData[I].Data[J*5 + 1].BParm2 := 0;
        NewEvent(I, J*5 + 2, $B0, 6);
        TrackData[I].Data[J*5 + 2].Status := $B0 or J;
        TrackData[I].Data[J*5 + 2].BParm2 := B;
        NewEvent(I, J*5 + 3, $B0, $64);
        TrackData[I].Data[J*5 + 3].Status := $B0 or J;
        TrackData[I].Data[J*5 + 3].BParm2 := $7F;
        NewEvent(I, J*5 + 4, $B0, $65);
        TrackData[I].Data[J*5 + 4].Status := $B0 or J;
        TrackData[I].Data[J*5 + 4].BParm2 := $7F;
      end;
      if not Rhythm then
        for J := 6 to 8 do
        begin
          NewEvent(I, J*5 + 0, $B0, $64);
          TrackData[I].Data[J*5 + 0].Status := $B0 or J;
          TrackData[I].Data[J*5 + 0].BParm2 := 0;
          NewEvent(I, J*5 + 1, $B0, $65);
          TrackData[I].Data[J*5 + 1].Status := $B0 or J;
          TrackData[I].Data[J*5 + 1].BParm2 := 0;
          NewEvent(I, J*5 + 2, $B0, 6);
          TrackData[I].Data[J*5 + 2].Status := $B0 or J;
          TrackData[I].Data[J*5 + 2].BParm2 := B;
          NewEvent(I, J*5 + 3, $B0, $64);
          TrackData[I].Data[J*5 + 3].Status := $B0 or J;
          TrackData[I].Data[J*5 + 3].BParm2 := $7F;
          NewEvent(I, J*5 + 4, $B0, $65);
          TrackData[I].Data[J*5 + 4].Status := $B0 or J;
          TrackData[I].Data[J*5 + 4].BParm2 := $7F;
        end;
    end;
    if (I = 0) and SongData_GetStr('MUS_TuneName', SName) then
      if SName <> '' then
      begin // Insert tune name
        NewEvent(I, 0, $FF, $03);
        TrackData[I].Data[0].DataString := SName;
      end;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_GetWord('Division', Division);
  SongData.Strings.Clear;

  SongData_PutInt('MIDIType', 0);
  SongData_PutDWord('InitTempo', 500000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', Division);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MUS_MDI;
var
  InitTempo: Cardinal;
  I, J, K: Integer;
  W: Word;
  SName, SData: String;
  SL: TStringList;
  Division: Word;
begin
  Log.Lines.Add('[*] Converting AdLib MUS to AdLib MDI...');
  Application.ProcessMessages;
  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;
  for I := 0 to Length(TrackData) - 1 do begin
    J := 0;
    while J < Length(TrackData[I].Data) do begin
      // Process events
      case TrackData[I].Data[J].Status shr 4 of
        10: // Volume Change A# xx -> D# xx
        begin
          TrackData[I].Data[J].Status := $D0 or TrackData[I].Data[J].Status and $F;
        end;
        12: // Program Change
        begin
          SName := '';
          if SongData_GetStr('SND_Data#'+IntToStr(TrackData[I].Data[J].BParm1), SData) then
          begin
            SongData_GetStr('SND_Name#'+IntToStr(TrackData[I].Data[J].BParm1), SName);
            SetLength(TrackData[I].Data[J].DataArray, 6 + 28);
            TrackData[I].Data[J].DataArray[0] := $00; // Ad Lib ID
            TrackData[I].Data[J].DataArray[1] := $00;
            TrackData[I].Data[J].DataArray[2] := $3F;
            TrackData[I].Data[J].DataArray[3] := $00; // Opcode = Load patch
            TrackData[I].Data[J].DataArray[4] := $01;
            TrackData[I].Data[J].DataArray[5] :=      // Channel
              TrackData[I].Data[J].Status and $F;
            SL := TStringList.Create;
            SL.Delimiter := ' ';
            SL.StrictDelimiter := True;
            SL.DelimitedText := SData;
            for K := 0 to (13+13+2) - 1 do
            begin
              try
                W := StrToInt(SL[K]);
              except
                W := 0;
              end;
              W := W and $FF;
              TrackData[I].Data[J].DataArray[6+K] := W;
            end;
            SL.Free;
            TrackData[I].Data[J].Status := $FF; // Meta Event
            TrackData[I].Data[J].BParm1 := $7F; // Sequencer-Specific
            TrackData[I].Data[J].Len := Length(TrackData[I].Data[J].DataArray);
            NewEvent(I, J, $FF, $04); // Insert instrument name
            TrackData[I].Data[J].DataString := SName;
            Inc(J);
          end else begin
            // Instrument not found
            DelEvent(I, J, True);
            Continue;
          end;
        end;
        15: // System Event
        begin
          case TrackData[I].Data[J].Status and $F of
            0: // SysEx
            begin
              if (TrackData[I].Data[J].Len = 5)
              and (TrackData[I].Data[J].DataArray[0] = $7F)
              then begin
                // Tempo
                TrackData[I].Data[J].Status := $FF;
                TrackData[I].Data[J].BParm1 := 81;

                if ((TrackData[I].Data[J].DataArray[3] / 128) +
                TrackData[I].Data[J].DataArray[2]) <> 0 then
                  TrackData[I].Data[J].Value :=
                  Round(InitTempo / ((TrackData[I].Data[J].DataArray[3] / 128) + TrackData[I].Data[J].DataArray[2]))
                else
                  TrackData[I].Data[J].Value := InitTempo;

                TrackData[I].Data[J].DataArray[0] := (TrackData[I].Data[J].Value shr 16) and $FF;
                TrackData[I].Data[J].DataArray[1] := (TrackData[I].Data[J].Value shr 8) and $FF;
                TrackData[I].Data[J].DataArray[2] := (TrackData[I].Data[J].Value) and $FF;

                SetLength(TrackData[I].Data[J].DataArray, 3);
                TrackData[I].Data[J].Len := 3;
              end;
            end;
            $C: // End Of Track
            begin
              TrackData[I].Data[J].Status := $FF;
              TrackData[I].Data[J].BParm1 := $2F;
            end;
          end;
        end;
      end;
      Inc(J);
    end;

    NewEvent(I, 0, $FF, $7F);
    SetLength(TrackData[I].Data[0].DataArray, 6);
    TrackData[I].Data[0].Len := Length(TrackData[I].Data[0].DataArray);
    TrackData[I].Data[0].DataArray[0] := $00; // Ad Lib ID
    TrackData[I].Data[0].DataArray[1] := $00;
    TrackData[I].Data[0].DataArray[2] := $3F;
    TrackData[I].Data[0].DataArray[3] := $00; // Opcode = Pitch Bend range
    TrackData[I].Data[0].DataArray[4] := $03;
    if not SongData_GetInt('MUS_PitchBendRange', J) then
      J := 1;
    if J < 1 then
      J := 1;
    if J > 12 then
      J := 12;
    TrackData[I].Data[0].DataArray[5] := J;   // Value

    NewEvent(I, 0, $FF, $7F);
    SetLength(TrackData[I].Data[0].DataArray, 6);
    TrackData[I].Data[0].Len := Length(TrackData[I].Data[0].DataArray);
    TrackData[I].Data[0].DataArray[0] := $00; // Ad Lib ID
    TrackData[I].Data[0].DataArray[1] := $00;
    TrackData[I].Data[0].DataArray[2] := $3F;
    TrackData[I].Data[0].DataArray[3] := $00; // Opcode = Card mode
    TrackData[I].Data[0].DataArray[4] := $02;
    SongData_GetInt('MUS_Percussive', J);
    if J <> 0 then
      J := 1;
    TrackData[I].Data[0].DataArray[5] := J;   // Value

    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_GetWord('Division', Division);
  SongData.Strings.Clear;

  SongData_PutInt('MIDIType', 0);
  SongData_PutDWord('InitTempo', 500000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', Division);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MDI_MID;
type
  TInst = Array[0..13+13+2-1] of Byte;
  PInst = ^TInst;
var
  Notes: Array[0..15] of Array of Byte;
  NotesReset: Array[0..15] of Boolean;
  Insts: TList;
  P: PInst;
  I,J,K,Idx: Integer;
  Val: Byte;
  Rhythm: Boolean;

  procedure ClearNotes;
  var
    I: Integer;
  begin
    for I := 0 to 15 do
    begin
      SetLength(Notes[I], 0);
      NotesReset[I] := False;
    end;
  end;
  function IsNoteOnChannel(Chn, Note: Byte): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to Length(Notes[Chn]) - 1 do
      if Notes[Chn][I] = Note then
      begin
        Result := True;
        Break;
      end;
  end;
  procedure SetNoteOff(Chn, Note: Byte);
  var
    I, Idx: Integer;
  begin
    Idx := -1;
    for I := 0 to Length(Notes[Chn]) - 1 do
      if Notes[Chn][I] = Note then
      begin
        Idx := I;
        Break;
      end;
    if Idx = -1 then
      Exit;
    for I := Idx+1 to Length(Notes[Chn]) - 1 do
      Notes[Chn][I-1] := Notes[Chn][I];
    SetLength(Notes[Chn], Length(Notes[Chn]) - 1);
  end;
begin
  Rhythm := False;
  Log.Lines.Add('[*] Converting AdLib MDI to Standard MIDI...');
  Application.ProcessMessages;
  Insts := TList.Create;
  for I := 0 to Length(TrackData) - 1 do
  begin
    ClearNotes;
    J := 0;
    while J < Length(TrackData[I].Data) do
    begin
      case TrackData[I].Data[J].Status shr 4 of
        8: // Note Off
        begin
          if TrackData[I].Data[J].BParm1 = 0 then
          begin
            // Global Note Off
            if Length(Notes[TrackData[I].Data[J].Status and $F]) = 0 then
            begin
              if not NotesReset[TrackData[I].Data[J].Status and $F] then
              begin
                // No notes on channel -> Convert to All Notes Off
                NotesReset[TrackData[I].Data[J].Status and $F] := True;
                TrackData[I].Data[J].Status := $B0 or (TrackData[I].Data[J].Status and $F);
                TrackData[I].Data[J].BParm1 := $7B;
                TrackData[I].Data[J].BParm2 := 0;
                Inc(J);
                Continue;
              end
              else
              begin
                // Notes already reset
                DelEvent(I, J, True);
                Continue;
              end;
            end
            else
            begin
              K := TrackData[I].Data[J].Status and $F;
              TrackData[I].Data[J].BParm1 := Notes[K][0];
              TrackData[I].Data[J].BParm2 := 0;
              SetNoteOff(K, Notes[K][0]);
              for K := 1 to Length(Notes[TrackData[I].Data[J].Status and $F]) - 1 do
              begin
                NewEvent(I, J+K, TrackData[I].Data[J].Status, 0);
                TrackData[I].Data[J+K].Status := TrackData[I].Data[J].Status;
                TrackData[I].Data[J+K].BParm1 := Notes[TrackData[I].Data[J].Status and $F][K];
              end;
            end;
          end
          else // Normal Note Off
            SetNoteOff(TrackData[I].Data[J].Status and $F, TrackData[I].Data[J].BParm1);

          if Rhythm then
          begin
            // convert drums
            case TrackData[I].Data[J].Status and 15 of
              6: // ch06 - Bass Drum
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 36 then
                  Val := 35
                else
                  Val := 36;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              7: // ch07 - Snare Drum
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 40 then
                  Val := 38
                else
                  Val := 40;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              8: // ch08 - Tom
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                Val := 45;
                if TrackData[I].Data[J].BParm1 < 39 then
                  Val := 41;
                if TrackData[I].Data[J].BParm1 = 39 then
                  Val := 43;
                if TrackData[I].Data[J].BParm1 = 40 then
                  Val := 45;
                if TrackData[I].Data[J].BParm1 = 41 then
                  Val := 47;
                if TrackData[I].Data[J].BParm1 = 42 then
                  Val := 48;
                if TrackData[I].Data[J].BParm1 > 42 then
                  Val := 50;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              9: // ch09 - Cymbal
              begin
                Val := 57;
                if TrackData[I].Data[J].BParm1 <= 50 then
                  Val := 49;
                if (TrackData[I].Data[J].BParm1 > 50) and
                (TrackData[I].Data[J].BParm1 <= 65) then
                  Val := 57;
                if TrackData[I].Data[J].BParm1 > 65 then
                  Val := 55;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              10: // ch10 - Hi-Hat
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 44 then
                  Val := 42
                else
                  Val := 44;
                TrackData[I].Data[J].BParm1 := Val;
              end;
            end;
          end;
          Inc(J);
        end;
        9: // Note On
        begin
          if TrackData[I].Data[J].BParm2 = 0 then
          begin
            // Treat as Note Off
            SetNoteOff(TrackData[I].Data[J].Status and $F, TrackData[I].Data[J].BParm1);
          end
          else
            if not IsNoteOnChannel(TrackData[I].Data[J].Status and $F, TrackData[I].Data[J].BParm1) then
            begin
              K := TrackData[I].Data[J].Status and $F;
              SetLength(Notes[K], Length(Notes[K]) + 1);
              Notes[K][High(Notes[K])] := TrackData[I].Data[J].BParm1;
            end;

          if Rhythm then
          begin
            // convert drums
            case TrackData[I].Data[J].Status and 15 of
              6:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 36 then
                  Val := 35
                else
                  Val := 36;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              7:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 40 then
                  Val := 38
                else
                  Val := 40;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              8:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                Val := 45;
                if TrackData[I].Data[J].BParm1 < 39 then
                  Val := 41;
                if TrackData[I].Data[J].BParm1 = 39 then
                  Val := 43;
                if TrackData[I].Data[J].BParm1 = 40 then
                  Val := 45;
                if TrackData[I].Data[J].BParm1 = 41 then
                  Val := 47;
                if TrackData[I].Data[J].BParm1 = 42 then
                  Val := 48;
                if TrackData[I].Data[J].BParm1 > 42 then
                  Val := 50;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              9:
              begin
                Val := 57;
                if TrackData[I].Data[J].BParm1 <= 50 then
                  Val := 49;
                if (TrackData[I].Data[J].BParm1 > 50) and
                (TrackData[I].Data[J].BParm1 <= 65) then
                  Val := 57;
                if TrackData[I].Data[J].BParm1 > 65 then
                  Val := 55;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              10:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 44 then
                  Val := 42
                else
                  Val := 44;
                TrackData[I].Data[J].BParm1 := Val;
              end;
            end;
          end;
          Inc(J);
        end;
        10..12,14: Inc(J);
        13: // Channel Aftertouch -> Volume Change
        begin
          TrackData[I].Data[J].Status := $B0 or TrackData[I].Data[J].Status and $F;
          TrackData[I].Data[J].BParm2 := TrackData[I].Data[J].BParm1;
          TrackData[I].Data[J].BParm1 := 7;
          Inc(J);
        end;
        15: // System
        begin
          if (TrackData[I].Data[J].Status and 15 = 0)
          or ((TrackData[I].Data[J].Status and 15 = 15)
          and (TrackData[I].Data[J].BParm1 = $7F))
          and (Length(TrackData[I].Data[J].DataArray) >= 6)
          and (TrackData[I].Data[J].DataArray[0] = 0)
          and (TrackData[I].Data[J].DataArray[1] = 0)
          and (TrackData[I].Data[J].DataArray[2] = $3F)
          and (TrackData[I].Data[J].DataArray[3] = 0)
          then begin
            case TrackData[I].Data[J].DataArray[4] of
              1: // Load Patch
              begin
                if TrackData[I].Data[J].DataArray[5] < 16 then begin
                  if Rhythm
                  and (TrackData[I].Data[J].DataArray[5] >= 6)
                  and (TrackData[I].Data[J].DataArray[5] <= 10) then
                    DelEvent(I, J, True)
                  else begin
                    if Length(TrackData[I].Data[J].DataArray) < 34 then
                    begin
                      DelEvent(I, J, True);
                      Continue;
                    end;
                    Idx := -1;
                    for K := 0 to Insts.Count - 1 do
                    begin
                      P := Insts[K];
                      if CompareMem(@TrackData[I].Data[J].DataArray[6],
                      @P^[0], 13+13+2) then
                        Idx := K;
                    end;
                    TrackData[I].Data[J].Status :=
                    $C0 or (TrackData[I].Data[J].DataArray[5] and $F);
                    if Idx > -1 then
                      TrackData[I].Data[J].BParm1 := Idx mod 128
                    else begin
                      New(P);
                      CopyMemory(@P^[0],
                      @TrackData[I].Data[J].DataArray[6], 13+13+2);
                      TrackData[I].Data[J].BParm1 := Insts.Count mod 128;
                      Insts.Add(P);
                    end;
                    TrackData[I].Data[J].BParm2 := 0;
                    TrackData[I].Data[J].Len := 0;
                    SetLength(TrackData[I].Data[J].DataArray, 0);
                    Inc(J);
                  end;
                end else
                  Inc(J);
              end;
              2: // Rhythm Mode
              begin
                Rhythm := TrackData[I].Data[J].DataArray[5] > 0;
                DelEvent(I, J, True);
              end;
              3: // Pitch Bend Range
              begin
                Idx := TrackData[I].Data[J].DataArray[5];
                if Idx > 1 then
                begin
                  for K := 0 to 5 do
                  begin
                    NewEvent(I, J + (K*5) + 1, $B0, $64);
                    TrackData[I].Data[J + (K*5) + 1].Status := $B0 or K;
                    TrackData[I].Data[J + (K*5) + 1].BParm2 := 0;
                    NewEvent(I, J + (K*5) + 2, $B0, $65);
                    TrackData[I].Data[J + (K*5) + 2].Status := $B0 or K;
                    TrackData[I].Data[J + (K*5) + 2].BParm2 := 0;
                    NewEvent(I, J + (K*5) + 3, $B0, 6);
                    TrackData[I].Data[J + (K*5) + 3].Status := $B0 or K;
                    TrackData[I].Data[J + (K*5) + 3].BParm2 := Idx;
                    NewEvent(I, J + (K*5) + 4, $B0, $64);
                    TrackData[I].Data[J + (K*5) + 4].Status := $B0 or K;
                    TrackData[I].Data[J + (K*5) + 4].BParm2 := $7F;
                    NewEvent(I, J + (K*5) + 5, $B0, $65);
                    TrackData[I].Data[J + (K*5) + 5].Status := $B0 or K;
                    TrackData[I].Data[J + (K*5) + 5].BParm2 := $7F;
                  end;
                  if not Rhythm then
                    for K := 6 to 8 do
                    begin
                      NewEvent(I, J + (K*5) + 1, $B0, $64);
                      TrackData[I].Data[J + (K*5) + 1].Status := $B0 or K;
                      TrackData[I].Data[J + (K*5) + 1].BParm2 := 0;
                      NewEvent(I, J + (K*5) + 2, $B0, $65);
                      TrackData[I].Data[J + (K*5) + 2].Status := $B0 or K;
                      TrackData[I].Data[J + (K*5) + 2].BParm2 := 0;
                      NewEvent(I, J + (K*5) + 3, $B0, 6);
                      TrackData[I].Data[J + (K*5) + 3].Status := $B0 or K;
                      TrackData[I].Data[J + (K*5) + 3].BParm2 := Idx;
                      NewEvent(I, J + (K*5) + 4, $B0, $64);
                      TrackData[I].Data[J + (K*5) + 4].Status := $B0 or K;
                      TrackData[I].Data[J + (K*5) + 4].BParm2 := $7F;
                      NewEvent(I, J + (K*5) + 5, $B0, $65);
                      TrackData[I].Data[J + (K*5) + 5].Status := $B0 or K;
                      TrackData[I].Data[J + (K*5) + 5].BParm2 := $7F;
                    end;
                end;
                DelEvent(I, J, True);
                if Idx > 1 then
                  if Rhythm then
                    J := J + 6 * 5
                  else
                    J := J + 9 * 5;
              end;
              else
                Inc(J);
            end;
          end else
            Inc(J);
        end;
      end;
    end;
    if not((TrackData[I].Data[Length(TrackData[I].Data)-1].Status = $FF)
    and (TrackData[I].Data[Length(TrackData[I].Data)-1].BParm1 = $2F)) then
    begin
      SetLength(TrackData[I].Data, Length(TrackData[I].Data) + 1);
      TrackData[I].Data[High(TrackData[I].Data)].Status := $FF;
      TrackData[I].Data[High(TrackData[I].Data)].BParm1 := $2F;
    end;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;

  if Insts.Count > 0 then
  begin
    for I := 0 to Insts.Count - 1 do
    begin
      P := Insts[I];
      Dispose(P);
    end;
    Insts.Clear;
  end;
  Insts.Free;

  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MID_MUS;
const
  TPB = 240;
var
  InitTempo: Cardinal;
  I, J: Integer;
  Speed: Double;
  Division: Word;
  TuneName: String;
begin
  Log.Lines.Add('[*] Converting Standard MIDI to AdLib MUS...');
  Application.ProcessMessages;
  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;
  TuneName := '';
  for I := 0 to Length(TrackData) - 1 do begin
    J := 0;
    while J < Length(TrackData[I].Data) do begin
      case TrackData[I].Data[J].Status shr 4 of
        10: // Poly Aftertouch
        begin
          // Not compatible with MUS A# xx event
          DelEvent(I, J, True);
          Continue;
        end;
        11: // Control Change
        begin
          if TrackData[I].Data[J].BParm1 = 7 then // Volume Change
          begin
            TrackData[I].Data[J].Status := $A0 or TrackData[I].Data[J].Status and $F;
            TrackData[I].Data[J].BParm1 := TrackData[I].Data[J].BParm2;
            TrackData[I].Data[J].BParm2 := 0;
          end;
        end;
        15: // System Event
        begin
          case TrackData[I].Data[J].Status and $F of
            15: // Meta Event
            begin
              case TrackData[I].Data[J].BParm1 of
                3: // Track Name -> Tune Name
                begin
                  if TuneName = '' then
                    TuneName := TrackData[I].Data[J].DataString;
                  DelEvent(I, J, True);
                  Continue;
                end;
                81: // Set Tempo -> Set Speed
                begin
                  Speed := InitTempo / TrackData[I].Data[J].Value / (InitTempo / (60000000 / TPB));
                  TrackData[I].Data[J].Status := $F0;
                  SetLength(TrackData[I].Data[J].DataArray, 5);
                  TrackData[I].Data[J].Len := Length(TrackData[I].Data[J].DataArray);
                  TrackData[I].Data[J].DataArray[0] := $7F;
                  TrackData[I].Data[J].DataArray[1] := $00;
                  TrackData[I].Data[J].DataArray[2] := Floor(Speed);
                  TrackData[I].Data[J].DataArray[3] := Round(Frac(Speed)*128);
                  TrackData[I].Data[J].DataArray[4] := $F7;
                end;
                $2F: // End Of Track -> Song End
                  TrackData[I].Data[J].Status := $FC;
                else begin
                  // Not compatible with MUS
                  DelEvent(I, J, True);
                  Continue;
                end;
              end;
            end;
          end;
        end;
      end;
      Inc(J);
    end;
    if (Length(TrackData[I].Data) > 0)
    and (TrackData[I].Data[High(TrackData[I].Data)].Status <> $FC) then
      NewEvent(I, Length(TrackData[I].Data), $FC, 0);
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_PutInt('MUS_Version', 1);
  SongData_PutInt('MUS_ID', 0);
  SongData_PutStr('MUS_TuneName', TuneName);
  SongData_PutInt('MUS_TicksPerBeat', TPB);
  SongData_PutInt('MUS_Percussive', 1);
  SongData_PutInt('MUS_PitchBendRange', 1);
  SongData_GetWord('Division', Division);
  SongData_PutInt('MUS_BasicTempo', Division);
  SongData_PutDWord('InitTempo', 60000000 div TPB);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MDI_MUS;
const
  TPB = 240;
type
  TInst = record
    Name: String;
    Data: Array[0..13+13+2-1] of Byte;
  end;
  PInst = ^TInst;
var
  InitTempo: Cardinal;
  I, J, K, Idx: Integer;
  Speed: Double;
  Division: Word;
  Perc, PBend, TuneName, Instr: String;
  Insts: TList;
  P: PInst;
begin
  Log.Lines.Add('[*] Converting AdLib MIDI to AdLib MUS...');
  Application.ProcessMessages;
  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;
  Perc := '';
  PBend := '';
  TuneName := '';
  Instr := '';
  Insts := TList.Create;
  for I := 0 to Length(TrackData) - 1 do begin
    J := 0;
    while J < Length(TrackData[I].Data) do begin
      case TrackData[I].Data[J].Status shr 4 of
        10: // Poly Aftertouch
        begin
          // Not compatible with MUS A# xx event
          DelEvent(I, J, True);
          Continue;
        end;
        13: // Volume Change D# -> Volume Change A#
          TrackData[I].Data[J].Status := $A0 or TrackData[I].Data[J].Status and $F;
        15: // System Event
        begin
          case TrackData[I].Data[J].Status and $F of
            15: // Meta Event
            begin
              case TrackData[I].Data[J].BParm1 of
                3: // Track Name -> Tune Name
                begin
                  if TuneName = '' then
                    TuneName := TrackData[I].Data[J].DataString;
                  DelEvent(I, J, True);
                  Continue;
                end;
                4: // Instrument Name
                begin
                  Instr := TrackData[I].Data[J].DataString;
                  DelEvent(I, J, True);
                  Continue;
                end;
                81: // Set Tempo -> Set Speed
                begin
                  Speed := InitTempo / TrackData[I].Data[J].Value / (InitTempo / (60000000 / TPB));
                  TrackData[I].Data[J].Status := $F0;
                  SetLength(TrackData[I].Data[J].DataArray, 5);
                  TrackData[I].Data[J].Len := Length(TrackData[I].Data[J].DataArray);
                  TrackData[I].Data[J].DataArray[0] := $7F;
                  TrackData[I].Data[J].DataArray[1] := $00;
                  TrackData[I].Data[J].DataArray[2] := Floor(Speed);
                  TrackData[I].Data[J].DataArray[3] := Round(Frac(Speed)*128);
                  TrackData[I].Data[J].DataArray[4] := $F7;
                end;
                $2F: // End Of Track -> Song End
                  TrackData[I].Data[J].Status := $FC;
                $7F: // Sequencer Specific
                begin
                  if (Length(TrackData[I].Data[J].DataArray) >= 6)
                  and (TrackData[I].Data[J].DataArray[0] = $00)
                  and (TrackData[I].Data[J].DataArray[1] = $00)
                  and (TrackData[I].Data[J].DataArray[2] = $3F) then
                    case TrackData[I].Data[J].DataArray[4] of
                      1: // Load patch
                      begin
                        if Length(TrackData[I].Data[J].DataArray) < 34 then
                        begin
                          Instr := '';
                          DelEvent(I, J, True);
                          Continue;
                        end;
                        Idx := -1;
                        for K := 0 to Insts.Count - 1 do
                        begin
                          P := Insts[K];
                          if CompareMem(@TrackData[I].Data[J].DataArray[6],
                          @P^.Data[0], 13+13+2) then
                            Idx := K;
                        end;
                        TrackData[I].Data[J].Status :=
                        $C0 or (TrackData[I].Data[J].DataArray[5] and $F);
                        if Idx > -1 then
                          TrackData[I].Data[J].BParm1 := Idx mod 128
                        else begin
                          New(P);
                          if Instr = '' then
                            Instr := Format('inst%.4d', [Insts.Count]);
                          P^.Name := Instr;
                          CopyMemory(@P^.Data[0],
                          @TrackData[I].Data[J].DataArray[6], 13+13+2);
                          TrackData[I].Data[J].BParm1 := Insts.Count mod 128;
                          Insts.Add(P);
                        end;
                        TrackData[I].Data[J].BParm2 := 0;
                        TrackData[I].Data[J].Len := 0;
                        SetLength(TrackData[I].Data[J].DataArray, 0);
                        Instr := '';
                        Inc(J);
                        Continue;
                      end;
                      2: // Card mode
                        if Perc = '' then
                          if TrackData[I].Data[J].DataArray[5] = 0 then
                            Perc := '-'
                          else
                            Perc := '+';
                      3: // Pitch bend range
                        if PBend = '' then
                          PBend := IntToStr(TrackData[I].Data[J].DataArray[5]);
                    end;
                  DelEvent(I, J, True);
                  Continue;
                end;
                else begin
                  // Not compatible with MUS
                  DelEvent(I, J, True);
                  Continue;
                end;
              end;
            end;
          end;
        end;
      end;
      Instr := '';
      Inc(J);
    end;
    if (Length(TrackData[I].Data) > 0)
    and (TrackData[I].Data[High(TrackData[I].Data)].Status <> $FC) then
      NewEvent(I, Length(TrackData[I].Data), $FC, 0);
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_PutInt('MUS_Version', 1);
  SongData_PutInt('MUS_ID', 0);
  SongData_PutStr('MUS_TuneName', TuneName);
  SongData_PutInt('MUS_TicksPerBeat', TPB);
  if (Perc = '+') or (Perc = '') then
    SongData_PutInt('MUS_Percussive', 1)
  else
    SongData_PutInt('MUS_Percussive', 0);
  if PBend = '' then
    SongData_PutInt('MUS_PitchBendRange', 1)
  else
    SongData_PutStr('MUS_PitchBendRange', PBend);
  SongData_GetWord('Division', Division);
  SongData_PutInt('MUS_BasicTempo', Division);
  SongData_PutDWord('InitTempo', 60000000 div TPB);

  if Insts.Count > 0 then
  begin
    SongData_PutInt('SND_Version', 1);
    for I := 0 to Insts.Count - 1 do
    begin
      P := Insts[I];
      SongData_PutStr('SND_Name#'+IntToStr(I), P^.Name);
      Instr := '';
      for J := 0 to (13+13+2) - 1 do
        if P^.Data[J] < $80 then
          Instr := Instr + IntToStr(P^.Data[J]) + ' '
        else
          Instr := Instr + IntToStr(P^.Data[J] or $FF00) + ' ';
      SongData_PutStr('SND_Data#'+IntToStr(I), Instr);
      Dispose(P);
    end;
    Insts.Clear;
  end;
  Insts.Free;

  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_CMF_MID;
var
  I, J: Integer;
  Val: Byte;
  Rhythm: Boolean;
  Division: Word;
begin
  Log.Lines.Add('[*] Converting Creative Music File to Standard MIDI...');
  Application.ProcessMessages;
  Rhythm := False;
  for I := 0 to Length(TrackData) - 1 do begin
    J := 0;
    while J < Length(TrackData[I].Data) do begin
      case TrackData[I].Data[J].Status shr 4 of
        8: // Note Off
        begin
          if Rhythm then begin
            // convert drums
            case TrackData[I].Data[J].Status and 15 of
              11: // ch11 - Bass Drum
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 36 then
                  Val := 35
                else
                  Val := 36;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              12: // ch12 - Snare Drum
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 40 then
                  Val := 38
                else
                  Val := 40;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              13: // ch13 - Tom
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                Val := 45;
                if TrackData[I].Data[J].BParm1 < 39 then
                  Val := 41;
                if TrackData[I].Data[J].BParm1 = 39 then
                  Val := 43;
                if TrackData[I].Data[J].BParm1 = 40 then
                  Val := 45;
                if TrackData[I].Data[J].BParm1 = 41 then
                  Val := 47;
                if TrackData[I].Data[J].BParm1 = 42 then
                  Val := 48;
                if TrackData[I].Data[J].BParm1 > 42 then
                  Val := 50;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              14: // ch14 - Cymbal
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                Val := 57;
                if TrackData[I].Data[J].BParm1 <= 50 then
                  Val := 49;
                if (TrackData[I].Data[J].BParm1 > 50) and
                (TrackData[I].Data[J].BParm1 <= 65) then
                  Val := 57;
                if TrackData[I].Data[J].BParm1 > 65 then
                  Val := 55;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              15: // ch15 - Hi-Hat
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 44 then
                  Val := 42
                else
                  Val := 44;
                TrackData[I].Data[J].BParm1 := Val;
              end;
            end;
          end;
        end;
        9: // Note On
        begin
          if Rhythm then begin
            // convert drums
            case TrackData[I].Data[J].Status and 15 of
              11:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 36 then
                  Val := 35
                else
                  Val := 36;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              12:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 40 then
                  Val := 38
                else
                  Val := 40;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              13:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                Val := 45;
                if TrackData[I].Data[J].BParm1 < 39 then
                  Val := 41;
                if TrackData[I].Data[J].BParm1 = 39 then
                  Val := 43;
                if TrackData[I].Data[J].BParm1 = 40 then
                  Val := 45;
                if TrackData[I].Data[J].BParm1 = 41 then
                  Val := 47;
                if TrackData[I].Data[J].BParm1 = 42 then
                  Val := 48;
                if TrackData[I].Data[J].BParm1 > 42 then
                  Val := 50;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              14:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                Val := 57;
                if TrackData[I].Data[J].BParm1 <= 50 then
                  Val := 49;
                if (TrackData[I].Data[J].BParm1 > 50) and
                (TrackData[I].Data[J].BParm1 <= 65) then
                  Val := 57;
                if TrackData[I].Data[J].BParm1 > 65 then
                  Val := 55;
                TrackData[I].Data[J].BParm1 := Val;
              end;
              15:
              begin
                TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
                if TrackData[I].Data[J].BParm1 <= 44 then
                  Val := 42
                else
                  Val := 44;
                TrackData[I].Data[J].BParm1 := Val;
              end;
            end;
          end;
        end;
        11: // Control Change
        begin
          case TrackData[I].Data[J].BParm1 of
            $63: // AM+VIB: Unsupported by MIDI
            begin
              DelEvent(I, J, True);
              Continue;
            end;
            $66: // Set Marker Byte
            begin
              TrackData[I].Data[J].Status := $FF;
              TrackData[I].Data[J].BParm1 := $06;
              TrackData[I].Data[J].DataString := IntToStr(TrackData[I].Data[J].BParm2);
              TrackData[I].Data[J].BParm2 := 0;
            end;
            $67: // Rhythm Mode
            begin
              Rhythm := TrackData[I].Data[J].BParm2 > 0;
              DelEvent(I, J, True);
              Continue;
            end;
            $68: // Transpose Up
            begin
              DelEvent(I, J, True);
              Continue;
              // TODO
              TrackData[I].Data[J].Status :=
              $E0 or (TrackData[I].Data[J].Status and $F);
              TrackData[I].Data[J].Value := 8192 +
              (TrackData[I].Data[J].BParm2 * 32);
            end;
            $69: // Transpose Down
            begin
              DelEvent(I, J, True);
              Continue;
              // TODO
              TrackData[I].Data[J].Status :=
              $E0 or (TrackData[I].Data[J].Status and $F);
              TrackData[I].Data[J].Value := 8192 -
              (TrackData[I].Data[J].BParm2 * 32);
            end;
          end;
        end;
        12: // Program Change
          if Rhythm and (TrackData[I].Data[J].Status and $F >= 11) then
          begin
            DelEvent(I, J, True);
            Continue;
          end;
        15: // System
        begin
          if (TrackData[I].Data[J].Status = $FF)
          and (TrackData[I].Data[J].BParm1 = 81) then
            // convert tempo
            TrackData[I].Data[J].Value := TrackData[I].Data[J].Value * 2;
        end;
      end;
      Inc(J);
    end;
    NewEvent(I, 0, $FF, $51);
    TrackData[I].Data[0].Value := 1000000;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_GetWord('Division', Division);
  SongData.Strings.Clear;

  SongData_PutInt('MIDIType', 0);
  SongData_PutDWord('InitTempo', 500000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', Division);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_CMF_MDI;
type
  TOPLRegs = packed record
    ksl: Byte;
    multiplier: Byte;
    feedback: Byte;
    attack: Byte;
    sustain: Byte;
    eg: Byte;
    decay: Byte;
    release: Byte;
    output: Byte;
    vibam: Byte;
    vibfq: Byte;
    envscale: Byte;
    conn: Byte;
  end;
  TMDIInstrument = packed record
    oplModulator: TOPLRegs;
    oplCarrier: TOPLRegs;
    iModWaveSel: Byte;
    iCarWaveSel: Byte;
  end;
  PMDIInstrument = ^TMDIInstrument;
  TCMFInstrument = packed record
    iModChar: Byte;
    iCarChar: Byte;
    iModScale: Byte;
    iCarScale: Byte;
    iModAttack: Byte;
    iCarAttack: Byte;
    iModSustain: Byte;
    iCarSustain: Byte;
    iModWaveSel: Byte;
    iCarWaveSel: Byte;
    iFeedback: Byte;
  end;
  PCMFInstrument = ^TCMFInstrument;
var
  I, J, K: Integer;
  Rhythm: Boolean;
  Division: Word;
  S: String;
  SL: TStringList;
  CMFInst: Array[0..11-1] of Byte;
  MDIInst: Array[0..13+13+2-1] of Byte;
  PCMF: PCMFInstrument;
  PMDI: PMDIInstrument;
begin
  Log.Lines.Add('[*] Converting Creative Music File to AdLib MDI...');
  Application.ProcessMessages;
  Rhythm := False;
  for I := 0 to Length(TrackData) - 1 do begin
    J := 0;
    while J < Length(TrackData[I].Data) do begin
      if TrackData[I].Data[J].Status shr 4 < 15 then
        if (
          Rhythm and
          (TrackData[I].Data[J].Status and $F in [6..10])
        )
        or (
          (not Rhythm) and
          (TrackData[I].Data[J].Status and $F in [9..15])
        ) then
        begin
          DelEvent(I, J, True);
          Continue;
        end;
      if Rhythm and (TrackData[I].Data[J].Status shr 4 < 15) then
      begin
        // convert drums
        case TrackData[I].Data[J].Status and $F of
          11: // ch11 -> ch06 - Bass Drum
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 6;
          12: // ch12 -> ch07 - Snare Drum
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 7;
          13: // ch13 -> ch08 - Tom
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 8;
          14: // ch14 -> ch09 - Cymbal
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 9;
          15: // ch15 -> ch10 - Hi-Hat
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 10;
        end;
      end;
      case TrackData[I].Data[J].Status shr 4 of
        10, 13: // Poly Aftertouch, Channel Aftertouch
        begin
          DelEvent(I, J, True);
          Continue;
        end;
        11: // Control Change
        begin
          case TrackData[I].Data[J].BParm1 of
            7: // Volume Change
            begin
              TrackData[I].Data[J].Status := $D0 or TrackData[I].Data[J].Status and $F;
              TrackData[I].Data[J].BParm1 := TrackData[I].Data[J].BParm2;
              TrackData[I].Data[J].BParm2 := 0;
            end;
            $63: // AM+VIB: Unsupported by MDI
            begin
              DelEvent(I, J, True);
              Continue;
            end;
            $66: // Set Marker Byte
            begin
              TrackData[I].Data[J].Status := $FF;
              TrackData[I].Data[J].BParm1 := $06;
              TrackData[I].Data[J].DataString := IntToStr(TrackData[I].Data[J].BParm2);
              TrackData[I].Data[J].BParm2 := 0;
            end;
            $67: // Rhythm Mode
            begin
              Rhythm := TrackData[I].Data[J].BParm2 > 0;
              TrackData[I].Data[J].Status := $FF;
              TrackData[I].Data[J].BParm1 := $7F;
              TrackData[I].Data[J].BParm2 := 0;
              TrackData[I].Data[J].Len := 6;
              SetLength(TrackData[I].Data[J].DataArray, 6);
              TrackData[I].Data[J].DataArray[0] := $00;
              TrackData[I].Data[J].DataArray[1] := $00;
              TrackData[I].Data[J].DataArray[2] := $3F; // Ad Lib ID
              TrackData[I].Data[J].DataArray[3] := $00;
              TrackData[I].Data[J].DataArray[4] := $02; // Card mode
              TrackData[I].Data[J].DataArray[5] := Byte(Rhythm);
            end;
            $68: // Transpose Up
            begin
              DelEvent(I, J, True);
              Continue;
              // TODO
              TrackData[I].Data[J].Status :=
              $E0 or (TrackData[I].Data[J].Status and $F);
              TrackData[I].Data[J].Value := 8192 +
              (TrackData[I].Data[J].BParm2 * 32);
            end;
            $69: // Transpose Down
            begin
              DelEvent(I, J, True);
              Continue;
              // TODO
              TrackData[I].Data[J].Status :=
              $E0 or (TrackData[I].Data[J].Status and $F);
              TrackData[I].Data[J].Value := 8192 -
              (TrackData[I].Data[J].BParm2 * 32);
            end;
          end;
        end;
        12: // Program Change
        begin
          if not SongData_GetStr('CMF_Inst#'+IntToStr(TrackData[I].Data[J].BParm1), S) then
          begin
            DelEvent(I, J, True);
            Continue;
          end;
          SL := TStringList.Create;
          SL.Delimiter := ' ';
          SL.StrictDelimiter := True;
          SL.DelimitedText := S;
          for K := 0 to 11 - 1 do
          begin
            try
              CMFInst[K] := StrToInt(SL[K]);
            except
              CMFInst[K] := 0;
            end;
          end;
          SL.Free;
          FillChar(MDIInst, SizeOf(MDIInst), 0);
          PCMF := @CMFInst[0];
          PMDI := @MDIInst[0];
          PMDI^.oplModulator.ksl := PCMF^.iModScale shr 6;
          PMDI^.oplModulator.multiplier := PCMF^.iModChar and $F;
          PMDI^.oplModulator.feedback := (PCMF^.iFeedback shr 1) and 7;
          PMDI^.oplModulator.attack := PCMF^.iModAttack shr 4;
          PMDI^.oplModulator.sustain := PCMF^.iModSustain shr 4;
          PMDI^.oplModulator.eg := (PCMF^.iModChar shr 5) and 1;
          PMDI^.oplModulator.decay := PCMF^.iModAttack and $F;
          PMDI^.oplModulator.release := PCMF^.iModSustain and $F;
          PMDI^.oplModulator.output := PCMF^.iModScale and $3F;
          PMDI^.oplModulator.vibam := PCMF^.iModChar shr 7;
          PMDI^.oplModulator.vibfq := (PCMF^.iModChar shr 6) and 1;
          PMDI^.oplModulator.envscale := (PCMF^.iModChar shr 4) and 1;
          PMDI^.oplModulator.conn := (not PCMF^.iFeedback) and 1;
          PMDI^.oplCarrier.ksl := PCMF^.iCarScale shr 6;
          PMDI^.oplCarrier.multiplier := PCMF^.iCarChar and $F;
          PMDI^.oplCarrier.feedback := (not PMDI^.oplModulator.feedback) and $7F;
          PMDI^.oplCarrier.attack := PCMF^.iCarAttack shr 4;
          PMDI^.oplCarrier.sustain := PCMF^.iCarSustain shr 4;
          PMDI^.oplCarrier.eg := (PCMF^.iCarChar shr 5) and 1;
          PMDI^.oplCarrier.decay := PCMF^.iCarAttack and $F;
          PMDI^.oplCarrier.release := PCMF^.iCarSustain and $F;
          PMDI^.oplCarrier.output := PCMF^.iCarScale and $3F;
          PMDI^.oplCarrier.vibam := PCMF^.iCarChar shr 7;
          PMDI^.oplCarrier.vibfq := (PCMF^.iCarChar shr 6) and 1;
          PMDI^.oplCarrier.envscale := (PCMF^.iCarChar shr 4) and 1;
          PMDI^.oplCarrier.conn := 1;
          PMDI^.iModWaveSel := PCMF^.iModWaveSel;
          PMDI^.iCarWaveSel := PCMF^.iCarWaveSel;
          TrackData[I].Data[J].Len := 6;
          SetLength(TrackData[I].Data[J].DataArray, 5 + 1 + 13 + 13 + 2);
          TrackData[I].Data[J].DataArray[0] := $00;
          TrackData[I].Data[J].DataArray[1] := $00;
          TrackData[I].Data[J].DataArray[2] := $3F; // Ad Lib ID
          TrackData[I].Data[J].DataArray[3] := $00;
          TrackData[I].Data[J].DataArray[4] := $01; // Load Patch
          TrackData[I].Data[J].DataArray[5] := TrackData[I].Data[J].Status and $F;
          CopyMemory(@TrackData[I].Data[J].DataArray[6], @MDIInst[0], 13 + 13 + 2);
          TrackData[I].Data[J].Status := $FF;
          TrackData[I].Data[J].BParm1 := $7F;
          TrackData[I].Data[J].BParm2 := 0;
        end;
        15: // System
        begin
          if (TrackData[I].Data[J].Status = $FF)
          and (TrackData[I].Data[J].BParm1 = 81) then
            // convert tempo
            TrackData[I].Data[J].Value := TrackData[I].Data[J].Value * 2;
        end;
      end;
      Inc(J);
    end;
    NewEvent(I, 0, $FF, $51);
    TrackData[I].Data[0].Value := 1000000;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;
  SongData_GetWord('Division', Division);
  SongData.Strings.Clear;

  SongData_PutInt('MIDIType', 0);
  SongData_PutDWord('InitTempo', 500000);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', Division);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.Convert_MDI_CMF;
type
  TOPLRegs = packed record
    ksl: Byte;
    multiplier: Byte;
    feedback: Byte;
    attack: Byte;
    sustain: Byte;
    eg: Byte;
    decay: Byte;
    release: Byte;
    output: Byte;
    vibam: Byte;
    vibfq: Byte;
    envscale: Byte;
    conn: Byte;
  end;
  TMDIInstrument = packed record
    oplModulator: TOPLRegs;
    oplCarrier: TOPLRegs;
    iModWaveSel: Byte;
    iCarWaveSel: Byte;
  end;
  PMDIInstrument = ^TMDIInstrument;
  TCMFInstrument = packed record
    iModChar: Byte;
    iCarChar: Byte;
    iModScale: Byte;
    iCarScale: Byte;
    iModAttack: Byte;
    iCarAttack: Byte;
    iModSustain: Byte;
    iCarSustain: Byte;
    iModWaveSel: Byte;
    iCarWaveSel: Byte;
    iFeedback: Byte;
  end;
  PCMFInstrument = ^TCMFInstrument;
  TInst = Array[0..13+13+2-1] of Byte;
  PInst = ^TInst;
var
  Notes: Array[0..15] of Array of Byte;
  NotesReset: Array[0..15] of Boolean;
  Insts: TList;
  P: PInst;
  I,J,K,Idx: Integer;
  Rhythm: Boolean;
  Division: Word;
  Tempo, S: String;
  CMFInst: Array[0..11-1] of Byte;
  PCMF: PCMFInstrument;
  PMDI: PMDIInstrument;

  procedure ClearNotes;
  var
    I: Integer;
  begin
    for I := 0 to 15 do
    begin
      SetLength(Notes[I], 0);
      NotesReset[I] := False;
    end;
  end;
  function IsNoteOnChannel(Chn, Note: Byte): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to Length(Notes[Chn]) - 1 do
      if Notes[Chn][I] = Note then
      begin
        Result := True;
        Break;
      end;
  end;
  procedure SetNoteOff(Chn, Note: Byte);
  var
    I, Idx: Integer;
  begin
    Idx := -1;
    for I := 0 to Length(Notes[Chn]) - 1 do
      if Notes[Chn][I] = Note then
      begin
        Idx := I;
        Break;
      end;
    if Idx = -1 then
      Exit;
    for I := Idx+1 to Length(Notes[Chn]) - 1 do
      Notes[Chn][I-1] := Notes[Chn][I];
    SetLength(Notes[Chn], Length(Notes[Chn]) - 1);
  end;
begin
  Rhythm := False;
  Log.Lines.Add('[*] Converting AdLib MDI to Creative Music File...');
  Application.ProcessMessages;
  Insts := TList.Create;
  Tempo := '';
  for I := 0 to Length(TrackData) - 1 do
  begin
    ClearNotes;
    J := 0;
    while J < Length(TrackData[I].Data) do
    begin
      if Rhythm and (TrackData[I].Data[J].Status shr 4 < 15) then
      begin
        // convert drums
        case TrackData[I].Data[J].Status and 15 of
          6: // ch06 -> ch11 - Bass Drum
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 11;
          7: // ch07 -> ch12 - Snare Drum
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 12;
          8: // ch08 -> ch13 - Tom
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 13;
          9: // ch09 -> ch14 - Cymbal
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 14;
          10: // ch10 -> ch15 - Hi-Hat
            TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 15;
        end;
      end;
      case TrackData[I].Data[J].Status shr 4 of
        8: // Note Off
        begin
          if TrackData[I].Data[J].BParm1 = 0 then
          begin
            // Global Note Off
            if Length(Notes[TrackData[I].Data[J].Status and $F]) = 0 then
            begin
              if not NotesReset[TrackData[I].Data[J].Status and $F] then
              begin
                // No notes on channel -> Convert to All Notes Off
                NotesReset[TrackData[I].Data[J].Status and $F] := True;
                TrackData[I].Data[J].Status := $B0 or (TrackData[I].Data[J].Status and $F);
                TrackData[I].Data[J].BParm1 := $7B;
                TrackData[I].Data[J].BParm2 := 0;
                Inc(J);
                Continue;
              end
              else
              begin
                // Notes already reset
                DelEvent(I, J, True);
                Continue;
              end;
            end
            else
            begin
              K := TrackData[I].Data[J].Status and $F;
              TrackData[I].Data[J].BParm1 := Notes[K][0];
              TrackData[I].Data[J].BParm2 := 0;
              SetNoteOff(K, Notes[K][0]);
              for K := 1 to Length(Notes[TrackData[I].Data[J].Status and $F]) - 1 do
              begin
                NewEvent(I, J+K, TrackData[I].Data[J].Status, 0);
                TrackData[I].Data[J+K].Status := TrackData[I].Data[J].Status;
                TrackData[I].Data[J+K].BParm1 := Notes[TrackData[I].Data[J].Status and $F][K];
              end;
            end;
          end
          else // Normal Note Off
            SetNoteOff(TrackData[I].Data[J].Status and $F, TrackData[I].Data[J].BParm1);
          Inc(J);
        end;
        9: // Note On
        begin
          if TrackData[I].Data[J].BParm2 = 0 then
          begin
            // Treat as Note Off
            SetNoteOff(TrackData[I].Data[J].Status and $F, TrackData[I].Data[J].BParm1);
          end
          else
            if not IsNoteOnChannel(TrackData[I].Data[J].Status and $F, TrackData[I].Data[J].BParm1) then
            begin
              K := TrackData[I].Data[J].Status and $F;
              SetLength(Notes[K], Length(Notes[K]) + 1);
              Notes[K][High(Notes[K])] := TrackData[I].Data[J].BParm1;
            end;
          Inc(J);
        end;
        10..12: Inc(J);
        13: // Channel Aftertouch -> Volume Change
        begin
          TrackData[I].Data[J].Status := $B0 or TrackData[I].Data[J].Status and $F;
          TrackData[I].Data[J].BParm2 := TrackData[I].Data[J].BParm1;
          TrackData[I].Data[J].BParm1 := 7;
          Inc(J);
        end;
        14: // Pitch Bend
        begin
          // TODO
          Inc(J);
        end;
        15: // System
        begin
          if (TrackData[I].Data[J].Status and 15 = 0)
          or ((TrackData[I].Data[J].Status and 15 = 15)
          and (TrackData[I].Data[J].BParm1 = $7F))
          and (Length(TrackData[I].Data[J].DataArray) >= 6)
          and (TrackData[I].Data[J].DataArray[0] = 0)
          and (TrackData[I].Data[J].DataArray[1] = 0)
          and (TrackData[I].Data[J].DataArray[2] = $3F)
          and (TrackData[I].Data[J].DataArray[3] = 0)
          then begin
            case TrackData[I].Data[J].DataArray[4] of
              1: // Load Patch
              begin
                if TrackData[I].Data[J].DataArray[5] < 16 then
                begin
                  if Length(TrackData[I].Data[J].DataArray) < 34 then
                  begin
                    DelEvent(I, J, True);
                    Continue;
                  end;
                  Idx := -1;
                  for K := 0 to Insts.Count - 1 do
                  begin
                    P := Insts[K];
                    if CompareMem(@TrackData[I].Data[J].DataArray[6],
                    @P^[0], 13+13+2) then
                      Idx := K;
                  end;
                  TrackData[I].Data[J].Status :=
                  $C0 or (TrackData[I].Data[J].DataArray[5] and $F);
                  if Idx > -1 then
                    TrackData[I].Data[J].BParm1 := Idx mod 128
                  else begin
                    New(P);
                    CopyMemory(@P^[0],
                    @TrackData[I].Data[J].DataArray[6], 13+13+2);
                    TrackData[I].Data[J].BParm1 := Insts.Count mod 128;
                    Insts.Add(P);
                  end;
                  if Rhythm then
                    case TrackData[I].Data[J].Status and 15 of
                      6: TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 11;
                      7: TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 12;
                      8: TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 13;
                      9: TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 14;
                      10: TrackData[I].Data[J].Status := (TrackData[I].Data[J].Status and $F0) or 15;
                    end;
                  TrackData[I].Data[J].BParm2 := 0;
                  TrackData[I].Data[J].Len := 0;
                  SetLength(TrackData[I].Data[J].DataArray, 0);
                end;
                Inc(J);
              end;
              2: // Rhythm Mode
              begin
                Rhythm := TrackData[I].Data[J].DataArray[5] > 0;
                TrackData[I].Data[J].Status := $B0;
                TrackData[I].Data[J].BParm1 := $67;
                TrackData[I].Data[J].BParm2 := Byte(Rhythm);
                TrackData[I].Data[J].Len := 0;
                SetLength(TrackData[I].Data[J].DataArray, 0);
                Inc(J);
              end;
              else
              begin
                DelEvent(I, J, True);
                Continue;
              end;
            end;
          end
          else
            case TrackData[I].Data[J].BParm1 of
              81: // Tempo
              begin
                if Tempo = '' then
                  Tempo := IntToStr(TrackData[I].Data[J].Value);
                DelEvent(I, J, True);
                Continue;
              end;
              else begin
                DelEvent(I, J, True);
                Continue;
              end;
            end;
        end;
      end;
    end;
    if not((TrackData[I].Data[Length(TrackData[I].Data)-1].Status = $FF)
    and (TrackData[I].Data[Length(TrackData[I].Data)-1].BParm1 = $2F)) then
    begin
      SetLength(TrackData[I].Data, Length(TrackData[I].Data) + 1);
      TrackData[I].Data[High(TrackData[I].Data)].Status := $FF;
      TrackData[I].Data[High(TrackData[I].Data)].BParm1 := $2F;
    end;
    Log.Lines.Add('[+] Track #'+IntToStr(I)+': '+IntToStr(Length(TrackData[I].Data))+' events converted.');
  end;

  SongData_GetWord('Division', Division);
  SongData.Strings.Clear;

  SongData_PutInt('MIDIType', 0);
  SongData_PutDWord('InitTempo', 1000000);
  SongData_PutInt('SMPTE', 0);
  if Tempo <> '' then
  begin
    Division := Round(Division * (1000000 / StrToInt(Tempo)));
    SongData_PutInt('CMF_Tempo', StrToInt(Tempo) div 1000);
  end;
  SongData_PutInt('Division', Division);
  SongData_PutInt('CMF_TicksPerSecond', Division);
  SongData_PutInt('CMF_TicksPerQuarter', Division div 2);

  if Insts.Count > 0 then
  begin
    for I := 0 to Insts.Count - 1 do
    begin
      P := Insts[I];
      PMDI := Pointer(P);
      PCMF := @CMFInst[0];
      FillChar(CMFInst, SizeOf(CMFInst), 0);
      PCMF^.iModChar :=
      (PMDI^.oplModulator.multiplier and $F) or
      (PMDI^.oplModulator.envscale and 1 shl 4) or
      (PMDI^.oplModulator.eg and 1 shl 5) or
      (PMDI^.oplModulator.vibfq and 1 shl 6) or
      (PMDI^.oplModulator.vibam and 1 shl 7);
      PCMF^.iModScale :=
      (PMDI^.oplModulator.output and $3F) or
      (PMDI^.oplModulator.ksl and 3 shl 6);
      PCMF^.iModAttack :=
      (PMDI^.oplModulator.decay and $F) or
      (PMDI^.oplModulator.attack and $F shl 4);
      PCMF^.iModSustain :=
      (PMDI^.oplModulator.release and $F) or
      (PMDI^.oplModulator.sustain and $F shl 4);
      PCMF^.iModWaveSel := PMDI^.iModWaveSel and 3;
      PCMF^.iCarChar :=
      (PMDI^.oplCarrier.multiplier and $F) or
      (PMDI^.oplCarrier.envscale and 1 shl 4) or
      (PMDI^.oplCarrier.eg and 1 shl 5) or
      (PMDI^.oplCarrier.vibfq and 1 shl 6) or
      (PMDI^.oplCarrier.vibam and 1 shl 7);
      PCMF^.iCarScale :=
      (PMDI^.oplCarrier.output and $3F) or
      (PMDI^.oplCarrier.ksl and 3 shl 6);
      PCMF^.iCarAttack :=
      (PMDI^.oplCarrier.decay and $F) or
      (PMDI^.oplCarrier.attack and $F shl 4);
      PCMF^.iCarSustain :=
      (PMDI^.oplCarrier.release and $F) or
      (PMDI^.oplCarrier.sustain and $F shl 4);
      PCMF^.iCarWaveSel := PMDI^.iCarWaveSel and 3;
      PCMF^.iFeedback :=
      ((not PMDI^.oplModulator.conn) and 1) or
      (PMDI^.oplModulator.feedback and 7 shl 1);
      S := '';
      for J := 0 to Length(CMFInst) - 1 do
        S := S + IntToStr(CMFInst[J]) + ' ';
      SongData_PutStr('CMF_Inst#'+IntToStr(I), S);
      Dispose(P);
    end;
    Insts.Clear;
  end;
  Insts.Free;

  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.RefTrackList;
var
  I: Integer;
begin
  TrkCh.Items.Clear;
  for I:=0 to Length(TrackData)-1 do
    if TrackData[I].Title='' then
      TrkCh.Items.Add(Format('%.'+IntToStr(Length(IntToStr(Length(TrackData))))+'d',[I])+
      ' |')
    else
      TrkCh.Items.Add(Format('%.'+IntToStr(Length(IntToStr(Length(TrackData))))+'d',[I])+
      ' | '+TrackData[I].Title);
end;

procedure TMainForm.CalculateEvnts;
var
  I,J: Integer;
  Cnt: UInt64;
begin
  Cnt:=0;
  for I := 0 to SongData.ColCount - 1 do
    for J := 0 to SongData.RowCount - 1 do
      Cnt:=Cnt+Length(SongData.Cells[I,J])*2;
  for I:=0 to Length(TrackData)-1 do begin
    Cnt:=Cnt+Length(TrackData[I].Title);
    for J:=0 to Length(TrackData[I].Data)-1 do begin
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].Ticks);
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].Status);
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].BParm1);
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].BParm2);
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].Value);
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].Len);
      Cnt:=Cnt+Length(TrackData[I].Data[J].DataArray);
      Cnt:=Cnt+Length(TrackData[I].Data[J].DataString);
      Cnt:=Cnt+sizeof(TrackData[I].Data[J].RunStatMode);
    end;
  end;
  StatusBar.Panels.Items[0].Text:='Memory usage: '+
  IntToStr(Cnt)+' bytes';
  Cnt:=0;
  for I:=0 to Length(TrackData)-1 do
    Cnt:=Cnt+Length(TrackData[I].Data);
  StatusBar.Panels.Items[1].Text:='Total events: '+IntToStr(Cnt);
end;

function GetSongLengthTicks: UInt64;
var
  Ver: Word;
  I, J: Integer;
  X: UInt64;
begin
  Result := 0;
  if not SongData_GetWord('MIDIType', Ver) then
    Exit;
  if Ver = 0 then begin
    if Length(TrackData) < 1 then
      Exit;
    for I := 0 to Length(TrackData[0].Data) - 1 do
      Result := Result + TrackData[0].Data[I].Ticks;
  end;
  if Ver = 1 then begin
    for J := 0 to Length(TrackData) - 1 do begin
      X := 0;
      for I := 0 to Length(TrackData[J].Data) - 1 do
        X := X + TrackData[J].Data[I].Ticks;
      if X > Result then
        Result := X;
    end;
  end;
  if Ver = 2 then begin
    for J := 0 to Length(TrackData) - 1 do
      for I := 0 to Length(TrackData[J].Data) - 1 do
        Result := Result + TrackData[J].Data[I].Ticks;
  end;
end;

procedure TMainForm.MCalcLenClick(Sender: TObject);
var
  SMPTE: ShortInt;
  Division: Word;
  Len, Time: UInt64;
  S: String;
begin
  Len := GetSongLengthTicks;
  S := 'Total ticks: ' + IntToStr(Len)+#13#10;
  if not SongData_GetSInt('SMPTE', SMPTE) then
    SMPTE := 0;
  if not SongData_GetWord('Division', Division) then
  begin
    Log.Lines.Add('[-] Division is not defined.');
    Exit;
  end;
  if SMPTE>=0 then begin
    Time := Round(Len / Division * 500)
  end else begin
    Time := 0;
  end;
  S := S +'Time: ' + Format('%.2d', [Time div (1000 * 60 * 60)]) +
  ':' + Format('%.2d', [(Time div (1000 * 60)) mod 60]) +
  ':' + Format('%.2d', [(Time div 1000) mod 60]) +
  '.' + Format('%.3d', [Time mod 1000]);
  MessageBox(Handle, PWideChar(S), 'Song length', mb_IconInformation or mb_Ok);
end;

procedure TMainForm.Changechannel1Click(Sender: TObject);
var
  I, Trk: Integer;
  //Ch: Byte;
begin
  Trk := TrkCh.ItemIndex;
  for I := 0 to Length(TrackData[Trk].Data) - 1 do begin
    // Channel replace
    {
    if TrackData[Trk].Data[I].Status shr 4 < 15 then begin
      TrackData[Trk].Data[I].Status := TrackData[Trk].Data[I].Status and $F0;
      TrackData[Trk].Data[I].Status := TrackData[Trk].Data[I].Status or 9;
    end;
    }
    // Shift channel (for MT-32)
    {
    if TrackData[Trk].Data[I].Status shr 4 < 15 then begin
      Ch := TrackData[Trk].Data[I].Status and $F;
      case Ch of
        0: Ch := 1;
        1: Ch := 2;
        2: Ch := 3;
        3: Ch := 4;
        4: Ch := 5;
        5: Ch := 6;
        6: Ch := 7;
        7: Ch := 8;
        8: Ch := 10;
        9: ;
        10: Ch := 11;
        11: Ch := 12;
        12: Ch := 13;
        13: Ch := 14;
        14: Ch := 15;
        15: Ch := 0;
      end;
      TrackData[Trk].Data[I].Status := TrackData[Trk].Data[I].Status and $F0;
      TrackData[Trk].Data[I].Status := TrackData[Trk].Data[I].Status or Ch;
    end;
    }
    // Drum replace
    {
    if (TrackData[Trk].Data[I].Status shr 4=8) or (TrackData[Trk].Data[I].Status shr 4=9) then
      case TrackData[Trk].Data[I].BParm1 of
        64: TrackData[Trk].Data[I].BParm1:=38;
      end;
    }
    // Replace Note Off by Note On volume 0
    {
    if TrackData[Trk].Data[I].Status shr 4 = 8 then begin
      TrackData[Trk].Data[I].Status := TrackData[Trk].Data[I].Status and $F;
      TrackData[Trk].Data[I].Status := TrackData[Trk].Data[I].Status or $90;
      TrackData[Trk].Data[I].BParm2 := 0;
    end;
    }
    // Volume up
    {
    if TrackData[Trk].Data[I].Status shr 4=9 then begin
      TrackData[Trk].Data[I].BParm2:=Round(TrackData[Trk].Data[I].BParm2*(120/82));
      if TrackData[Trk].Data[I].BParm2>127 then
        TrackData[Trk].Data[I].BParm2:=127;
    end;
    }
  end;
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.MChangeDivisionClick(Sender: TObject);
var
  Ver, Division: Word;
  SMPTE: ShortInt;
begin
  if not SongData_GetWord('MIDIType', Ver) then
  begin
    Log.Lines.Add('[-] MIDI Type is not defined.');
    Exit;
  end;
  if not SongData_GetSInt('SMPTE', SMPTE) then
    SMPTE := 0;
  if not SongData_GetWord('Division', Division) then
  begin
    Log.Lines.Add('[-] Division is not defined.');
    Exit;
  end;
  EditDialog.MType.ItemIndex:=Ver;
  EditDialog.Chn.Visible:=False;
  EditDialog.DeltaTime.Visible:=False;
  EditDialog.StaticText1.Visible:=False;
  EditDialog.StaticText2.Visible:=False;
  EditDialog.DVal.Value:=Division;
  if SMPTE>=0 then begin
    EditDialog.DRes.ItemIndex:=0;
    EditDialog.DSMPTE.Value:=0;
  end else begin
    EditDialog.DRes.ItemIndex:=1;
    EditDialog.DSMPTE.Value:=SMPTE;
  end;
  EditDialog.DResClick(Sender);
  EditDialog.PageControl1.TabIndex:=16;
  EditDialog.bOk.Caption:='OK';
  EditDialog.ChangeHeight(1);
  EditDialog.Caption:='Change division';
  if EditDialog.ShowModal<>mrOk then Exit;
  Division:=EditDialog.DVal.Value;
  if EditDialog.DRes.ItemIndex=1 then
    SMPTE:=-EditDialog.DSMPTE.Value
  else
    SMPTE:=0;
  SongData_PutInt('Division', Division);
  SongData_PutInt('SMPTE', SMPTE);
  Log.Lines.Add('[*] Division changed.');
  if SMPTE>=0 then
    Log.Lines.Add('Division    '+IntToStr(Division)+' PPQN')
  else begin
    Log.Lines.Add('Division    '+IntToStr(Division)+' TPF');
    Log.Lines.Add('SMPTE       '+IntToStr(-SMPTE)+' FPS');
  end;
  Log.Lines.Add('');
end;

procedure TMainForm.MShowVarsClick(Sender: TObject);
var
  I: Integer;
begin
  Log.Lines.Add('[*] Internal variables:');
  Log.Lines.Add('Container = ' + Container);
  Log.Lines.Add('EventFormat = ' + EventFormat);
  Log.Lines.Add('EventProfile = ' + EventProfile);
  for I := 1 to SongData.RowCount - 1 do
    Log.Lines.Add(SongData.Cells[0, I] + ' = ' + SongData.Cells[1, I]);
end;

procedure TMainForm.MChangeTypeClick(Sender: TObject);
var
  Ver: Word;
begin
  if not SongData_GetWord('MIDIType', Ver) then
  begin
    Log.Lines.Add('[-] MIDI Type is not defined.');
    Exit;
  end;
  EditDialog.MType.ItemIndex:=Ver;
  EditDialog.Chn.Visible:=False;
  EditDialog.DeltaTime.Visible:=False;
  EditDialog.StaticText1.Visible:=False;
  EditDialog.StaticText2.Visible:=False;
  EditDialog.PageControl1.TabIndex:=15;
  EditDialog.bOk.Caption:='OK';
  EditDialog.ChangeHeight(2);
  EditDialog.Caption:='Change MIDI Type';
  if EditDialog.ShowModal<>mrOk then Exit;
  if Ver<>EditDialog.MType.ItemIndex then begin
    Ver:=EditDialog.MType.ItemIndex;
    SongData_PutInt('MIDIType', Ver);
    Log.Lines.Add('[*] MIDI Type changed to '+IntToStr(Ver)+'.');
  end;
end;

procedure TMainForm.ChkButtons;
begin
  BAddTrack.Enabled:=Opened;
  MAddTrack.Enabled:=Opened;
  MTrack.Enabled:=Opened;
  MEdit.Enabled:=Opened;
  MSave.Enabled:=Opened;
  MSaveAs.Enabled:=Opened;
  MDelTrack.Enabled:=(Length(TrackData)>0);
  BDelTrack.Enabled:=(Length(TrackData)>0);
  Label1.Enabled:=(Length(TrackData)>0);
  TrkCh.Enabled:=(Length(TrackData)>0);
  Events.Enabled:=(Length(TrackData)>0);
  MPaste.Enabled:=(Length(TrackData)>0) and BCopyBuf;
  PPaste.Enabled:=(Length(TrackData)>0) and BCopyBuf;
  MAddEvnt.Enabled:=(Length(TrackData)>0);
  BAddEvnt.Enabled:=(Length(TrackData)>0);
  Action1.Enabled:=(Length(TrackData)>0);
  Action2.Enabled:=(Length(TrackData)>0);
  Action3.Enabled:=(Length(TrackData)>0);
  Action4.Enabled:=(Length(TrackData)>0);
  Action5.Enabled:=(Length(TrackData)>0);
  MActions.Enabled:=(Length(TrackData)>0);
  MOptimize.Enabled:=(Length(TrackData)>0);
  MFind.Enabled:=(Length(TrackData)>0);
  MReplace.Enabled:=(Length(TrackData)>0);
  MProfile.Enabled:=(Length(TrackData)>0);
  if Length(TrackData)=0 then begin
    MEditEvnt.Enabled:=False;
    BEditEvnt.Enabled:=False;
    MDelEvnt.Enabled:=False;
    BDelEvnt.Enabled:=False;
    MDelEvntRange.Enabled:=False;
    BDelEvntRange.Enabled:=False;
    MDelEvntT.Enabled:=False;
    BDelEvntT.Enabled:=False;
    MDelEvntRangeT.Enabled:=False;
    BDelEvntRangeT.Enabled:=False;
    MCut.Enabled:=False;
    PCut.Enabled:=False;
    MCopy.Enabled:=False;
    PCopy.Enabled:=False;
    PCopyText.Enabled:=False;
    PDel.Enabled:=False;
    MMoveUp.Enabled:=False;
    BMoveUp.Enabled:=False;
    MMoveDown.Enabled:=False;
    BMoveDown.Enabled:=False;
    MMerge1.Enabled:=False;
    MMerge2.Enabled:=False;
    MSplit1.Enabled:=False;
    MSplit2.Enabled:=False;
    MSplit3.Enabled:=False;
    Events.ColCount:=1;
    Events.RowCount:=1;
    Events.DefaultColWidth:=64;
    Events.Cells[0,0]:='No tracks';
  end else begin
    MEditEvnt.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BEditEvnt.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MDelEvnt.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BDelEvnt.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MDelEvntRange.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BDelEvntRange.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MDelEvntT.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BDelEvntT.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MDelEvntRangeT.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BDelEvntRangeT.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MCut.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    PCut.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MCopy.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    PCopy.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    PCopyText.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    PDel.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MMoveUp.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BMoveUp.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MMoveDown.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    BMoveDown.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    if Events.Row=1 then begin
      MMoveUp.Enabled:=False;
      BMoveUp.Enabled:=False;
    end;
    if Events.Row=Events.RowCount-1 then begin
      MMoveDown.Enabled:=False;
      BMoveDown.Enabled:=False;
    end;
    MMerge1.Enabled:=(Length(TrackData)>1);
    MMerge2.Enabled:=(Length(TrackData)>1);
    MSplit1.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MSplit2.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
    MSplit3.Enabled:=(Length(TrackData[TrkCh.ItemIndex].Data)>0);
  end;
  MFormatMID.Enabled := True;
  MFormatXMI.Enabled := True;
  MFormatMUS.Enabled := True;
  MFormatMDI.Enabled := True;
  MFormatCMF.Enabled := True;
  MFormatMID.Checked := False;
  MFormatXMI.Checked := False;
  MFormatMUS.Checked := False;
  MFormatMDI.Checked := False;
  MFormatCMF.Checked := False;
  MProfileMID.Enabled := True;
  MProfileXMI.Enabled := True;
  MProfileMUS.Enabled := True;
  MProfileMDI.Enabled := True;
  MProfileCMF.Enabled := True;
  MProfileMID.Checked := False;
  MProfileXMI.Checked := False;
  MProfileMUS.Checked := False;
  MProfileMDI.Checked := False;
  MProfileCMF.Checked := False;
  if EventProfile = 'mid' then begin
    MFormatMID.Checked := True;
    MFormatMID.Enabled := False;
  end;
  if EventViewProfile = 'mid' then begin
    MProfileMID.Checked := True;
    MProfileMID.Enabled := False;
  end;
  if EventProfile = 'xmi' then begin
    MFormatXMI.Checked := True;
    MFormatXMI.Enabled := False;
  end;
  if EventViewProfile = 'xmi' then begin
    MProfileXMI.Checked := True;
    MProfileXMI.Enabled := False;
  end;
  if EventProfile = 'mus' then begin
    MFormatMUS.Checked := True;
    MFormatMUS.Enabled := False;
  end;
  if EventViewProfile = 'mus' then begin
    MProfileMUS.Checked := True;
    MProfileMUS.Enabled := False;
  end;
  if EventProfile = 'mdi' then begin
    MFormatMDI.Checked := True;
    MFormatMDI.Enabled := False;
  end;
  if EventViewProfile = 'mdi' then begin
    MProfileMDI.Checked := True;
    MProfileMDI.Enabled := False;
  end;
  if EventProfile = 'cmf' then begin
    MFormatCMF.Checked := True;
    MFormatCMF.Enabled := False;
  end;
  if EventViewProfile = 'cmf' then begin
    MProfileCMF.Checked := True;
    MProfileCMF.Enabled := False;
  end;
end;

procedure TMainForm.NewEvent(Trk, Idx: Integer; E, Parm: Byte);
var
  I: Integer;
  Chn: SmallInt;
  InitTempo: Cardinal;
begin
  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;
  Chn:=-1;
  for I:=0 to Length(TrackData[Trk].Data)-1 do
    if (TrackData[Trk].Data[I].Status = 15)
    and (TrackData[Trk].Data[I].BParm1 = 32) then begin
      Chn:=TrackData[Trk].Data[I].DataArray[0];
      Break;
    end;
  if Chn=-1 then
    for I:=0 to Length(TrackData[Trk].Data)-1 do
      if (TrackData[Trk].Data[I].Status shr 4) in [8..14] then begin
        Chn:=TrackData[Trk].Data[I].Status and 15;
        Break;
      end;
  if Chn=-1 then
    if Trk in [0..15] then
      Chn:=Trk
    else
      Chn:=0;
  if E<240 then
    E:=E or Chn;
  SetLength(TrackData[Trk].Data, Length(TrackData[Trk].Data)+1);
  for I:=Length(TrackData[Trk].Data)-1 downto Idx+1 do
    TrackData[Trk].Data[I]:=TrackData[Trk].Data[I-1];
  TrackData[Trk].Data[Idx].Ticks:=0;
  TrackData[Trk].Data[Idx].Status:=E;
  TrackData[Trk].Data[Idx].RunStatMode:=False;
  SetLength(TrackData[Trk].Data[Idx].DataArray, 0);
  TrackData[Trk].Data[Idx].DataString:='';
  if (E<$F0) and (Idx>0) and (E=TrackData[Trk].Data[Idx-1].Status) then
    TrackData[Trk].Data[Idx].RunStatMode:=True;
  case E shr 4 of
    // default values
    8: begin  // NoteOff
      TrackData[Trk].Data[Idx].BParm1:=48;
      TrackData[Trk].Data[Idx].BParm2:=0;
    end;
    9: begin  // NoteOn
      TrackData[Trk].Data[Idx].BParm1:=48;
      TrackData[Trk].Data[Idx].BParm2:=127;
    end;
    10: begin // KeyPressure
      TrackData[Trk].Data[Idx].BParm1:=48;
      TrackData[Trk].Data[Idx].BParm2:=64;
    end;
    12:       // ProgramChange
      TrackData[Trk].Data[Idx].BParm1:=0;
    13:       // ChannelPressure
      TrackData[Trk].Data[Idx].BParm1:=64;
    14:       // PitchBend
      TrackData[Trk].Data[Idx].Value:=8192;
    11: begin // ControlChange
      TrackData[Trk].Data[Idx].BParm1:=Parm;
      case Parm of
        $07,$27,$75:
          TrackData[Trk].Data[Idx].BParm2:=127;
        $08,$0A,$28,$2A:
          TrackData[Trk].Data[Idx].BParm2:=64;
        else
          TrackData[Trk].Data[Idx].BParm2:=0;
      end;
    end;
    15:       // System
      case E and 15 of
        0: begin // SysEx
          TrackData[Trk].Data[Idx].Len:=1;
          SetLength(TrackData[Trk].Data[Idx].DataArray, 1);
          TrackData[Trk].Data[Idx].DataArray[0]:=$F7;
        end;
        1:       // QuarterFrame
          TrackData[Trk].Data[Idx].BParm1:=0;
        2:       // SongPosPtr
          TrackData[Trk].Data[Idx].Value:=0;
        3:       // SongSelect
          TrackData[Trk].Data[Idx].BParm1:=0;
        7: begin // EOX
          TrackData[Trk].Data[Idx].Len:=0;
          SetLength(TrackData[Trk].Data[Idx].DataArray, 0);
        end;
        15: begin // Meta
          TrackData[Trk].Data[Idx].BParm1:=Parm;
          case Parm of
            0: begin  // Sequence Number
              TrackData[Trk].Data[Idx].Len:=2;
              TrackData[Trk].Data[Idx].Value:=Trk;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 2);
              TrackData[Trk].Data[Idx].DataArray[0]:=(Trk shr 8) and $FF;
              TrackData[Trk].Data[Idx].DataArray[1]:=Trk and $FF;
            end;
            1..7: begin  // Strings
              TrackData[Trk].Data[Idx].Len:=0;
              TrackData[Trk].Data[Idx].DataString:='';
            end;
            $40: begin  // MIDI Channel
              TrackData[Trk].Data[Idx].Len:=1;
              TrackData[Trk].Data[Idx].Value:=Chn;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 1);
              TrackData[Trk].Data[Idx].DataArray[0]:=Chn;
            end;
            $41: begin  // MIDI Port
              TrackData[Trk].Data[Idx].Len:=1;
              TrackData[Trk].Data[Idx].Value:=0;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 1);
              TrackData[Trk].Data[Idx].DataArray[0]:=0;
            end;
            $51: begin  // Tempo
              TrackData[Trk].Data[Idx].Len:=3;
              TrackData[Trk].Data[Idx].Value := InitTempo;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 3);
              TrackData[Trk].Data[Idx].DataArray[0]:=$07;
              TrackData[Trk].Data[Idx].DataArray[1]:=$A1;
              TrackData[Trk].Data[Idx].DataArray[2]:=$20;
            end;
            $54: begin  // SMPTE Offset
              TrackData[Trk].Data[Idx].Len:=5;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 5);
              TrackData[Trk].Data[Idx].DataArray[0]:=$60;
              TrackData[Trk].Data[Idx].DataArray[1]:=$00;
              TrackData[Trk].Data[Idx].DataArray[2]:=$03;
              TrackData[Trk].Data[Idx].DataArray[3]:=$00;
              TrackData[Trk].Data[Idx].DataArray[4]:=$00;
            end;
            $58: begin  // TimeSignature
              TrackData[Trk].Data[Idx].Len:=4;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 4);
              TrackData[Trk].Data[Idx].DataArray[0]:=$06;
              TrackData[Trk].Data[Idx].DataArray[1]:=$03;
              TrackData[Trk].Data[Idx].DataArray[2]:=$24;
              TrackData[Trk].Data[Idx].DataArray[3]:=$08;
            end;
            $59: begin  // KeySignature
              TrackData[Trk].Data[Idx].Len:=2;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 2);
              TrackData[Trk].Data[Idx].DataArray[0]:=$00;
              TrackData[Trk].Data[Idx].DataArray[1]:=$00;
            end;
            else begin
              TrackData[Trk].Data[Idx].Len:=0;
              SetLength(TrackData[Trk].Data[Idx].DataArray, 0);
            end;
          end;
        end;
      end;
  end;
end;

procedure TMainForm.AddEvent(E, Parm: Byte);
var
  Trk, Pos: UInt64;
begin
  Trk:=TrkCh.ItemIndex;
  Pos:=0;
  if (Events.Row-1)>=0 then
    Pos:=Events.Row-1;
  NewEvent(Trk, Pos, E, Parm);
  FillEvents(TrkCh.ItemIndex);
  if Length(TrackData[Trk].Data)=1 then
    Events.Row:=1
  else
    Events.Row:=Events.Row+1;
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.BAddEvntClick(Sender: TObject);
begin
  if ActiveControl <> Events then
    Exit;
  PopEvnt.Popup(MainForm.Left + BAddEvnt.Left + BAddEvnt.Width + 3,
  MainForm.Top + splitH.Top + 44);
end;

procedure TMainForm.BAddTrackClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx:=TrkCh.ItemIndex;
  AddTrack;
  RefTrackList;
  if Idx=-1 then
    TrkCh.ItemIndex:=0
  else
    TrkCh.ItemIndex:=Idx;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.BDelEvntClick(Sender: TObject);
begin
  if ActiveControl <> Events then
    Exit;
  if Events.Selection.Bottom-Events.Selection.Top+1=1 then
    DelEvent(TrkCh.ItemIndex, Events.Row-1, False)
  else
    DelRange(TrkCh.ItemIndex, Events.Selection.Top-1,
    Events.Selection.Bottom-Events.Selection.Top+1, False);
  if Length(TrackData[TrkCh.ItemIndex].Data)=Events.Row-1 then
    Events.Row:=Events.Row-1;
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.BDelEvntRangeClick(Sender: TObject);
var
  Trk, E, Cnt: Integer;
begin
  Trk:=TrkCh.ItemIndex;
  EditDialog.Chn.Visible:=False;
  EditDialog.DeltaTime.Visible:=False;
  EditDialog.StaticText1.Visible:=False;
  EditDialog.StaticText2.Visible:=False;
  EditDialog.PageControl1.TabIndex:=0;
  EditDialog.RangeFrom.Value:=1;
  EditDialog.RangeTo.MaxValue:=Length(TrackData[Trk].Data);
  EditDialog.RangeTo.Value:=Length(TrackData[Trk].Data);
  EditDialog.RangeTo.MinValue:=1;
  EditDialog.RangeFrom.MinValue:=1;
  EditDialog.bOk.Caption:='Delete';
  EditDialog.ChangeHeight(0);
  EditDialog.Caption:='Delete range of events';
  if EditDialog.ShowModal<>mrOk then Exit;
  E:=EditDialog.RangeFrom.Value-1;
  Cnt:=(EditDialog.RangeTo.Value-1)-(EditDialog.RangeFrom.Value-1)+1;
  DelRange(Trk, E, Cnt, False);
  if Events.Row>Length(TrackData[Trk].Data) then
    Events.Row:=Events.Row-1;
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.BDelEvntRangeTClick(Sender: TObject);
var
  Trk,E,Cnt: Integer;
begin
  Trk:=TrkCh.ItemIndex;
  EditDialog.Chn.Visible:=False;
  EditDialog.DeltaTime.Visible:=False;
  EditDialog.StaticText1.Visible:=False;
  EditDialog.StaticText2.Visible:=False;
  EditDialog.PageControl1.TabIndex:=0;
  EditDialog.RangeFrom.Value:=1;
  EditDialog.RangeTo.MaxValue:=Length(TrackData[Trk].Data);
  EditDialog.RangeTo.Value:=Length(TrackData[Trk].Data);
  EditDialog.RangeTo.MinValue:=1;
  EditDialog.RangeFrom.MinValue:=1;
  EditDialog.bOk.Caption:='Delete';
  EditDialog.ChangeHeight(0);
  EditDialog.Caption:='Delete range of events with time saving';
  if EditDialog.ShowModal<>mrOk then Exit;
  E:=EditDialog.RangeFrom.Value-1;
  Cnt:=(EditDialog.RangeTo.Value-1)-(EditDialog.RangeFrom.Value-1)+1;
  DelRange(Trk, E, Cnt, True);
  if Events.Row>Length(TrackData[Trk].Data) then
    Events.Row:=Events.Row-1;
  FillEvents(Trk);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.BDelEvntTClick(Sender: TObject);
begin
  if ActiveControl <> Events then
    Exit;
  if Events.Selection.Bottom-Events.Selection.Top+1=1 then
    DelEvent(TrkCh.ItemIndex, Events.Row-1, True)
  else
    DelRange(TrkCh.ItemIndex, Events.Selection.Top-1,
    Events.Selection.Bottom-Events.Selection.Top+1, True);
  if Length(TrackData[TrkCh.ItemIndex].Data)=Events.Row-1 then
    Events.Row:=Events.Row-1;
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.BDelTrackClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TrkCh.ItemIndex;
  DelTrack(Idx);
  RefTrackList;
  if Length(TrackData) = 0 then
    ChkButtons
  else begin
    if Idx<Length(TrackData) then
      TrkCh.ItemIndex := Idx
    else
      TrkCh.ItemIndex := Idx - 1;
    FillEvents(TrkCh.ItemIndex);
  end;
  CalculateEvnts;
end;

procedure TMainForm.BEditEvntClick(Sender: TObject);
var
  Trk, I: Integer;
  E: ^Command;
begin
  Trk:=TrkCh.ItemIndex;
  E:=@TrackData[Trk].Data[Events.Row-1];
  EditDialog.DeltaTime.Value:=E^.Ticks;
  EditDialog.Chn.ItemIndex:=E^.Status and 15;
  EditDialog.Chn.Visible:=True;
  EditDialog.DeltaTime.Visible:=True;
  EditDialog.StaticText1.Visible:=True;
  EditDialog.StaticText2.Visible:=True;
  EditDialog.bOk.Caption:='OK';
  case E^.Status shr 4 of
    8: begin
      EditDialog.Caption:='Event: Note Off';
      EditDialog.ChnChange(Sender);
      EditDialog.Velocity.Visible:=False;
      EditDialog.VelLabel.Visible:=False;
      EditDialog.Label4.Visible:=False;
      if EditDialog.Chn.ItemIndex<>9 then
        EditDialog.Note.ItemIndex:=127-E^.BParm1
      else
        EditDialog.Note.ItemIndex:=E^.BParm1;
      EditDialog.PageControl1.TabIndex:=1;
      EditDialog.ChangeHeight(1);
    end;
    9: begin
      EditDialog.Caption:='Event: Note On';
      EditDialog.ChnChange(Sender);
      EditDialog.Velocity.Visible:=True;
      EditDialog.VelLabel.Visible:=True;
      EditDialog.Label4.Visible:=True;
      EditDialog.NoteDur.Visible := False;
      EditDialog.lNoteDur.Visible := False;
      EditDialog.lNoteDurRes.Visible := False;
      if EditDialog.Chn.ItemIndex<>9 then
        EditDialog.Note.ItemIndex:=127-E^.BParm1
      else
        EditDialog.Note.ItemIndex:=E^.BParm1;
      EditDialog.Velocity.Position:=E^.BParm2;
      EditDialog.VelLabel.Caption:=IntToStr(E^.BParm2);
      EditDialog.PageControl1.TabIndex:=1;
      EditDialog.ChangeHeight(2);
      if EventProfile = 'xmi' then
      begin
        EditDialog.Caption:='Event: Play Note';
        EditDialog.ChnChange(Sender);
        EditDialog.NoteDur.Value := E^.Len;
        EditDialog.NoteDur.Visible := True;
        EditDialog.lNoteDur.Visible := True;
        EditDialog.lNoteDurRes.Caption := '(in ticks)';
        EditDialog.lNoteDurRes.Visible := True;
        EditDialog.ChangeHeight(3);
      end;
    end;
    10: begin
      EditDialog.Caption:='Event: Polyphonic Aftertouch';
      EditDialog.ChnChange(Sender);
      EditDialog.Label6.Visible:=True;
      EditDialog.ANote.Visible:=True;
      if EditDialog.Chn.ItemIndex<>9 then
        EditDialog.ANote.ItemIndex:=127-E^.BParm1
      else
        EditDialog.ANote.ItemIndex:=E^.BParm1;
      EditDialog.Pressure.Position:=E^.BParm2;
      EditDialog.PrLabel.Caption:=IntToStr(E^.BParm2);
      EditDialog.PageControl1.TabIndex:=4;
      EditDialog.ChangeHeight(2);
    end;
    11:
      if Pos('Undefined', ControlTable[E^.BParm1])=0 then
        case E^.BParm1 of
          7,8,10,39,40,42: begin
            EditDialog.Caption:='Event: '+ControlTable[E^.BParm1];
            EditDialog.Level.Position:=E^.BParm2;
            EditDialog.LvLabel.Caption:=IntToStr(E^.BParm2);
            EditDialog.Label12.Caption:=ControlTable[E^.BParm1]+':';
            EditDialog.Label12.Left:=64-EditDialog.Label12.Width;
            EditDialog.PageControl1.TabIndex:=8;
            EditDialog.ChangeHeight(1);
          end;
          64..69,103,122: begin
            EditDialog.Caption:='Event: '+ControlTable[E^.BParm1];
            case E^.BParm2 of
              0..63:   EditDialog.Switch.ItemIndex:=0;
              64..127: EditDialog.Switch.ItemIndex:=1;
            end;
            EditDialog.Switch.Items.Strings[0]:='Off';
            EditDialog.Switch.Items.Strings[1]:='On';
            if E^.BParm1=68 then begin
              EditDialog.Switch.Items.Strings[0]:='Normal';
              EditDialog.Switch.Items.Strings[1]:='Legato';
            end;
            if E^.BParm1=103 then begin
              EditDialog.Switch.Items.Strings[0]:='Melody mode';
              EditDialog.Switch.Items.Strings[1]:='Rhythm mode';
              case E^.BParm2 of
                0:      EditDialog.Switch.ItemIndex:=0;
                1..127: EditDialog.Switch.ItemIndex:=1;
              end;
            end;
            EditDialog.PageControl1.TabIndex:=10;
            EditDialog.ChangeHeight(2);
          end;
          84: begin
            EditDialog.Caption:='Event: '+ControlTable[E^.BParm1];
            EditDialog.ChnChange(Sender);
            EditDialog.Velocity.Visible:=False;
            EditDialog.VelLabel.Visible:=False;
            EditDialog.Label4.Visible:=False;
            if EditDialog.Chn.ItemIndex<>9 then
              EditDialog.Note.ItemIndex:=127-E^.BParm2
            else
              EditDialog.Note.ItemIndex:=E^.BParm2;
            EditDialog.PageControl1.TabIndex:=1;
            EditDialog.ChangeHeight(1);
          end;
          96..97,120,121,123..125,127: begin
            EditDialog.Caption:='Event: '+ControlTable[E^.BParm1];
            EditDialog.PageControl1.TabIndex:=2;
            EditDialog.ChangeHeight(0);
          end;
          else begin
            EditDialog.Caption:='Event: '+ControlTable[E^.BParm1];
            EditDialog.CtrlValue.MaxValue:=127;
            EditDialog.CtrlValue.Value:=E^.BParm2;
            EditDialog.PageControl1.TabIndex:=9;
            EditDialog.ChangeHeight(1);
          end;
        end
      else begin
        EditDialog.Caption:='Event: Control Change';
        EditDialog.Label10.Caption:='Controller:';
        EditDialog.Label10.Left:=64-EditDialog.Label10.Width;
        EditDialog.Control.MaxValue:=127;
        EditDialog.CVal.MaxValue:=127;
        EditDialog.Control.Value:=E^.BParm1;
        EditDialog.CVal.Value:=E^.BParm2;
        EditDialog.PageControl1.TabIndex:=7;
        EditDialog.ChangeHeight(1);
      end;
    12: begin
      EditDialog.Caption:='Event: Program Change';
      EditDialog.ChnChange(Sender);
      EditDialog.CProgram.ItemIndex:=E^.BParm1;
      EditDialog.PageControl1.TabIndex:=3;
      EditDialog.ChangeHeight(1);
    end;
    13: begin
      EditDialog.Caption:='Event: Channel Aftertouch';
      EditDialog.Label6.Visible:=False;
      EditDialog.ANote.Visible:=False;
      EditDialog.Pressure.Position:=E^.BParm1;
      EditDialog.PrLabel.Caption:=IntToStr(E^.BParm1);
      EditDialog.PageControl1.TabIndex:=4;
      EditDialog.ChangeHeight(1);
    end;
    14: begin
      EditDialog.Caption:='Event: Pitch Bend';
      EditDialog.PitchBend.Position:=E^.Value;
      EditDialog.PbLabel.Caption:=IntToStr(E^.Value);
      EditDialog.PageControl1.TabIndex:=5;
      EditDialog.ChangeHeight(1);
    end;
    15: begin
      EditDialog.Chn.Visible:=False;
      EditDialog.StaticText2.Visible:=False;
      case E^.Status and 15 of
        0,7: begin
          EditDialog.Caption:='Event: '+SystemTable[E^.Status and 15];
          SetLength(EditDialog.HexArray, Length(E^.DataArray));
          for I:=0 to Length(E^.DataArray)-1 do
            EditDialog.HexArray[I]:=E^.DataArray[I];
          EditDialog.FillHex;
          EditDialog.PageControl1.TabIndex:=11;
          EditDialog.ChangeHeight(4);
        end;
        1: begin
          EditDialog.Caption:='Event: '+SystemTable[E^.Status and 15];
          EditDialog.Label10.Caption:='Msg type:';
          EditDialog.Label10.Left:=64-EditDialog.Label10.Width;
          EditDialog.Control.MaxValue:=7;
          EditDialog.CVal.MaxValue:=15;
          EditDialog.Control.Value:=E^.BParm1 shr 4;
          EditDialog.CVal.Value:=E^.BParm1 and 15;
          EditDialog.PageControl1.TabIndex:=7;
          EditDialog.ChangeHeight(1);
        end;
        2: begin
          EditDialog.Caption:='Event: '+SystemTable[E^.Status and 15];
          EditDialog.CtrlValue.MaxValue:=16383;
          EditDialog.CtrlValue.Value:=E^.Value;
          EditDialog.PageControl1.TabIndex:=9;
          EditDialog.ChangeHeight(1);
        end;
        3: begin
          EditDialog.Caption:='Event: '+SystemTable[E^.Status and 15];
          EditDialog.CtrlValue.MaxValue:=127;
          EditDialog.CtrlValue.Value:=E^.BParm1;
          EditDialog.PageControl1.TabIndex:=9;
          EditDialog.ChangeHeight(1);
        end;
        4..6,8..14: begin
          EditDialog.Caption:='Event: '+SystemTable[E^.Status and 15];
          EditDialog.PageControl1.TabIndex:=2;
          EditDialog.ChangeHeight(0);
        end;
        15:
        case E^.BParm1 of
          0: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.CtrlValue.MaxValue:=65535;
            EditDialog.CtrlValue.Value:=E^.Value;
            EditDialog.PageControl1.TabIndex:=9;
            EditDialog.ChangeHeight(1);
          end;
          1..7: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.StrEdit.Text:=E^.DataString;
            EditDialog.PageControl1.TabIndex:=6;
            EditDialog.ChangeHeight(4);
          end;
          32: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.Chn.Visible:=True;
            EditDialog.StaticText2.Visible:=True;
            EditDialog.Chn.ItemIndex:=E^.Value;
            EditDialog.PageControl1.TabIndex:=2;
            EditDialog.ChangeHeight(0);
          end;
          33: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.CtrlValue.MaxValue:=255;
            EditDialog.CtrlValue.Value:=E^.Value;
            EditDialog.PageControl1.TabIndex:=9;
            EditDialog.ChangeHeight(1);
          end;
          47: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.PageControl1.TabIndex:=2;
            EditDialog.ChangeHeight(0);
          end;
          81: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.CtrlValue.MaxValue:=16777215;
            EditDialog.CtrlValue.Value:=E^.Value;
            EditDialog.PageControl1.TabIndex:=9;
            EditDialog.ChangeHeight(1);
          end;
          84: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.S_H.Value:=E^.DataArray[0];
            EditDialog.S_M.Value:=E^.DataArray[1];
            EditDialog.S_S.Value:=E^.DataArray[2];
            EditDialog.S_F.Value:=E^.DataArray[3];
            EditDialog.S_FF.Value:=E^.DataArray[4];
            EditDialog.PageControl1.TabIndex:=12;
            EditDialog.ChangeHeight(2);
          end;
          88: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.T_N.Value:=E^.DataArray[0];
            EditDialog.T_D.Value:=E^.DataArray[1];
            EditDialog.T_C.Value:=E^.DataArray[2];
            EditDialog.T_32.Value:=E^.DataArray[3];
            EditDialog.PageControl1.TabIndex:=13;
            EditDialog.ChangeHeight(2);
          end;
          89: begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            EditDialog.KeyVal.Value:=ShortInt(E^.DataArray[0]);
            EditDialog.KeyRadio.ItemIndex:=E^.DataArray[1];
            EditDialog.KeyValChange(Sender);
            EditDialog.PageControl1.TabIndex:=14;
            EditDialog.ChangeHeight(2);
          end;
          else begin
            EditDialog.Caption:='Event: '+MetaTable[E^.BParm1];
            SetLength(EditDialog.HexArray, Length(E^.DataArray));
            for I:=0 to Length(E^.DataArray)-1 do
              EditDialog.HexArray[I]:=E^.DataArray[I];
            EditDialog.FillHex;
            EditDialog.PageControl1.TabIndex:=11;
            EditDialog.ChangeHeight(4);
          end;
        end;
      end;
    end;
  end;
  if EditDialog.ShowModal<>mrOk then Exit;

  E^.Ticks:=EditDialog.DeltaTime.Value;
  if (E^.Status shr 4)<15 then
    E^.Status:=(E^.Status and $F0) or EditDialog.Chn.ItemIndex;

  case E^.Status shr 4 of
    8:
      if EditDialog.Chn.ItemIndex<>9 then
        E^.BParm1:=127-EditDialog.Note.ItemIndex
      else
        E^.BParm1:=EditDialog.Note.ItemIndex;
    9: begin
      if EditDialog.Chn.ItemIndex<>9 then
        E^.BParm1:=127-EditDialog.Note.ItemIndex
      else
        E^.BParm1:=EditDialog.Note.ItemIndex;
      E^.BParm2:=EditDialog.Velocity.Position;
      if EventProfile = 'xmi' then
        E^.Len := EditDialog.NoteDur.Value;
    end;
    10: begin
      if EditDialog.Chn.ItemIndex<>9 then
        E^.BParm1:=127-EditDialog.ANote.ItemIndex
      else
        E^.BParm1:=EditDialog.ANote.ItemIndex;
      E^.BParm2:=EditDialog.Pressure.Position;
    end;
    11:
      if EditDialog.Caption<>'Event: Control Change' then
        case E^.BParm1 of
          7,8,10,39,40,42:
            E^.BParm2:=EditDialog.Level.Position;
          64..69,122:
            case EditDialog.Switch.ItemIndex of
              0: E^.BParm2:=0;
              1: E^.BParm2:=127;
            end;
          84:
            if EditDialog.Chn.ItemIndex<>9 then
              E^.BParm2:=127-EditDialog.Note.ItemIndex
            else
              E^.BParm2:=EditDialog.Note.ItemIndex;
          103:
            E^.BParm2:=EditDialog.Switch.ItemIndex;
          else
            E^.BParm2:=EditDialog.CtrlValue.Value;
        end
      else begin
        E^.BParm1:=EditDialog.Control.Value;
        E^.BParm2:=EditDialog.CVal.Value;
      end;
    12:
      E^.BParm1:=EditDialog.CProgram.ItemIndex;
    13:
      E^.BParm1:=EditDialog.Pressure.Position;
    14:
      E^.Value:=EditDialog.PitchBend.Position;
    15:
      case E^.Status and 15 of
        0: begin
          SetLength(E^.DataArray, Length(EditDialog.HexArray));
          for I:=0 to Length(EditDialog.HexArray)-1 do
            E^.DataArray[I]:=EditDialog.HexArray[I];
          if E^.DataArray[Length(E^.DataArray)-1]<>$F7 then begin
            SetLength(E^.DataArray, Length(E^.DataArray)+1);
            E^.DataArray[Length(E^.DataArray)-1]:=$F7;
          end;
        end;
        7: begin
          SetLength(E^.DataArray, Length(EditDialog.HexArray));
          for I:=0 to Length(EditDialog.HexArray)-1 do
            E^.DataArray[I]:=EditDialog.HexArray[I];
        end;
        1: E^.BParm1:=EditDialog.CVal.Value or (EditDialog.Control.Value shl 4);
        2: E^.Value:=EditDialog.CtrlValue.Value;
        3: E^.BParm1:=EditDialog.CtrlValue.Value;
        15:
        case E^.BParm1 of
          0,33,81:
            E^.Value:=EditDialog.CtrlValue.Value;
          1..7: begin
            E^.DataString:=EditDialog.StrEdit.Text;
            E^.Len:=Length(E^.DataString);
          end;
          32:
            E^.Value:=EditDialog.Chn.ItemIndex;
          84: begin
            E^.DataArray[0]:=EditDialog.S_H.Value;
            E^.DataArray[1]:=EditDialog.S_M.Value;
            E^.DataArray[2]:=EditDialog.S_S.Value;
            E^.DataArray[3]:=EditDialog.S_F.Value;
            E^.DataArray[4]:=EditDialog.S_FF.Value;
          end;
          88: begin
            E^.DataArray[0]:=EditDialog.T_N.Value;
            E^.DataArray[1]:=EditDialog.T_D.Value;
            E^.DataArray[2]:=EditDialog.T_C.Value;
            E^.DataArray[3]:=EditDialog.T_32.Value;
          end;
          89: begin
            ShortInt(E^.DataArray[0]):=EditDialog.KeyVal.Value;
            E^.DataArray[1]:=EditDialog.KeyRadio.ItemIndex;
          end;
          else begin
            SetLength(E^.DataArray, Length(EditDialog.HexArray));
            for I:=0 to Length(EditDialog.HexArray)-1 do
              E^.DataArray[I]:=EditDialog.HexArray[I];
          end;
        end;
      end;
  end;
  FillEvents(Trk);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.BMoveDownClick(Sender: TObject);
var
  C: Command;
begin
  C:=TrackData[TrkCh.ItemIndex].Data[Events.Row];
  TrackData[TrkCh.ItemIndex].Data[Events.Row]:=
  TrackData[TrkCh.ItemIndex].Data[Events.Row-1];
  TrackData[TrkCh.ItemIndex].Data[Events.Row-1]:=C;
  FillEvents(TrkCh.ItemIndex);
  Events.Row:=Events.Row+1;
  ChkButtons;
end;

procedure TMainForm.BMoveUpClick(Sender: TObject);
var
  C: Command;
begin
  C:=TrackData[TrkCh.ItemIndex].Data[Events.Row-2];
  TrackData[TrkCh.ItemIndex].Data[Events.Row-2]:=
  TrackData[TrkCh.ItemIndex].Data[Events.Row-1];
  TrackData[TrkCh.ItemIndex].Data[Events.Row-1]:=C;
  FillEvents(TrkCh.ItemIndex);
  Events.Row:=Events.Row-1;
  ChkButtons;
end;

procedure TMainForm.OnEventChange(var Msg: TMessage);
begin
  if Msg.LParam <> TrkCh.ItemIndex then
    Exit;
  vEvntIndex := Msg.WParam;
  vTrkIndex := Msg.LParam;
  vChangeEvent := True;
end;

procedure TMainForm.OnTrackChange(var Msg: TMessage);
begin
  vTrkIndex := Msg.WParam;
  vChangeTrack := True;
end;

procedure TMainForm.OnVUChange(var Msg: TMessage);
begin
  if not Msg.WParam in [0..15] then
    Exit;
  if not Msg.LParam in [0..127] then
    Exit;
  if VU[Msg.WParam] < Msg.LParam then
    VU[Msg.WParam] := Msg.LParam;
end;

procedure NtDelayExecution(Alertable:boolean;Interval:PInt64); stdcall; external 'ntdll.dll';

procedure MIDIPlayer; stdcall;
label
  stop;
var
  I, Idx: Integer;
  Buf: Array of Byte;
  MIDIData: MIDIHDR;
  Ver: Word;
begin
  Idx := -1;
  I := 0;
  if not SongData_GetWord('MIDIType', Ver) then
    goto stop;
  while I < Length(PlayData) do begin
    if MIDIThrId = 0 then
      Break;
    if (Ver <> 1) and (Idx <> PlayData[I].PlayerInfo.TrackID) then begin
      Idx := PlayData[I].PlayerInfo.TrackID;
      PostMessage(MainForm.Handle, WM_TRACKIDX, Idx, 0);
    end;
    if PlayData[I].PlayerInfo.Notify then
      PostMessage(MainForm.Handle, WM_EVENTIDX,
      PlayData[I].PlayerInfo.TrackPos, PlayData[I].PlayerInfo.TrackID);
    if PlayData[I].Ticks > 0 then begin
      timeBeginPeriod(1);
      NtDelayExecution(false, @PlayData[I].PlayerInfo.MSec);
      timeEndPeriod(1);
    end;
    if LoopEnabled and ((I = LoopEnd) or (I = Length(PlayData) - 1)) then
      I := LoopPoint;
    if PlayData[I].PlayerInfo.Send then begin
      if midiOutShortMsg(MIDIOut, PlayData[I].PlayerInfo.Cmd) <> MMSYSERR_NOERROR then
        Break;
      if PlayData[I].Status shr 4 = 9 then begin
        PostMessage(MainForm.Handle, WM_SETVU, PlayData[I].Status and $F, PlayData[I].BParm2);
      end;
    end else
      if ((PlayData[I].Status = $F0)
      or ((PlayData[I].Status = $FF) and (PlayData[I].BParm1 = $7F)))
      and (Length(PlayData[I].DataArray) > 0)
      then begin
        if PlayData[I].DataArray[Length(PlayData[I].DataArray) - 1] = $F7 then begin
          SetLength(Buf, Length(PlayData[I].DataArray) + 1);
          Buf[0] := $F0;
          Move(PlayData[I].DataArray[0], Buf[1], Length(PlayData[I].DataArray));
        end else begin
          SetLength(Buf, Length(PlayData[I].DataArray) + 2);
          Buf[0] := $F0;
          Move(PlayData[I].DataArray[0], Buf[1], Length(PlayData[I].DataArray));
          Buf[Length(Buf) - 1] := $F7;
        end;
        FillChar(MIDIData, SizeOf(MIDIData), 0);
        MIDIData.lpData := @Buf[0];
        MIDIData.dwBufferLength := Length(Buf);
        MIDIData.dwBytesRecorded := Length(Buf);
        if midiOutPrepareHeader(MIDIOut, @MIDIData, SizeOf(MIDIData)) <> MMSYSERR_NOERROR then
          Break;
        if midiOutLongMsg(MIDIOut, @MIDIData, SizeOf(MIDIData)) <> MMSYSERR_NOERROR then
          Break;
      end;
    Inc(I);
  end;
stop:
  midiOutClose(MIDIOut);
  MIDIThrId := 0;
end;

procedure TMainForm.bPlayClick(Sender: TObject);
var
  Err: DWORD;
  NewMIDIOut: THandle;
  Ver, Division: Word;
  InitTempo: Cardinal;
  UseTempo: Boolean;
  Tempo, MSPT: Cardinal;

  procedure MixType0;
  var
    I: Integer;
  begin
    SetLength(PlayData, Length(TrackData[0].Data));
    for I := 0 to Length(PlayData) - 1 do begin
      PlayData[I] := TrackData[0].Data[I];
      PlayData[I].PlayerInfo.TrackID := 0;
      PlayData[I].PlayerInfo.TrackPos := I;
      PlayData[I].PlayerInfo.Notify := PlayData[I].Ticks > 0;
      PlayData[I].PlayerInfo.MSec := -10 * PlayData[I].Ticks * MSPT;

      // Loop Start (XMI)
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $74)
      and (PlayData[I].BParm2 = $00)
      then
        LoopPoint := I;
      // Loop End (XMI)
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $75)
      and (PlayData[I].BParm2 = $7F)
      then
        LoopEnd := I;
      // Loop Point Start
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $76)
      and (PlayData[I].BParm2 = $00)
      then
        LoopPoint := I;
      // Loop Point End
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $76)
      and (PlayData[I].BParm2 = $7F)
      then
        LoopEnd := I;
      case PlayData[I].Status shr 4 of
        8, 9, 10, 11, 14: begin
          PlayData[I].PlayerInfo.Send := True;
          PlayData[I].PlayerInfo.Cmd :=
          PlayData[I].Status
          or (PlayData[I].BParm1 shl 8)
          or (PlayData[I].BParm2 shl 16);
        end;
        12, 13: begin
          PlayData[I].PlayerInfo.Send := True;
          PlayData[I].PlayerInfo.Cmd :=
          PlayData[I].Status
          or (PlayData[I].BParm1 shl 8);
        end;
        15: begin
          PlayData[I].PlayerInfo.Send := False;
          // System
          case PlayData[I].Status and 15 of
            // Meta Event
            15: begin
              case PlayData[I].BParm1 of
                // Tempo
                81: begin
                  if UseTempo then begin
                    Tempo := PlayData[I].Value;
                    MSPT := Round(Tempo / Division);
                  end;
                end;
              end;
            end;
          end;
          if EventProfile = 'mus' then begin
            if (PlayData[I].Status = $F0)
            and (PlayData[I].Len = 5)
            and (PlayData[I].DataArray[0] = $7F) then begin
              // Set Speed
              if ((PlayData[I].DataArray[3] / 128) +
              PlayData[I].DataArray[2]) <> 0 then
                Tempo :=
                Round(InitTempo / ((PlayData[I].DataArray[3] / 128) + PlayData[I].DataArray[2]))
              else
                Tempo := InitTempo;
              MSPT := Round(Tempo / Division);
            end;
          end;
        end;
      end;

    end;
    if Length(PlayData) > 0 then
      PlayData[0].PlayerInfo.Notify := True;
  end;

  procedure MixType1;
  var
    I, Idx: Integer;
    MinTick, Tick: UInt64;
    Positions: Array of UInt64;
    function GetTick(Idx: Integer; var Tick: UInt64): Boolean;
    begin
      Result := False;
      if Positions[Idx] >= Length(TrackData[Idx].Data) then
        Exit;
      Tick := TrackData[Idx].Data[Positions[Idx]].Ticks;
      Result := True;
    end;
  begin
    SetLength(Positions, Length(TrackData));
    for I := 0 to Length(Positions) - 1 do
      Positions[I] := 0;
    for I := 0 to Length(TrackData) - 1 do
      ConvertTicks(True, TrackData[I].Data);
    while True do begin
      Idx := -1;
      MinTick := High(UInt64);
      for I := 0 to Length(TrackData) - 1 do
        if GetTick(I, Tick) then
          if (Idx = -1) or (Tick < MinTick) then begin
            MinTick := Tick;
            Idx := I;
          end;
      if Idx = -1 then
        Break;
      SetLength(PlayData, Length(PlayData) + 1);
      PlayData[Length(PlayData) - 1] := TrackData[Idx].Data[Positions[Idx]];
      PlayData[Length(PlayData) - 1].PlayerInfo.TrackID := Idx;
      PlayData[Length(PlayData) - 1].PlayerInfo.TrackPos := Positions[Idx];

      case PlayData[Length(PlayData) - 1].Status shr 4 of
        8, 9, 10, 11, 14: begin
          PlayData[Length(PlayData) - 1].PlayerInfo.Send := True;
          PlayData[Length(PlayData) - 1].PlayerInfo.Cmd :=
          PlayData[Length(PlayData) - 1].Status
          or (PlayData[Length(PlayData) - 1].BParm1 shl 8)
          or (PlayData[Length(PlayData) - 1].BParm2 shl 16);
        end;
        12, 13: begin
          PlayData[Length(PlayData) - 1].PlayerInfo.Send := True;
          PlayData[Length(PlayData) - 1].PlayerInfo.Cmd :=
          PlayData[Length(PlayData) - 1].Status
          or (PlayData[Length(PlayData) - 1].BParm1 shl 8);
        end;
      end;

      Inc(Positions[Idx]);
    end;
    for I := 0 to Length(TrackData) - 1 do
      ConvertTicks(False, TrackData[I].Data);
    ConvertTicks(False, PlayData);

    for I := 0 to Length(PlayData) - 1 do begin
      PlayData[I].PlayerInfo.Notify := (PlayData[I].PlayerInfo.TrackPos = 0)
      or (TrackData[PlayData[I].PlayerInfo.TrackID].Data[PlayData[I].PlayerInfo.TrackPos].Ticks > 0);
      PlayData[I].PlayerInfo.MSec := -10 * PlayData[I].Ticks * MSPT;

      // Loop Start (XMI)
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $74)
      and (PlayData[I].BParm2 = $00)
      then
        LoopPoint := I;
      // Loop End (XMI)
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $75)
      and (PlayData[I].BParm2 = $7F)
      then
        LoopEnd := I;
      // Loop Point Start
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $76)
      and (PlayData[I].BParm2 = $00)
      then
        LoopPoint := I;
      // Loop Point End
      if (PlayData[I].Status shr 4 = 11)
      and (PlayData[I].BParm1 = $76)
      and (PlayData[I].BParm2 = $7F)
      then
        LoopEnd := I;

      case PlayData[I].Status shr 4 of
        15: begin
          PlayData[I].PlayerInfo.Send := False;
          // System
          case PlayData[I].Status and 15 of
            // Meta Event
            15: begin
              case PlayData[I].BParm1 of
                // Tempo
                81: begin
                  if UseTempo then begin
                    Tempo := PlayData[I].Value;
                    MSPT := Round(Tempo / Division);
                  end;
                end;
              end;
            end;
          end;
          if EventProfile = 'mus' then begin
            if (PlayData[I].Status = $F0)
            and (PlayData[I].Len = 5)
            and (PlayData[I].DataArray[0] = $7F) then begin
              // Set Speed
              if ((PlayData[I].DataArray[3] / 128) +
              PlayData[I].DataArray[2]) <> 0 then
                Tempo :=
                Round(InitTempo / ((PlayData[I].DataArray[3] / 128) + PlayData[I].DataArray[2]))
              else
                Tempo := InitTempo;
              MSPT := Round(Tempo / Division);
            end;
          end;

        end;
      end;

    end;
  end;

  procedure MixType2;
  var
    Idx, I, J: Integer;
  begin
    Idx := 0;
    for I := 0 to Length(TrackData) - 1 do begin
      SetLength(PlayData, Length(PlayData) + Length(TrackData[I].Data));
      for J := 0 to Length(TrackData[I].Data) - 1 do begin
        PlayData[Idx] := TrackData[I].Data[J];
        PlayData[Idx].PlayerInfo.TrackID := I;
        PlayData[Idx].PlayerInfo.TrackPos := J;
        PlayData[Idx].PlayerInfo.Notify := (J = 0) or (PlayData[Idx].Ticks > 0);
        PlayData[Idx].PlayerInfo.MSec := -10 * PlayData[Idx].Ticks * MSPT;

        // Loop Start (XMI)
        if (PlayData[Idx].Status shr 4 = 11)
        and (PlayData[Idx].BParm1 = $74)
        and (PlayData[Idx].BParm2 = $00)
        then
          LoopPoint := Idx;
        // Loop End (XMI)
        if (PlayData[Idx].Status shr 4 = 11)
        and (PlayData[Idx].BParm1 = $75)
        and (PlayData[Idx].BParm2 = $7F)
        then
          LoopEnd := Idx;
        // Loop Point Start
        if (PlayData[Idx].Status shr 4 = 11)
        and (PlayData[Idx].BParm1 = $76)
        and (PlayData[Idx].BParm2 = $00)
        then
          LoopPoint := Idx;
        // Loop Point End
        if (PlayData[Idx].Status shr 4 = 11)
        and (PlayData[Idx].BParm1 = $76)
        and (PlayData[Idx].BParm2 = $7F)
        then
          LoopEnd := Idx;

        case PlayData[Idx].Status shr 4 of
          8, 9, 10, 11, 14: begin
            PlayData[Idx].PlayerInfo.Send := True;
            PlayData[Idx].PlayerInfo.Cmd :=
            PlayData[Idx].Status
            or (PlayData[Idx].BParm1 shl 8)
            or (PlayData[Idx].BParm2 shl 16);
          end;
          12, 13: begin
            PlayData[Idx].PlayerInfo.Send := True;
            PlayData[Idx].PlayerInfo.Cmd :=
            PlayData[Idx].Status
            or (PlayData[Idx].BParm1 shl 8);
          end;
          15: begin
            PlayData[Idx].PlayerInfo.Send := False;
            // System
            case PlayData[Idx].Status and 15 of
              // Meta Event
              15: begin
                case PlayData[Idx].BParm1 of
                  // Tempo
                  81: begin
                    if UseTempo then begin
                      Tempo := PlayData[Idx].Value;
                      MSPT := Round(Tempo / Division);
                    end;
                  end;
                end;
              end;
            end;
            if EventProfile = 'mus' then begin
              if (PlayData[Idx].Status = $F0)
              and (PlayData[Idx].Len = 5)
              and (PlayData[Idx].DataArray[0] = $7F) then begin
                // Set Speed
                if ((PlayData[Idx].DataArray[3] / 128) +
                PlayData[Idx].DataArray[2]) <> 0 then
                  Tempo :=
                  Round(InitTempo / ((PlayData[Idx].DataArray[3] / 128) + PlayData[Idx].DataArray[2]))
                else
                  Tempo := InitTempo;
                MSPT := Round(Tempo / Division);
              end;
            end;
          end;
        end;

        Inc(Idx);
      end;
    end;
  end;
begin
  if Length(TrackData) = 0 then
    Exit;
  if not SongData_GetWord('MIDIType', Ver) then
  begin
    Log.Lines.Add('[-] MIDI Type is not defined.');
    Exit;
  end;
  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;
  if not SongData_GetWord('Division', Division) then
  begin
    Log.Lines.Add('[-] Division is not defined.');
    Exit;
  end;

  Err := midiOutOpen(@NewMIDIOut, MIDIDev, 0, 0, CALLBACK_NULL);
  if Err <> MMSYSERR_NOERROR then
    Exit;
  MIDIOut := NewMIDIOut;

  SetLength(PlayData, 0);
  Tempo := InitTempo;
  MSPT := Round(Tempo / Division);
  UseTempo := EventProfile <> 'xmi';
  LoopPoint := 0;
  LoopEnd := -1;
  case Ver of
    0: MixType0;
    1: MixType1;
    2: MixType2;
  end;

  MIDIThr := CreateThread(nil, 0, @MIDIPlayer, nil, CREATE_SUSPENDED, MIDIThrId);
  SetThreadPriority(MIDIThr, THREAD_PRIORITY_HIGHEST);
  ResumeThread(MIDIThr);
end;

procedure TMainForm.bStopClick(Sender: TObject);
begin
  MIDIThrId := 0;
end;

function TMainForm.LoadFile(FileName, Fmt: String): Boolean;
var
  Ext: String;
  M: TMemoryStream;
begin
  Log.Lines.Add('[*] Opening file '+FileName+' ...');
  Container := '';
  if Fmt = '' then begin
    // Detect container by extension
    Ext := LowerCase(ExtractFileExt(FileName));
    if (Ext = '.mid')
    or (Ext = '.midi')
    or (Ext = '.kar')
    or (Ext = '.mdi') then begin
      Container := 'smf';
      EventFormat := 'mid';
      if (Ext <> '.mdi') then
        EventProfile := 'mid'
      else
        EventProfile := 'mdi';
    end;
    if (Ext = '.rmi')
    or (Ext = '.rmid')
    or (Ext = '.orc') then begin
      Container := 'rmi';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if (Ext = '.mds')
    or (Ext = '.mids') then begin
      Container := 'mids';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if (Ext = '.xmi') then begin
      Container := 'xmi';
      EventFormat := 'xmi';
      EventProfile := 'xmi';
    end;
    if (Ext = '.cmf') then begin
      Container := 'cmf';
      EventFormat := 'mid';
      EventProfile := 'cmf';
    end;
    if (Ext = '.mus') then begin
      Container := 'mus';
      EventFormat := 'mus';
      EventProfile := 'mus';
    end;
    if (Ext = '.raw') then begin
      Container := 'raw';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if (Ext = '.syx') then begin
      Container := 'syx';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
  end else begin
    // Container specified
    if Fmt = 'smf' then begin
      Container := 'smf';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if Fmt = 'rmi' then begin
      Container := 'rmi';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if Fmt = 'mids' then begin
      Container := 'mids';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if Fmt = 'xmi' then begin
      Container := 'xmi';
      EventFormat := 'xmi';
      EventProfile := 'xmi';
    end;
    if Fmt = 'cmf' then begin
      Container := 'cmf';
      EventFormat := 'mid';
      EventProfile := 'cmf';
    end;
    if Fmt = 'mdi' then begin
      Container := 'smf';
      EventFormat := 'mid';
      EventProfile := 'mdi';
    end;
    if Fmt = 'mus' then begin
      Container := 'mus';
      EventFormat := 'mus';
      EventProfile := 'mus';
    end;
    if Fmt = 'raw' then begin
      Container := 'raw';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
    if Fmt = 'syx' then begin
      Container := 'syx';
      EventFormat := 'mid';
      EventProfile := 'mid';
    end;
  end;

  M := TMemoryStream.Create;
  try
    M.LoadFromFile(FileName);
  except
    M.Free;
    Result := False;
    Log.Lines.Add('[-] Load file failed.');
    Exit;
  end;
  if Container = '' then
  begin
    // Detect container by data
    Container := DetectFile(M);
  end;
  EventViewProfile := EventProfile;

  if Container <> '' then
  begin
    SongData.Strings.Clear;
    if Container = 'smf' then begin
      Opened := ReadMIDI(M);
    end;
    if Container = 'rmi' then begin
      Opened := ReadRMI(M);
    end;
    if Container = 'mids' then begin
      Opened := ReadMIDS(M);
    end;
    if Container = 'xmi' then begin
      Opened := ReadXMI(M);
    end;
    if Container = 'cmf' then begin
      Opened := ReadCMF(M);
    end;
    if Container = 'mus' then begin
      Opened := ReadMUS(M, FileName);
    end;
    if Container = 'raw' then begin
      Opened := ReadRaw(M);
    end;
    if Container = 'syx' then begin
      Opened := ReadSYX(M);
    end;
    if not Opened then
      SongData.Strings.Clear;
  end else
    Log.Lines.Add('[-] Unknown file format.');
  M.Free;
  Result := Opened;
end;

function TMainForm.SaveFile(FileName: String): Boolean;
var
  Idx: Integer;
  Ext: String;
  M: TMemoryStream;
  TargetContainer, TargetEventFormat, TargetEventProfile: AnsiString;
begin
  Result := False;
  Log.Lines.Add('[*] Saving to '+FileName+'...');
  Idx := TrkCh.ItemIndex;
  Ext := LowerCase(ExtractFileExt(FileName));
  TargetContainer := '';
  TargetEventFormat := '';
  TargetEventProfile := '';
  if (Ext = '.mid')
  or (Ext = '.midi')
  or (Ext = '.kar')
  then begin
    TargetContainer := 'smf';
    TargetEventFormat := 'mid';
    TargetEventProfile := 'mid';
  end;
  if (Ext = '.rmi')
  or (Ext = '.rmid')
  then begin
    TargetContainer := 'rmi';
    TargetEventFormat := 'mid';
    TargetEventProfile := 'mid';
  end;
  if (Ext = '.mdi')
  then begin
    TargetContainer := 'smf';
    TargetEventFormat := 'mid';
    TargetEventProfile := 'mdi';
  end;
  if (Ext = '.xmi')
  then begin
    TargetContainer := 'xmi';
    TargetEventFormat := 'xmi';
    TargetEventProfile := 'xmi';
  end;
  if (Ext = '.mus')
  then begin
    TargetContainer := 'mus';
    TargetEventFormat := 'mus';
    TargetEventProfile := 'mus';
  end;
  if (Ext = '.cmf')
  then begin
    TargetContainer := 'cmf';
    TargetEventFormat := 'mid';
    TargetEventProfile := 'cmf';
  end;
  if (Ext = '.raw')
  then begin
    TargetContainer := 'raw';
    TargetEventFormat := 'mid';
    TargetEventProfile := 'mid';
  end;
  if (Ext = '.syx')
  then begin
    TargetContainer := 'syx';
    TargetEventFormat := 'mid';
    TargetEventProfile := 'mid';
  end;
  if TargetContainer = '' then
    TargetContainer := Container;
  if TargetEventFormat = '' then
    TargetEventFormat := EventFormat;
  if TargetEventProfile = '' then
    TargetEventProfile := EventProfile;

  M := TMemoryStream.Create;
  if TargetContainer = 'smf' then begin
    if TargetEventProfile = 'mid' then
      ConvertEvents('mid');
    if TargetEventProfile = 'mdi' then
      ConvertEvents('mdi');
    WriteMIDI(M);
    Result := True;
  end;
  if TargetContainer = 'rmi' then begin
    if TargetEventProfile = 'mid' then
      ConvertEvents('mid');
    WriteRMI(M);
    Result := True;
  end;
  if TargetContainer = 'xmi' then begin
    if TargetEventProfile = 'xmi' then
      ConvertEvents('xmi');
    WriteXMI(M);
    Result := True;
  end;
  if TargetContainer = 'cmf' then begin
    if TargetEventProfile = 'cmf' then
      ConvertEvents('cmf');
    WriteCMF(M);
    Result := True;
  end;
  if TargetContainer = 'mus' then begin
    if TargetEventProfile = 'mus' then
      ConvertEvents('mus');
    WriteMUS(M, FileName);
    Result := True;
  end;
  if TargetContainer = 'raw' then begin
    if TargetEventFormat = 'mid' then
      EventFormat := 'mid';
    if TargetEventProfile = 'mid' then
      ConvertEvents('mid');
    WriteRaw(M);
    Result := True;
  end;
  if TargetContainer = 'syx' then begin
    WriteSYX(M);
    Result := True;
  end;
  try
    if Result then
      M.SaveToFile(FileName);
  except
    Result := False;
  end;
  if Result then
    Log.Lines.Add('[+] Saved.')
  else
    Log.Lines.Add('[-] Save failed.');
  M.Free;
  RefTrackList;
  TrkCh.ItemIndex := Idx;
  if (TrkCh.Items.Count > 0) and (TrkCh.ItemIndex = -1) then
    TrkCh.ItemIndex := 0;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

function TMainForm.DetectFile(var F: TMemoryStream): String;
begin
  Result := '';
  if DetectMIDI(F) then
  begin
    Result := 'smf';
    EventFormat := 'mid';
    EventProfile := 'mid';
    Exit;
  end;
  if DetectRMI(F) then
  begin
    Result := 'rmi';
    EventFormat := 'mid';
    EventProfile := 'mid';
    Exit;
  end;
  if DetectMIDS(F) then
  begin
    Result := 'mids';
    EventFormat := 'mid';
    EventProfile := 'mid';
    Exit;
  end;
  if DetectXMI(F) then
  begin
    Result := 'xmi';
    EventFormat := 'xmi';
    EventProfile := 'xmi';
    Exit;
  end;
  if DetectCMF(F) then
  begin
    Result := 'cmf';
    EventFormat := 'mid';
    EventProfile := 'cmf';
    Exit;
  end;
  if DetectMUS(F) then
  begin
    Result := 'mus';
    EventFormat := 'mus';
    EventProfile := 'mus';
    Exit;
  end;
end;

procedure TMainForm.BtOpenClick(Sender: TObject);
var
  Fmt, FilterExt: String;
  Filter: TStringList;
begin
  if not OpenDialog.Execute then
    Exit;
  Log.Clear;
  Fmt := '';
  if OpenDialog.FilterIndex > 1 then
  begin
    Filter := TStringList.Create;
    Filter.Delimiter := '|';
    Filter.StrictDelimiter := True;
    Filter.DelimitedText := OpenDialog.Filter;
    FilterExt := Filter[OpenDialog.FilterIndex*2 - 1];
    Filter.Free;

    if Pos('*.mid', FilterExt) > 0 then
      Fmt := 'smf';
    if Pos('*.rmi', FilterExt) > 0 then
      Fmt := 'rmi';
    if Pos('*.mds', FilterExt) > 0 then
      Fmt := 'mids';
    if Pos('*.xmi', FilterExt) > 0 then
      Fmt := 'xmi';
    if Pos('*.cmf', FilterExt) > 0 then
      Fmt := 'cmf';
    if Pos('*.mus', FilterExt) > 0 then
      Fmt := 'mus';
    if Pos('*.mdi', FilterExt) > 0 then
      Fmt := 'mdi';
    if Pos('*.raw', FilterExt) > 0 then
      Fmt := 'raw';
    if Pos('*.syx', FilterExt) > 0 then
      Fmt := 'syx';
  end;
  LoadFile(OpenDialog.FileName, Fmt);
  if TrkCh.Items.Count > 0 then begin
    TrkCh.ItemIndex := 0;
    FillEvents(TrkCh.ItemIndex);
  end;
  ChkButtons;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Filter: TStringList;
  AllStr: String;
  I: Integer;
begin
  imgVU.Canvas.Pen.Color := clBlack;
  imgVU.Canvas.Brush.Color := clBlack;
  imgVU.Canvas.FillRect(imgVU.Canvas.ClipRect);

  SongData := TValueListEditor.Create(nil);

  Filter := TStringList.Create;
  Filter.Delimiter := '|';
  Filter.StrictDelimiter := True;
  Filter.DelimitedText := OpenDialog.Filter;
  AllStr := '';
  for I := 1 to Filter.Count div 2 - 1 do
    AllStr := AllStr + Filter[I*2 + 1] + ';';
  Delete(AllStr, Length(AllStr), 1);
  Filter.Free;
  OpenDialog.Filter :=
    StringReplace(OpenDialog.Filter, '||', '|'+AllStr+'|', []);

  SearchEv.dtOp := 0;
  SearchEv.dt := 0;
  SearchEv.chan := $FF;
  SearchEv.evnt := 0;
  SearchEv.v1Op := 1;
  SearchEv.v1 := 48;
  SearchEv.v2Op := 1;
  SearchEv.v2 := 127;
  SearchEv.Text := '';

  MW32RefreshClick(Sender);
  ChkButtons;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SongData.Free;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if ClientWidth-300>=0 then
    Progress.Width:=ClientWidth-300
  else
    Progress.Width:=0;
  Progress.Top:=ClientHeight-17;
  panToolbar.Width := panMiddle.Width;
end;

procedure TMainForm.TrkChChange(Sender: TObject);
begin
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
end;

procedure TMainForm.EventsClick(Sender: TObject);
begin
  ChkButtons;
end;

procedure TMainForm.EventsKeyPress(Sender: TObject; var Key: Char);
begin
  ChkButtons;
end;

procedure TMainForm.EventsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Events.ColCount=5 then begin
    WidTable[0]:=Events.ColWidths[0];
    WidTable[1]:=Events.ColWidths[1];
    WidTable[2]:=Events.ColWidths[2];
    WidTable[3]:=Events.ColWidths[3];
    WidTable[4]:=Events.ColWidths[4];
  end;
end;

procedure TMainForm.MExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MFindClick(Sender: TObject);
begin
  EditDialog.PageControl1.TabIndex:=17;
  EditDialog.ChangeHeight(4);
  EditDialog.ETypeChange(Sender);
  EditDialog.StaticText1.Visible:=False;
  EditDialog.StaticText2.Visible:=False;
  EditDialog.DeltaTime.Visible:=False;
  EditDialog.Chn.Visible:=False;
  EditDialog.Caption:='Find event';

  EditDialog.EDelta.Value := SearchEv.dt;
  EditDialog.ETickOp.ItemIndex := SearchEv.dtOp;
  case SearchEv.evnt of
    $8: EditDialog.EType.ItemIndex := 1;
    $9: EditDialog.EType.ItemIndex := 0;
    $A: EditDialog.EType.ItemIndex := 5;
    $B: EditDialog.EType.ItemIndex := 4;
    $C: EditDialog.EType.ItemIndex := 3;
    $D: EditDialog.EType.ItemIndex := 6;
    $E: EditDialog.EType.ItemIndex := 2;
    $F: EditDialog.EType.ItemIndex := 7;
    else
       EditDialog.EType.ItemIndex := 0;
  end;
  if SearchEv.chan = $FF then
    EditDialog.FChn.ItemIndex := 0
  else
    EditDialog.FChn.ItemIndex := SearchEv.chan + 1;
  EditDialog.ETypeChange(Sender);
  EditDialog.EVal1Op.ItemIndex := SearchEv.v1Op;
  EditDialog.EVal2Op.ItemIndex := SearchEv.v2Op;
  case SearchEv.evnt of
    $8, $9, $A:
    begin
      if SearchEv.chan = 9 then
        EditDialog.EVal1.ItemIndex := SearchEv.v1
      else
        EditDialog.EVal1.ItemIndex := 127 - SearchEv.v1;
      EditDialog.seVal2.Value := SearchEv.v2;
    end;
    $B:
    begin
      EditDialog.EVal1.ItemIndex := SearchEv.v1;
      EditDialog.seVal2.Value := SearchEv.v2;
    end;
    $C:
      EditDialog.EVal1.ItemIndex := SearchEv.v1;
    $D, $E:
      EditDialog.seVal1.Value := SearchEv.v1;
    $F:
    begin
      EditDialog.EVal1.ItemIndex := SearchEv.v1;
      EditDialog.EVal1Change(Sender);
      case SearchEv.v1 of
        2, 3: EditDialog.seVal2.Value := SearchEv.v2;
        15:
        begin
          EditDialog.EVal2.ItemIndex := SearchEv.v2;
          EditDialog.EVal2Change(Sender);
        end;
      end;
    end;
  end;
  EditDialog.EText.Text := SearchEv.Text;

  if EditDialog.ShowModal <> mrOk then
    Exit;

  SearchEv.dtOp := EditDialog.ETickOp.ItemIndex;
  SearchEv.dt := EditDialog.EDelta.Value;
  case EditDialog.EType.ItemIndex of
    0: SearchEv.evnt := $9;
    1: SearchEv.evnt := $8;
    2: SearchEv.evnt := $E;
    3: SearchEv.evnt := $C;
    4: SearchEv.evnt := $B;
    5: SearchEv.evnt := $A;
    6: SearchEv.evnt := $D;
    7: SearchEv.evnt := $F;
  end;
  if EditDialog.FChn.ItemIndex < 1 then
    SearchEv.chan := $FF
  else
    SearchEv.chan := EditDialog.FChn.ItemIndex - 1;
  SearchEv.v1Op := EditDialog.EVal1Op.ItemIndex;
  SearchEv.v2Op := EditDialog.EVal2Op.ItemIndex;
  case SearchEv.evnt of
    $8, $9, $A:
    begin
      if SearchEv.chan = 9 then
        SearchEv.v1 := EditDialog.EVal1.ItemIndex
      else
        SearchEv.v1 := 127 - EditDialog.EVal1.ItemIndex;
      SearchEv.v2 := EditDialog.seVal2.Value;
    end;
    $B:
    begin
      SearchEv.v1 := EditDialog.EVal1.ItemIndex;
      SearchEv.v2 := EditDialog.seVal2.Value;
    end;
    $C:
      SearchEv.v1 := EditDialog.EVal1.ItemIndex;
    $D, $E:
      SearchEv.v1 := EditDialog.seVal1.Value;
    $F:
    begin
      SearchEv.v1 := EditDialog.EVal1.ItemIndex;
      case SearchEv.v1 of
        2, 3: SearchEv.v2 := EditDialog.seVal2.Value;
        15: SearchEv.v2 := EditDialog.EVal2.ItemIndex;
      end;
    end;
  end;
  SearchEv.Text := EditDialog.EText.Text;
  MFindNext.Enabled := SearchEv.evnt >= 8;
  MFindNextClick(Sender);
end;

procedure TMainForm.MFindNextClick(Sender: TObject);
var
  I, J: Integer;
  Ev: Command;
  Found: Boolean;
begin
  if SearchEv.evnt < 8 then
    Exit;
  I := TrkCh.ItemIndex;
  while I < Length(TrackData) do
  begin
    if I = TrkCh.ItemIndex then
      J := Events.Row // search from next event
    else
      J := 0;
    while J < Length(TrackData[I].Data) do
    begin
      Ev := TrackData[I].Data[J];
      // check event
      Found := Ev.Status shr 4 = SearchEv.evnt;
      // check delta time
      if Found
      and (SearchEv.dtOp > 0) then
        case SearchEv.dtOp of
          1: // equal
            Found := Ev.Ticks = SearchEv.dt;
          2: // not equal
            Found := Ev.Ticks <> SearchEv.dt;
          3: // greater
            Found := Ev.Ticks > SearchEv.dt;
          4: // less
            Found := Ev.Ticks < SearchEv.dt;
          5: // greater or equal
            Found := Ev.Ticks >= SearchEv.dt;
          6: // less or equal
            Found := Ev.Ticks <= SearchEv.dt;
        end;
      // check channel
      if Found
      and (SearchEv.evnt < $F)
      and (SearchEv.chan <= $F) then
        Found := Ev.Status and $F = SearchEv.chan;
      // check values
      if Found
      and (SearchEv.evnt in [$8, $9, $A, $B, $C, $D])
      and (SearchEv.v1Op > 0) then
        case SearchEv.v1Op of
          1: // equal
            Found := Ev.BParm1 = SearchEv.v1;
          2: // not equal
            Found := Ev.BParm1 <> SearchEv.v1;
          3: // greater
            Found := Ev.BParm1 > SearchEv.v1;
          4: // less
            Found := Ev.BParm1 < SearchEv.v1;
          5: // greater or equal
            Found := Ev.BParm1 >= SearchEv.v1;
          6: // less or equal
            Found := Ev.BParm1 <= SearchEv.v1;
        end;
      if Found
      and (SearchEv.evnt in [$8, $9, $A, $B])
      and (SearchEv.v2Op > 0) then
        case SearchEv.v2Op of
          1: // equal
            Found := Ev.BParm2 = SearchEv.v2;
          2: // not equal
            Found := Ev.BParm2 <> SearchEv.v2;
          3: // greater
            Found := Ev.BParm2 > SearchEv.v2;
          4: // less
            Found := Ev.BParm2 < SearchEv.v2;
          5: // greater or equal
            Found := Ev.BParm2 >= SearchEv.v2;
          6: // less or equal
            Found := Ev.BParm2 <= SearchEv.v2;
        end;
      if Found
      and (SearchEv.evnt = $E)
      and (SearchEv.v1Op > 0) then
        case SearchEv.v1Op of
          1: // equal
            Found := Ev.Value = SearchEv.v1;
          2: // not equal
            Found := Ev.Value <> SearchEv.v1;
          3: // greater
            Found := Ev.Value > SearchEv.v1;
          4: // less
            Found := Ev.Value < SearchEv.v1;
          5: // greater or equal
            Found := Ev.Value >= SearchEv.v1;
          6: // less or equal
            Found := Ev.Value <= SearchEv.v1;
        end;
      if Found
      and (SearchEv.evnt = $F) then
      begin
        Found := Ev.Status and $F = SearchEv.v1;
        if Found
        and (SearchEv.v1 in [2, 3])
        and (SearchEv.v2Op > 0) then
          case SearchEv.v2Op of
            1: // equal
              Found := Ev.BParm1 = SearchEv.v2;
            2: // not equal
              Found := Ev.BParm1 <> SearchEv.v2;
            3: // greater
              Found := Ev.BParm1 > SearchEv.v2;
            4: // less
              Found := Ev.BParm1 < SearchEv.v2;
            5: // greater or equal
              Found := Ev.BParm1 >= SearchEv.v2;
            6: // less or equal
              Found := Ev.BParm1 <= SearchEv.v2;
          end;
        if Found
        and (SearchEv.v1 = $F) then
        begin
          Found := Ev.BParm1 = SearchEv.v2;
          if Found
          and (SearchEv.v2 in [1..7])
          and (SearchEv.Text <> '') then
            Found := Pos(SearchEv.Text, Ev.DataString) > 0;
        end;
      end;

      if Found then
      begin
        TrkCh.ItemIndex := I;
        TrkChChange(Sender);
        Events.Row := J + 1;
        Exit;
      end;
      Inc(J);
    end;
    Inc(I);
  end;
  Log.Lines.Add('[*] Search complete.');
end;

procedure TMainForm.MReplaceClick(Sender: TObject);
begin
  MessageBox(Handle, 'This feature is not implemented yet.', 'Notice', mb_Ok or mb_IconWarning);
end;

procedure TMainForm.MFormatMIDClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TrkCh.ItemIndex;
  ConvertEvents('mid');
  RefTrackList;
  TrkCh.ItemIndex := Idx;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MFormatMDIClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TrkCh.ItemIndex;
  ConvertEvents('mdi');
  RefTrackList;
  TrkCh.ItemIndex := Idx;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MFormatCMFClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TrkCh.ItemIndex;
  ConvertEvents('cmf');
  RefTrackList;
  TrkCh.ItemIndex := Idx;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MFormatXMIClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TrkCh.ItemIndex;
  ConvertEvents('xmi');
  RefTrackList;
  TrkCh.ItemIndex := Idx;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MFormatMUSClick(Sender: TObject);
var
  Idx: Integer;
begin
  Idx := TrkCh.ItemIndex;
  ConvertEvents('mus');
  RefTrackList;
  TrkCh.ItemIndex := Idx;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.FillEvents(Idx: Integer);
var
  I,J: Integer;
  S: String;
  Speed: Double;
  Rhythm: Boolean;
  InitTempo: Cardinal;
begin
  if (Idx < 0) or (Idx >= Length(TrackData)) then
    Exit;
  if Length(TrackData[Idx].Data) = 0 then begin
    Events.ColCount := 1;
    Events.RowCount := 1;
    Events.DefaultColWidth := 64;
    Events.Cells[0,0] := 'No events';
    Exit;
  end;
  Events.ColCount := 5;
  Events.RowCount := Length(TrackData[Idx].Data)+1;
  Events.FixedCols := 1;
  Events.FixedRows := 1;
  Events.DefaultColWidth := 64;
  Events.Cells[0,0] := '#';
  Events.Cells[1,0] := 'Delta-time';
  Events.Cells[2,0] := 'Chn';
  Events.Cells[3,0] := 'Event';
  Events.Cells[4,0] := 'Data';
  Events.ColWidths[0] := WidTable[0];
  Events.ColWidths[1] := WidTable[1];
  Events.ColWidths[2] := WidTable[2];
  Events.ColWidths[3] := WidTable[3];
  Events.ColWidths[4] := WidTable[4];

  if not SongData_GetDWord('InitTempo', InitTempo) then
  begin
    Log.Lines.Add('[-] Initial Tempo is not defined.');
    Exit;
  end;

  Rhythm := False;
  if EventViewProfile = 'mus' then
    if SongData_GetInt('MUS_Percussive', I) then
      Rhythm := I > 0;

  for I := 0 to Length(TrackData[Idx].Data) - 1 do begin
    Events.Cells[0,I+1] := IntToStr(I+1);
    Events.Cells[1,I+1] := IntToStr(TrackData[Idx].Data[I].Ticks);
    Events.Cells[2,I+1] := '';
    Events.Cells[4,I+1] := '';
    if (TrackData[Idx].Data[I].Status shr 4) < 15 then
      Events.Cells[2,I+1] := IntToStr(TrackData[Idx].Data[I].Status and 15 + 1);

    case TrackData[Idx].Data[I].Status shr 4 of
      8: begin // NoteOff
        Events.Cells[3,I+1]:='Note Off';
        if (TrackData[Idx].Data[I].Status and 15)<>9 then
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+NoteNum(TrackData[Idx].Data[I].BParm1)+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2)
        else
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+DrumTable[TrackData[Idx].Data[I].BParm1]+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2);
      end;
      9: begin // NoteOn
        if TrackData[Idx].Data[I].BParm2 > 0 then
          Events.Cells[3,I+1]:='Note On'
        else
          Events.Cells[3,I+1]:='Note Off';
        if (TrackData[Idx].Data[I].Status and 15)<>9 then
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+NoteNum(TrackData[Idx].Data[I].BParm1)+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2)
        else
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+DrumTable[TrackData[Idx].Data[I].BParm1]+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2);
      end;
      10: begin // Polyphonic Aftertouch
        Events.Cells[3,I+1]:='Polyphonic Aftertouch';
        if (TrackData[Idx].Data[I].Status and 15)<>9 then
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+NoteNum(TrackData[Idx].Data[I].BParm1)+
          '), pressure = '+IntToStr(TrackData[Idx].Data[I].BParm2)
        else
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+DrumTable[TrackData[Idx].Data[I].BParm1]+
          '), pressure = '+IntToStr(TrackData[Idx].Data[I].BParm2);
      end;
      11: begin // Control Change
        Events.Cells[3,I+1]:='Control: '+ControlTable[TrackData[Idx].Data[I].BParm1];
        case TrackData[Idx].Data[I].BParm1 of
          64..66,67,69: begin  // Switches
            if TrackData[Idx].Data[I].BParm2<=63 then
              Events.Cells[4,I+1]:='Off';
            if TrackData[Idx].Data[I].BParm2>=64 then
              Events.Cells[4,I+1]:='On';
          end;
          68: begin  // Legato Footswitch
            if TrackData[Idx].Data[I].BParm2<=63 then
              Events.Cells[4,I+1]:='Normal';
            if TrackData[Idx].Data[I].BParm2>=64 then
              Events.Cells[4,I+1]:='Legato';
          end;
          84: begin  // Portamento control
            if (TrackData[Idx].Data[I].Status and 15)<>9 then
              Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm2)+
              ' ('+NoteNum(TrackData[Idx].Data[I].BParm2)+')'
            else
              Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm2)+
              ' ('+DrumTable[TrackData[Idx].Data[I].BParm2]+')';
          end;
          96..97,120,121,123..125,127:  // value ignored
            Events.Cells[4,I+1]:='';
          118: begin  // Loop Point
            Events.Cells[4,I+1] := 'Value = ' + IntToStr(TrackData[Idx].Data[I].BParm2);
            if TrackData[Idx].Data[I].BParm2 = 0 then
              Events.Cells[4,I+1] := 'Loop Start';
            if TrackData[Idx].Data[I].BParm2 = 127 then
              Events.Cells[4,I+1] := 'Loop End';
          end;
          122: begin  // Local control switch
            Events.Cells[4,I+1]:='Value = '+IntToStr(TrackData[Idx].Data[I].BParm2);
            if TrackData[Idx].Data[I].BParm2=0 then
              Events.Cells[4,I+1]:='Off';
            if TrackData[Idx].Data[I].BParm2=127 then
              Events.Cells[4,I+1]:='On';
          end;
          126: begin  // Mono mode on
            if TrackData[Idx].Data[I].BParm2>0 then
              Events.Cells[4,I+1]:='Number of channels = '+IntToStr(TrackData[Idx].Data[I].BParm2)
            else
              Events.Cells[4,I+1]:='Number of channels = '+IntToStr(TrackData[Idx].Data[I].BParm2)+
              ' (same as number of voices in the receiver)';
          end;
          else  // others
            Events.Cells[4,I+1]:='Value = '+IntToStr(TrackData[Idx].Data[I].BParm2);
        end;
      end;
      12: begin // Program Change
        Events.Cells[3,I+1]:='Program Change';
        if (TrackData[Idx].Data[I].Status and 15)<>9 then
          Events.Cells[4,I+1]:='Instrument = '+IntToStr(TrackData[Idx].Data[I].BParm1) +
          ' ('+InstrumentTable[TrackData[Idx].Data[I].BParm1]+')'
        else
          Events.Cells[4,I+1]:='Drum Kit = '+IntToStr(TrackData[Idx].Data[I].BParm1) +
          ' ('+DrumKits[TrackData[Idx].Data[I].BParm1]+')';
      end;
      13: begin // Channel Aftertouch
        Events.Cells[3,I+1]:='Channel Aftertouch';
        Events.Cells[4,I+1]:='Pressure = '+IntToStr(TrackData[Idx].Data[I].BParm1);
      end;
      14: begin // Pitch Bend
        Events.Cells[3,I+1]:='Pitch Bend';
        Events.Cells[4,I+1]:='Value = '+IntToStr(TrackData[Idx].Data[I].Value);
      end;
      15: begin // System
        Events.Cells[3,I+1]:='System: '+SystemTable[TrackData[Idx].Data[I].Status and 15];
        case TrackData[Idx].Data[I].Status and 15 of
          0,7: begin // SysEx and EOX
            S := SysExProcess(TrackData[Idx].Data[I].DataArray);
            if S <> '' then
              Events.Cells[4,I+1] := S
            else
              Events.Cells[4,I+1] := 'No data';
          end;
          1:   // QuarterFrame
            Events.Cells[4,I+1]:='Message type = '+
            IntToStr(TrackData[Idx].Data[I].BParm1 shr 4)+', value = '+
            IntToStr(TrackData[Idx].Data[I].BParm1 and 15);
          2:   // Song Position Pointer
            Events.Cells[4,I+1]:=IntToStr(TrackData[Idx].Data[I].Value)+
            ' beats ('+IntToStr(TrackData[Idx].Data[I].Value*6)+' MIDI clocks) from start';
          3:   // Song Select
            Events.Cells[4,I+1]:='Value = '+IntToStr(TrackData[Idx].Data[I].BParm1);
          6: ; // Tune Request
          8: ; // TimingClock
          10: ; // Start
          11: ; // Continue
          12: ; // Stop
          14: ; // ActiveSens
          15: begin  // Meta Event
            Events.Cells[4,I+1]:=MetaTable[TrackData[Idx].Data[I].BParm1]+
            ': ';
            case TrackData[Idx].Data[I].BParm1 of
              // Sequence Number
              0: Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                IntToStr(TrackData[Idx].Data[I].Value);
              // Strings
              1..7: Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                TrackData[Idx].Data[I].DataString;
              // MIDI Channel
              32: Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                IntToStr(TrackData[Idx].Data[I].Value + 1);
              // MIDI Port
              33: Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                IntToStr(TrackData[Idx].Data[I].Value);
              // Tempo
              81:
                Events.Cells[4,I+1] := Events.Cells[4,I+1] +
                IntToStr(TrackData[Idx].Data[I].Value div 1000) +
                '.' +
                Format('%.3d', [TrackData[Idx].Data[I].Value mod 1000]) +
                ' ms/4th (' +
                IntToStr(60000000 div TrackData[Idx].Data[I].Value) +
                ' BPM, ' +
                IntToStr(Round(InitTempo / TrackData[Idx].Data[I].Value * 100)) +
                '%)';
              // SMPTE Offset
              84:
                Events.Cells[4,I+1]:=Events.Cells[4,I+1]+'Hour = '+
                IntToStr(TrackData[Idx].Data[I].DataArray[0])+
                ', min = '+
                IntToStr(TrackData[Idx].Data[I].DataArray[1])+
                ', sec = '+
                IntToStr(TrackData[Idx].Data[I].DataArray[2])+
                ', fr = '+
                IntToStr(TrackData[Idx].Data[I].DataArray[3])+
                ', ff = '+
                IntToStr(TrackData[Idx].Data[I].DataArray[4]);
              // Time Signature
              88: begin
                Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                IntToStr(TrackData[Idx].Data[I].DataArray[0])+'/'+
                IntToStr(Round(Power(2, TrackData[Idx].Data[I].DataArray[1])))+
                ' time, '+IntToStr(TrackData[Idx].Data[I].DataArray[2])+
                ' MIDI clock(s) per dotted-quarter, '+
                IntToStr(TrackData[Idx].Data[I].DataArray[3])+
                ' notated 32nd-notes per MIDI quarter note';
              end;
              // Key Signature
              89: begin
                if ShortInt(TrackData[Idx].Data[I].DataArray[0]) = 0 then
                  Events.Cells[4,I+1]:=Events.Cells[4,I+1]+'Key of C';
                if ShortInt(TrackData[Idx].Data[I].DataArray[0]) < 0 then
                  Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                  IntToStr(-ShortInt(TrackData[Idx].Data[I].DataArray[0]))+' flat(s)';
                if ShortInt(TrackData[Idx].Data[I].DataArray[0]) > 0 then
                  Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                  IntToStr(ShortInt(TrackData[Idx].Data[I].DataArray[0]))+' sharp(s)';
                case TrackData[Idx].Data[I].DataArray[1] of
                  0: Events.Cells[4,I+1]:=Events.Cells[4,I+1]+' major';
                  1: Events.Cells[4,I+1]:=Events.Cells[4,I+1]+' minor';
                end;
              end;
              // Sequencer-Specific
              127: begin
                S := SysExProcess(TrackData[Idx].Data[I].DataArray);
                if S = '' then
                  S := 'No data';
                Events.Cells[4,I+1] := Events.Cells[4,I+1] + S;
              end;
              // other meta-event
              else begin
                for J:=0 to TrackData[Idx].Data[I].Len-1 do
                  Events.Cells[4,I+1]:=Events.Cells[4,I+1]+
                  IntToHex(TrackData[Idx].Data[I].DataArray[J],2);
                if (Copy(Events.Cells[4,I+1], Length(Events.Cells[4,I+1])-1, 2)=': ')
                and ((TrackData[Idx].Data[I].Len = 0) and
                (Length(TrackData[Idx].Data[I].DataString)=0)) then begin
                  S:=Events.Cells[4,I+1];
                  Delete(S, Length(S)-1, 2);
                  Events.Cells[4,I+1]:=S;
                end;
              end; // other meta-event
            end; // case meta-event
          end; // meta-event
        end; // system event type
      end; // system event
    end; // status byte check

    if EventViewProfile = 'xmi' then begin
      case TrackData[Idx].Data[I].Status shr 4 of
        8: // Note Off (unused)
          Events.Cells[4,I+1] := 'Ignored';
        9: // XMI Note
        begin
          Events.Cells[3,I+1] := 'Play Note';
          Events.Cells[4,I+1] := Events.Cells[4,I+1] +
          ', duration = ' + IntToStr(TrackData[Idx].Data[I].Len);
        end;
        11: // Control Change
        begin
          case TrackData[Idx].Data[I].BParm1 of
            32:  Events.Cells[3,I+1] := 'Control: AIL sysex start address MSB (queue 0)';
            33:  Events.Cells[3,I+1] := 'Control: AIL sysex start address KSB (queue 0)';
            34:  Events.Cells[3,I+1] := 'Control: AIL sysex start address LSB (queue 0)';
            35:  Events.Cells[3,I+1] := 'Control: AIL sysex data byte (queue 0)';
            36:  Events.Cells[3,I+1] := 'Control: AIL final sysex data byte (queue 0)';
            37:  Events.Cells[3,I+1] := 'Control: AIL sysex start address MSB (queue 1)';
            38:  Events.Cells[3,I+1] := 'Control: AIL sysex start address KSB (queue 1)';
            39:  Events.Cells[3,I+1] := 'Control: AIL sysex start address LSB (queue 1)';
            40:  Events.Cells[3,I+1] := 'Control: AIL sysex data byte (queue 1)';
            41:  Events.Cells[3,I+1] := 'Control: AIL final sysex data byte (queue 1)';
            42:  Events.Cells[3,I+1] := 'Control: AIL sysex start address MSB (queue 2)';
            43:  Events.Cells[3,I+1] := 'Control: AIL sysex start address KSB (queue 2)';
            44:  Events.Cells[3,I+1] := 'Control: AIL sysex start address LSB (queue 2)';
            45:  Events.Cells[3,I+1] := 'Control: AIL sysex data byte (queue 2)';
            46:  Events.Cells[3,I+1] := 'Control: AIL final sysex data byte (queue 2)';

            58:  Events.Cells[3,I+1] := 'Control: AIL Rhythm Setup Timbre';
            59:  Events.Cells[3,I+1] := 'Control: AIL MT-32 Patch Reverb SW';
            60:  Events.Cells[3,I+1] := 'Control: AIL MT-32 Pitch Bend range';
            61:  Events.Cells[3,I+1] := 'Control: AIL MT-32 Reverb Mode';
            62:  Events.Cells[3,I+1] := 'Control: AIL MT-32 Reverb Time';
            63:  Events.Cells[3,I+1] := 'Control: AIL MT-32 Reverb Level';

            110: Events.Cells[3,I+1] := 'Control: AIL Channel Release';
            111: Events.Cells[3,I+1] := 'Control: AIL Channel Lock';
            112: Events.Cells[3,I+1] := 'Control: AIL Voice Protection';
            113: Events.Cells[3,I+1] := 'Control: AIL Timbre Protection';
            114: Events.Cells[3,I+1] := 'Control: AIL Select Bank';
            115: Events.Cells[3,I+1] := 'Control: AIL Indirect Prefix';
            116: Events.Cells[3,I+1] := 'Control: AIL Loop Start';
            117: Events.Cells[3,I+1] := 'Control: AIL Loop End';
            118: Events.Cells[3,I+1] := 'Control: AIL Clear Beat Count';
            119: Events.Cells[3,I+1] := 'Control: AIL Callback Trigger';
            120: Events.Cells[3,I+1] := 'Control: AIL Sequence Index';
          end;
        end;
        15: // System
          if TrackData[Idx].Data[I].Status = $FF then // Meta
            case TrackData[Idx].Data[I].BParm1 of
              81: // Tempo
                Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (ignored)';
            end;
      end;
    end;

    if EventViewProfile = 'mus' then begin
      case TrackData[Idx].Data[I].Status shr 4 of
        8: // Note Off
        begin
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+NoteNum(TrackData[Idx].Data[I].BParm1)+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2);
          if TrackData[Idx].Data[I].BParm1 = 0 then
            Events.Cells[4,I+1] := 'Velocity = ' +
            IntToStr(TrackData[Idx].Data[I].BParm2);
          S := '';
          if Rhythm then
            case TrackData[Idx].Data[I].Status and 15 of
              6: S := 'Bass drum';
              7: S := 'Snare drum';
              8: S := 'Tom tom';
              9: S := 'Top cymbal';
              10: S := 'Hi-hat cymbal';
            end;
          if S <> '' then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        9: // Note On
        begin
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+NoteNum(TrackData[Idx].Data[I].BParm1)+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2);
          S := '';
          if Rhythm then
            case TrackData[Idx].Data[I].Status and 15 of
              6: S := 'Bass drum';
              7: S := 'Snare drum';
              8: S := 'Tom tom';
              9: S := 'Top cymbal';
              10: S := 'Hi-hat cymbal';
            end;
          if S <> '' then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        10: // Volume Change
        begin
          Events.Cells[3,I+1] := 'Volume Change';
          Events.Cells[4,I+1] :=
          'Value = '+IntToStr(TrackData[Idx].Data[I].BParm1);
        end;
        12: begin // Program Change
          Events.Cells[4,I+1] :=
          'Instrument = ' + IntToStr(TrackData[Idx].Data[I].BParm1);
          S := '';
          if SongData_GetStr('SND_Name#'+IntToStr(TrackData[Idx].Data[I].BParm1), S) then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        15: // System
        begin
          if (TrackData[Idx].Data[I].Status = $F0)
          and (TrackData[Idx].Data[I].Len = 5)
          and (TrackData[Idx].Data[I].DataArray[0] = $7F)
          then begin
            Events.Cells[3,I+1] := 'System: Set Speed';
            Speed :=
            (TrackData[Idx].Data[I].DataArray[3] / 128) +
            TrackData[Idx].Data[I].DataArray[2];
            Events.Cells[4,I+1] := 'Value = ' +
            IntToStr(Round(Speed)) + '.' +
            Format('%.2d', [Round(Speed * 100) mod 100]);
          end;
          if (TrackData[Idx].Data[I].Status = $FC)
          then begin
            Events.Cells[3,I+1] := 'System: Song End';
          end;
        end;
      end;
    end;

    if EventViewProfile = 'mdi' then begin
      case TrackData[Idx].Data[I].Status shr 4 of
        8: begin // NoteOff
          if TrackData[Idx].Data[I].BParm1 = 0 then
            Events.Cells[4,I+1] := 'Velocity = ' +
            IntToStr(TrackData[Idx].Data[I].BParm2)
          else
            Events.Cells[4,I+1] := 'Note = ' +
            IntToStr(TrackData[Idx].Data[I].BParm1) + ' (' +
            NoteNum(TrackData[Idx].Data[I].BParm1) + '), velocity = ' +
            IntToStr(TrackData[Idx].Data[I].BParm2);
          S := '';
          if Rhythm then
            case TrackData[Idx].Data[I].Status and 15 of
              6: S := 'Bass drum';
              7: S := 'Snare drum';
              8: S := 'Tom tom';
              9: S := 'Top cymbal';
              10: S := 'Hi-hat cymbal';
            end;
          if S <> '' then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        9: begin // NoteOn
          Events.Cells[4,I+1]:='Note = '+IntToStr(TrackData[Idx].Data[I].BParm1)+
          ' ('+NoteNum(TrackData[Idx].Data[I].BParm1)+
          '), velocity = '+IntToStr(TrackData[Idx].Data[I].BParm2);
          S := '';
          if Rhythm then
            case TrackData[Idx].Data[I].Status and 15 of
              6: S := 'Bass drum';
              7: S := 'Snare drum';
              8: S := 'Tom tom';
              9: S := 'Top cymbal';
              10: S := 'Hi-hat cymbal';
            end;
          if S <> '' then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        12: begin // Program Change
          Events.Cells[4,I+1] :=
          'Instrument = ' + IntToStr(TrackData[Idx].Data[I].BParm1);
        end;
        13: begin // Volume Change
          Events.Cells[3,I+1] := 'Volume Change';
          Events.Cells[4,I+1] :=
          'Value = '+IntToStr(TrackData[Idx].Data[I].BParm1);
        end;
        15: begin // System
          if (TrackData[Idx].Data[I].Status and 15 = 0)
          or (
            (TrackData[Idx].Data[I].Status and 15 = 15) and
            (TrackData[Idx].Data[I].BParm1 = 127)
          )
          then
            if (TrackData[Idx].Data[I].Len = 6)
            and (TrackData[Idx].Data[I].DataArray[0] = $00)
            and (TrackData[Idx].Data[I].DataArray[1] = $00)
            and (TrackData[Idx].Data[I].DataArray[2] = $3F)
            and (TrackData[Idx].Data[I].DataArray[3] = $00)
            and (TrackData[Idx].Data[I].DataArray[4] = $02)
            then begin
              if TrackData[Idx].Data[I].DataArray[5] = 0 then
                Rhythm := False;
              if TrackData[Idx].Data[I].DataArray[5] = 1 then
                Rhythm := True;
            end;
        end;
      end;
    end;

    if EventViewProfile = 'cmf' then begin
      case TrackData[Idx].Data[I].Status shr 4 of
        8: begin // NoteOff
          Events.Cells[4,I+1] :=
          'Note = ' + IntToStr(TrackData[Idx].Data[I].BParm1) +
          ' (' + NoteNum(TrackData[Idx].Data[I].BParm1) +
          '), velocity = ' + IntToStr(TrackData[Idx].Data[I].BParm2);
          S := '';
          if Rhythm then
            case TrackData[Idx].Data[I].Status and 15 of
              11: S := 'Bass drum';
              12: S := 'Snare drum';
              13: S := 'Tom tom';
              14: S := 'Top cymbal';
              15: S := 'Hi-hat cymbal';
            end;
          if S <> '' then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        9: begin // NoteOn
          Events.Cells[4,I+1] :=
          'Note = ' + IntToStr(TrackData[Idx].Data[I].BParm1) +
          ' (' + NoteNum(TrackData[Idx].Data[I].BParm1) +
          '), velocity = ' + IntToStr(TrackData[Idx].Data[I].BParm2);
          S := '';
          if Rhythm then
            case TrackData[Idx].Data[I].Status and 15 of
              11: S := 'Bass drum';
              12: S := 'Snare drum';
              13: S := 'Tom tom';
              14: S := 'Top cymbal';
              15: S := 'Hi-hat cymbal';
            end;
          if S <> '' then
            Events.Cells[4,I+1] := Events.Cells[4,I+1] + ' (' + S + ')';
        end;
        11: begin // Control Change
          case TrackData[Idx].Data[I].BParm1 of
            99: begin // Depth control
              Events.Cells[3,I+1] := 'Control: Amplitude+Vibrato Depth';
              case TrackData[Idx].Data[I].BParm2 of
                0: Events.Cells[4,I+1] := 'Amplitude = 1 dB, vibrato = 7 cents';
                1: Events.Cells[4,I+1] := 'Amplitude = 1 dB, vibrato = 14 cents';
                2: Events.Cells[4,I+1] := 'Amplitude = 4.8 dB, vibrato = 7 cents';
                3: Events.Cells[4,I+1] := 'Amplitude = 4.8 dB, vibrato = 14 cents';
              end;
            end;
            102: begin // Set marker byte
              Events.Cells[3,I+1] := 'Control: Set Marker Byte';
            end;
            103: begin // Rhythm mode change
              Events.Cells[3,I+1] := 'Control: Rhythm Mode';
              Rhythm := TrackData[Idx].Data[I].BParm2 > 0;
              if Rhythm then
                Events.Cells[4,I+1] := 'On'
              else
                Events.Cells[4,I+1] := 'Off';
            end;
            104..105: begin // Transpose Up/Down
              if TrackData[Idx].Data[I].BParm1 = 104 then
                Events.Cells[3,I+1] := 'Control: Transpose Up';
              if TrackData[Idx].Data[I].BParm1 = 105 then
                Events.Cells[3,I+1] := 'Control: Transpose Down';
              if TrackData[Idx].Data[I].BParm2 = 0 then
                Events.Cells[4,I+1] := 'Not transposed';
              if (TrackData[Idx].Data[I].BParm2 > 0) and (TrackData[Idx].Data[I].BParm2 < 127) then
                Events.Cells[4,I+1] := IntToStr(TrackData[Idx].Data[I].BParm2) + '/128 semitones';
              if TrackData[Idx].Data[I].BParm2 = 127 then
                Events.Cells[4,I+1] := 'Full semitone';
            end;
          end;
        end;
        12: begin // Program Change
          Events.Cells[4,I+1] :=
          'Instrument = ' + IntToStr(TrackData[Idx].Data[I].BParm1);
        end;
      end;
    end;

  end; // track read
end;

procedure TMainForm.MNewClick(Sender: TObject);
begin
  OpenDialog.FileName := '';
  Log.Lines.Clear;
  Opened := True;
  Container := 'smf';
  EventFormat := 'mid';
  EventProfile := 'mid';
  EventViewProfile := 'mid';
  SongData.Strings.Clear;
  SetLength(TrackData, 0);
  SongData_PutInt('MIDIType', 1);
  SongData_PutInt('SMPTE', 0);
  SongData_PutInt('Division', 96);
  SongData_PutDWord('InitTempo', 500000);
  Log.Lines.Add('[*] New sequence created.');
  TrkCh.ItemIndex := -1;
  BAddTrackClick(Sender);
  Log.Lines.Add('');
  Log.Lines.Add('[*] Default settings:');
  LogSongInfo;
  Log.Lines.Add('');
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MSaveAsClick(Sender: TObject);
var
  FileName, FilterExt: String;
  Filter: TStringList;
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if not SaveDialog.Execute then
    Exit;
  FileName := SaveDialog.FileName;
  if OpenDialog.FileName <> '' then
    OpenDialog.FileName := FileName;

  Filter := TStringList.Create;
  Filter.Delimiter := '|';
  Filter.StrictDelimiter := True;
  Filter.DelimitedText := SaveDialog.Filter;
  FilterExt := Filter[SaveDialog.FilterIndex*2 - 1];
  Filter.Free;

  if Pos('*.mid', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (
        (LowerCase(ExtractFileExt(FileName)) <> '.mid')
    and (LowerCase(ExtractFileExt(FileName)) <> '.midi')
    and (LowerCase(ExtractFileExt(FileName)) <> '.kar')
    )
    then
      FileName := FileName + '.mid';
  end;
  if Pos('*.rmi', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (
        (LowerCase(ExtractFileExt(FileName)) <> '.rmi')
    and (LowerCase(ExtractFileExt(FileName)) <> '.rmid')
    )
    then
      FileName := FileName + '.rmi';
  end;
  if Pos('*.xmi', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (LowerCase(ExtractFileExt(FileName)) <> '.xmi')
    then
      FileName := FileName + '.xmi';
  end;
  if Pos('*.cmf', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (LowerCase(ExtractFileExt(FileName)) <> '.cmf')
    then
      FileName := FileName + '.mus';
  end;
  if Pos('*.mus', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (LowerCase(ExtractFileExt(FileName)) <> '.mus')
    then
      FileName := FileName + '.mus';
  end;
  if Pos('*.mdi', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (LowerCase(ExtractFileExt(FileName)) <> '.mdi')
    then
      FileName := FileName + '.mdi';
  end;
  if Pos('*.raw', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (LowerCase(ExtractFileExt(FileName)) <> '.raw')
    then
      FileName := FileName + '.raw';
  end;
  if Pos('*.syx', FilterExt) > 0 then
  begin
    if (ExtractFileExt(FileName) = '')
    or (LowerCase(ExtractFileExt(FileName)) <> '.syx')
    then
      FileName := FileName + '.syx';
  end;

  SaveFile(FileName);
end;

procedure TMainForm.MSaveClick(Sender: TObject);
begin
  if OpenDialog.FileName <> '' then
    SaveFile(OpenDialog.FileName)
  else
    MSaveAs.Click;
end;

function TMainForm.DelEvent(Trk, Idx: Integer; TimeSave: Boolean): Boolean;
var
  I: Integer;
  Delta: UInt64;
begin
  Result := False;
  if (Trk < 0) or (Trk >= Length(TrackData)) then
    Exit;
  if TimeSave then
    Delta := TrackData[Trk].Data[Idx].Ticks
  else
    Delta := 0;
  for I := Idx + 1 to Length(TrackData[Trk].Data) - 1 do
    TrackData[Trk].Data[I-1] := TrackData[Trk].Data[I];
  SetLength(TrackData[Trk].Data, Length(TrackData[Trk].Data) - 1);
  if TimeSave and (Idx < Length(TrackData[Trk].Data)) then
    TrackData[Trk].Data[Idx].Ticks :=
    TrackData[Trk].Data[Idx].Ticks + Delta;
  Result := True;
end;

function TMainForm.DelRange(Trk, From, Count: Integer;
  TimeSave: Boolean): Boolean;
var
  I: Integer;
  Delta: UInt64;
  Store: Boolean;
begin
  Result := False;
  if Count = 0 then
    Exit;
  if (Trk < 0) or (Trk >= Length(TrackData)) then
    Exit;
  Store := True;
  Delta := 0;
  if From + Count = Length(TrackData[Trk].Data) then
    Store := False;
  if TimeSave then
    for I := From to From + Count - 1 do
      Delta := Delta + TrackData[Trk].Data[I].Ticks;
  for I := From + Count to Length(TrackData[Trk].Data) - 1 do
    TrackData[Trk].Data[I-Count] := TrackData[Trk].Data[I];
  SetLength(TrackData[Trk].Data,
  Length(TrackData[Trk].Data) - Count);
  if TimeSave and Store then
    TrackData[Trk].Data[From].Ticks := TrackData[Trk].Data[From].Ticks + Delta;
  Result := True;
end;

procedure TMainForm.LogSongInfo;
var
  Ver, Division: String;
  SMPTE: ShortInt;  
begin
  SongData_GetStr('MIDIType', Ver);
  SongData_GetStr('Division', Division);
  Log.Lines.Add('MIDI Type   '+Ver);
  Log.Lines.Add('Track count '+IntToStr(Length(TrackData)));
  if not SongData_GetSInt('SMPTE', SMPTE) then
    SMPTE := 0;
  if SMPTE >= 0 then
    Log.Lines.Add('Division    '+Division+' PPQN')
  else begin
    Log.Lines.Add('Division    '+Division+' TPF');
    Log.Lines.Add('SMPTE       '+IntToStr(-SMPTE)+' FPS');
  end;
end;

procedure TMainForm.AddTrack;
begin
  SetLength(TrackData, Length(TrackData)+1);
  TrackData[Length(TrackData)-1].Title:='';
  SetLength(TrackData[Length(TrackData)-1].Data, 1);
  TrackData[Length(TrackData)-1].Data[0].Status:=$FF;
  TrackData[Length(TrackData)-1].Data[0].BParm1:=$2F;
  TrackData[Length(TrackData)-1].Data[0].Len:=0;
  Log.Lines.Add('[*] Track '+IntToStr(Length(TrackData)-1)+' added.');
end;

procedure TMainForm.DelTrack(Idx: Integer);
var
  I: Integer;
  Title: AnsiString;
begin
  Title := TrackData[Idx].Title;
  for I := Idx + 1 to Length(TrackData)-1 do
    TrackData[I-1] := TrackData[I];
  SetLength(TrackData, Length(TrackData)-1);
  if Title = '' then
    Log.Lines.Add('[*] Track '+IntToStr(Idx)+' deleted.')
  else
    Log.Lines.Add('[*] Track '+IntToStr(Idx)+' ('+Title+') deleted.');
end;

function TMainForm.TimeBetween(Trk, Idx1, Idx2: Integer): UInt64;
var
  I: Integer;
begin
  Result:=0;
  for I:=Idx1+1 to Idx2 do
    Result:=Result+TrackData[Trk].Data[I].Ticks;
end;

procedure TMainForm.MSplit1Click(Sender: TObject);
var
  Trk, I, J: Integer;
  Chnls: Array of Byte;
  B: Byte;
  ChFnd: Boolean;
  Itr, Sz: Integer;
begin
  Trk:=TrkCh.ItemIndex;
  Log.Lines.Add('[*] Splitting track '+IntToStr(Trk)+' by channels...');
  for I:=0 to Length(TrackData[Trk].Data)-1 do
    if (TrackData[Trk].Data[I].Status shr 4)<15 then begin
      ChFnd:=False;
      for J:=0 to Length(Chnls)-1 do
        if Chnls[J]=TrackData[Trk].Data[I].Status and 15 then begin
          ChFnd:=True;
          Break;
        end;
      if not ChFnd then begin
        SetLength(Chnls, Length(Chnls)+1);
        Chnls[Length(Chnls)-1]:=TrackData[Trk].Data[I].Status and 15;
      end;
    end;
  if Length(Chnls)=0 then begin
    Log.Lines.Add('[-] Error: Track contains no channel events.');
    Exit;
  end;
  if Length(Chnls)=1 then begin
    Log.Lines.Add('[-] Error: Can''t split track because it has only one channel.');
    Exit;
  end;
  Log.Lines.Add('[+] Found '+IntToStr(Length(Chnls))+' channels.');
  for I:=0 to Length(Chnls)-1 do
    AddTrack;
  // begin sort
  for I:=0 to Length(Chnls)-2 do
    for J:=I+1 to Length(Chnls)-1 do
      if Chnls[J]<Chnls[I] then begin
        B:=Chnls[I];
        Chnls[I]:=Chnls[J];
        Chnls[J]:=B;
      end;
  // end sort
  Log.Lines.Add('[*] Moving events...');
  I:=0;
  Itr:=0; Sz:=Length(TrackData[Trk].Data);
  while I<Length(TrackData[Trk].Data) do begin
    if (TrackData[Trk].Data[I].Status shr 4)<15 then begin
      B:=0;
      for J:=0 to Length(Chnls)-1 do
        if Chnls[J]=TrackData[Trk].Data[I].Status and 15 then begin
          B:=J+1;
          Break;
        end;
      SetLength(TrackData[Trk+B].Data, Length(TrackData[Trk+B].Data)+1);
      CopyEvent(Trk+B, Length(TrackData[Trk+B].Data)-2, Trk+B, Length(TrackData[Trk+B].Data)-1);
      CopyEvent(Trk, I, Trk+B, Length(TrackData[Trk+B].Data)-2);
      TrackData[Trk+B].Data[Length(TrackData[Trk+B].Data)-2].Ticks:=
      TimeBetween(Trk, -1, I)-TimeBetween(Trk+B, -1, Length(TrackData[Trk+B].Data)-3);
      DelEvent(Trk, I, True);
    end else
      Inc(I);
    Inc(Itr);
    if Sz div 256>0 then begin
      if ((Itr mod (Sz div 256))=0) and (Sz>0) then
        Progress.Position:=Round(Itr/Sz*100);
    end else begin
      if ((Itr mod 1)=0) and (Sz>0) then
        Progress.Position:=Round(Itr/Sz*100);
    end;
  end;
  Progress.Position:=0;
  Log.Lines.Add('[+] Done.');
  RefTrackList;
  TrkCh.ItemIndex:=Trk;
  FillEvents(Trk);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.MSplit2Click(Sender: TObject);
type
  Rang = record
    Full: Boolean;
    VFrom: Integer;
    VTo: Integer;
  end;
  Prog = record
    Val: Byte;
    Ranges: Array of Rang;
  end;
var
  Trk, Dest, I, J, K: Integer;
  Prgs: Array of Prog;
  Last: Byte;
  Idx: Integer;
begin
  Trk := TrkCh.ItemIndex;
  Log.Lines.Add('[*] Splitting track '+IntToStr(Trk)+' by program change events...');
  Last := 255;
  for I := 0 to Length(TrackData[Trk].Data)-1 do
    if TrackData[Trk].Data[I].Status shr 4 = 12 then begin
      if TrackData[Trk].Data[I].BParm1 <> Last then begin
        if Last = 255 then begin
          SetLength(Prgs, 1);
          Prgs[0].Val := TrackData[Trk].Data[I].BParm1;
          SetLength(Prgs[0].Ranges, 1);
          Prgs[0].Ranges[0].Full := False;
          Prgs[0].Ranges[0].VFrom := 0;
        end else begin
          if Length(Prgs) = 1 then begin
            SetLength(Prgs, 2);
            Prgs[1].Val := TrackData[Trk].Data[I].BParm1;
            SetLength(Prgs[1].Ranges, 1);
            Prgs[1].Ranges[0].Full := False;
            Prgs[1].Ranges[0].VFrom := I;
            Prgs[0].Ranges[Length(Prgs[0].Ranges)-1].Full := True;
            Prgs[0].Ranges[Length(Prgs[0].Ranges)-1].VTo := I-1;
          end else begin
            for J := 0 to Length(Prgs)-1 do // find for last
              if Prgs[J].Val = Last then begin
                Prgs[J].Ranges[Length(Prgs[J].Ranges)-1].Full := True;
                Prgs[J].Ranges[Length(Prgs[J].Ranges)-1].VTo := I-1;
                Break;
              end;
            Idx := -1;
            for J := 0 to Length(Prgs)-1 do // find for program
              if Prgs[J].Val = TrackData[Trk].Data[I].BParm1 then begin
                Idx := J;
                Break;
              end;
            if Idx = -1 then begin
              SetLength(Prgs, Length(Prgs)+1);
              Prgs[Length(Prgs)-1].Val := TrackData[Trk].Data[I].BParm1;
              SetLength(Prgs[Length(Prgs)-1].Ranges, 1);
              Prgs[Length(Prgs)-1].Ranges[0].Full := False;
              Prgs[Length(Prgs)-1].Ranges[0].VFrom := I;
            end else begin
              if Prgs[Idx].Ranges[Length(Prgs[Idx].Ranges)-1].Full then begin
                SetLength(Prgs[Idx].Ranges, Length(Prgs[Idx].Ranges)+1);
                Prgs[Idx].Ranges[Length(Prgs[Idx].Ranges)-1].Full := False;
                Prgs[Idx].Ranges[Length(Prgs[Idx].Ranges)-1].VFrom := I;
              end else begin
                Prgs[Idx].Ranges[Length(Prgs[Idx].Ranges)-1].Full := True;
                Prgs[Idx].Ranges[Length(Prgs[Idx].Ranges)-1].VTo := I-1;
              end;
            end;
          end;
        end;
      end;
      Last := TrackData[Trk].Data[I].BParm1;
    end;
  if Length(Prgs) = 0 then begin
    Log.Lines.Add('[-] Error: Track contains no program change events.');
    Exit;
  end;
  if Length(Prgs) = 1 then begin
    Log.Lines.Add('[-] Error: Can''t split track because it use only one program.');
    Exit;
  end;
  for J := 0 to Length(Prgs)-1 do // finish last
    if Prgs[J].Val = Last then begin
      Prgs[J].Ranges[Length(Prgs[J].Ranges)-1].Full := True;
      if (TrackData[Trk].Data[High(TrackData[Trk].Data)].Status = $FF) and
      (TrackData[Trk].Data[High(TrackData[Trk].Data)].BParm1 = $2F) then
        Prgs[J].Ranges[Length(Prgs[J].Ranges)-1].VTo := High(TrackData[Trk].Data)-1
      else
        Prgs[J].Ranges[Length(Prgs[J].Ranges)-1].VTo := High(TrackData[Trk].Data);
      Break;
    end;
  Log.Lines.Add('[+] Found '+IntToStr(Length(Prgs))+' different program changes.');
  for I := 0 to Length(Prgs)-2 do
    AddTrack;
  Log.Lines.Add('[*] Copying events...');
  for I := 1 to Length(Prgs)-1 do
    for J := 0 to Length(Prgs[I].Ranges)-1 do begin
      Dest := Length(TrackData) - Length(Prgs) + I;
      Idx := Length(TrackData[Dest].Data) - 1;
      SetLength(TrackData[Dest].Data, Length(TrackData[Dest].Data) +
      Prgs[I].Ranges[J].VTo - Prgs[I].Ranges[J].VFrom + 1);

      CopyEvent(Dest, Length(TrackData[Dest].Data) - Prgs[I].Ranges[J].VTo +
      Prgs[I].Ranges[J].VFrom - 2, Dest, Length(TrackData[Dest].Data) - 1);

      for K := Prgs[I].Ranges[J].VFrom to Prgs[I].Ranges[J].VTo do begin
        CopyEvent(Trk, K, Dest, Idx + K - Prgs[I].Ranges[J].VFrom);
        if K = Prgs[I].Ranges[J].VFrom then begin
          if J > 1 then
            TrackData[Dest].Data[Idx + K - Prgs[I].Ranges[J].VFrom].Ticks :=
            TimeBetween(Trk, Prgs[I].Ranges[J-1].VTo + 1, Prgs[I].Ranges[J].VFrom)
          else
            TrackData[Dest].Data[Idx + K - Prgs[I].Ranges[J].VFrom].Ticks :=
            TimeBetween(Trk, -1, Prgs[I].Ranges[J].VFrom);
        end;
      end;
    end;
  Log.Lines.Add('[*] Cleaning up...');
  for I := Length(Prgs)-1 downto 1 do
    for J := Length(Prgs[I].Ranges)-1 downto 0 do
      DelRange(Trk, Prgs[I].Ranges[J].VFrom,
      Prgs[I].Ranges[J].VTo - Prgs[I].Ranges[J].VFrom + 1, True);
  Progress.Position := 0;
  Log.Lines.Add('[+] Done.');
  RefTrackList;
  TrkCh.ItemIndex := Trk;
  FillEvents(Trk);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.MSplit3Click(Sender: TObject);
begin
  MessageBox(Handle, 'This feature is not implemented yet.', 'Notice', mb_Ok or mb_IconWarning);
end;

procedure TMainForm.ConvertEvents(DestProfile: AnsiString);
begin
  if EventProfile = 'mid' then begin
    if DestProfile = 'xmi' then begin
      Convert_MID_XMI;
      EventProfile := 'xmi';
      EventViewProfile := 'xmi';
    end;
    if DestProfile = 'mus' then begin
      Convert_MID_MUS;
      EventProfile := 'mus';
      EventViewProfile := 'mus';
    end;
  end;
  if EventProfile = 'mdi' then begin
    if DestProfile = 'mid' then begin
      Convert_MDI_MID;
      EventProfile := 'mid';
      EventViewProfile := 'mid';
    end;
    if DestProfile = 'mus' then begin
      Convert_MDI_MUS;
      EventProfile := 'mus';
      EventViewProfile := 'mus';
    end;
    if DestProfile = 'cmf' then begin
      Convert_MDI_CMF;
      EventProfile := 'cmf';
      EventViewProfile := 'cmf';
    end;
  end;
  if EventProfile = 'xmi' then begin
    if DestProfile = 'mid' then begin
      Convert_XMI_MID;
      EventProfile := 'mid';
      EventViewProfile := 'mid';
    end;
  end;
  if EventProfile = 'cmf' then begin
    if DestProfile = 'mid' then begin
      Convert_CMF_MID;
      EventProfile := 'mid';
      EventViewProfile := 'mid';
    end;
    if DestProfile = 'mdi' then begin
      Convert_CMF_MDI;
      EventProfile := 'mdi';
      EventViewProfile := 'mdi';
    end;
  end;
  if EventProfile = 'mus' then begin
    if DestProfile = 'mid' then begin
      Convert_MUS_MID;
      EventProfile := 'mid';
      EventViewProfile := 'mid';
    end;
    if DestProfile = 'mdi' then begin
      Convert_MUS_MDI;
      EventProfile := 'mdi';
      EventViewProfile := 'mdi';
    end;
  end;
end;

procedure TMainForm.ConvertTicks(RelToAbs: Boolean; var Data: Array of Command);
var
  I: Integer;
  TicksPos: UInt64;
begin
  TicksPos := 0;
  if RelToAbs then begin
    for I := 0 to Length(Data) - 1 do begin
      Data[I].Ticks := Data[I].Ticks + TicksPos;
      TicksPos := Data[I].Ticks;
    end;
  end else
    for I := 0 to Length(Data) - 1 do begin
      Data[I].Ticks := Data[I].Ticks - TicksPos;
      TicksPos := TicksPos + Data[I].Ticks;
    end;
end;

procedure TMainForm.MergeTracksByTicks;
var
  I: Integer;
  Track: Chunk;
  Positions: Array of UInt64;
  Cmd: Command;
  function GetTick(Idx: Integer; var Tick: UInt64): Boolean;
  begin
    Result := False;
    if Positions[Idx] >= Length(TrackData[Idx].Data) then
      Exit;
    Tick := TrackData[Idx].Data[Positions[Idx]].Ticks;
    Result := True;
  end;
  function GetNextEvent: Boolean;
  var
    I, Idx: Integer;
    MinTick, Tick: UInt64;
  begin
    Result := False;
    Idx := -1;
    MinTick := High(UInt64);
    for I := 0 to Length(TrackData) - 1 do
      if GetTick(I, Tick) then
        if (Idx = -1) or (Tick < MinTick) then begin
          MinTick := Tick;
          Idx := I;
        end;
    if Idx = -1 then
      Exit;
    Cmd := TrackData[Idx].Data[Positions[Idx]];
    Inc(Positions[Idx]);
    Result := True;
  end;
begin
  if Length(TrackData) < 2 then begin
    Log.Lines.Add('[-] Merge failed. At least two tracks are required.');
    Exit;
  end;
  Log.Lines.Add('[*] Checking empty tracks...');
  I := 0;
  while I < Length(TrackData) do begin
    if Length(TrackData[I].Data) = 0 then
      DelTrack(I)
    else
      Inc(I);
  end;
  Log.Lines.Add('[*] Clearing EOT events...');
  for I := 0 to Length(TrackData) - 1 do
    if (TrackData[I].Data[Length(TrackData[I].Data) - 1].Status = $FF)
    and(TrackData[I].Data[Length(TrackData[I].Data) - 1].BParm1 = $2F)
    then
      DelEvent(I, Length(TrackData[I].Data) - 1, False);
  Log.Lines.Add('[*] Merging tracks...');
  SetLength(Positions, Length(TrackData));
  for I := 0 to Length(Positions) - 1 do
    Positions[I] := 0;
  Track.Title := '';
  for I := 0 to Length(TrackData) - 1 do
    ConvertTicks(True, TrackData[I].Data);
  while GetNextEvent do begin
    SetLength(Track.Data, Length(Track.Data) + 1);
    Track.Data[Length(Track.Data) - 1] := Cmd;
  end;
  SetLength(Track.Data, Length(Track.Data) + 1);
  if Length(Track.Data) > 1 then
    Track.Data[Length(Track.Data) - 1].Ticks := Track.Data[Length(Track.Data) - 2].Ticks
  else
    Track.Data[Length(Track.Data) - 1].Ticks := 0;
  Track.Data[Length(Track.Data) - 1].Status := $FF;
  Track.Data[Length(Track.Data) - 1].BParm1 := $2F;
  while Length(TrackData) > 0 do
    DelTrack(0);
  AddTrack;
  TrackData[0] := Track;
  for I := 0 to Length(TrackData) - 1 do
    ConvertTicks(False, TrackData[I].Data);
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.MergeTracksByOrder;
var
  I, J: Integer;
  Ticks: UInt64;
begin
  if Length(TrackData) < 2 then begin
    Log.Lines.Add('[-] Merge failed. At least two tracks are required.');
    Exit;
  end;
  Log.Lines.Add('[*] Checking empty tracks...');
  I := 0;
  while I < Length(TrackData) do begin
    if Length(TrackData[I].Data) = 0 then
      DelTrack(I)
    else
      Inc(I);
  end;
  Log.Lines.Add('[*] Clearing EOT events...');
  for I := 0 to Length(TrackData) - 2 do
    if (TrackData[I].Data[Length(TrackData[I].Data) - 1].Status = $FF)
    and(TrackData[I].Data[Length(TrackData[I].Data) - 1].BParm1 = $2F)
    then begin
      Ticks := TrackData[I].Data[Length(TrackData[I].Data) - 1].Ticks;
      TrackData[I + 1].Data[0].Ticks :=
      TrackData[I + 1].Data[0].Ticks + Ticks;
      DelEvent(I, Length(TrackData[I].Data) - 1, False);
    end;
  Log.Lines.Add('[*] Merging tracks...');
  while Length(TrackData) > 1 do begin
    J := Length(TrackData[0].Data);
    SetLength(TrackData[0].Data,
    Length(TrackData[0].Data) + Length(TrackData[1].Data));
    for I := 0 to Length(TrackData[1].Data) - 1 do
      TrackData[0].Data[J + I] := TrackData[1].Data[I];
    DelTrack(1);
  end;
  Log.Lines.Add('[+] Done.');
end;

procedure TMainForm.CopyBufRange(Trk, From, Count: Integer);
var
  I: Integer;
begin
  BCopyBuf:=True;
  SetLength(DCopyBuf, 0);
  SetLength(DCopyBuf, Count);
  for I:=From to From+Count-1 do
    DCopyBuf[I-From]:=TrackData[Trk].Data[I];
  Log.Lines.Add('[*] '+IntToStr(Count)+' events in buffer.');
  ChkButtons;
end;

procedure TMainForm.CopyEvent(SrcTrk, SrcIdx, DestTrk, DestIdx: Integer);
begin
  TrackData[DestTrk].Data[DestIdx]:=TrackData[SrcTrk].Data[SrcIdx];
end;

procedure TMainForm.MOptimizeClick(Sender: TObject);
var
  I,J,K,L: Integer;
  Notes: Array[0..15] of Array of Byte;
  Pitch: Array[0..15] of LongInt;
  Prg: Array[0..15] of SmallInt;
  Ctrl: Array[0..15] of Array[0..127] of SmallInt;
  Counter: UInt64;
  NoteFnd: Boolean;
begin
  if MessageBox(Handle, 'This action will delete unnecessary events and excess '+
  'status bytes (with time saving). You will see effect on resulting file size. '+
  'Do you wish to continue?', 'Optimize song', mb_IconQuestion or mb_YesNo)<>mrYes
  then Exit;
  Log.Lines.Add('[*] Optimizing note off events...');
  Counter:=0;
  for I:=0 to Length(TrackData)-1 do begin
    J:=0;
    while J<Length(TrackData[I].Data) do
      case TrackData[I].Data[J].Status shr 4 of
        8: begin
          NoteFnd:=False;
          for K:=0 to Length(Notes[TrackData[I].Data[J].Status and 15])-1 do
            if Notes[TrackData[I].Data[J].Status and 15][K]=
            TrackData[I].Data[J].BParm1 then begin
              NoteFnd:=True;
              Break;
            end;
          if not NoteFnd then begin
            DelEvent(I, J, True);
            Inc(Counter);
          end else begin
            for L:=K+1 to Length(Notes[TrackData[I].Data[J].Status and 15])-1 do
              Notes[TrackData[I].Data[J].Status and 15][L-1]:=
              Notes[TrackData[I].Data[J].Status and 15][L];
            SetLength(Notes[TrackData[I].Data[J].Status and 15],
            Length(Notes[TrackData[I].Data[J].Status and 15])-1);
            Inc(J);
          end;
        end;
        9: if TrackData[I].Data[J].BParm2=0 then begin
          NoteFnd:=False;
          for K:=0 to Length(Notes[TrackData[I].Data[J].Status and 15])-1 do
            if Notes[TrackData[I].Data[J].Status and 15][K]=
            TrackData[I].Data[J].BParm1 then begin
              NoteFnd:=True;
              Break;
            end;
          if not NoteFnd then begin
            DelEvent(I, J, True);
            Inc(Counter);
          end else begin
            for L:=K+1 to Length(Notes[TrackData[I].Data[J].Status and 15])-1 do
              Notes[TrackData[I].Data[J].Status and 15][L-1]:=
              Notes[TrackData[I].Data[J].Status and 15][L];
            SetLength(Notes[TrackData[I].Data[J].Status and 15],
            Length(Notes[TrackData[I].Data[J].Status and 15])-1);
            Inc(J);
          end;
        end else begin
          NoteFnd:=False;
          for K:=0 to Length(Notes[TrackData[I].Data[J].Status and 15])-1 do
            if Notes[TrackData[I].Data[J].Status and 15][K]=
            TrackData[I].Data[J].BParm1 then begin
              NoteFnd:=True;
              Break;
            end;
          if not NoteFnd then begin
            SetLength(Notes[TrackData[I].Data[J].Status and 15],
            Length(Notes[TrackData[I].Data[J].Status and 15])+1);
            Notes[TrackData[I].Data[J].Status and 15]
            [Length(Notes[TrackData[I].Data[J].Status and 15])-1]:=
            TrackData[I].Data[J].BParm1;
          end;
          Inc(J);
        end;
        else
          Inc(J);
      end;
  end;
  Log.Lines.Add('[+] Deleted '+IntToStr(Counter)+' events.');
  Log.Lines.Add('[*] Optimizing control change events...');
  Counter:=0;
  for I:=0 to 15 do
    for J:=0 to 127 do
      Ctrl[I][J]:=-1;
  for I:=0 to Length(TrackData)-1 do begin
    J:=0;
    while J<Length(TrackData[I].Data) do
      if TrackData[I].Data[J].Status shr 4 = 11 then begin
        if (TrackData[I].Data[J].BParm2 =
        Ctrl[TrackData[I].Data[J].Status and 15][TrackData[I].Data[J].BParm1]) and
        (not TrackData[I].Data[J].BParm1 in [$06,$26,$60,$61,$62,$63,$64,$65]) then begin
          DelEvent(I, J, True);
          Inc(Counter);
        end else begin
          Ctrl[TrackData[I].Data[J].Status and 15][TrackData[I].Data[J].BParm1]:=
          TrackData[I].Data[J].BParm2;
          Inc(J);
        end;
      end else
        Inc(J);
  end;
  Log.Lines.Add('[+] Deleted '+IntToStr(Counter)+' events.');
  Log.Lines.Add('[*] Optimizing program change events...');
  Counter:=0;
  for I:=0 to 15 do
    Prg[I]:=-1;
  for I:=0 to Length(TrackData)-1 do begin
    J:=0;
    while J<Length(TrackData[I].Data) do
      if TrackData[I].Data[J].Status shr 4 = 12 then begin
        if TrackData[I].Data[J].BParm1 = Prg[TrackData[I].Data[J].Status and 15] then begin
          DelEvent(I, J, True);
          Inc(Counter);
        end else begin
          Prg[TrackData[I].Data[J].Status and 15]:=TrackData[I].Data[J].BParm1;
          Inc(J);
        end;
      end else
        Inc(J);
  end;
  Log.Lines.Add('[+] Deleted '+IntToStr(Counter)+' events.');
  Log.Lines.Add('[*] Optimizing pitch bends...');
  Counter:=0;
  for I:=0 to 15 do
    Pitch[I]:=-1;
  for I:=0 to Length(TrackData)-1 do begin
    J:=0;
    while J<Length(TrackData[I].Data) do
      if TrackData[I].Data[J].Status shr 4 = 14 then begin
        if TrackData[I].Data[J].Value = Pitch[TrackData[I].Data[J].Status and 15] then begin
          DelEvent(I, J, True);
          Inc(Counter);
        end else begin
          Pitch[TrackData[I].Data[J].Status and 15]:=TrackData[I].Data[J].Value;
          Inc(J);
        end;
      end else
        Inc(J);
  end;
  Log.Lines.Add('[+] Deleted '+IntToStr(Counter)+' events.');
  Log.Lines.Add('[*] Optimizing status bytes...');
  Counter:=0;
  for I:=0 to Length(TrackData)-1 do
    for J:=1 to Length(TrackData[I].Data)-1 do
      if (TrackData[I].Data[J].Status=TrackData[I].Data[J-1].Status)
      and (TrackData[I].Data[J].Status < $F0) and
      (not TrackData[I].Data[J].RunStatMode) then begin
        TrackData[I].Data[J].RunStatMode:=True;
        Inc(Counter);
      end;
  Log.Lines.Add('[+] Deleted '+IntToStr(Counter)+' excess status bytes.');
  Progress.Position:=0;
  Log.Lines.Add('[+] Done.');
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.MProfileMIDClick(Sender: TObject);
begin
  EventViewProfile := 'mid';
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MProfileXMIClick(Sender: TObject);
begin
  EventViewProfile := 'xmi';
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MProfileMDIClick(Sender: TObject);
begin
  EventViewProfile := 'mdi';
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MProfileCMFClick(Sender: TObject);
begin
  EventViewProfile := 'cmf';
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.MProfileMUSClick(Sender: TObject);
begin
  EventViewProfile := 'mus';
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
  ChkButtons;
end;

procedure TMainForm.PCopyClick(Sender: TObject);
begin
  if ActiveControl <> Events then
    Exit;
  CopyBufRange(TrkCh.ItemIndex, Events.Selection.Top-1,
  Events.Selection.Bottom-Events.Selection.Top+1);
end;

procedure TMainForm.PCopyTextClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(PWideChar(Events.Cells[Events.Col, Events.Row]));
end;

procedure TMainForm.PCutClick(Sender: TObject);
begin
  if ActiveControl <> Events then
    Exit;
  CopyBufRange(TrkCh.ItemIndex, Events.Selection.Top-1,
  Events.Selection.Bottom-Events.Selection.Top+1);
  DelRange(TrkCh.ItemIndex, Events.Selection.Top-1,
  Events.Selection.Bottom-Events.Selection.Top+1, True);
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.PPasteClick(Sender: TObject);
var
  I,E,Trk,Cnt: Integer;
begin
  if ActiveControl <> Events then
    Exit;
  Cnt:=Length(DCopyBuf);
  Trk:=TrkCh.ItemIndex;
  E:=0;
  if Length(TrackData[Trk].Data)>0 then
    E:=Events.Row-1;
  SetLength(TrackData[Trk].Data, Length(TrackData[Trk].Data)+Cnt);
  for I:=Length(TrackData[Trk].Data)-1 downto E+Cnt do
    TrackData[Trk].Data[I]:=TrackData[Trk].Data[I-Cnt];
  for I:=0 to Cnt-1 do
    TrackData[Trk].Data[I+E]:=DCopyBuf[I];
  FillEvents(TrkCh.ItemIndex);
  ChkButtons;
  CalculateEvnts;
end;

procedure TMainForm.MLoopSongClick(Sender: TObject);
begin
  LoopEnabled := not LoopEnabled;
  MLoopSong.Checked := LoopEnabled;
end;

procedure TMainForm.MW32RefreshClick(Sender: TObject);
var
  C: Cardinal;
  I: Integer;
  lpCaps: TMidiOutCaps;
  M: TMenuItem;
begin
  C := 0;
  while MWin32.Count > 3 do
  begin
    M := MWin32.FindComponent('MW32_' + IntToStr(C)) as TMenuItem;
    M.Free;
    Inc(C);
  end;
  C := midiOutGetNumDevs();
  for I := 0 to C - 1 do
    if midiOutGetDevCaps(Cardinal(I), @lpCaps, SizeOf(lpCaps)) = MMSYSERR_NOERROR then
    begin
      M := TMenuItem.Create(MWin32);
      M.Name := 'MW32_' + IntToStr(I);
      M.RadioItem := True;
      M.Checked := Integer(MIDIDev) = I;
      M.Caption := lpCaps.szPname;
      M.OnClick := MW32MapperClick;
      MWin32.Add(M);
    end;
end;

procedure TMainForm.MW32MapperClick(Sender: TObject);
var
  M, OM: TMenuItem;
  I: Integer;
begin
  M := Sender as TMenuItem;
  if M.Name = 'MW32Mapper' then
    I := Integer(MIDI_MAPPER)
  else
    I := StrToInt(Copy(M.Name, 6, Length(M.Name) - 5));
  if MIDIDev = MIDI_MAPPER then
    MW32Mapper.Checked := False
  else
  begin
    OM := MWin32.FindComponent('MW32_' + IntToStr(MIDIDev)) as TMenuItem;
    if OM <> nil then
      OM.Checked := False;
  end;
  MIDIDev := DWORD(I);
  M.Checked := True;
  MSynth.Checked := False;
  MWin32.Checked := True;
end;

procedure TMainForm.MOutConfClick(Sender: TObject);
begin
  MessageBox(Handle, 'This feature is not implemented yet.', 'Notice', mb_Ok or mb_IconWarning);
end;

procedure TMainForm.Evnt128Click(Sender: TObject);
begin
  AddEvent($80,0);
end;

procedure TMainForm.Evnt144Click(Sender: TObject);
begin
  AddEvent($90,0);
end;

procedure TMainForm.Evnt160Click(Sender: TObject);
begin
  AddEvent($A0,0);
end;

procedure TMainForm.BankSelect1Click(Sender: TObject);
begin
  AddEvent($B0,$00);
end;

procedure TMainForm.Modulation1Click(Sender: TObject);
begin
  AddEvent($B0,$01);
end;

procedure TMainForm.Breath1Click(Sender: TObject);
begin
  AddEvent($B0,$02);
end;

procedure TMainForm.DX7Aftertouch1Click(Sender: TObject);
begin
  AddEvent($B0,$03);
end;

procedure TMainForm.Foot1Click(Sender: TObject);
begin
  AddEvent($B0,$04);
end;

procedure TMainForm.PortamentoTime1Click(Sender: TObject);
begin
  AddEvent($B0,$05);
end;

procedure TMainForm.DataEntryMSB1Click(Sender: TObject);
begin
  AddEvent($B0,$06);
end;

procedure TMainForm.Volume1Click(Sender: TObject);
begin
  AddEvent($B0,$07);
end;

procedure TMainForm.Balance1Click(Sender: TObject);
begin
  AddEvent($B0,$08);
end;

procedure TMainForm.Other1Click(Sender: TObject);
begin
  AddEvent($B0,$09);
end;

procedure TMainForm.Panning1Click(Sender: TObject);
begin
  AddEvent($B0,$0A);
end;

procedure TMainForm.Expression1Click(Sender: TObject);
begin
  AddEvent($B0,$0B);
end;

procedure TMainForm.Effect11Click(Sender: TObject);
begin
  AddEvent($B0,$0C);
end;

procedure TMainForm.Effect21Click(Sender: TObject);
begin
  AddEvent($B0,$0D);
end;

procedure TMainForm.Generalpurpose11Click(Sender: TObject);
begin
  AddEvent($B0,$10);
end;

procedure TMainForm.Generalpurpose31Click(Sender: TObject);
begin
  AddEvent($B0,$11);
end;

procedure TMainForm.Generalpurpose32Click(Sender: TObject);
begin
  AddEvent($B0,$12);
end;

procedure TMainForm.Generalpurpose41Click(Sender: TObject);
begin
  AddEvent($B0,$13);
end;

procedure TMainForm.BankselectLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$20);
end;

procedure TMainForm.ModulationLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$21);
end;

procedure TMainForm.BreathLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$22);
end;

procedure TMainForm.DX7AftertouchLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$23);
end;

procedure TMainForm.FootLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$24);
end;

procedure TMainForm.PortamentotimeLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$25);
end;

procedure TMainForm.DataEntryLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$26);
end;

procedure TMainForm.VolumeLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$27);
end;

procedure TMainForm.BalanceLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$28);
end;

procedure TMainForm.PanningLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$2A);
end;

procedure TMainForm.ExpressionLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$2B);
end;

procedure TMainForm.Effect1LSB1Click(Sender: TObject);
begin
  AddEvent($B0,$2C);
end;

procedure TMainForm.Effect2LSB1Click(Sender: TObject);
begin
  AddEvent($B0,$2D);
end;

procedure TMainForm.Generalpurpose1LSB1Click(Sender: TObject);
begin
  AddEvent($B0,$30);
end;

procedure TMainForm.Generalpurpose2LSB1Click(Sender: TObject);
begin
  AddEvent($B0,$31);
end;

procedure TMainForm.Generalpurpose3LSB1Click(Sender: TObject);
begin
  AddEvent($B0,$32);
end;

procedure TMainForm.Generalpurpose4LSB1Click(Sender: TObject);
begin
  AddEvent($B0,$33);
end;

procedure TMainForm.SustainSW1Click(Sender: TObject);
begin
  AddEvent($B0,$40);
end;

procedure TMainForm.Portamento1Click(Sender: TObject);
begin
  AddEvent($B0,$41);
end;

procedure TMainForm.Sustenutopedal1Click(Sender: TObject);
begin
  AddEvent($B0,$42);
end;

procedure TMainForm.Softpedal1Click(Sender: TObject);
begin
  AddEvent($B0,$43);
end;

procedure TMainForm.Legato1Click(Sender: TObject);
begin
  AddEvent($B0,$44);
end;

procedure TMainForm.Hold21Click(Sender: TObject);
begin
  AddEvent($B0,$45);
end;

procedure TMainForm.Soundvariation1Click(Sender: TObject);
begin
  AddEvent($B0,$46);
end;

procedure TMainForm.Harmonique1Click(Sender: TObject);
begin
  AddEvent($B0,$47);
end;

procedure TMainForm.Releasetime1Click(Sender: TObject);
begin
  AddEvent($B0,$48);
end;

procedure TMainForm.Attacktime1Click(Sender: TObject);
begin
  AddEvent($B0,$49);
end;

procedure TMainForm.Cutoff1Click(Sender: TObject);
begin
  AddEvent($B0,$4A);
end;

procedure TMainForm.Decaytime1Click(Sender: TObject);
begin
  AddEvent($B0,$4B);
end;

procedure TMainForm.Vibratorate1Click(Sender: TObject);
begin
  AddEvent($B0,$4C);
end;

procedure TMainForm.Vibratodepth1Click(Sender: TObject);
begin
  AddEvent($B0,$4D);
end;

procedure TMainForm.Vibratodelay1Click(Sender: TObject);
begin
  AddEvent($B0,$4E);
end;

procedure TMainForm.Soundcontroller101Click(Sender: TObject);
begin
  AddEvent($B0,$4F);
end;

procedure TMainForm.Generalpurpose51Click(Sender: TObject);
begin
  AddEvent($B0,$50);
end;

procedure TMainForm.Generalpurpose61Click(Sender: TObject);
begin
  AddEvent($B0,$51);
end;

procedure TMainForm.Generalpurpose71Click(Sender: TObject);
begin
  AddEvent($B0,$52);
end;

procedure TMainForm.Generalpurpose81Click(Sender: TObject);
begin
  AddEvent($B0,$53);
end;

procedure TMainForm.Portamento2Click(Sender: TObject);
begin
  AddEvent($B0,$54);
end;

procedure TMainForm.HiResvelocityprefix1Click(Sender: TObject);
begin
  AddEvent($B0,$58);
end;

procedure TMainForm.Reverbdepth1Click(Sender: TObject);
begin
  AddEvent($B0,$5B);
end;

procedure TMainForm.remolodepth1Click(Sender: TObject);
begin
  AddEvent($B0,$5C);
end;

procedure TMainForm.Chorusdepth1Click(Sender: TObject);
begin
  AddEvent($B0,$5D);
end;

procedure TMainForm.Detunedepth1Click(Sender: TObject);
begin
  AddEvent($B0,$5E);
end;

procedure TMainForm.Phaserdepth1Click(Sender: TObject);
begin
  AddEvent($B0,$5F);
end;

procedure TMainForm.DataEntry11Click(Sender: TObject);
begin
  AddEvent($B0,$60);
end;

procedure TMainForm.DataEntry12Click(Sender: TObject);
begin
  AddEvent($B0,$61);
end;

procedure TMainForm.NRPNLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$62);
end;

procedure TMainForm.NonRegisteredParameterNumberMSB1Click(Sender: TObject);
begin
  AddEvent($B0,$63);
end;

procedure TMainForm.Amplitudevibratodepthcontrol1Click(Sender: TObject);
begin
  AddEvent($B0,$63);
end;

procedure TMainForm.RegisteredParameterNumberLSB1Click(Sender: TObject);
begin
  AddEvent($B0,$64);
end;

procedure TMainForm.RegisteredParameterNumberMSB1Click(Sender: TObject);
begin
  AddEvent($B0,$65);
end;

procedure TMainForm.Setmarkerbyte1Click(Sender: TObject);
begin
  AddEvent($B0,$66);
end;

procedure TMainForm.Rhythmmodechange1Click(Sender: TObject);
begin
  AddEvent($B0,$67);
end;

procedure TMainForm.ransposeup1Click(Sender: TObject);
begin
  AddEvent($B0,$68);
end;

procedure TMainForm.ransposedown1Click(Sender: TObject);
begin
  AddEvent($B0,$69);
end;

procedure TMainForm.AllSoundOff1Click(Sender: TObject);
begin
  AddEvent($B0,$78);
end;

procedure TMainForm.ResetAllControllers1Click(Sender: TObject);
begin
  AddEvent($B0,$79);
end;

procedure TMainForm.Localcontrol1Click(Sender: TObject);
begin
  AddEvent($B0,$7A);
end;

procedure TMainForm.Loopend1Click(Sender: TObject);
begin
  AddEvent($B0,$75);
end;

procedure TMainForm.Loopstart1Click(Sender: TObject);
begin
  AddEvent($B0,$74);
end;

procedure TMainForm.Allnotesoff1Click(Sender: TObject);
begin
  AddEvent($B0,$7B);
end;

procedure TMainForm.Omnimodeoff1Click(Sender: TObject);
begin
  AddEvent($B0,$7C);
end;

procedure TMainForm.Omnimodeon1Click(Sender: TObject);
begin
  AddEvent($B0,$7D);
end;

procedure TMainForm.Monomodeon1Click(Sender: TObject);
begin
  AddEvent($B0,$7E);
end;

procedure TMainForm.Polymodeon1Click(Sender: TObject);
begin
  AddEvent($B0,$7F);
end;

procedure TMainForm.Evnt192Click(Sender: TObject);
begin
  AddEvent($C0,0);
end;

procedure TMainForm.Evnt208Click(Sender: TObject);
begin
  AddEvent($D0,0);
end;

procedure TMainForm.Evnt224Click(Sender: TObject);
begin
  AddEvent($E0,0);
end;

procedure TMainForm.MSystem0Click(Sender: TObject);
begin
  AddEvent($F0,0);
end;

procedure TMainForm.MSystem1Click(Sender: TObject);
begin
  AddEvent($F1,0);
end;

procedure TMainForm.MSystem2Click(Sender: TObject);
begin
  AddEvent($F2,0);
end;

procedure TMainForm.MSystem3Click(Sender: TObject);
begin
  AddEvent($F3,0);
end;

procedure TMainForm.MSystem6Click(Sender: TObject);
begin
  AddEvent($F6,0);
end;

procedure TMainForm.MSystem7Click(Sender: TObject);
begin
  AddEvent($F7,0);
end;

procedure TMainForm.MSystem8Click(Sender: TObject);
begin
  AddEvent($F8,0);
end;

procedure TMainForm.MSystem10Click(Sender: TObject);
begin
  AddEvent($FA,0);
end;

procedure TMainForm.MSystem11Click(Sender: TObject);
begin
  AddEvent($FB,0);
end;

procedure TMainForm.MSystem12Click(Sender: TObject);
begin
  AddEvent($FC,0);
end;

procedure TMainForm.MSystem14Click(Sender: TObject);
begin
  AddEvent($FE,0);
end;

procedure TMainForm.MMerge1Click(Sender: TObject);
begin
  if MessageBox(Handle, 'This action will merge all tracks into one '+
  'by delta ticks. It''s useful when you want to convert '+
  'multi-track MIDI-1 format to single multi-channel track MIDI-0. '+
  'Do you wish to continue?', 'Merge tracks by ticks', mb_IconQuestion or mb_YesNo)<>mrYes
  then Exit;
  MergeTracksByTicks;
  RefTrackList;
  TrkCh.ItemIndex := 0;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
end;

procedure TMainForm.MMerge2Click(Sender: TObject);
begin
  if MessageBox(Handle, 'This action will merge all tracks into one '+
  'sequently by order. It''s useful when you want to convert '+
  'multi-song MIDI-2 format to single multi-channel track MIDI-0. '+
  'Do you wish to continue?', 'Merge tracks by order', mb_IconQuestion or mb_YesNo)<>mrYes
  then Exit;
  MergeTracksByOrder;
  RefTrackList;
  TrkCh.ItemIndex := 0;
  FillEvents(TrkCh.ItemIndex);
  CalculateEvnts;
end;

procedure TMainForm.MMeta0Click(Sender: TObject);
begin
  AddEvent($FF,$00);
end;

procedure TMainForm.MMeta1Click(Sender: TObject);
begin
  AddEvent($FF,$01);
end;

procedure TMainForm.MMeta2Click(Sender: TObject);
begin
  AddEvent($FF,$02);
end;

procedure TMainForm.MMeta3Click(Sender: TObject);
begin
  AddEvent($FF,$03);
end;

procedure TMainForm.MMeta4Click(Sender: TObject);
begin
  AddEvent($FF,$04);
end;

procedure TMainForm.MMeta5Click(Sender: TObject);
begin
  AddEvent($FF,$05);
end;

procedure TMainForm.MMeta6Click(Sender: TObject);
begin
  AddEvent($FF,$06);
end;

procedure TMainForm.MMeta7Click(Sender: TObject);
begin
  AddEvent($FF,$07);
end;

procedure TMainForm.MMetaOtherClick(Sender: TObject);
begin
  AddEvent($FF,$09);
end;

procedure TMainForm.MMeta32Click(Sender: TObject);
begin
  AddEvent($FF,$20);
end;

procedure TMainForm.MMeta33Click(Sender: TObject);
begin
  AddEvent($FF,$21);
end;

procedure TMainForm.MMeta47Click(Sender: TObject);
begin
  AddEvent($FF,$2F);
end;

procedure TMainForm.MMeta81Click(Sender: TObject);
begin
  AddEvent($FF,$51);
end;

procedure TMainForm.MMeta84Click(Sender: TObject);
begin
  AddEvent($FF,$54);
end;

procedure TMainForm.MMeta88Click(Sender: TObject);
begin
  AddEvent($FF,$58);
end;

procedure TMainForm.MMeta89Click(Sender: TObject);
begin
  AddEvent($FF,$59);
end;

procedure TMainForm.MMeta127Click(Sender: TObject);
begin
  AddEvent($FF,$7F);
end;

procedure TMainForm.VisualTimerTimer(Sender: TObject);
const
  Pad = 5;
  Wid = 11;
  Ofs = 3;
  FallSpeed = 4;
var
  TrkIdx, I: Integer;
  V: Byte;
  VV: Word;
begin
  if vChangeTrack then begin
    if (vTrkIndex >= 0) and (vTrkIndex < Length(TrackData)) then begin
      try
        TrkCh.ItemIndex := vTrkIndex;
        TrkChChange(nil);
      except

      end;
    end;
    vChangeTrack := False;
  end;
  if vChangeEvent then begin
    TrkIdx := TrkCh.ItemIndex;
    if vTrkIndex = TrkIdx then begin
      if (vEvntIndex >= 0) and (vEvntIndex < Length(TrackData[TrkIdx].Data)) then
        if vEvntIndex < Events.RowCount then
          Events.Row := vEvntIndex + 1;
    end;
    vChangeEvent := False;
  end;
  for I := 0 to 15 do begin
    V := Round(VU[I]*imgVU.Height/127);
    VV := Round(VU[I]*255/127)+64;
    if VV > 255 then
      VV := 255;
    imgVU.Canvas.Pen.Color := clBlack;
    imgVU.Canvas.Brush.Color := clBlack;
    imgVU.Canvas.Rectangle(I*(Wid+Ofs)+Pad, 0, I*(Wid+Ofs)+Pad+Wid, imgVU.Height - V - 1);
    imgVU.Canvas.Pen.Color := RGB(0, VV, 0);
    imgVU.Canvas.Brush.Color := RGB(0, VV, 0);
    imgVU.Canvas.Rectangle(I*(Wid+Ofs)+Pad, imgVU.Height - V, I*(Wid+Ofs)+Pad+Wid, imgVU.Height);
    if VU[I] > 0 then begin
      if VU[I] <= FallSpeed then
        VU[I] := 0
      else
        Dec(VU[I], FallSpeed);
    end;
  end;
end;

end.
