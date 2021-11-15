unit Model.Contracts.Connection4D;

interface

uses
  Types.Attributes.Connection4D,
  Types.Enums.Connection4D,
  System.Classes,
  System.Generics.Collections;

type
{$M+}

  [DatabaseAccess(DbExpress), Database(SingleTenancy, [Oracle, Firebird])]
  IModelConnection4D = interface
    ['{483506D8-5C33-413A-93C8-3B9F387B1C67}']
    function Connection: TComponent;
    function Conect(AID: Integer): IModelConnection4D;

    [SetterDatabase]
    function Database(AValue: Integer): IModelConnection4D;
    function Disconect: IModelConnection4D;
    function LoadParams: IModelConnection4D;

    [SetterTenancy]
    function TipoTenancy(AValue: TEnumTenancy): IModelConnection4D;
    function PoolConnection: TObjectDictionary<Integer, TComponent>;
  end;

implementation

end.
