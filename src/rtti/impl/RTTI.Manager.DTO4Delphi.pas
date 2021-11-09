unit RTTI.Manager.DTO4Delphi;

interface

uses Core.Contracts.DTO4Delphi, RTTI.Contracts.DT4Delphi, System.RTTI;

type

  TRTTIManager4DTODelphi<T: IInterface> = class(TInterfacedObject,
    IRTTIManager<T>)
  private
    [weak]
    FParent: ICoreDTO4Delphi<T>;
    FContext: TRttiContext;
  public
    constructor Create(AParent: ICoreDTO4Delphi<T>);
    destructor Destroy; override;
    class function New(AParent: ICoreDTO4Delphi<T>): IRTTIManager<T>;
    function AsInstace: T;
    function Bind: IRTTIManager<T>;
    function DataSetToObject: T;
    function DataSetToList: IRTTIManager<T>;
    function GetClass: TClass;
  end;

implementation

{ TRTTIManager4DTODelphi<T> }

uses System.SysUtils, Types.Attributes.DTO4Delphi, Data.DB, Core.Registry.DTO4D;

function TRTTIManager4DTODelphi<T>.AsInstace: T;
var
  LType: TRttiType;
  LMethods: TRttiMethod;
  LAttributes: TCustomAttribute;
begin
  Result := nil;

  LType := FContext.GetType(GetClass);

  for LMethods in LType.GetDeclaredMethods do
    for LAttributes in LMethods.GetAttributes do
      if LAttributes is New__ then
        Result := LMethods.Invoke(GetClass, []).AsType<T>;

end;

function TRTTIManager4DTODelphi<T>.Bind: IRTTIManager<T>;
begin
  Result := Self;
end;

constructor TRTTIManager4DTODelphi<T>.Create(AParent: ICoreDTO4Delphi<T>);
begin
  FParent := AParent;
  FContext := TRttiContext.Create;
end;

function TRTTIManager4DTODelphi<T>.DataSetToList: IRTTIManager<T>;
var
  LType: TRttiType;
  LInstance: TRttiInstanceType;
  LInterface: TRttiInterfaceType;
  LMethods: TRttiMethod;
  LAttributes: TCustomAttribute;
  LField: TField;
begin
  Result := Self.AsInstace;
  LType := FContext.GetType(GetClass);

  FParent.Params.GetDataSet.First;
  FParent.Params.GetDataSet.DisableControls;
  while not FParent.Params.GetDataSet.Eof do
  begin
    FParent.GetList.Add(Self.AsInstace);
    LInstance := LType.AsInstance;
    for LInterface in LInstance.GetDeclaredImplementedInterfaces do
    begin
      for LMethods in LInterface.GetDeclaredMethods do
        for LAttributes in LMethods.GetAttributes do
          if LAttributes is Campo then
          begin
            LField := FParent.Params.GetDataSet.FieldByName
              (Campo(LAttributes).Field);
            case LField.DataType of
              ftString, ftWideString, ftWideMemo:
                LMethods.Invoke(TValue.From<T>(FParent.GetList.Last),
                  [LField.AsString]);
              ftSmallint, ftInteger, ftLongWord, ftShortint, ftWord:
                LMethods.Invoke(TValue.From<T>(FParent.GetList.Last),
                  [LField.AsInteger]);
              ftBoolean:
                LMethods.Invoke(TValue.From<T>(FParent.GetList.Last),
                  [LField.AsBoolean]);
              ftFloat, ftCurrency, ftBCD, ftExtended, ftFMTBcd:
                LMethods.Invoke(TValue.From<T>(FParent.GetList.Last),
                  [LField.AsExtended]);
              ftDate, ftTime, ftDateTime, ftTimeStamp:
                LMethods.Invoke(TValue.From<T>(FParent.GetList.Last),
                  [LField.AsDateTime]);
            end;
          end;
    end;
    FParent.Params.GetDataSet.Next;
  end;
  FParent.Params.GetDataSet.First;
  FParent.Params.GetDataSet.EnableControls;

end;

function TRTTIManager4DTODelphi<T>.DataSetToObject: T;
var
  LType: TRttiType;
  LInstance: TRttiInstanceType;
  LInterface: TRttiInterfaceType;
  LMethods: TRttiMethod;
  LAttributes: TCustomAttribute;
  LField: TField;
  LNameQuery: String;
begin
  Result := Self.AsInstace;
  LType := FContext.GetType(GetClass);
  LInstance := LType.AsInstance;

  for LInterface in LInstance.GetDeclaredImplementedInterfaces do
  begin
    for LAttributes in LInterface.GetAttributes do
    begin
      if LAttributes is Query then
      begin
        LAttributes := Query(LAttributes).QuerName;
        /// Realizar a consulta para o dataset;
        Break;
      end;
    end;

    for LMethods in LInterface.GetDeclaredMethods do
      for LAttributes in LMethods.GetAttributes do
        if LAttributes is Campo then
        begin
          LField := FParent.Params.GetDataSet.FieldByName
            (Campo(LAttributes).Field);
          case LField.DataType of
            ftString, ftWideString, ftWideMemo:
              LMethods.Invoke(TValue.From<T>(Result), [LField.AsString]);
            ftSmallint, ftInteger, ftLongWord, ftShortint, ftWord:
              LMethods.Invoke(TValue.From<T>(Result), [LField.AsInteger]);
            ftBoolean:
              LMethods.Invoke(TValue.From<T>(Result), [LField.AsBoolean]);
            ftFloat, ftCurrency, ftBCD, ftExtended, ftFMTBcd:
              LMethods.Invoke(TValue.From<T>(Result), [LField.AsExtended]);
            ftDate, ftTime, ftDateTime, ftTimeStamp:
              LMethods.Invoke(TValue.From<T>(Result), [LField.AsDateTime]);
          end;
        end;
  end;
end;

destructor TRTTIManager4DTODelphi<T>.Destroy;
begin
  FContext.Free;
  inherited;
end;

function TRTTIManager4DTODelphi<T>.GetClass: TClass;
begin
  Result := TRegisterClassDTO4D.GetClass<T>;
end;

class function TRTTIManager4DTODelphi<T>.New(AParent: ICoreDTO4Delphi<T>)
  : IRTTIManager<T>;
begin
  Result := Self.Create(AParent);
end;

end.
