program FB_CSV;

uses
  Vcl.Forms,
  uFB_CSV in 'uFB_CSV.pas' {frmFB_CSV},
  uMultiLanguage in 'uMultiLanguage.pas',
  uGlobal in 'uGlobal.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmFB_CSV, frmFB_CSV);
  Application.Run;
end.
