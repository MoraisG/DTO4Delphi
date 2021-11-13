unit DTO.Pessoa;

interface

uses
  DTO.Contracts.Samples,
  Types.Attributes.DTO4D;

type
{$M+}
  TPessoDTO = class(TInterfacedObject, IPessoa)
  private
    FNome: String;
    FIdade: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    [New__]
    class function New: IPessoa;

    function Nome(AValue: String): IPessoa; overload;
    function Nome: String; overload;
    function Idade(AValue: Integer): IPessoa; overload;
    function Idade: Integer; overload;
  end;

implementation

{ TPessoDTO }

uses Core.Registry.DTO4D;

constructor TPessoDTO.Create;
begin

end;

destructor TPessoDTO.Destroy;
begin

  inherited;
end;

function TPessoDTO.Idade(AValue: Integer): IPessoa;
begin
  Result := Self;
  FIdade := AValue;
end;

function TPessoDTO.Idade: Integer;
begin
  Result := FIdade;
end;

class function TPessoDTO.New: IPessoa;
begin
  Result := Self.Create;
end;

function TPessoDTO.Nome(AValue: String): IPessoa;
begin
  Result := Self;
  FNome := AValue;
end;

function TPessoDTO.Nome: String;
begin
  Result := FNome;
end;

initialization

TRegisterClassDTO4D
  .RegisterClass(TRegisterClassDTO4D.GetGUID<IPessoa>,TPessoDTO);

finalization

end.
