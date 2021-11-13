unit Model.Connection.Core.Connection4D;

interface

uses
  Types.Attributes.Connection4D,
  Types.Enums.Connection4D,
  System.Classes,
  System.Generics.Collections,
  Model.Contracts.Connection4D;

type

  TConnectionCore4D = class abstract(TInterfacedObject, IModelConnection4D)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IModelConnection4D;
    function Connection: TComponent; virtual; abstract;
    function Conect(AID: Integer): IModelConnection4D; virtual; abstract;
    function Database(AValue: Integer): IModelConnection4D; virtual; abstract;
    function Disconect: IModelConnection4D; virtual; abstract;
    function Generate: IModelConnection4D; virtual; abstract;
    function TipoTenancy(AValue: TEnumTenancy): IModelConnection4D;
      virtual; abstract;
    function PoolConnection: TObjectDictionary<Integer, TComponent>;
      virtual; abstract;
  end;

implementation

uses
  System.SysUtils;
{ TConnectionCore4D }

constructor TConnectionCore4D.Create;
begin
  raise Exception.Create('Classe abstract, não deve ser instanciada');
end;

destructor TConnectionCore4D.Destroy;
begin

  inherited;
end;

class function TConnectionCore4D.New: IModelConnection4D;
begin
  Result := Self.Create;
end;

end.
