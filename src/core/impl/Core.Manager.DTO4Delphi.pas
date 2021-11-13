unit Core.Manager.DTO4Delphi;

interface

uses
  System.Generics.Collections,
  Core.Contracts.DTO4Delphi;

type

  TCoreManagerDTO4Delphi<T: IInterface> = class(TInterfacedObject,
    IDTO4Delphi<T>)
  private
    FListObjs: TList<T>;
    FOwnerList: Boolean;
  protected
    FParams: IParams4DTODelphi<T>;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IDTO4Delphi<T>;
    function Bind: IDTO4Delphi<T>;
    function DTO: T;
    function DataSetToObject: T;
    function DataSetToList(const AOwnwer: Boolean = true): TList<T>;
    function Delete: IDTO4Delphi<T>;
    function GetList: TList<T>;
    function Insert(AObject: T): IDTO4Delphi<T>;
    function Params: IParams4DTODelphi<T>;
    function Update: IDTO4Delphi<T>;
  end;

implementation

{ TCoreManagerDTO4Delphi<T> }

uses
  RTTI.Manager.DTO4Delphi,
  Core.Params.Manager.DTO4Delphi;

function TCoreManagerDTO4Delphi<T>.Bind: IDTO4Delphi<T>;
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

function TCoreManagerDTO4Delphi<T>.Delete: IDTO4Delphi<T>;
begin
  Result := Self;
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

function TCoreManagerDTO4Delphi<T>.Insert(AObject: T): IDTO4Delphi<T>;
begin
  Result := Self;
  Self.Params.DTO(AObject);
  TRTTIManager4DTODelphi<T>.New(Self).Insert;
end;

class function TCoreManagerDTO4Delphi<T>.New: IDTO4Delphi<T>;
begin
  Result := Self.Create;
end;

function TCoreManagerDTO4Delphi<T>.Params: IParams4DTODelphi<T>;
begin
  if FParams = nil then
    FParams := TCoreParamsDTO4Delphi<T>.New(Self);
  Result := FParams;
end;

function TCoreManagerDTO4Delphi<T>.Update: IDTO4Delphi<T>;
begin
  Result := Self;
end;

end.
