unit uFrmLembreteEditar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  uDM, uLembreteDAO, uLembrete, generics.defaults, generics.collections, Vcl.ComCtrls;

type
  TfrmLembreteEditar = class(TForm)
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
    procedure FormDestroy(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
 private
    _LembreteDAO: TLembreteDAO;
    _Lembrete: TLembrete;
    procedure PreencherLembrete;
    procedure PreencherTela;

    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pLembrete: TLembrete);
  end;

var
  frmLembreteEditar: TfrmLembreteEditar;

implementation

{$R *.dfm}

procedure TfrmLembreteEditar.PreencherLembrete;
begin
  _Lembrete.Titulo    := EdtTitulo.Text;
  _Lembrete.Descricao := MmDescricao.Text;
  _Lembrete.DataHora  := DtpDataHora.DateTime;
end;

procedure TfrmLembreteEditar.PreencherTela;
begin
  EdtTitulo.Text       := _Lembrete.Titulo;
  MmDescricao.Text     := _Lembrete.Descricao;
  DtpDataHora.DateTime := _Lembrete.DataHora;
end;

constructor TFrmLembreteEditar.Create(AOwner: TComponent; pLembrete: TLembrete);
begin
  inherited Create(AOwner);
  _LembreteDAO := TLembreteDAO.Create;

  try
    if Assigned(pLembrete) then
    begin
      _Lembrete := pLembrete;
      PreencherTela;
    end;
  except on e: exception do
    raise Exception.Create(E.Message);
  end;

end;

procedure TfrmLembreteEditar.bExcluirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmLembreteEditar.bInserirClick(Sender: TObject);
begin
  PreencherLembrete;

  if _LembreteDAO.Alterar(_Lembrete) then
  begin
    ShowMessage('Registro editado com sucesso');
    Close;
  end;
end;

procedure TfrmLembreteEditar.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(_LembreteDAO) then
      FreeAndNil(_LembreteDAO);
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TfrmLembreteEditar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    close;
end;

end.
