unit Core.Manager.DTO4Delphi;

interface

uses
  System.Generics.Collections,
  Core.Contracts.DTO4Delphi;

type

  TCoreManagerDTO4Delphi<T: IInterface> = class(TInterfacedObject,
    ICoreDTO4Delphi<T>)
  private
    FListObjs: TList<T>;
    FInstance: T;
    FParams: ICoreParams4DTODelphi<T>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ICoreDTO4Delphi<T>;
    function Bind: ICoreDTO4Delphi<T>;
    function DataSetToObject: T;
    function DataSetToList: ICoreDTO4Delphi<T>;
    function DTO: T;
    function GetList: TList<T>;
    function Params: ICoreParams4DTODelphi<T>;
  end;

implementation

{ TCoreManagerDTO4Delphi<T> }

uses
  RTTI.Manager.DTO4Delphi,
  Core.Params.Manager.DTO4Delphi;

function TCoreManagerDTO4Delphi<T>.Bind: ICoreDTO4Delphi<T>;
begin
  Result := Self;
end;

constructor TCoreManagerDTO4Delphi<T>.Create;
begin
  FListObjs := TList<T>.Create;
end;

function TCoreManagerDTO4Delphi<T>.DataSetToList: ICoreDTO4Delphi<T>;
begin
  Result := Self;
  TRTTIManager4DTODelphi<T>.New(Self).DataSetToList;
end;

function TCoreManagerDTO4Delphi<T>.DataSetToObject: T;
begin
  Self.DTO;
  TRTTIManager4DTODelphi<T>.New(Self).DataSetToObject;
  Result := FInstance;
end;

destructor TCoreManagerDTO4Delphi<T>.Destroy;
begin
  FListObjs.Free;
  inherited;
end;

function TCoreManagerDTO4Delphi<T>.DTO: T;
begin
  if FInstance = nil then
    FInstance := TRTTIManager4DTODelphi<T>.New(Self).AsInstace;
  Result := FInstance;
end;

function TCoreManagerDTO4Delphi<T>.GetList: TList<T>;
begin
  Result := FListObjs;
end;

class function TCoreManagerDTO4Delphi<T>.New: ICoreDTO4Delphi<T>;
begin
  Result := Self.Create;
end;

function TCoreManagerDTO4Delphi<T>.Params: ICoreParams4DTODelphi<T>;
begin
  if FParams = nil then
    FParams := TCoreParamsDTO4Delphi<T>.New(Self);
  Result := FParams;
end;

end.
