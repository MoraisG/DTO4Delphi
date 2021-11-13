unit Core.Params.Manager.DTO4Delphi;

interface

uses
  Core.Contracts.DTO4D,
  Data.DB;

type

  TCoreParamsDTO4Delphi<T: IInterface> = class(TInterfacedObject,
    IParams4DTODelphi<T>)
  private
    [weak]
    FParent: IDTO4Delphi<T>;
    [weak]
    FDTO: T;
    FClass: TClass;
    FDataSource: TDataSource;
    FNameQuery: String;
  public
    constructor Create(AParent: IDTO4Delphi<T>);
    destructor Destroy; override;
    class function New(AParent: IDTO4Delphi<T>): IParams4DTODelphi<T>;
    function ClassType(AValue: TClass): IParams4DTODelphi<T>; overload;
      deprecated;
    function ClassType: TClass; overload; deprecated;
    function DataSet(ADataSource: TDataSource): IParams4DTODelphi<T>; overload;
    function DataSet(ADataSet: TDataSet): IParams4DTODelphi<T>; overload;
    function DTO(AValue: T): IParams4DTODelphi<T>; overload;
    function DTO: T; overload;
    function GetDataSet: TDataSet; overload;
    function GetNameQuery: String;
    function Return: IDTO4Delphi<T>;
    function SetNameQuery(AValue: String): IParams4DTODelphi<T>;
  end;

implementation

{ TCoreParamsDTO4Delphi<T> }

function TCoreParamsDTO4Delphi<T>.ClassType(AValue: TClass)
  : IParams4DTODelphi<T>;
begin
  Result := Self;
  FClass := AValue;
end;

function TCoreParamsDTO4Delphi<T>.ClassType: TClass;
begin
  Result := FClass;
end;

function TCoreParamsDTO4Delphi<T>.Return: IDTO4Delphi<T>;
begin
  Result := FParent;
end;

function TCoreParamsDTO4Delphi<T>.SetNameQuery(AValue: String)
  : IParams4DTODelphi<T>;
begin
  Result := Self;
  FNameQuery := AValue;
end;

constructor TCoreParamsDTO4Delphi<T>.Create(AParent: IDTO4Delphi<T>);
begin
  FParent := AParent;
  FDataSource := TDataSource.Create(nil);
end;

function TCoreParamsDTO4Delphi<T>.GetDataSet: TDataSet;
begin
  Result := FDataSource.DataSet;
end;

function TCoreParamsDTO4Delphi<T>.GetNameQuery: String;
begin
  Result := FNameQuery;
end;

function TCoreParamsDTO4Delphi<T>.DataSet(ADataSource: TDataSource)
  : IParams4DTODelphi<T>;
begin
  Result := Self;
  FDataSource.DataSet := ADataSource.DataSet;
end;

function TCoreParamsDTO4Delphi<T>.DataSet(ADataSet: TDataSet)
  : IParams4DTODelphi<T>;
begin
  Result := Self;
  FDataSource.DataSet := ADataSet;
end;

destructor TCoreParamsDTO4Delphi<T>.Destroy;
begin
  FDataSource.Free;
  inherited;
end;

function TCoreParamsDTO4Delphi<T>.DTO: T;
begin
  Result := FDTO;
end;

function TCoreParamsDTO4Delphi<T>.DTO(AValue: T): IParams4DTODelphi<T>;
begin
  Result := Self;
  FDTO := AValue;
end;

class function TCoreParamsDTO4Delphi<T>.New(AParent: IDTO4Delphi<T>)
  : IParams4DTODelphi<T>;
begin
  Result := Self.Create(AParent);
end;

end.
