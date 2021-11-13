unit RTTI.Strategy.QueryByBLOB.DTO4D;

interface

uses
  Data.DB,
  RTTI.Contracts.DT4Delphi,
  Core.Contracts.DTO4Delphi;

type

  TQueryBlobDTO4Delphi<T: IInterface> = class(TInterfacedObject,
    IRTTIDataBase<T>)
  private
    [Weak]
    FCoreDTO: IDTO4Delphi<T>;
  public
    constructor Create(AValue: IDTO4Delphi<T>);
    destructor Destroy; override;
    class function New(AValue: IDTO4Delphi<T>): IRTTIDataBase<T>;
    function Query: IRTTIDataBase<T>;
  end;

implementation

{ TQueryBlobDTO4Delphi<T> }

constructor TQueryBlobDTO4Delphi<T>.Create(AValue: IDTO4Delphi<T>);
begin
  FCoreDTO := AValue;
end;

destructor TQueryBlobDTO4Delphi<T>.Destroy;
begin

  inherited;
end;

class function TQueryBlobDTO4Delphi<T>.New(AValue: IDTO4Delphi<T>)
  : IRTTIDataBase<T>;
begin
  Result := Self.Create(AValue);
end;

function TQueryBlobDTO4Delphi<T>.Query: IRTTIDataBase<T>;
begin
  Result := Self;
end;

end.
