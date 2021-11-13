unit Types.Attributes.DTO4D;

interface

uses
  Types.Enums.DTO4D;

type
{$M+}
  New__ = class(TCustomAttribute)
  end;

  Campo = class(TCustomAttribute)
  private
    FField: String;
    procedure SetField(const Value: String);
  published
    constructor Create(AName: String);
    destructor Destroy; override;
    property Field: String read FField write SetField;
  end;

  Query = class(TCustomAttribute)
  private
    FQuerName: String;
    FQueryType: TEnumQuery;
    procedure SetQuerName(const Value: String);
    procedure SetQueryType(const Value: TEnumQuery);
  public
    constructor Create(const AQueryName: String;
      const AType: TEnumQuery = tpQueryBLOB);
    destructor Destroy; override;
  published
    property QuerName: String read FQuerName write SetQuerName;
    property QueryType: TEnumQuery read FQueryType write SetQueryType;
  end;

  Getter = class(TCustomAttribute)
  end;

  Setter = class(TCustomAttribute)
  end;

implementation

{ Campo }

constructor Campo.Create(AName: String);
begin
  Field := AName;
end;

destructor Campo.Destroy;
begin

  inherited;
end;

procedure Campo.SetField(const Value: String);
begin
  FField := Value;
end;

{ Query }

constructor Query.Create(const AQueryName: String;
  const AType: TEnumQuery = tpQueryBLOB);
begin
  QuerName := AQueryName;
  QueryType := AType;
end;

destructor Query.Destroy;
begin

  inherited;
end;

procedure Query.SetQuerName(const Value: String);
begin
  FQuerName := Value;
end;

procedure Query.SetQueryType(const Value: TEnumQuery);
begin
  FQueryType := Value;
end;

end.
