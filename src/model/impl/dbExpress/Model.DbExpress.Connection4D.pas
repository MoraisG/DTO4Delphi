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
  public
    constructor Create;
    destructor Destroy; override;

    [New__]
    class function New: IConnectionDbExpress;
    function Connection(AID: Integer): TComponent;
    function Conect: IModelConnection4D;

    [SetterDatabase]
    function Database(AValue: Integer): IModelConnection4D;
    function Disconect: IModelConnection4D;
    function Generate: IModelConnection4D;

    [SetterTenancy]
    function TipoTenancy(AValue: TEnumTenancy): IModelConnection4D;
    function PoolConnection: TObjectDictionary<Integer, TComponent>;
  end;

implementation

uses
  System.SysUtils,
  Core.Registry.DTO4D;
{ TConnectionDbExpress }

function TConnectionDbExpress.Conect: IModelConnection4D;
begin
  Result := Self;
end;

function TConnectionDbExpress.Connection(AID: Integer): TComponent;
begin
  Result := FPoolConnections.Items[AID];
end;

constructor TConnectionDbExpress.Create;
begin

end;

function TConnectionDbExpress.Database(AValue: Integer): IModelConnection4D;
begin
  Result := Self;
  raise Exception.Create('Oracle');
end;

destructor TConnectionDbExpress.Destroy;
begin

  inherited;
end;

function TConnectionDbExpress.Disconect: IModelConnection4D;
begin
  Result := Self;
end;

function TConnectionDbExpress.Generate: IModelConnection4D;
begin
  Result := Self;
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

end;

initialization

TRegisterClassDTO4D.RegisterClass
  (TRegisterClassDTO4D.GetGUID<IConnectionDbExpress>, TConnectionDbExpress);

end.
