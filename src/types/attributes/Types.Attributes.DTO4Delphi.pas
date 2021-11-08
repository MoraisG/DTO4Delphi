unit Types.Attributes.DTO4Delphi;

interface

type
{$M+}
  Instance = class(TCustomAttribute)
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

  Injection = class(TCustomAttribute)
  private
    FClass: TClass;
    FParent: IInterface;
  public
    constructor Create(AInjection: TClass);
    function ClassType: TClass;
    function Obj: IInterface;
  end;

implementation

{ Injection }

function Injection.ClassType: TClass;
begin
  Result := FClass;
end;

constructor Injection.Create(AInjection: TClass);
begin
  FClass := AInjection;
end;

function Injection.Obj: IInterface;
begin
  Result := FParent;
end;

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

end.
