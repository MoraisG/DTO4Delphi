unit Types.Enums.Helpers.Connection4D;

interface

uses
  Types.Enums.Connection4D;

type
  THelperEnumDatabase = record helper for TEnumDataBase
    function ToString: String;
    function ToInteger: Integer;
  end;

  THelperEnumTenancy = record helper for TEnumTenancy
    function ToString: String;
    function ToInteger: Integer;
  end;

implementation

uses
  System.TypInfo,
  System.RTTI;
{ THelperEnumDatabase }

function THelperEnumDatabase.ToInteger: Integer;
begin
  result := GetEnumValue(TypeInfo(TEnumDataBase), Self.ToString);
end;

function THelperEnumDatabase.ToString: String;
begin
  result := TRttiEnumerationType.GetName<TEnumDataBase>(Self);
end;

{ THelperEnumTenancy }

function THelperEnumTenancy.ToInteger: Integer;
begin
  result := GetEnumValue(TypeInfo(TEnumTenancy), Self.ToString);
end;

function THelperEnumTenancy.ToString: String;
begin
  result := TRttiEnumerationType.GetName<TEnumTenancy>(Self);
end;

end.
