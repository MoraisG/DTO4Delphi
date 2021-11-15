unit RTTI.Manager.Connection4D;

interface

uses
  System.RTTI,
  Types.Enums.Connection4D,
  RTTI.Contracts.Connection4D;

type

  TRTTIManagerConnection4D<T: IInterface> = class(TInterfacedObject,
    IRTTIConnection4D<T>)
  private
    FContext: TRttiContext;
    FEnumDataBase: TEnumDataBase;
    procedure SettingTenancy(AInterface: TRttiInterfaceType);
    procedure SettingDataBaseConnection(AInterface: TRttiInterfaceType);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IRTTIConnection4D<T>;
    function Connection: T;
    function InfoDataAccess: IRTTIConnection4D<T>;
    function PoolConnection: IRTTIConnection4D<T>;
    class function GetClass: TClass;
  end;

implementation

uses
  System.SysUtils,
  Types.Attributes.Connection4D,
  Types.Enums.Helpers.Connection4D,
  Pool.Connection.Connection4D,
  Registry.Connections.Connection4D;

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
  Result := TRegistryConnection.GetClass<T>;
end;

function TRTTIManagerConnection4D<T>.InfoDataAccess: IRTTIConnection4D<T>;
var
  LType: TRttiType;
  LInterface: TRttiInterfaceType;
  LInstance: TRttiInstanceType;
  LNotation: TCustomAttribute;
begin
  LType := FContext.GetType(GetClass);
  LInstance := LType.AsInstance;
  for LInterface in LInstance.GetImplementedInterfaces do
  begin
    for LNotation in LInterface.GetAttributes do
    begin
      if LNotation is DatabaseAccess then
        TRegistryConnection.InfoConnection.SetDataAcess
          (DatabaseAccess(LNotation).Component);

      if LNotation is Database then
      begin
        TRegistryConnection.InfoConnection.SetDatabase
          (Database(LNotation).Databases);

        TRegistryConnection.InfoConnection.SetTeancy
          (Database(LNotation).Tenant);
      end;

    end;
    Break;
  end;
  Result := Self;
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
  Result := Self;
  LType := FContext.GetType(GetClass);
  LInstance := LType.AsInstance;
  try
    for LInterface in LInstance.GetImplementedInterfaces do
    begin
      SettingTenancy(LInterface);
      for LEnum := Oracle to Postgres do
      begin
        FEnumDataBase := LEnum;
        if LEnum in TRegistryConnection.InfoConnection.GetDatabase then
        begin
          TPoolConnection<T>.Pool.Add(Self.Connection);
          SettingDataBaseConnection(LInterface);
        end;
      end;
    end;
  except
    on E: Exception do
    begin

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
          [TRegistryConnection.InfoConnection.GetTenancy.ToInteger]);
      end;
    end;
end;

end.
