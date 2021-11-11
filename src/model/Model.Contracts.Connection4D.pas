unit Model.Contracts.Connection4D;

interface

uses
  Data.DB,
  System.Classes;

type
  IModelConnection4D = interface
    ['{483506D8-5C33-413A-93C8-3B9F387B1C67}']
    function Connection: TComponent;
    function Conect: IModelConnection4D;
    function Disconect: IModelConnection4D;
  end;

  IModelQueryConnection4D = interface
    ['{069F995E-1F1A-4F0C-A178-39A9062ECA91}']
    function Close: IModelQueryConnection4D;
    function DataSet: TDataSet;
    function Add(AValue: String): IModelQueryConnection4D; overload;
    function Add(AValue: TStrings): IModelQueryConnection4D; overload;
    function Add(AValue: TStream): IModelQueryConnection4D; overload;
    function Open: IModelQueryConnection4D;
  end;

implementation

end.
