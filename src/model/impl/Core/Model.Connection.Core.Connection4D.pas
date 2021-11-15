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
    function LoadParams: IModelConnection4D; virtual; abstract;
    function TipoTenancy(AValue: TEnumTenancy): IModelConnection4D;
      virtual; abstract;
    function PoolConnection: TObjectDictionary<Integer, TComponent>;
      virtual; abstract;
  end;

implementation

uses
  Registry.Connections.Connection4D,
  System.SysUtils;
{ TConnectionCore4D }

constructor TConnectionCore4D.Create;
begin
  raise Exception.Create('Class abstract, there are not implementation');
end;

destructor TConnectionCore4D.Destroy;
begin

  inherited;
end;

class function TConnectionCore4D.New: IModelConnection4D;
begin
  Result := Self.Create;
end;

initialization

TRegistryConnection.RegisterClass
  (TRegistryConnection.GetGUID<IModelConnection4D>, TConnectionCore4D);

end.
