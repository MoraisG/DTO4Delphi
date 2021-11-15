unit Registry.Connections.Connection4D;

interface

uses
  Types.Enums.Connection4D,
  Types.Commons.Connection4D,
  Model.Contracts.Connection4D,
  System.Generics.Collections,
  Model.Contracts.Access.Connection4D;

type

  THelperEnumRegistryDataAccess = record helper for TEnumComponentDataBase
    procedure Registry;
  end;

  TRegistryConnection = class

  protected
    class var FInfoConnection: TInfoConnection;
    class var FRegisters: TDictionary<TGUID, TClass>;
  public
    class procedure GetInfoConnection;
    class procedure RegistryConnection;
    class function InfoConnection: TInfoConnection;
    class procedure RegisterClass(AGUID: TGUID; AClass: TClass);
    class function GetClass<T: IInterface>: TClass;
    class function GetGUID<T: IInterface>: TGUID;
  end;

const
  TOTAL_REGISTRY = 5;

implementation

uses
  System.TypInfo,
  Model.DbExpress.Connection4D,
  RTTI.Manager.Connection4D;

{ TRegistryConnection }

class function TRegistryConnection.GetClass<T>: TClass;
begin
  Result := FRegisters.Items[GetGUID<T>];
end;

class function TRegistryConnection.GetGUID<T>: TGUID;
begin
  Result := GetTypeData(TypeInfo(T))^.GUID
end;

class procedure TRegistryConnection.GetInfoConnection;
begin
  TRTTIManagerConnection4D<IModelConnection4D>.New.InfoDataAccess;
end;

class function TRegistryConnection.InfoConnection: TInfoConnection;
begin
  Result := FInfoConnection;
end;

class procedure TRegistryConnection.RegisterClass(AGUID: TGUID; AClass: TClass);
begin
  if FRegisters = nil then
    FRegisters := TDictionary<TGUID, TClass>.Create(TOTAL_REGISTRY);
  FRegisters.Add(AGUID, AClass);
end;

class procedure TRegistryConnection.RegistryConnection;
begin
  FInfoConnection.GetDataAcess.Registry;
end;

{ THelperEnumRegistryDataAccess }

procedure THelperEnumRegistryDataAccess.Registry;
begin
  case self of
    DbExpress:
      TRegistryConnection.RegisterClass
        (TRegistryConnection.GetGUID<IConnectionDbExpress>,
        TConnectionDbExpress);
    FireDac:
      ;
    Zeos:
      ;
    UniDac:
      ;
  end;
end;

end.
