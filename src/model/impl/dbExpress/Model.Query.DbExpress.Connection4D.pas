unit Model.Query.DbExpress.Connection4D;

interface

uses
  Data.DB,
  SqlExpr,
  System.Classes,
  Model.Connection.Core.Connection4D,
  Model.Contracts.Access.Connection4D;

type

  TModelQueryDbExpressConnection4D = class(TConnectionCore4D,
    IModelQueryConnection4D)
  private
    [weak]
    FConn: IConnectionDbExpress;
    FQuery: TSQLQuery;
  public
    constructor Create(AConn: IConnectionDbExpress);
    destructor Destroy; override;
    class function New(AConn: IConnectionDbExpress): IModelQueryConnection4D;
    function Close: IModelQueryConnection4D;
    function DataSet: TDataSet;
    function Add(AValue: String): IModelQueryConnection4D; overload;
    function Add(AValue: TStrings): IModelQueryConnection4D; overload;
    function Add(AValue: TStream): IModelQueryConnection4D; overload;
    function Open: IModelQueryConnection4D;
  end;

implementation

{ TModelQueryDbExpressConnection4D }

function TModelQueryDbExpressConnection4D.Add(AValue: String)
  : IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.SQL.Add(AValue);
end;

function TModelQueryDbExpressConnection4D.Add(AValue: TStrings)
  : IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.AddStrings(AValue);
end;

function TModelQueryDbExpressConnection4D.Add(AValue: TStream)
  : IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.LoadFromStream(AValue);
end;

function TModelQueryDbExpressConnection4D.Close: IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.Close;
end;

constructor TModelQueryDbExpressConnection4D.Create
  (AConn: IConnectionDbExpress);
begin
  FConn := AConn;
  FQuery := TSQLQuery.Create(nil);
  FQuery.SQLConnection := (FConn.Connection as TSQLConnection);
end;

function TModelQueryDbExpressConnection4D.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TModelQueryDbExpressConnection4D.Destroy;
begin
  FQuery.Free;
  inherited;
end;

class function TModelQueryDbExpressConnection4D.New(AConn: IConnectionDbExpress)
  : IModelQueryConnection4D;
begin
  Result := Self.Create(AConn);
end;

function TModelQueryDbExpressConnection4D.Open: IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.Open;
end;

end.
