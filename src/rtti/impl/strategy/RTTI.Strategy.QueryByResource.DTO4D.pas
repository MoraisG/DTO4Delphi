unit RTTI.Strategy.QueryByResource.DTO4D;

{$I config.inc}

interface

uses
  Model.Contracts.Access.Connection4D,
  RTTI.Contracts.DTO4D,
  Core.Contracts.DTO4D;

type

  TQueryResourceDTO4Delphi<T: IInterface> = class(TInterfacedObject,
    IRTTIDataBase<T>)
  private
    [Weak]
    FCoreDTO: IDTO4Delphi<T>;
    FQuery: IModelQueryConnection4D;
  public
    constructor Create(AValue: IDTO4Delphi<T>);
    destructor Destroy; override;
    class function New(AValue: IDTO4Delphi<T>): IRTTIDataBase<T>;
    function Query: IRTTIDataBase<T>;
  end;

implementation

uses
  Winapi.Windows,
  System.Classes;
{ TQueryResourceDTO4Delphi<T> }

constructor TQueryResourceDTO4Delphi<T>.Create(AValue: IDTO4Delphi<T>);
begin
  FCoreDTO := AValue;
  FQuery := nil;
end;

destructor TQueryResourceDTO4Delphi<T>.Destroy;
begin
  inherited;
end;

class function TQueryResourceDTO4Delphi<T>.New(AValue: IDTO4Delphi<T>)
  : IRTTIDataBase<T>;
begin
  Result := Self.Create(AValue);
end;

function TQueryResourceDTO4Delphi<T>.Query: IRTTIDataBase<T>;
var
  LResourceStream: TResourceStream;
begin
  Result := Self;
  LResourceStream := TResourceStream.Create(HInstance,
    FCoreDTO.Params.GetNameQuery, RT_RCDATA);
  try
    FCoreDTO.Params.DataSet(FQuery.Close.Add(LResourceStream).Open.DataSet);
  finally
    LResourceStream.Free;
  end;
end;

end.
