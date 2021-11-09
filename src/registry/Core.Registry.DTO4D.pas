unit Core.Registry.DTO4D;

interface

uses System.Generics.Collections;

Type
  TRegisterClassDTO4D = class
  protected
    class var FRegister: TDictionary<TGUID, TClass>;
  public
    class procedure RegisterClass(AGUID: TGUID; AClass: TClass);
    class function GetClass<T: IInterface>: TClass;
    class function GetGUID<T: IInterface>: TGUID;
  end;

implementation

uses
  System.TypInfo;
{ TRegisterClassDTO4D }

class function TRegisterClassDTO4D.GetClass<T>: TClass;
begin
  Result := FRegister.Items[GetGUID<T>];
end;

class function TRegisterClassDTO4D.GetGUID<T>: TGUID;
begin
  Result := GetTypeData(TypeInfo(T))^.GUID
end;

class procedure TRegisterClassDTO4D.RegisterClass(AGUID: TGUID; AClass: TClass);
begin
  if FRegister = nil then
    FRegister := TDictionary<TGUID, TClass>.Create;
  FRegister.Add(AGUID, AClass);
end;

initialization

finalization

if Assigned(TRegisterClassDTO4D.FRegister) then
  TRegisterClassDTO4D.FRegister.Free;

end.
