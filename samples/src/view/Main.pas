unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  DTO.Contracts.Samples,
  Core.Contracts.DTO4Delphi,
  Data.DB,
  Datasnap.DBClient, DTO.Industrias;

type
  TForm1 = class(TForm)
    Button1: TButton;
    cdsIndustrias: TClientDataSet;
    dsIndustrias: TDataSource;
    cdsIndustriasIND_CODE: TSmallintField;
    cdsIndustriasIND_NAME: TStringField;
    cdsIndustriasLONG_NAME: TStringField;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPessoaDTO: ICoreDTO4Delphi<IPessoa>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Core.Manager.DTO4Delphi;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  FPessoaDTO := TCoreManagerDTO4Delphi<IPessoa>.New;

  FPessoaDTO.DTO.Nome('Developer JR').Idade(58);

  ShowMessage(FPessoaDTO.DTO.Nome);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LIndustriaDTO: ICoreDTO4Delphi<IDTOIndustrias>;
  LIndustria: IDTOIndustrias;
begin
  Memo1.Lines.Clear;
  LIndustriaDTO := TCoreManagerDTO4Delphi<IDTOIndustrias>.New.Params.DataSet
    (dsIndustrias).Return;

  for LIndustria in LIndustriaDTO.DataSetToList do
  begin
    Memo1.Lines.Add(Format('|Codigo %d|Apelido: %s|Nome: %s|',
      [LIndustria.Codigo, LIndustria.Nome, LIndustria.NomeCompleto]));
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  ReportMemoryLeaksOnShutdown := True;
end;

end.
