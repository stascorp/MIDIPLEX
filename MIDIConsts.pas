unit MIDIConsts;

interface

uses SysUtils;

function NoteNum(Note: Byte): String;
function GetManufacturerID(Data: Cardinal; var Len: Byte): AnsiString;
function SysExProcess(Data: Array of Byte): AnsiString;

const
  InstrumentTable: Array[0..127] of AnsiString =
  (
    'Acoustic Grand Piano', 'Bright Acoustic Piano', 'Electric Grand Piano', 'Honky-Tonk Piano',
    'Electric Piano 1', 'Electric Piano 2', 'Harpsichord', 'Clavinet',
    'Celesta', 'Glockenspiel', 'Music Box', 'Vibraphone',
    'Marimba', 'Xylophone', 'Tubular Bells', 'Dulcimer',
    'Drawbar Organ', 'Percussive Organ', 'Rock Organ', 'Church Organ',
    'Reed Organ', 'Accordion', 'Harmonica', 'Tango Accordion',
    'Acoustic Guitar (nylon)', 'Acoustic Guitar (steel)', 'Electric Guitar (jazz)', 'Electric Guitar (clean)',
    'Electric Guitar (muted)', 'Overdriven Guitar', 'Distortion Guitar', 'Guitar Harmonics',
    'Acoustic Bass', 'Electric Bass (finger)', 'Electric Bass (pick)', 'Fretless Bass',
    'Slap Bass 1', 'Slap Bass 2', 'Synth Bass 1', 'Synth Bass 2',
    'Violin', 'Viola', 'Cello', 'Contrabass',
    'Tremolo Strings', 'Pizzicato Strings', 'Orchestral Harp', 'Timpani',
    'String Ensemble 1', 'String Ensemble 2', 'SynthStrings 1', 'SynthStrings 2',
    'Choir Aahs', 'Voice Oohs', 'Synth Voice', 'Orchestra Hit',
    'Trumpet', 'Trombone', 'Tuba', 'Muted Trumpet',
    'French Horn', 'Brass Section', 'SynthBrass 1', 'SynthBrass 2',
    'Soprano Sax', 'Alto Sax', 'Tenor Sax', 'Baritone Sax',
    'Oboe', 'English Horn', 'Bassoon', 'Clarinet',
    'Piccolo', 'Flute', 'Recorder', 'Pan Flute',
    'Blown Bottle', 'Skakuhachi', 'Whistle', 'Ocarina',
    'Lead 1 (square)', 'Lead 2 (sawtooth)', 'Lead 3 (calliope)', 'Lead 4 (chiff)',
    'Lead 5 (charang)', 'Lead 6 (voice)', 'Lead 7 (fifths)', 'Lead 8 (bass + lead)',
    'Pad 1 (new age)', 'Pad 2 (warm)', 'Pad 3 (polysynth)', 'Pad 4 (choir)',
    'Pad 5 (bowed)', 'Pad 6 (metallic)', 'Pad 7 (halo)', 'Pad 8 (sweep)',
    'FX 1 (rain)', 'FX 2 (soundtrack)', 'FX 3 (crystal)', 'FX 4 (atmosphere)',
    'FX 5 (brightness)', 'FX 6 (goblins)', 'FX 7 (echoes)', 'FX 8 (sci-fi)',
    'Sitar', 'Banjo', 'Shamisen', 'Koto',
    'Kalimba', 'Bag Pipe', 'Fiddle', 'Shanai',
    'Tinkle Bell', 'Agogo', 'Steel Drums', 'Woodblock',
    'Taiko Drum', 'Melodic Tom', 'Synth Drum', 'Reverse Cymbal',
    'Guitar Fret Noise', 'Breath Noise', 'Seashore', 'Bird Tweet',
    'Telephone Ring', 'Helicopter', 'Applause', 'Gunshot'
  );
  DrumKits: Array[0..127] of AnsiString =
  (
    'Standard', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Room', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Power', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Electronic', 'TR-808', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Jazz', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Brush', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Orchestra', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Sound FX', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'CM-64/CM-32L'
  );
  DrumTable: Array[0..127] of AnsiString =
  (
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Snare Roll', 'Finger Snap', 'High Q',
    'Slap', 'Scratch Push', 'Scratch Pull', 'Sticks',
    'Square Click', 'Metronome Click', 'Metronome Bell', 'Acoustic Bass Drum',
    'Bass Drum 1', 'Side Stick', 'Acoustic Snare', 'Hand Clap',
    'Electric Snare', 'Low Floor Tom', 'Closed Hi-Hat', 'High Floor Tom',
    'Pedal Hi-Hat', 'Low Tom', 'Open Hi-Hat', 'Low-Mid Tom',
    'Hi-Mid Tom', 'Crash Cymbal 1', 'High Tom', 'Ride Cymbal 1',
    'Chinese Cymbal', 'Ride Bell', 'Tambourine', 'Splash Cymbal',
    'Cowbell', 'Crash Cymbal 2', 'Vibraslap', 'Ride Cymbal 2',
    'Hi Bongo', 'Low Bongo', 'Mute Hi Conga', 'Open Hi Conga',
    'Low Conga', 'High Timbale', 'Low Timbale', 'High Agogo',
    'Low Agogo', 'Cabasa', 'Maracas', 'Short Whistle',
    'Long Whistle', 'Short Guiro', 'Long Guiro', 'Claves',
    'Hi Wood Block', 'Low Wood Block', 'Mute Cuica', 'Open Cuica',
    'Mute Triangle', 'Open Triangle', 'Shaker', 'Jingle Bell',
    'Belltree', 'Castanets', 'Mute Surdo', 'Open Surdo',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined',
    'Undefined', 'Undefined', 'Undefined', 'Undefined'
  );
  ControlTable: Array[0..127] of AnsiString =
  (
    'Bank Select', 'Modulation', 'Breath', 'DX7 Aftertouch',
    'Foot', 'Portamento Time', 'Data Entry', 'Volume',
    'Balance', 'Undefined [09]', 'Panning', 'Expression',
    'Effect 1', 'Effect 2', 'Undefined [0E]', 'Undefined [0F]',
    'General Purpose 1', 'General Purpose 2', 'General Purpose 3', 'General Purpose 4',
    'Undefined [14]', 'Undefined [15]', 'Undefined [16]', 'Undefined [17]',
    'Undefined [18]', 'Undefined [19]', 'Undefined [1A]', 'Undefined [1B]',
    'Undefined [1C]', 'Undefined [1D]', 'Undefined [1E]', 'Undefined [1F]',
    'Bank Select LSB', 'Modulation LSB', 'Breath LSB', 'DX7 Aftertouch LSB',
    'Foot LSB', 'Portamento Time LSB', 'Data Entry LSB', 'Volume LSB',
    'Balance LSB', 'Undefined [29] LSB', 'Panning LSB', 'Expression LSB',
    'Effect 1 LSB', 'Effect 2 LSB', 'Undefined [2E] LSB', 'Undefined [2F] LSB',
    'General Purpose 1 LSB', 'General Purpose 2 LSB', 'General Purpose 3 LSB', 'General Purpose 4 LSB',
    'Undefined [34] LSB', 'Undefined [35] LSB', 'Undefined [36] LSB', 'Undefined [37] LSB',
    'Undefined [38] LSB', 'Undefined [39] LSB', 'Undefined [3A] LSB', 'Undefined [3B] LSB',
    'Undefined [3C] LSB', 'Undefined [3D] LSB', 'Undefined [3E] LSB', 'Undefined [3F] LSB',
    'Sustain SW', 'Portamento SW', 'Sustenuto Pedal SW', 'Soft Pedal SW',
    'Legato SW', 'Hold 2 SW', 'Sound Variation SW', 'Harmonique SW',
    'Release Time', 'Attack Time', 'Cutoff', 'Decay Time',
    'Vibrato Rate', 'Vibrato Depth', 'Vibrato Delay', 'Sound Controller 10',
    'General Purpose 5', 'General Purpose 6', 'General Purpose 7', 'General Purpose 8',
    'Portamento Control', 'Undefined [55]', 'Undefined [56]', 'Undefined [57]',
    'Hi-Res Velocity Prefix', 'Undefined [59]', 'Undefined [5A]', 'Reverb Depth',
    'Tremolo Depth', 'Chorus Depth', 'Detune Depth', 'Phaser Depth',
    'Data Entry +1', 'Data Entry -1', 'NRPN LSB', 'NRPN MSB',
    'RPN LSB', 'RPN MSB', 'Undefined [66]', 'Undefined [67]',
    'Undefined [68]', 'Undefined [69]', 'Undefined [6A]', 'Undefined [6B]',
    'Undefined [6C]', 'Undefined [6D]', 'Undefined [6E]', 'Undefined [6F]',
    'Undefined [70]', 'Undefined [71]', 'Undefined [72]', 'Undefined [73]',
    'Loop Start (XMI)', 'Loop End (XMI)', 'Loop Point', 'Undefined [77]',
    'All Sound Off', 'Reset All Controllers', 'Local Control SW', 'All Notes Off',
    'Omni Mode Off', 'Omni Mode On', 'Mono Mode On', 'Poly Mode On'
  );
  SystemTable: Array[0..15] of AnsiString =
  (
    'Exclusive',
    'Quarter Frame',
    'Song Position Pointer',
    'Song Select',
    'Undefined [4]',
    'Undefined [5]',
    'Tune Request',
    'End of SysEx (EOX)',
    'Timing Clock',
    'Undefined [9]',
    'Start',
    'Continue',
    'Stop',
    'Undefined [D]',
    'Active Sensing',
    'Meta Event'
  );
  MetaTable: Array[0..127] of AnsiString =
  (
    'Sequence Number', 'Text', 'Copyright', 'Track Name',
    'Instrument Name', 'Lyrics', 'Marker', 'Cue Point',
    'Undefined [08]', 'Undefined [09]', 'Undefined [0A]', 'Undefined [0B]',
    'Undefined [0C]', 'Undefined [0D]', 'Undefined [0E]', 'Undefined [0F]',
    'Undefined [10]', 'Undefined [11]', 'Undefined [12]', 'Undefined [13]',
    'Undefined [14]', 'Undefined [15]', 'Undefined [16]', 'Undefined [17]',
    'Undefined [18]', 'Undefined [19]', 'Undefined [1A]', 'Undefined [1B]',
    'Undefined [1C]', 'Undefined [1D]', 'Undefined [1E]', 'Undefined [1F]',
    'MIDI Channel', 'MIDI Port', 'Undefined [22]', 'Undefined [23]',
    'Undefined [24]', 'Undefined [25]', 'Undefined [26]', 'Undefined [27]',
    'Undefined [28]', 'Undefined [29]', 'Undefined [2A]', 'Undefined [2B]',
    'Undefined [2C]', 'Undefined [2D]', 'Undefined [2E]', 'End Of Track',
    'Undefined [30]', 'Undefined [31]', 'Undefined [32]', 'Undefined [33]',
    'Undefined [34]', 'Undefined [35]', 'Undefined [36]', 'Undefined [37]',
    'Undefined [38]', 'Undefined [39]', 'Undefined [3A]', 'Undefined [3B]',
    'Undefined [3C]', 'Undefined [3D]', 'Undefined [3E]', 'Undefined [3F]',
    'Undefined [40]', 'Undefined [41]', 'Undefined [42]', 'Undefined [43]',
    'Undefined [44]', 'Undefined [45]', 'Undefined [46]', 'Undefined [47]',
    'Undefined [48]', 'Undefined [49]', 'Undefined [4A]', 'Undefined [4B]',
    'Undefined [4C]', 'Undefined [4D]', 'Undefined [4E]', 'Undefined [4F]',
    'Undefined [50]', 'Tempo', 'Undefined [52]', 'Undefined [53]',
    'SMPTE Offset', 'Undefined [55]', 'Undefined [56]', 'Undefined [57]',
    'Time Signature', 'Key Signature', 'Undefined [5A]', 'Undefined [5B]',
    'Undefined [5C]', 'Undefined [5D]', 'Undefined [5E]', 'Undefined [5F]',
    'Undefined [60]', 'Undefined [61]', 'Undefined [62]', 'Undefined [63]',
    'Undefined [64]', 'Undefined [65]', 'Undefined [66]', 'Undefined [67]',
    'Undefined [68]', 'Undefined [69]', 'Undefined [6A]', 'Undefined [6B]',
    'Undefined [6C]', 'Undefined [6D]', 'Undefined [6E]', 'Undefined [6F]',
    'Undefined [70]', 'Undefined [71]', 'Undefined [72]', 'Undefined [73]',
    'Undefined [74]', 'Undefined [75]', 'Undefined [76]', 'Undefined [77]',
    'Undefined [78]', 'Undefined [79]', 'Undefined [7A]', 'Undefined [7B]',
    'Undefined [7C]', 'Undefined [7D]', 'Undefined [7E]', 'Sequencer-Specific'
  );
  RPN: Array[0..4] of AnsiString =
  ('Pitch Bend Sensitivity', 'Fine Tuning', 'Coarse Tuning',
   'Tuning Program Select', 'Tuning Bank Select');

