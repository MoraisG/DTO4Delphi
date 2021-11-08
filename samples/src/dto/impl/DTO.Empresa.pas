unit DTO.Empresa;

interface

uses DTO.Contracts.Samples, DTO.Pessoa, Types.Attributes.DTO4Delphi;

type
{$M+}
  TEmpresaDTO = class(TInterfacedObject, IEmpresa)
  private
    FProprietario: IPessoa;
  public
    constructor Create(AParent: IPessoa);
    destructor Destroy; override;

    [Injection(TPessoDTO)]
    class function New(AParent: IPessoa): IEmpresa;
    function Proprietario(AValue: String): IEmpresa; overload;
    function Propriertario: String; overload;
  end;

implementation

{ TEmpresaDTO }

constructor TEmpresaDTO.Create(AParent: IPessoa);
begin
  FProprietario := AParent;
end;

destructor TEmpresaDTO.Destroy;
begin

  inherited;
end;

class function TEmpresaDTO.New(AParent: IPessoa): IEmpresa;
begin
  Result := Self.Create(AParent);
end;

function TEmpresaDTO.Propriertario: String;
begin
  Result := FProprietario.Nome;
end;

function TEmpresaDTO.Proprietario(AValue: String): IEmpresa;
begin
  Result := Self;
  FProprietario.Nome(AValue);
end;

end.
