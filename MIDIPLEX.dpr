program MIDIPLEX;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  MIDIConsts in 'MIDIConsts.pas',
  MultiDialog in 'MultiDialog.pas' {EditDialog},
  IFFTrees in 'IFFTrees.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MIDI Event Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TEditDialog, EditDialog);
  Application.Run;
end.
