unit Types.Attributes.Connection4D;

interface

uses
  Types.Enums.Connection4D,
  Types.Commons.Connection4D;

type
  New__ = class(TCustomAttribute)
  end;

  DatabaseAccess = class(TCustomAttribute)
  private
    FComponent: TEnumComponentDataBase;
    procedure SetComponent(const Value: TEnumComponentDataBase);
  public
    constructor Create(AComponent: TEnumComponentDataBase);
    destructor Destroy; override;
  published
    property Component: TEnumComponentDataBase read FComponent
      write SetComponent;
  end;

  Database = class(TCustomAttribute)
  private
    FDatabases: TSetDatabase;
    FTenant: TEnumTenancy;
    procedure SetDatabases(const Value: TSetDatabase);
    procedure SetTenant(const Value: TEnumTenancy);
  public
    constructor Create(ATenant: TEnumTenancy; ADataBase: TSetDatabase);
  published
    property Databases: TSetDatabase read FDatabases write SetDatabases;
    property Tenant: TEnumTenancy read FTenant write SetTenant;
  end;

  SetterDatabase = class(TCustomAttribute)
  end;

  SetterTenancy = class(TCustomAttribute)
  end;

implementation

{ Database }

constructor Database.Create(ATenant: TEnumTenancy; ADataBase: TSetDatabase);
begin
  Tenant := ATenant;
  Databases := ADataBase;
end;

procedure Database.SetDatabases(const Value: TSetDatabase);
begin
  FDatabases := Value;
end;

procedure Database.SetTenant(const Value: TEnumTenancy);
begin
  FTenant := Value;
end;

{ DatabaseAccess }

constructor DatabaseAccess.Create(AComponent: TEnumComponentDataBase);
begin
  Component := AComponent;
end;

destructor DatabaseAccess.Destroy;
begin

  inherited;
end;

procedure DatabaseAccess.SetComponent(const Value: TEnumComponentDataBase);
begin
  FComponent := Value;
end;

end.
