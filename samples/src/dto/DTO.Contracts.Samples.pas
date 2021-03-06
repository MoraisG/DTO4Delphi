unit DTO.Contracts.Samples;

interface

type
  IEmpresa = interface;

  IPessoa = interface
    ['{1AAE9C12-B9E2-414F-B8AC-81B151812FE1}']
    function Nome(AValue: String): IPessoa; overload;
    function Nome: String; overload;
    function Idade(AValue: Integer): IPessoa; overload;
    function Idade: Integer; overload;
  end;

  IEmpresa = interface
    ['{04DB68BA-D9A9-4BC2-9A31-9819E60ADBDF}']
    function Proprietario(AValue: String): IEmpresa; overload;
    function Propriertario: String; overload;
  end;

implementation

end.
