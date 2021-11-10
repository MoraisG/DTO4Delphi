# DTO4Delphi
 > ## **Target**
> ### DTO4Delphi é uma biblioteca que permite o usuário implementar o uso de DTO (Data transfer object), isto é, ao invés de trabalhar com os DataSet's, será usado objetos, permitindo implementar regras próprias para estes.

## Informações

> ### É muito comum utilizar a classe concreta para mapear um objeto, contudo a abordagem feita pelo DTO4Delphi é por meio de interfaces, assim permite que o Delphi use seu ARC e faça o gerenciamento da memória.

> ### *Como usar*

> > ### ***DataSet para lista de objetos***

```pascal
procedure TForm1.Button2Click(Sender: TObject);
var
  LIndustriaDAO: ICoreDTO4Delphi<IDTOIndustrias>;
  LIndustriaDTO: IDTOIndustrias;
begin
  Memo1.Lines.Clear;
  LIndustriaDAO := TCoreManagerDTO4Delphi<IDTOIndustrias>.New.Params.DataSet
    (dsIndustrias).Return;

  for LIndustriaDTO in LIndustriaDAO.DataSetToList do
  begin
    Memo1.Lines.Add(Format('|Codigo %d|Apelido: %s|Nome: %s|',
      [LIndustriaDTO.Codigo, LIndustriaDTO.Nome, LIndustriaDTO.NomeCompleto]));
  end;
end;
```

>
> ### *Como mapear*
> 

```pascal
uses
  Types.Attributes.DTO4Delphi;
{$M+}

type

  IDTOIndustrias = interface
    ['{C2C650C9-9D09-429C-A6EA-A9C0DFA5DA6B}']
    [Campo('IND_CODE')]
    function SetCodigo(AValue: Integer): IDTOIndustrias;

    [Campo('IND_NAME')]
    function SetNome(AValue: String): IDTOIndustrias;

    [Campo('LONG_NAME')]
    function SetNomeCompleto(AValue: String): IDTOIndustrias;

    function Codigo: Integer;
    function Nome: String;
    function NomeCompleto: String;
  end;

  TDTOIndustrias = class(TInterfacedObject, IDTOIndustrias)
  private
    FNome: String;
    FNomeCompleto: String;
    FCodigo: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    [New__]
    class function New: IDTOIndustrias;
    function SetCodigo(AValue: Integer): IDTOIndustrias;
    function SetNome(AValue: String): IDTOIndustrias;
    function SetNomeCompleto(AValue: String): IDTOIndustrias;
    function Codigo: Integer;
    function Nome: String;
    function NomeCompleto: String;
  end;

implementation

uses Core.Registry.DTO4D;
...
initialization
TRegisterClassDTO4D.RegisterClass(TRegisterClassDTO4D.GetGUID<IDTOIndustrias>,
  TDTOIndustrias);
finalization
end;
```

## Atributos (Notation)

***New__***
> Mapeia o método para que a biblioteca saiba qual é o construtor da classe.
> 
***Campo***
> Mapeia como o framework deve chamar o field da consulta para o objeto a ser serializado.
