unit Types.Commons.Connection4D;

interface

uses Types.Enums.Connection4D;

type
  TArrayDatabase = array of TEnumDataBase;
  TSetDatabase = set of TEnumDataBase;

  TInfoConnection = record
  private
    DataAccess: TEnumComponentDataBase;
    DataBaseSets: TSetDatabase;
    InfoTenancy: TEnumTenancy;
  public
    function GetDataAcess: TEnumComponentDataBase;
    function GetDatabase: TSetDatabase;
    function GetTenancy: TEnumTenancy;
    procedure SetDataAcess(AValue: TEnumComponentDataBase);
    procedure SetDatabase(AValue: TSetDatabase);
    procedure SetTeancy(AValue: TEnumTenancy);
  end;

implementation

{ TInfoConnection }

function TInfoConnection.GetDataAcess: TEnumComponentDataBase;
begin
  Result := Self.DataAccess;
end;

function TInfoConnection.GetDatabase: TSetDatabase;
begin
  Result := Self.DataBaseSets;
end;

function TInfoConnection.GetTenancy: TEnumTenancy;
begin
  Result := Self.InfoTenancy;
end;

procedure TInfoConnection.SetDataAcess(AValue: TEnumComponentDataBase);
begin
  Self.DataAccess := AValue;
end;

procedure TInfoConnection.SetDatabase(AValue: TSetDatabase);
begin
  Self.DataBaseSets := AValue;
end;

procedure TInfoConnection.SetTeancy(AValue: TEnumTenancy);
begin
  Self.InfoTenancy := AValue;
end;

end.
