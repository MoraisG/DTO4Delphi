unit RTTI.Contracts.Connection4D;

interface

uses
  Types.Enums.DTO4D;

type
  IRTTIConnection4D<T: IInterface> = interface
    ['{19872C73-E9AE-4DFB-8577-FCF95676A67A}']
    function Connection: T;
    function PoolConnection: IRTTIConnection4D<T>;
  end;

implementation

end.
