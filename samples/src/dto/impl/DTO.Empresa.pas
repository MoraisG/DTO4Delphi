unit DTO.Empresa;

interface

uses DTO.Contracts.Samples, DTO.Pessoa, Types.Attributes.DTO4Delphi;

type
{$M+}
  TEmpresaDTO = class(TInterfacedObject, IEmpresa)
  private
    FNome: String;
  public
    constructor Create;
    destructor Destroy; override;
    [New__]
    class function New: IEmpresa;
    function Proprietario(AValue: String): IEmpresa; overload;
    function Propriertario: String; overload;
  end;

implementation

{ TEmpresaDTO }

uses Core.Registry.DTO4D;

constructor TEmpresaDTO.Create;
begin

end;

destructor TEmpresaDTO.Destroy;
begin

  inherited;
end;

class function TEmpresaDTO.New: IEmpresa;
begin
  Result := Self.Create();
end;

function TEmpresaDTO.Propriertario: String;
begin
  Result := FNome;
end;

function TEmpresaDTO.Proprietario(AValue: String): IEmpresa;
begin
  Result := Self;
  FNome := AValue;
end;

initialization

TRegisterClassDTO4D.RegisterClass(TRegisterClassDTO4D.GetGUID<IEmpresa>,
  TEmpresaDTO);

finalization

end.
