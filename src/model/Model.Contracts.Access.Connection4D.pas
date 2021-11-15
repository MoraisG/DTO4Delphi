unit Model.Contracts.Access.Connection4D;

interface

uses
  Data.DB,
  System.Classes,
  Model.Contracts.Connection4D;

type

  IConnectionDbExpress = interface(IModelConnection4D)
    ['{C8CB32AE-CC87-411C-9B41-26241F537BA3}']
  end;

  IConnectionFireDac = interface(IModelConnection4D)
    ['{1048AAD7-95D1-47EE-8FBA-BAC881E992BF}']
  end;

  IConnectionZeos = interface(IModelConnection4D)
    ['{CBDDD0F3-6872-471C-BF45-BEABB063D04A}']
  end;

  IConnectionUniDac = interface(IModelConnection4D)
    ['{8ADB281C-9FCB-4F2E-8FD3-1997F7DAE8DD}']
  end;

  IConnectionParams = interface
    ['{1653C6EB-55ED-4009-8444-6DA9582F0A94}']
    function LoadInfoDatabase: IConnectionParams;
    function SettingParams: IConnectionParams;
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
