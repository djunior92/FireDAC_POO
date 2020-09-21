unit uFrmConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls, uDM, uLembreteDAO, uLembrete, generics.defaults, generics.collections;

type
  TfrmConsulta = class(TForm)
    pnTitulo: TPanel;
    lTitulo: TLabel;
    pnBusca: TPanel;
    lBusca: TLabel;
    edtTituloBusca: TEdit;
    bPesquisar: TSpeedButton;
    pnRodape: TPanel;
    bInserir: TSpeedButton;
    lvLembrete: TListView;
    bAlterar: TSpeedButton;
    bExcluir: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bInserirClick(Sender: TObject);
    procedure bExcluirClick(Sender: TObject);
    procedure bPesquisarClick(Sender: TObject);
    procedure bAlterarClick(Sender: TObject);
    procedure lvLembreteDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    _LembreteDAO: TLembreteDAO;
    procedure EditarLembrete;
    procedure CarregarColecao;
    procedure PreencherListView(pListaLembrete: TList<TLembrete>);
  public
    { Public declarations }
  end;

var
  frmConsulta: TfrmConsulta;

implementation

{$R *.dfm}

uses
  uFrmLembreteInserir, uFrmLembreteEditar;

procedure TfrmConsulta.EditarLembrete;
begin
if (lvLembrete.Items.Count > 0) then
  begin
    try
      FrmLembreteEditar := TFrmLembreteEditar.Create(Self, TLembrete(lvLembrete.ItemFocused.Data));
      FrmLembreteEditar.ShowModal;
      CarregarColecao;
    finally
      FreeAndNil(FrmLembreteEditar);
    end;
  end;
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

procedure TfrmConsulta.PreencherListView(pListaLembrete: TList<TLembrete>);
var
  I: Integer;
  tempItem: TListItem;
begin
  lvLembrete.Clear;

  if Assigned(pListaLembrete) then
  begin
    for I := 0 to pListaLembrete.Count -1 do
    begin
      tempItem := lvLembrete.Items.Add;
      tempItem.Caption := IntToStr(TLembrete(pListaLembrete[I]).IDLembrete);
      tempItem.SubItems.Add(TLembrete(pListaLembrete[I]).Titulo);
      tempItem.SubItems.Add(FormatDateTime('dd/mm/yyyy hh:mm', TLembrete(pListaLembrete[I]).DataHora));
      tempItem.Data := TLembrete(pListaLembrete[I]);
    end;
  end
  else
    ShowMessage('Nenhum lembrete encontrado.');
end;

procedure TfrmConsulta.bAlterarClick(Sender: TObject);
begin
  EditarLembrete;
end;

procedure TfrmConsulta.bExcluirClick(Sender: TObject);
begin
  if (lvLembrete.Items.Count > 0) and (lvLembrete.ItemIndex > -1)then
    if MessageDlg('Deseja remover este item?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if _LembreteDAO.Deletar(TLembrete(lvLembrete.ItemFocused.Data)) then
        CarregarColecao;
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

procedure TfrmConsulta.FormShow(Sender: TObject);
begin
  lvLembrete.Clear;
end;

procedure TfrmConsulta.lvLembreteDblClick(Sender: TObject);
begin
EditarLembrete;
end;

end.
