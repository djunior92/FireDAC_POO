unit uFrmLembreteInserir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, uDM, uLembreteDAO,
  uLembrete, generics.defaults, generics.collections, Vcl.ComCtrls;

type
  TfrmLembreteInserir = class(TForm)
    Panel3: TPanel;
    bInserir: TSpeedButton;
    bExcluir: TSpeedButton;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtTitulo: TEdit;
    mmDescricao: TMemo;
    dtpDataHora: TDateTimePicker;
    procedure bInserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
  private
    { Private declarations }
    _LembreteDAO: TLembreteDAO;
    _Lembrete: TLembrete;
    procedure PreencherLembrete;
  public
    { Public declarations }
  end;

var
  frmLembreteInserir: TfrmLembreteInserir;

implementation

{$R *.dfm}

procedure TfrmLembreteInserir.bExcluirClick(Sender: TObject);
begin
close;
end;

procedure TfrmLembreteInserir.bInserirClick(Sender: TObject);
begin
 PreencherLembrete;
  if _LembreteDAO.Inserir(_Lembrete) then
  begin
    ShowMessage('Registro Inserido com sucesso');
    Close;
  end;
end;

procedure TfrmLembreteInserir.FormCreate(Sender: TObject);
begin
  DtpDataHora.DateTime := Now;
  _Lembrete    := TLembrete.Create;
  _LembreteDAO := TLembreteDAO.Create;
end;

procedure TfrmLembreteInserir.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(_Lembrete) then
      FreeAndNil(_Lembrete);
    if Assigned(_LembreteDAO) then
      FreeAndNil(_LembreteDAO);
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TfrmLembreteInserir.PreencherLembrete;
begin
  _Lembrete.Titulo    := EdtTitulo.Text;
  _Lembrete.Descricao := MmDescricao.Text;
  _Lembrete.DataHora  := DtpDataHora.DateTime;
end;

end.