implementation

function NoteNum(Note: Byte): String;
var
  N: String;
begin
  case Note mod 12 of
    0: N:='C';
    1: N:='C#';
    2: N:='D';
    3: N:='D#';
    4: N:='E';
    5: N:='F';
    6: N:='F#';
    7: N:='G';
    8: N:='G#';
    9: N:='A';
    10: N:='A#';
    11: N:='B';
  end;
  Result:=N+IntToStr(Note div 12);
end;

function GetManufacturerID(Data: Cardinal; var Len: Byte): AnsiString;
begin
  Result:='';
  if Data and $FF = $00 then
    Len := 3
  else
    Len := 1;
  case Data and $FF of
    $00: case (Data shr 8) and $FF of
      // American (0001-1F7F)
      $00: case (Data shr 16) and $FF of
        $07: Result:='Digital Music Corporation';
        $0E: Result:='Alesis';
        $15: Result:='KAT';
        $16: Result:='Opcode';
        $1A: Result:='Allen & Heath Brenell';
        $1B: Result:='Peavey Electronics';
        $1C: Result:='360 Systems';
        $20: Result:='Axxes';
        $3F: Result:='Ad Lib';
        $74: Result:='Ta Horng Musical Instrument';
        $75: Result:='e-Tek Labs (Forte Tech)';
        $76: Result:='Electro-Voice';
        $77: Result:='Midisoft Corporation';
        $78: Result:='QSound Labs';
        $79: Result:='Westrex';
        $7A: Result:='Nvidia';
        $7B: Result:='ESS Technology';
        $7C: Result:='Media Trix Peripherals';
        $7D: Result:='Brooktree Corp';
        $7E: Result:='Otari Corp';
        $7F: Result:='Key Electronics';
      end;
      $01: case (Data shr 16) and $FF of
        $00: Result:='Shure';
        $01: Result:='AuraSound';
        $02: Result:='Crystal Semiconductor';
        $03: Result:='Conexant (Rockwell)';
        $04: Result:='Silicon Graphics';
        $05: Result:='M-Audio (Midiman)';
        $06: Result:='PreSonus';
        $08: Result:='Topaz Enterprises';
        $09: Result:='Cast Lighting';
        $0A: Result:='Microsoft';
        $0B: Result:='Sonic Foundry';
        $0C: Result:='Line 6 (Fast Forward)';
        $0D: Result:='Beatnik';
        $0E: Result:='Van Koevering Company';
        $0F: Result:='Altech Systems';
        $10: Result:='S & S Research';
        $11: Result:='VLSI Technology';
        $12: Result:='Chromatic Research';
        $13: Result:='Sapphire';
        $14: Result:='IDRC';
        $15: Result:='Justonic Tuning';
        $16: Result:='TorComp Research';
        $17: Result:='Newtek';
        $18: Result:='Sound Sculpture';
        $19: Result:='Walker Technical';
        $1A: Result:='Digital Harmony (PAVO)';
        $1B: Result:='InVision Interactive';
        $1C: Result:='T-Square Design';
        $1D: Result:='Nemesys Music Technology';
        $1E: Result:='DBX Professional (Harman Intl)';
        $1F: Result:='Syndyne Corporation';
        $20: Result:='Bitheadz';
        $21: Result:='Cakewalk Music Software';
        $22: Result:='Analog Devices';
        $23: Result:='National Semiconductor';
        $24: Result:='Boom Theory / Adinolfi Alternative Percussion';
        $25: Result:='Virtual DSP Corporation';
        $26: Result:='Antares Systems';
        $27: Result:='Angel Software';
        $28: Result:='St. Louis Music';
        $29: Result:='Lyrrus dba G-VOX';
        $2A: Result:='Ashley Audio';
        $2B: Result:='Vari-Lite';
        $2C: Result:='Summit Audio';
        $2D: Result:='Aureal Semiconductor';
        $2E: Result:='SeaSound LLC';
        $2F: Result:='U.S. Robotics';
        $30: Result:='Aurisis Research';
        $31: Result:='Nearfield Research';
        $32: Result:='FM7';
        $33: Result:='Swivel Systems';
        $34: Result:='Hyperactive Audio Systems';
        $35: Result:='MidiLite (Castle Studios Productions)';
        $36: Result:='Radikal Technologies';
        $37: Result:='Roger Linn Design';
        $38: Result:='TC-Helicon Vocal Technologies';
        $39: Result:='Event Electronics';
        $3A: Result:='Sonic Network';
        $3B: Result:='Realtime Music Solutions';
        $3C: Result:='Apogee Digital';
        $3D: Result:='Classical Organs';
        $3E: Result:='Microtools';
        $3F: Result:='Numark Industries';
        $40: Result:='Frontier Design Group';
        $41: Result:='Recordare LLC';
        $42: Result:='Starr Labs';
        $43: Result:='Voyager Sound';
        $44: Result:='Manifold Labs';
        $45: Result:='Aviom';
        $46: Result:='Mixmeister Technology';
        $47: Result:='Notation Software';
        $48: Result:='Mercurial Communications';
        $49: Result:='Wave Arts';
        $4A: Result:='Logic Sequencing Devices';
        $4B: Result:='Axess Electronics';
        $4C: Result:='Muse Research';
        $4D: Result:='Open Labs';
        $4E: Result:='Guillemot R&D';
        $4F: Result:='Samson Technologies';
        $50: Result:='Electronic Theatre Controls';
        $51: Result:='Research in Motion';
        $52: Result:='Mobileer';
        $53: Result:='Synthogy';
        $54: Result:='Lynx Studio Technology';
        $55: Result:='Damage Control Engineering';
        $56: Result:='Yost Engineering';
        $57: Result:='Brooks & Forsman Designs LLC / DrumLite';
        $58: Result:='Infinite Response';
        $59: Result:='Garritan Corp';
        $5A: Result:='Plogue Art et Technologie';
        $5B: Result:='RJM Music Technology';
        $5C: Result:='Custom Solutions Software';
        $5D: Result:='Sonarcana LLC';
        $5E: Result:='Centrance';
        $5F: Result:='Kesumo LLC';
        $60: Result:='Stanton';
        $61: Result:='Livid Instruments';
        $62: Result:='First Act / 745 Media';
        $63: Result:='Pygraphics';
        $64: Result:='Panadigm Innovations';
        $65: Result:='Avedis Zildjian Co';
        $66: Result:='Auvital Music Corp';
        $67: Result:='Inspired Instruments';
        $68: Result:='Chris Grigg Designs';
        $69: Result:='Slate Digital';
        $6A: Result:='Mixware';
        $6B: Result:='Social Entropy';
        $6C: Result:='Source Audio';
        $70: Result:='American Audio/DJ';
        $71: Result:='Mega Control Systems';
        $72: Result:='Kilpatrick Audio';
        $73: Result:='iConnectivity';
        $74: Result:='Fractal Audio';
        $75: Result:='NetLogic Microsystems';
        $76: Result:='Music Computing';
        $77: Result:='Nektar Technology';
        $78: Result:='Zenph Sound Innovations';
        $79: Result:='DJTechTools.com';
        $7A: Result:='Rezonance Labs';
        $7B: Result:='Decibel Eleven';
        $7C: Result:='CNMAT';
        $7D: Result:='Media Overkill';
        $7E: Result:='Confusionists LLC';
        $7F: Result:='moForte Inc';
      end;
      $02: case (Data shr 16) and $FF of
        $00: Result:='Miselu Inc';
        $01: Result:='Amelia''s Compass LLC';
        $02: Result:='Zivix LLC';
        $03: Result:='Artiphon';
        $04: Result:='Synclavier Digital';
        $05: Result:='Light & Sound Control Devices LLC';
        $06: Result:='Retronyms Inc';
        $07: Result:='JS Technologies';
      end;
      // European (2000-3F7F)
      $20: case (Data shr 16) and $FF of
        $27: Result:='Acorn Computer';
        $29: Result:='Novation Digital Music System';
        $2A: Result:='Samkyung Mechatronics';
        $2B: Result:='Medeli Electronics';
        $2C: Result:='Charlie Lab SRL';
        $2D: Result:='Blue Chip Music Technology';
        $2E: Result:='BEE OH Corp';
        $2F: Result:='LG Semicon America';
        $30: Result:='TESI';
        $31: Result:='EMAGIC';
        $32: Result:='Behringer GmbH';
        $33: Result:='Access Music Electronics';
        $34: Result:='Synoptic';
        $35: Result:='Hanmesoft';
        $36: Result:='Terratec Electronic GmbH';
        $37: Result:='Proel SpA';
        $38: Result:='IBK MIDI';
        $39: Result:='IRCAM';
        $3A: Result:='Propellerhead Software';
        $3B: Result:='Red Sound Systems';
        $3C: Result:='Elektron ESI AB';
        $3D: Result:='Sintefex Audio';
        $3E: Result:='MAM (Music and More)';
        $3F: Result:='Amsaro GmbH';
        $40: Result:='CDS Advanced Technology BV';
        $41: Result:='Touched By Sound GmbH';
        $42: Result:='DSP Arts';
        $43: Result:='Phil Rees Music Tech';
        $44: Result:='Stamer Muiskanlagen GmbH';
        $45: Result:='Musical Muntaner S.A. dba Soundart';
        $46: Result:='C-Mexx Software';
        $47: Result:='Klavis Technologies';
        $48: Result:='Noteheads AB';
        $49: Result:='Algorithmix';
        $4A: Result:='Skrydstrup R&D';
        $4B: Result:='Professional Audio Company';
        $4C: Result:='NewWave Labs (MadWaves)';
        $4D: Result:='Vermona';
        $4E: Result:='Nokia';
        $4F: Result:='Wave Idea';
        $50: Result:='Hartmann GmbH';
        $51: Result:='Lion''s Tracs';
        $52: Result:='Analogue Systems';
        $53: Result:='Focal-JMlab';
        $54: Result:='Ringway Electronics (Chang-Zhou)';
        $55: Result:='Faith Technologies (Digiplug)';
        $56: Result:='Showworks';
        $57: Result:='Manikin Electronic';
        $58: Result:='1 Come Tech';
        $59: Result:='Phonic Corp';
        $5A: Result:='Dolby Australia (Lake)';
        $5B: Result:='Silansys Technologies';
        $5C: Result:='Winbond Electronics';
        $5D: Result:='Cinetix Medien und Interface GmbH';
        $5E: Result:='A&G Soluzioni Digitali';
        $5F: Result:='Sequentix Music Systems';
        $60: Result:='Oram Pro Audio';
        $61: Result:='Be4 Ltd';
        $62: Result:='Infection Music';
        $63: Result:='Central Music Co. (CME)';
        $64: Result:='genoQs Machines GmbH';
        $65: Result:='Medialon';
        $66: Result:='Waves Audio';
        $67: Result:='Jerash Labs';
        $68: Result:='Da Fact';
        $69: Result:='Elby Designs';
        $6A: Result:='Spectral Audio';
        $6B: Result:='Arturia';
        $6C: Result:='Vixid';
        $6D: Result:='C-Thru Music';
        $6E: Result:='Ya Horng Electronic';
        $6F: Result:='SM Pro Audio';
        $70: Result:='OTO MACHINES';
        $71: Result:='ELZAB S.A., G LAB';
        $72: Result:='Blackstar Amplification';
        $73: Result:='M3i Technologies GmbH';
        $74: Result:='Gemalto (from Xiring)';
        $75: Result:='Prostage SL';
        $76: Result:='Teenage Engineering';
        $77: Result:='Tobias Erichsen Consulting';
        $78: Result:='Nixer Ltd';
        $79: Result:='Hanpin Electron';
        $7A: Result:='"MIDI-hardware" R.Sowa';
        $7B: Result:='Beyond Music Industrial';
        $7C: Result:='Kiss Box B.V.';
        $7D: Result:='Misa Digital Technologies';
        $7E: Result:='AI Musics Technology';
        $7F: Result:='Serato Inc LP';
      end;
      $21: case (Data shr 16) and $FF of
        $00: Result:='Limex Music Handels GmbH';
        $01: Result:='Kyodday/Tokai';
        $02: Result:='Mutable Instruments';
        $03: Result:='PreSonus Software';
        $04: Result:='Xiring';
        $05: Result:='Fairlight Instruments';
        $06: Result:='Musicom Lab';
        $07: Result:='VacoLoco';
        $08: Result:='RWA (Hong Kong)';
        $09: Result:='Native Instruments';
        $0A: Result:='Naonext';
        $0B: Result:='MFB';
        $0C: Result:='Teknel Research';
        $0D: Result:='Ploytec GmbH';
        $0E: Result:='Surfin Kangaroo Studio';
        $0F: Result:='Philips Electronics HK Ltd';
        $10: Result:='ROLI Ltd';
        $11: Result:='Panda-Audio Ltd';
        $12: Result:='BauM Software';
        $13: Result:='Machinewerks Ltd';
        $14: Result:='Xiamen Elane Electronics';
        $15: Result:='Marshall Amplification PLC';
        $16: Result:='Kiwitechnics Ltd';
        $17: Result:='Rob Papen';
        $18: Result:='Spicetone OU';
        $19: Result:='V3Sound';
      end;
      // Japanese (4000-5F7F)
      $40: case (Data shr 16) and $FF of
        $00: Result:='Crimson Technology';
        $01: Result:='Softbank Mobile';
        $03: Result:='D&M Holdings';
      end;
      // Other (6000-7F7F)
    end;
    // American (01-1F)
    $01: Result:='Sequential Circuits';
    $04: Result:='Moog';
    $06: Result:='Lexicon';
    $07: Result:='Kurzweil';
    $0F: Result:='Ensoniq';
    $10: Result:='Oberheim';
    $11: Result:='Apple';
    $18: Result:='E-mu';
    $1A: Result:='ART';
    // European (20-3F)
    $22: Result:='Synthaxe';
    $24: Result:='Hohner';
    $29: Result:='PPG';
    $2B: Result:='SSL';
    $2F: Result:='Elka / General Music';
    $30: Result:='Dynacord';
    $33: Result:='Clavia (Nord)';
    $36: Result:='Cheetah';
    $3E: Result:='Waldorf Electronics GmbH';
    // Japanese (40-5F)
    $40: Result:='Kawai Musical Instruments';
    $41: Result:='Roland';
    $42: Result:='Korg';
    $43: Result:='Yamaha';
    $44: Result:='Casio';
    $46: Result:='Kamiya Studio';
    $47: Result:='Akai Electric';
    $48: Result:='Victor Company of Japan';
    $4B: Result:='Fujitsu';
    $4C: Result:='Sony';
    $4E: Result:='Teac';
    $50: Result:='Matsushita Electric Industrial';
    $51: Result:='Fostex';
    $52: Result:='Zoom';
    $54: Result:='Matsushita Communication Industrial';
    $55: Result:='Suzuki Musical Instruments';
    $56: Result:='Fuji Sound Corporation';
    $57: Result:='Acoustic Technical Laboratory';
    $59: Result:='Faith';
    $5A: Result:='Internet Corporation';
    $5C: Result:='Seekers';
    $5F: Result:='SD Card Association';
    // Other (60-7C)
    // Special (7D-7F)
    $7D: Result:='Non-Commercial';
    $7E: Result:='Universal Non-Real Time';
    $7F: Result:='Universal Real Time';
  end;
