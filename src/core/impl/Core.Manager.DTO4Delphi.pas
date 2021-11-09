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
    FOwnerList: Boolean;
    FParams: ICoreParams4DTODelphi<T>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: ICoreDTO4Delphi<T>;
    function Bind: ICoreDTO4Delphi<T>;
    function DTO: T;
    function DataSetToObject: T;
    function DataSetToList(const AOwnwer: Boolean = true): TList<T>;
    function GetList : TList<T>;
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
  FOwnerList := true;
end;

function TCoreManagerDTO4Delphi<T>.DataSetToList(const AOwnwer: Boolean = true)
  : TList<T>;
begin
  FOwnerList := AOwnwer;
  TRTTIManager4DTODelphi<T>.New(Self).DataSetToList;
  Result := FListObjs;
end;

function TCoreManagerDTO4Delphi<T>.DataSetToObject: T;
begin
  Result := TRTTIManager4DTODelphi<T>.New(Self).DataSetToObject;
end;

destructor TCoreManagerDTO4Delphi<T>.Destroy;
begin
  if FOwnerList then
    FListObjs.Free;
  inherited;
end;

function TCoreManagerDTO4Delphi<T>.DTO: T;
begin
  Result := TRTTIManager4DTODelphi<T>.New(Self).AsInstace;
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
