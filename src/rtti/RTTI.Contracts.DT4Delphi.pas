unit RTTI.Contracts.DT4Delphi;

interface

type

  IRTTIManager<T: IInterface> = interface
    ['{B6BB910D-390F-46DB-8F94-4EC0B445FE63}']
    function AsInstace: T;
    function DataSetToObject: T;
    function DataSetToList: IRTTIManager<T>;
    function Bind: IRTTIManager<T>;
  end;

  IRTTIDataBase<T: IInterface> = interface
    ['{FD3B589B-D7F5-41FD-937E-2FDBA907E842}']
    function QueryByBLOB: IRTTIDataBase<T>;
    function QueryByResource: IRTTIDataBase<T>;
  end;

implementation

end.