end;

function SysExRoland(Data: Array of Byte): AnsiString;
  procedure SysExDefault;
  var
    I: Integer;
    Checksum, Address: Cardinal;
  begin
    Address := (Data[4] shl 16) or (Data[5] shl 8) or Data[6];
    case Data[3] of
      $11: begin
        Result := Result + ', read from ' + IntToHex(Address, 6) +
        ' size ' + IntToStr(Data[9] or (Data[8] shl 8) or (Data[7] shl 16));
      end;
      $12: begin
        Result := Result +
        ', write to ' + IntToHex(Address, 6) +
        ' data ';
        for I:=7 to Length(Data)-3 do
          Result := Result + IntToHex(Data[I],2);
      end;
      else begin
        Result := Result +
        ', command = ' + IntToStr(Data[3]) +
        ', address = ' + IntToHex(Address, 6) +
        ' data = ';
        for I:=7 to Length(Data)-3 do
          Result := Result + IntToHex(Data[I],2);
      end;
    end;
    Checksum := 0;
    for I:=4 to Length(Data)-3 do
      Checksum := Checksum + Data[I];
    Checksum := (128-(Checksum mod 128)) mod 128;
    if Checksum = Data[Length(Data)-2] then
      Result := Result + ', checksum ok'
    else
      Result := Result + ', checksum wrong';
  end;

  procedure SysExMT32;
  var
    I: Integer;
    Checksum, Address, Offset: Cardinal;
    AddrName, Msg: AnsiString;
  begin
    Address := (Data[4] shl 16) or (Data[5] shl 8) or Data[6];
    AddrName := '';
    Offset := Address mod $010000;
    Offset := (Offset and $7F) or ((Offset and $7F00) shr 1);
    case Address of
      $000000..$007F7F: AddrName := 'Patch Temp Area #' + IntToStr(Offset div 8);
      $010000..$017F7F: AddrName := 'Set Up Temp Area / rhythm';
      $020000..$027F7F: AddrName := 'Timbre Temp Area #' + IntToStr(Offset div $F6);
      $030000..$03007F: AddrName := 'Patch Temp Area #' + IntToStr(Offset shr 4);
      $030110..$037F7F: AddrName := 'Rhythm Set Up #' + IntToStr((Offset-144) div 4);
      $040000..$040F7F: AddrName := 'Timbre Temp Area #' + IntToStr(Offset div $F6);
      $050000..$05077F: AddrName := 'Patch Memory #' + IntToStr(Offset div 8);
      $080000..$087F7F: AddrName := 'Timbre Memory #' + IntToStr(Offset div $100);
      $100000..$107F7F: AddrName := 'System Area';
      $200000..$200013: AddrName := 'Display';
      $7F0000..$7F7F7F: AddrName := 'All Parameters Reset';
    end;
    if AddrName <> '' then
      AddrName := ' (' + AddrName + ')';
    case Data[3] of
      $11: begin
        Result := Result + ', read from ' + IntToHex(Address, 6) + AddrName +
        ' size ' + IntToStr(Data[9] or (Data[8] shl 8) or (Data[7] shl 16));
      end;
      $12: begin
        case Address of
          $200000: begin
            Msg := '';
            for I:=7 to Length(Data)-3 do
              Msg := Msg + AnsiChar(Data[I]);
            Msg := Trim(Msg);
            Result := Result + ', write LCD: "'+Msg+'"';
          end;
          $030000..$03007F: begin
            Offset := Address mod $010000;
            Offset := (Offset and $7F) or ((Offset and $7F00) shr 1);
            if Offset mod $10 = 0 then begin
              Result := Result + ', write patch temp #'+IntToStr(Offset div 8);
              case Data[7] of
                0: Msg := 'group A';
                1: Msg := 'group B';
                2: Msg := 'memory';
                3: Msg := 'rhythm';
                else Msg := '?';
              end;
              Result := Result + ', timbre #' + IntToStr(Data[8]) + ' (' + Msg + ')';
              Result := Result + ', key shift ' + IntToStr(Data[9] - 24);
              Result := Result + ', fine tune ' + IntToStr(Data[10] - 50);
              Result := Result + ', bend range ' + IntToStr(Data[11]);
              Result := Result + ', assign mode POLY' + IntToStr(Data[12]+1);
              case Data[13] of
                0: Msg := 'OFF';
                1: Msg := 'ON';
                else Msg := '?';
              end;
              Result := Result + ', reverb ' + Msg;
              Result := Result + ', out ' + IntToStr(Data[15]);
              Result := Result + ', pan ' + IntToStr(7-Data[16]);
            end else begin
              Result := Result +
              ', write to ' + IntToHex(Address, 6) + AddrName  +
              ' data ';
              for I:=7 to Length(Data)-3 do
                Result := Result + IntToHex(Data[I],2);
            end;
          end;
          $030110..$037F7F: begin
            if Address mod 4 = 0 then begin
              Offset := Address mod $010000;
              Offset := (Offset and $7F) or ((Offset and $7F00) shr 1);
              Result := Result + ', write rhythm #'+IntToStr((Offset-144) div 4);
              case Data[7] of
                0..63: Msg := '#'+IntToStr(Data[7])+' (melodic)';
                64..93: Msg := '#'+IntToStr(Data[7]-64)+' (drum)';
                94..127: Msg := 'none';
                else Msg := '?';
              end;
              Result := Result + ', timbre ' + Msg;
              Result := Result + ', out ' + IntToStr(Data[8]);
              Result := Result + ', pan ' + IntToStr(7-Data[9]);
              case Data[10] of
                0: Msg := 'OFF';
                1: Msg := 'ON';
                else Msg := '?';
              end;
              Result := Result + ', reverb ' + Msg;
            end else begin
              Result := Result +
              ', write to ' + IntToHex(Address, 6) + AddrName  +
              ' data ';
              for I:=7 to Length(Data)-3 do
                Result := Result + IntToHex(Data[I],2);
            end;
          end;
          $020000..$027F7F,$040000..$040F7F: begin
            Offset := Address mod $010000;
            Offset := (Offset and $7F) or ((Offset and $7F00) shr 1);
            if Offset mod $F6 = 0 then begin
              Msg := '';
              for I:=7 to 16 do
                Msg := Msg + AnsiChar(Data[I]);
              Msg := Trim(Msg);
              Result := Result + ', write timbre temp #'+IntToStr(Offset div $F6)+', tone name: "'+Msg+'"'+
              ', pt 1,2 = ' + IntToStr(Data[17]) + ', pt 3,4 = ' + IntToStr(Data[18]) +
              ', pt mute = ' + IntToStr(Data[19]);
              case Data[20] of
                0: Msg := 'normal';
                1: Msg := 'no sustain';
                else Msg := '?';
              end;
              Result := Result + ', env. mode = ' + Msg;
            end else begin
              Result := Result +
              ', write to ' + IntToHex(Address, 6) + AddrName  +
              ' data ';
              for I:=7 to Length(Data)-3 do
                Result := Result + IntToHex(Data[I],2);
            end;
          end;
          $050000..$05077F: begin
            if Address mod 8 = 0 then begin
              Offset := Address mod $010000;
              Offset := (Offset and $7F) or ((Offset and $7F00) shr 1);
              Result := Result + ', write patch #'+IntToStr(Offset div 8);
              case Data[7] of
                0: Msg := 'group A';
                1: Msg := 'group B';
                2: Msg := 'memory';
                3: Msg := 'rhythm';
                else Msg := '?';
              end;
              Result := Result + ', timbre #' + IntToStr(Data[8]) + ' (' + Msg + ')';
              Result := Result + ', key shift ' + IntToStr(Data[9] - 24);
              Result := Result + ', fine tune ' + IntToStr(Data[10] - 50);
              Result := Result + ', bend range ' + IntToStr(Data[11]);
              Result := Result + ', assign mode POLY' + IntToStr(Data[12]+1);
              case Data[13] of
                0: Msg := 'OFF';
                1: Msg := 'ON';
                else Msg := '?';
              end;
              Result := Result + ', reverb ' + Msg;
            end else begin
              Result := Result +
              ', write to ' + IntToHex(Address, 6) + AddrName  +
              ' data ';
              for I:=7 to Length(Data)-3 do
                Result := Result + IntToHex(Data[I],2);
            end;
          end;
          $080000..$087F7F: begin
            if Address mod $200 = 0 then begin
              Msg := '';
              for I:=7 to 16 do
                Msg := Msg + AnsiChar(Data[I]);
              Msg := Trim(Msg);
              Offset := Address mod $010000;
              Offset := (Offset and $7F) or ((Offset and $7F00) shr 1);
              Result := Result + ', write timbre #'+IntToStr(Offset div $100)+', tone name: "'+Msg+'"'+
              ', pt 1,2 = ' + IntToStr(Data[17]) + ', pt 3,4 = ' + IntToStr(Data[18]) +
              ', pt mute = ' + IntToStr(Data[19]);
              case Data[20] of
                0: Msg := 'normal';
                1: Msg := 'no sustain';
                else Msg := '?';
              end;
              Result := Result + ', env. mode = ' + Msg;
            end else begin
              Result := Result +
              ', write to ' + IntToHex(Address, 6) + AddrName  +
              ' data ';
              for I:=7 to Length(Data)-3 do
                Result := Result + IntToHex(Data[I],2);
            end;
          end;
          else begin
            Result := Result +
            ', write to ' + IntToHex(Address, 6) + AddrName  +
            ' data ';
            for I:=7 to Length(Data)-3 do
              Result := Result + IntToHex(Data[I],2);
          end;
        end;
      end;
      else begin
        Result := Result +
        ', command = ' + IntToStr(Data[3]) +
        ', address = ' + IntToHex(Address, 6) + AddrName  +
        ' data = ';
        for I:=7 to Length(Data)-3 do
          Result := Result + IntToHex(Data[I],2);
      end;
    end;
    Checksum := 0;
    for I:=4 to Length(Data)-3 do
      Checksum := Checksum + Data[I];
    Checksum := (128-(Checksum mod 128)) mod 128;
    if Checksum = Data[Length(Data)-2] then
      Result := Result + ', checksum ok'
    else
      Result := Result + ', checksum wrong';
  end;
