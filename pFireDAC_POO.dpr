program pFireDAC_POO;

uses
  Vcl.Forms,
  uFrmLembreteEditar in 'uFrmLembreteEditar.pas' {frmLembreteEditar},
  uFrmLembreteInserir in 'uFrmLembreteInserir.pas' {frmLembreteInserir},
  uDm in 'uDm.pas' {dm: TDataModule},
  uFrmConsulta in 'uFrmConsulta.pas' {frmConsulta},
  uBaseDAO in 'DAO\uBaseDAO.pas',
  uLembreteDAO in 'DAO\uLembreteDAO.pas',
  uLembrete in 'Model\uLembrete.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmConsulta, frmConsulta);
  Application.CreateForm(TfrmLembreteEditar, frmLembreteEditar);
  Application.CreateForm(TfrmLembreteInserir, frmLembreteInserir);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
