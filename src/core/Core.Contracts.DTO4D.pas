unit Core.Contracts.DTO4D;

interface

uses
  System.Generics.Collections,
  Data.DB;

type
  IParams4DTODelphi<T: IInterface> = interface;

  IDTO4Delphi<T: IInterface> = interface
    ['{52C3750B-84E0-41B4-AA07-1E0BAFE52BA1}']
    function Bind: IDTO4Delphi<T>;
    function DTO: T;
    function DataSetToObject: T;
    function DataSetToList(const AOwnwer: boolean = true): TList<T>;
    function Delete: IDTO4Delphi<T>;
    function GetList: TList<T>;
    function Insert(AObject : T): IDTO4Delphi<T>;
    function Params: IParams4DTODelphi<T>;
    function Update: IDTO4Delphi<T>;
  end;

  IParams4DTODelphi<T: IInterface> = interface
    ['{9753CD92-51CC-47DA-88CD-88D97199E073}']
    function ClassType(AValue: TClass): IParams4DTODelphi<T>; overload;
      deprecated;
    function ClassType: TClass; overload; deprecated;
    function DataSet(ADataSource: TDataSource): IParams4DTODelphi<T>; overload;
    function DataSet(ADataSet: TDataSet): IParams4DTODelphi<T>; overload;
    function DTO(AValue: T): IParams4DTODelphi<T>; overload;
    function DTO: T; overload;
    function GetNameQuery: String;
    function GetDataSet: TDataSet; overload;
    function Return: IDTO4Delphi<T>;
    function SetNameQuery(AValue: String): IParams4DTODelphi<T>;
  end;

implementation

end.
