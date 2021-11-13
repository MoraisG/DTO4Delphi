unit Connection.DBexpress;

interface

uses
  Types.Attributes.DTO4D,
  Types.Enums.DTO4D,
  Connection.Contracts,
  Connection.Base;
{$M+}

type

  TConnectionDbExpress = class(TConnectionBase, IConnectionDbExpress)
  private

  public
    constructor Create;
    destructor Destroy; override;
    [New__]
    class function New: IConnectionDbExpress;
    function Conect: IConnectionBase; override;
  end;

implementation

uses
  Core.Registry.DTO4D,
  System.SysUtils;
{ TConnectionDbExpress }

function TConnectionDbExpress.Conect: IConnectionBase;
begin
  Result := Self;
  raise Exception.Create('DbExpress');
end;

constructor TConnectionDbExpress.Create;
begin

end;

destructor TConnectionDbExpress.Destroy;
begin

  inherited;
end;

class function TConnectionDbExpress.New: IConnectionDbExpress;
begin
  Result := Self.Create;
end;

initialization

TRegisterClassDTO4D.RegisterClass
  (TRegisterClassDTO4D.GetGUID<IConnectionDbExpress>, TConnectionDbExpress);

end.
