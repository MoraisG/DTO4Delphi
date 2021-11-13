unit RTTI.Manager.Connection4D;

interface

uses
  System.RTTI,
  Types.Enums.Connection4D,
  System.Generics.Collections,
  RTTI.Contracts.Connection4D;

type

  TRTTIManagerConnection4D<T: IInterface> = class(TInterfacedObject,
    IRTTIConnection4D<T>)
  private
    FContext: TRttiContext;
    FEnumDataBase: TEnumDataBase;
    FEnumTenancy: TEnumTenancy;
    procedure SettingTenancy(AInterface: TRttiInterfaceType);
    procedure SettingDataBaseConnection(AInterface: TRttiInterfaceType);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IRTTIConnection4D<T>;
    function Connection: T;
    function PoolConnection: IRTTIConnection4D<T>;
    class function GetClass: TClass;
  end;

implementation

uses
  Types.Attributes.Connection4D,
  Core.Registry.DTO4D,
  Types.Enums.Helpers.Connection4D,
  Pool.Connection.Connection4D;

{ TRTTIManagerConnection4D<T:IInterface> }

function TRTTIManagerConnection4D<T>.Connection: T;
var
  LType: TRttiType;
  LMethod: TRttiMethod;
  LNotation: TCustomAttribute;
begin
  Result := nil;
  LType := FContext.GetType(GetClass);
  for LMethod in LType.GetDeclaredMethods do
  begin
    for LNotation in LMethod.GetAttributes do
    begin
      if LNotation is New__ then
      begin
        Result := LMethod.Invoke(GetClass, []).AsType<T>;
        Break;
      end;
    end;
  end;
end;

constructor TRTTIManagerConnection4D<T>.Create;
begin

end;

destructor TRTTIManagerConnection4D<T>.Destroy;
begin
  FContext.Free;
  inherited;
end;

class function TRTTIManagerConnection4D<T>.GetClass: TClass;
begin
  Result := TRegisterClassDTO4D.GetClass<T>;
end;

class function TRTTIManagerConnection4D<T>.New: IRTTIConnection4D<T>;
begin
  Result := Self.Create;
end;

function TRTTIManagerConnection4D<T>.PoolConnection: IRTTIConnection4D<T>;
var
  LType: TRttiType;
  LInterface: TRttiInterfaceType;
  LInstance: TRttiInstanceType;
  LNotation: TCustomAttribute;
  LEnum: TEnumDataBase;
begin

  LType := FContext.GetType(GetClass);
  LInstance := LType.AsInstance;
  for LInterface in LInstance.GetImplementedInterfaces do
  begin
    for LNotation in LInterface.GetAttributes do
    begin
      if LNotation is Database then
      begin
        TPoolConnection<T>.Pool.Add(Self.Connection);
        FEnumTenancy := Database(LNotation).Tenant;
        SettingTenancy(LInterface);
        for LEnum := Oracle to Postgres do
        begin
          FEnumDataBase := LEnum;
          SettingDataBaseConnection(LInterface);
        end;
      end;
    end;
  end;
end;

procedure TRTTIManagerConnection4D<T>.SettingDataBaseConnection
  (AInterface: TRttiInterfaceType);
var
  LMethod: TRttiMethod;
  LNotation: TCustomAttribute;
begin
  for LMethod in AInterface.GetDeclaredMethods do
    for LNotation in LMethod.GetAttributes do
    begin
      if LNotation is SetterDatabase then
      begin
        LMethod.Invoke(TValue.From<T>(TPoolConnection<T>.Pool.Last),
          [FEnumDataBase.ToInteger]);
      end;
    end;
end;

procedure TRTTIManagerConnection4D<T>.SettingTenancy
  (AInterface: TRttiInterfaceType);
var
  LMethod: TRttiMethod;
  LNotation: TCustomAttribute;
begin
  for LMethod in AInterface.GetDeclaredMethods do
    for LNotation in LMethod.GetAttributes do
    begin
      if LNotation is SetterTenancy then
      begin
        LMethod.Invoke(TValue.From<T>(TPoolConnection<T>.Pool.Last),
          [FEnumTenancy.ToInteger]);
      end;
    end;
end;

end.
