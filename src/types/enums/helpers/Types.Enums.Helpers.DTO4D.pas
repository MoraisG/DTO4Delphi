unit Types.Enums.Helpers.DTO4D;

interface

uses
  RTTI.Contracts.DT4Delphi, Types.Enums.DTO4D, Core.Contracts.DTO4Delphi;

type
  THelperEnumQuery = record helper for TEnumQuery
    function Query<T: IInterface>(AValue: IDTO4Delphi<T>): IRTTIDataBase<T>;
  end;

implementation

{ THelperEnumQuery }

uses
  RTTI.Strategy.QueryByBLOB.DTO4D,
  RTTI.Strategy.QueryByResource.DTO4D;

function THelperEnumQuery.Query<T>(AValue: IDTO4Delphi<T>)
  : IRTTIDataBase<T>;
begin
  case self of
    tpQueryResource:
      Result := TQueryResourceDTO4Delphi<T>.New(AValue);
    tpQueryBLOB:
      Result := TQueryBlobDTO4Delphi<T>.New(AValue);
  end;
end;

end.
