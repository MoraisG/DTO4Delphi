unit Types.Enums.Helpers.Databases.Connection4D;

interface

uses
  Types.Enums.Connection4D,
  Model.Contracts.Access.Connection4D;

type
  THelperEnumDatabase = record helper for TEnumDataBase
  public
    function DBExpressParametros(AValue: IConnectionDbExpress)
      : IConnectionParams;
  end;

implementation

{ THelperEnumDatabase }

function THelperEnumDatabase.DBExpressParametros(AValue: IConnectionDbExpress)
  : IConnectionParams;
begin
  case self of
    Oracle:
      ;
    Firebird:
      ;
    MySQL:
      ;
    MSSQL:
      ;
    Postgres:
      ;
  end;
end;

end.
