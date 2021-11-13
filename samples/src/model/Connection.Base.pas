unit Connection.Base;

interface

uses Connection.Contracts;

type

  TConnectionBase = class(TInterfacedObject, IConnectionBase)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New: IConnectionBase;
    function Conect: IConnectionBase; virtual;
  end;

implementation

uses
  System.SysUtils;
{ TConnectionBase }

function TConnectionBase.Conect: IConnectionBase;
begin
  Result := Self;
  raise Exception.Create('Implementar método nas classes herdadas');
end;

constructor TConnectionBase.Create;
begin

end;

destructor TConnectionBase.Destroy;
begin

  inherited;
end;

class function TConnectionBase.New: IConnectionBase;
begin
  Result := Self.Create;
end;

end.
