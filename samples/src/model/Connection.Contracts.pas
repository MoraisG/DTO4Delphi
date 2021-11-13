unit Connection.Contracts;

interface

uses
  Data.DB,
  Types.Attributes.DTO4D,
  Types.Enums.DTO4D,
  System.Classes,
  Types.Commons.DTO4D;

{$M+}

type

  [DatabaseAcces(DbExpress), Database(MultiTenancy, [Oracle, Postgres, MSSQL])]
  IConnectionBase = interface
    ['{C4D0E5A5-A923-45FF-9E3D-C3BE32EF9941}']
    function Conect: IConnectionBase;
  end;

  IConnectionDbExpress = interface(IConnectionBase)
    ['{2BA1EAF5-9E15-4456-BE29-53BC11F4F42E}']
  end;

  IConnectionFireDac = interface(IConnectionBase)
    ['{CF8377E7-47DF-4F5C-828F-9F7B630697E4}']
  end;

implementation

end.
