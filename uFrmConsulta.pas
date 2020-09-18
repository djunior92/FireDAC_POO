unit uFrmConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, uDM, uLembreteDAO, uLembrete, generics.defaults, generics.collections;

type
  TfrmConsulta = class(TForm)
    frmConsulta: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    edtTituloBusca: TEdit;
    bPesquisar: TSpeedButton;
    Panel3: TPanel;
    bInserir: TSpeedButton;
    ListView1: TListView;
    bAlterar: TSpeedButton;
    bExcluir: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bInserirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    _LembreteDAO: TLembreteDAO;
    procedure CarregarColecao;
    procedure PreencherListView(pListaLembrete: TList<TLembrete>);
  public
    { Public declarations }
  end;

var
  frmConsulta: TfrmConsulta;

implementation

uses
  uFrmLembreteInserir, uFrmLembreteEditar;

{$R *.dfm}

procedure TfrmConsulta.bExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja remover este item?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if ListView1.ItemIndex > -1 then
    begin
      if _LembreteDAO.Deletar(TLembrete
        (ListView1.ItemFocused.Data)) then
        CarregarColecao;
    end;
  end;
end;

procedure TfrmConsulta.bInserirClick(Sender: TObject);
begin
  try
    FrmLembreteInserir := TFrmLembreteInserir.Create(Self);
    FrmLembreteInserir.ShowModal;
    CarregarColecao;
  finally
    FreeAndNil(FrmLembreteInserir);
  end;
end;

procedure TfrmConsulta.bPesquisarClick(Sender: TObject);
begin
  CarregarColecao;
end;

procedure TfrmConsulta.CarregarColecao;
begin
  try
    PreencherListView(_LembreteDAO.ListarPorTitulo_Descricao(edtTituloBusca.Text));
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TfrmConsulta.PreencherListView
  (pListaLembrete: TList<TLembrete>);
var
  I: Integer;
  tempItem: TListItem;
begin
  if Assigned(pListaLembrete) then
  begin
    ListView1.Clear;
    for I := 0 to pListaLembrete.Count -1 do
    begin
      tempItem := ListView1.Items.Add;
      tempItem.Caption := IntToStr(TLembrete(pListaLembrete[I]).IDLembrete);
      tempItem.SubItems.Add(TLembrete(pListaLembrete[I]).Titulo);
      tempItem.SubItems.Add(FormatDateTime('dd/mm/yyyy hh:mm', TLembrete(pListaLembrete[I]).DataHora));
      tempItem.Data := TLembrete(pListaLembrete[I]);
    end;
  end
  else
    ShowMessage('Nenhum lembrete encontrado.');
end;


procedure TfrmConsulta.FormCreate(Sender: TObject);
begin
  DM            := TDM.Create(Self);
  _LembreteDAO  := TLembreteDAO.Create;
end;

procedure TfrmConsulta.FormDestroy(Sender: TObject);
begin
  try
    if Assigned(_LembreteDAO) then
      FreeAndNil(_LembreteDAO);
    if Assigned(DM) then
      FreeAndNil(DM);
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
