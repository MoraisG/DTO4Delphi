unit Model.Query.DbExpress.Connection4D;

interface

uses
  Data.DB,
  SqlExpr,
  System.Classes,
  Model.Contracts.Connection4D;

type

  TModelQueryConnection4D = class(TInterfacedObject, IModelQueryConnection4D)
  private
    FQuery: TSQLQuery;
  public
    constructor Create(AConn: IModelConnection4D);
    destructor Destroy; override;
    class function New(AConn: IModelConnection4D): IModelQueryConnection4D;
    function Close: IModelQueryConnection4D;
    function DataSet: TDataSet;
    function Add(AValue: String): IModelQueryConnection4D; overload;
    function Add(AValue: TStrings): IModelQueryConnection4D; overload;
    function Add(AValue: TStream): IModelQueryConnection4D; overload;
    function Open: IModelQueryConnection4D;
  end;

implementation

{ TModelQueryConnection4D }

function TModelQueryConnection4D.Add(AValue: String): IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.SQL.Add(AValue);
end;

function TModelQueryConnection4D.Add(AValue: TStrings): IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.AddStrings(AValue);
end;

function TModelQueryConnection4D.Add(AValue: TStream): IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.LoadFromStream(AValue);
end;

function TModelQueryConnection4D.Close: IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.Close;
end;

constructor TModelQueryConnection4D.Create(AConn: IModelConnection4D);
begin
  FQuery := TSQLQuery.Create(nil);
  FQuery.SQLConnection := (AConn.Connection as TSQLConnection);
end;

function TModelQueryConnection4D.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TModelQueryConnection4D.Destroy;
begin
  FQuery.Free;
  inherited;
end;

class function TModelQueryConnection4D.New(AConn: IModelConnection4D)
  : IModelQueryConnection4D;
begin
  Result := Self.Create(AConn);
end;

function TModelQueryConnection4D.Open: IModelQueryConnection4D;
begin
  Result := Self;
  FQuery.Open;
end;

end.