begin
  case Data[2] of
    $14: begin
      Result := 'Roland D-50' +
      ', device = ' + IntToHex(Data[1], 2) + 'h';
      SysExDefault;
    end;
    $16: begin
      Result := 'Roland MT-32';
      SysExMT32;
    end;
    $42: begin
      Result := 'Roland SCC-1/SC-88' +
      ', device = ' + IntToHex(Data[1], 2) + 'h';
      SysExDefault;
    end;
    $6A: begin
      Result := 'Roland JV-1010' +
      ', device = ' + IntToHex(Data[1], 2) + 'h';
      SysExDefault;
    end;
    else begin
      Result := 'Roland model ' + IntToHex(Data[2], 2) + 'h' +
      ', device = ' + IntToHex(Data[1], 2) + 'h';
      SysExDefault;
    end;
  end;
end;

function SysExAdLib(Data: Array of Byte): AnsiString;
type
  TOPLRegs = packed record
    ksl: Byte;
    multiplier: Byte;
    feedback: Byte;
    attack: Byte;
    sustain: Byte;
    sustaining: Byte;
    decay: Byte;
    release: Byte;
    output: Byte;
    vibam: Byte;
    vibfq: Byte;
    envscale: Byte;
    additive: Byte;
  end;
  TOPLInstrument = packed record
    oplModulator: TOPLRegs;
    oplCarrier: TOPLRegs;
    iModWaveSel: Byte;
    iCarWaveSel: Byte;
  end;
