unit Pool.Connection.Connection4D;

interface

uses
  Model.Contracts.Connection4D,
  System.Generics.Collections;

type
  TPoolConnection<T: IInterface> = class
  protected
    class var FPool: TList<T>;
  public
    class function Pool: TList<T>;
    class destructor Destroy;
  end;

implementation

{ TPoolConnection<T> }

class destructor TPoolConnection<T>.Destroy;
begin
  if Assigned(FPool) then
    FPool.Free;
end;

class function TPoolConnection<T>.Pool: TList<T>;
begin
  if FPool = nil then
    FPool := TList<T>.Create;
end;

end.
