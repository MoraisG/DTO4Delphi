unit Model.DbExpress.Oracle.Connection4D;

interface

uses Model.Contracts.Access.Connection4D;

type

  TConnectionDbExpressOracle = class(TInterfacedObject, IConnectionParams)
  private
    [weak]
    FConnection: IConnectionDbExpress;
  public
    constructor Create(AValue: IConnectionDbExpress);
    destructor Destroy; override;
    class function New(AValue: IConnectionDbExpress): IConnectionParams;
    function LoadInfoDatabase: IConnectionParams;
    function SettingParams: IConnectionParams;
  end;

implementation

uses
  SqlExpr;
{ TConnectionDbExpressOracle }

constructor TConnectionDbExpressOracle.Create(AValue: IConnectionDbExpress);
begin
  FConnection := AValue;
end;

destructor TConnectionDbExpressOracle.Destroy;
begin

  inherited;
end;

function TConnectionDbExpressOracle.LoadInfoDatabase: IConnectionParams;
begin
  Result := Self;

end;

class function TConnectionDbExpressOracle.New(AValue: IConnectionDbExpress)
  : IConnectionParams;
begin
  Result := Self.Create(AValue);
end;

function TConnectionDbExpressOracle.SettingParams: IConnectionParams;
var
  LSQLConnection: TSQLConnection;
begin
  Result := Self;
  LSQLConnection := TSQLConnection.Create(nil);

end;

end.