var
  Opcode: Word;
  I: Integer;
  patch: TOPLInstrument;
  chn, pitchRange: Byte;
begin
  if (Data[0] <> $00)
  or (Data[1] <> $00)
  or (Data[2] <> $3F)
  then
    Exit;
  Result := 'Ad Lib';
  Opcode := Data[4] or (Data[3] shl 8);
  case Opcode of
    1: begin
      Result := Result + ', load patch';
      if Length(Data) < 5 + 29 then
        Result := Result + ' (incomplete)'
      else begin
        chn := Data[5];
        if chn > 15 then
          Result := Result + ', chn = ?'
        else
          Result := Result + ', chn = ' + IntToStr(chn + 1);
        Move(Data[6], patch, 28);
        Result := Result + ', mod = [' +
        IntToStr(patch.oplModulator.ksl) + ' ' +
        IntToStr(patch.oplModulator.multiplier) + ' ' +
        IntToStr(patch.oplModulator.feedback) + ' ' +
        IntToStr(patch.oplModulator.attack) + ' ' +
        IntToStr(patch.oplModulator.sustain) + ' ' +
        IntToStr(patch.oplModulator.sustaining) + ' ' +
        IntToStr(patch.oplModulator.decay) + ' ' +
        IntToStr(patch.oplModulator.release) + ' ' +
        IntToStr(patch.oplModulator.output) + ' ' +
        IntToStr(patch.oplModulator.vibam) + ' ' +
        IntToStr(patch.oplModulator.vibfq) + ' ' +
        IntToStr(patch.oplModulator.envscale) + ' ' +
        IntToStr(patch.oplModulator.additive) + ' ' +
        IntToStr(patch.iModWaveSel) + ']';
        Result := Result + ', car = [' +
        IntToStr(patch.oplCarrier.ksl) + ' ' +
        IntToStr(patch.oplCarrier.multiplier) + ' ' +
        IntToStr(patch.oplCarrier.feedback) + ' ' +
        IntToStr(patch.oplCarrier.attack) + ' ' +
        IntToStr(patch.oplCarrier.sustain) + ' ' +
        IntToStr(patch.oplCarrier.sustaining) + ' ' +
        IntToStr(patch.oplCarrier.decay) + ' ' +
        IntToStr(patch.oplCarrier.release) + ' ' +
        IntToStr(patch.oplCarrier.output) + ' ' +
        IntToStr(patch.oplCarrier.vibam) + ' ' +
        IntToStr(patch.oplCarrier.vibfq) + ' ' +
        IntToStr(patch.oplCarrier.envscale) + ' ' +
        IntToStr(patch.oplCarrier.additive) + ' ' +
        IntToStr(patch.iCarWaveSel) + ']';
      end;
    end;
    2: begin
      Result := Result + ', card mode';
      if Length(Data) < 5 + 1 then
        Result := Result + ' (incomplete)'
      else begin
        case Data[5] of
          0: Result := Result + ' = melodic';
          1: Result := Result + ' = percussive';
          else Result := Result + ' = undefined';
        end;
      end;
    end;
    3: begin
      Result := Result + ', pitch bend multiplier';
      if Length(Data) < 5 + 1 then
        Result := Result + ' (incomplete)'
      else begin
        pitchRange := Data[5];
        if pitchRange > 12 then
          pitchRange := 12
        else
          if pitchRange < 1 then
            pitchRange := 1;
        Result := Result + ' = ' + IntToStr(pitchRange);
      end;
    end;
    else begin
      Result := Result + ', opcode = ' + IntToStr(Opcode);
      if Length(Data) > 5 then begin
        Result := Result + ', data = ';
        for I := 5 to Length(Data) - 1 do
          Result := Result + IntToHex(Data[I], 2);
      end;
    end;
  end;
