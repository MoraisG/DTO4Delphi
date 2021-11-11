unit Core.Params.Manager.DTO4Delphi;

interface

uses
  Core.Contracts.DTO4Delphi,
  Data.DB;

type

  TCoreParamsDTO4Delphi<T: IInterface> = class(TInterfacedObject,
    ICoreParams4DTODelphi<T>)
  private
    [weak]
    FParent: ICoreDTO4Delphi<T>;
    FClass: TClass;
    FDataSource: TDataSource;
    FNameQuery: String;
  public
    constructor Create(AParent: ICoreDTO4Delphi<T>);
    destructor Destroy; override;
    class function New(AParent: ICoreDTO4Delphi<T>): ICoreParams4DTODelphi<T>;
    function ClassType(AValue: TClass): ICoreParams4DTODelphi<T>; overload;
      deprecated;
    function ClassType: TClass; overload; deprecated;
    function DataSet(ADataSource: TDataSource)
      : ICoreParams4DTODelphi<T>; overload;
    function DataSet(ADataSet: TDataSet): ICoreParams4DTODelphi<T>; overload;
    function GetDataSet: TDataSet; overload;
    function GetNameQuery: String;
    function Return: ICoreDTO4Delphi<T>;
    function SetNameQuery(AValue: String): ICoreParams4DTODelphi<T>;
  end;

implementation

{ TCoreParamsDTO4Delphi<T> }

function TCoreParamsDTO4Delphi<T>.ClassType(AValue: TClass)
  : ICoreParams4DTODelphi<T>;
begin
  Result := Self;
  FClass := AValue;
end;

function TCoreParamsDTO4Delphi<T>.ClassType: TClass;
begin
  Result := FClass;
end;

function TCoreParamsDTO4Delphi<T>.Return: ICoreDTO4Delphi<T>;
begin
  Result := FParent;
end;

function TCoreParamsDTO4Delphi<T>.SetNameQuery(AValue: String)
  : ICoreParams4DTODelphi<T>;
begin
  Result := Self;
  FNameQuery := AValue;
end;

constructor TCoreParamsDTO4Delphi<T>.Create(AParent: ICoreDTO4Delphi<T>);
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
  : ICoreParams4DTODelphi<T>;
begin
  Result := Self;
  FDataSource.DataSet := ADataSource.DataSet;
end;

function TCoreParamsDTO4Delphi<T>.DataSet(ADataSet: TDataSet)
  : ICoreParams4DTODelphi<T>;
begin
  Result := Self;
  FDataSource.DataSet := ADataSet;
end;

destructor TCoreParamsDTO4Delphi<T>.Destroy;
begin
  FDataSource.Free;
  inherited;
end;

class function TCoreParamsDTO4Delphi<T>.New(AParent: ICoreDTO4Delphi<T>)
  : ICoreParams4DTODelphi<T>;
begin
  Result := Self.Create(AParent);
end;

end.
