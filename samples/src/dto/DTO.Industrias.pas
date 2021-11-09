unit DTO.Industrias;

interface

uses
  Types.Attributes.DTO4Delphi;
{$M+}

type

  [Query('SEL_IND')]
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
{ TDTOIndustrias }

function TDTOIndustrias.Codigo: Integer;
begin
  Result := FCodigo;
end;

constructor TDTOIndustrias.Create;
begin

end;

destructor TDTOIndustrias.Destroy;
begin

  inherited;
end;

class function TDTOIndustrias.New: IDTOIndustrias;
begin
  Result := Self.Create;
end;

function TDTOIndustrias.Nome: String;
begin
  Result := FNome;
end;

function TDTOIndustrias.NomeCompleto: String;
begin
  Result := FNomeCompleto;
end;

function TDTOIndustrias.SetCodigo(AValue: Integer): IDTOIndustrias;
begin
  Result := Self;
  FCodigo := AValue;
end;

function TDTOIndustrias.SetNome(AValue: String): IDTOIndustrias;
begin
  Result := Self;
  FNome := AValue;
end;

function TDTOIndustrias.SetNomeCompleto(AValue: String): IDTOIndustrias;
begin
  Result := Self;
  FNomeCompleto := AValue;
end;

initialization

TRegisterClassDTO4D.RegisterClass(TRegisterClassDTO4D.GetGUID<IDTOIndustrias>,
  TDTOIndustrias);

finalization

end.