end;

function SysExProcess(Data: Array of Byte): AnsiString;
var
  Mfg: Cardinal;
  MfgS: AnsiString;
  MfgLen: Byte;
  function SysExProcessDefault: AnsiString;
  var
    I: Integer;
  begin
    if MfgS = '' then begin
      Result := 'Data = ';
      for I := 0 to Length(Data) - 1 do
        Result := Result + IntToHex(Data[I], 2);
    end else begin
      Result := 'Manufacturer = ' + MfgS;
      if Length(Data) > MfgLen then begin
        Result := Result + ', data = ';
        for I := MfgLen to Length(Data) - 1 do
          Result := Result + IntToHex(Data[I], 2);
      end;
    end;
  end;
begin
  Result := '';
  if Length(Data) >= 3 then
    Mfg := Data[0] or (Data[1] shl 8) or (Data[2] shl 16)
  else begin
    if Length(Data) >= 1 then
      Mfg := Data[0]
    else
      Exit;
  end;
  MfgS := GetManufacturerID(Mfg, MfgLen);
  if MfgS <> '' then begin
    if (MfgS = 'Roland') and (Length(Data) >= 1 + 9) then begin
      Result := SysExRoland(Data);
      Exit;
    end;
    if (MfgS = 'Ad Lib') and (Length(Data) >= 3 + 2) then begin
      Result := SysExAdLib(Data);
      Exit;
    end;
  end;
  Result := SysExProcessDefault;
end;

end.
