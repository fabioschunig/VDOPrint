program demo;

uses
  Forms,
  untDemo in 'untDemo.pas' {frmDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'VDOPrint Demo';
  Application.CreateForm(TfrmDemo, frmDemo);
  Application.Run;
end.
