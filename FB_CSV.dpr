program FB_CSV;

uses
  Vcl.Forms,
  uFB_CSV in 'uFB_CSV.pas' {frmFB_CSV},
  uMultiLanguage in 'uMultiLanguage.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmFB_CSV, frmFB_CSV);
  Application.Run;
end.
