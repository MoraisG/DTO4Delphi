unit Core.Contracts.DTO4Delphi;

interface

uses
  System.Generics.Collections,
  Data.DB;

type
  ICoreParams4DTODelphi<T: IInterface> = interface;

  ICoreDTO4Delphi<T: IInterface> = interface
    ['{52C3750B-84E0-41B4-AA07-1E0BAFE52BA1}']
    function Bind: ICoreDTO4Delphi<T>;
    function DTO: T;
    function DataSetToObject: T;
    function DataSetToList(const AOwnwer: boolean = true): TList<T>;
    function GetList: TList<T>;
    function Params: ICoreParams4DTODelphi<T>;
  end;

  ICoreParams4DTODelphi<T: IInterface> = interface
    ['{9753CD92-51CC-47DA-88CD-88D97199E073}']
    function ClassType(AValue: TClass): ICoreParams4DTODelphi<T>; overload;
      deprecated;
    function ClassType: TClass; overload; deprecated;
    function DataSet(ADataSource: TDataSource)
      : ICoreParams4DTODelphi<T>; overload;
    function DataSet(ADataSet: TDataSet)
      : ICoreParams4DTODelphi<T>; overload;
    function GetNameQuery: String;
    function GetDataSet: TDataSet; overload;
    function Return: ICoreDTO4Delphi<T>;
    function SetNameQuery(AValue: String): ICoreParams4DTODelphi<T>;
  end;

implementation

end.
