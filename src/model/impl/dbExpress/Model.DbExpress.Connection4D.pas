unit Model.DbExpress.Connection4D;

interface

uses
  Model.Connection.Core.Connection4D,
  Model.Contracts.Access.Connection4D,
  Types.Attributes.Connection4D,
  Types.Enums.Connection4D,
  System.Generics.Collections,
  System.Classes,
  Model.Contracts.Connection4D;

type
{$M+}
  TConnectionDbExpress = class(TConnectionCore4D, IConnectionDbExpress)
  private
    FPoolConnections: TObjectDictionary<Integer, TComponent>;
    FEnumDatabase: TEnumDataBase;
    FTenancy: TEnumTenancy;
  public
    constructor Create;
    destructor Destroy; override;

    [New__]
    class function New: IConnectionDbExpress;
    function Connection(AID: Integer): TComponent;
    function Conect: IModelConnection4D;

    [SetterDatabase]
    function Database(AValue: Integer): IModelConnection4D; override;
    function Disconect: IModelConnection4D; override;
    function LoadParams: IModelConnection4D; override;

    [SetterTenancy]
    function TipoTenancy(AValue: TEnumTenancy): IModelConnection4D; override;
    function PoolConnection: TObjectDictionary<Integer, TComponent>; override;
  end;

implementation

uses
  SqlExpr,
  System.SysUtils,
  Types.Enums.Helpers.Databases.Connection4D;
{ TConnectionDbExpress }

function TConnectionDbExpress.Conect: IModelConnection4D;
begin
  Result := Self;
  FPoolConnections.Items[0];
end;

function TConnectionDbExpress.Connection(AID: Integer): TComponent;
begin
  Result := FPoolConnections.Items[AID];
end;

constructor TConnectionDbExpress.Create;
begin
  FPoolConnections := TObjectDictionary<Integer, TComponent>.Create();
end;

function TConnectionDbExpress.Database(AValue: Integer): IModelConnection4D;
begin
  Result := Self;
  FEnumDatabase := TEnumDataBase(AValue);
end;

destructor TConnectionDbExpress.Destroy;
begin
  FPoolConnections.Free;
  inherited;
end;

function TConnectionDbExpress.Disconect: IModelConnection4D;
begin
  Result := Self;
end;

function TConnectionDbExpress.LoadParams: IModelConnection4D;
begin
  Result := Self;
  FEnumDatabase.DBExpressParametros(Self);
end;

class function TConnectionDbExpress.New: IConnectionDbExpress;
begin
  Result := Self.Create;
end;

function TConnectionDbExpress.PoolConnection
  : TObjectDictionary<Integer, TComponent>;
begin
  Result := FPoolConnections;
end;

function TConnectionDbExpress.TipoTenancy(AValue: TEnumTenancy)
  : IModelConnection4D;
begin
  Result := Self;
  FTenancy := TEnumTenancy(AValue);
end;

end.
