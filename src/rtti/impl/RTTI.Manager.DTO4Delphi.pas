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
    function DataSetToObject: IRTTIManager<T>;
    function DataSetToList: IRTTIManager<T>;
  end;

implementation

{ TRTTIManager4DTODelphi<T> }

uses System.SysUtils, Types.Attributes.DTO4Delphi, Data.DB;

function TRTTIManager4DTODelphi<T>.AsInstace: T;
var
  LType: TRttiType;
  LMethods: TRttiMethod;
  LAttributes: TCustomAttribute;
begin
  Result := nil;

  LType := FContext.GetType(FParent.Params.ClassType);

  for LMethods in LType.GetDeclaredMethods do
    for LAttributes in LMethods.GetAttributes do
      if LAttributes is Instance then
        Result := LMethods.Invoke(FParent.Params.ClassType, []).AsType<T>;

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
  Result := Self;
  LType := FContext.GetType(FParent.Params.ClassType);

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

function TRTTIManager4DTODelphi<T>.DataSetToObject: IRTTIManager<T>;
var
  LType: TRttiType;
  LInstance: TRttiInstanceType;
  LInterface: TRttiInterfaceType;
  LMethods: TRttiMethod;
  LAttributes: TCustomAttribute;
  LField: TField;
begin
  Result := Self;
  LType := FContext.GetType(FParent.Params.ClassType);
  LInstance := LType.AsInstance;

  for LInterface in LInstance.GetDeclaredImplementedInterfaces do
    for LMethods in LInterface.GetDeclaredMethods do
      for LAttributes in LMethods.GetAttributes do
        if LAttributes is Campo then
        begin
          LField := FParent.Params.GetDataSet.FieldByName
            (Campo(LAttributes).Field);
          case LField.DataType of
            ftString, ftWideString, ftWideMemo:
              LMethods.Invoke(TValue.From<T>(FParent.DTO), [LField.AsString]);
            ftSmallint, ftInteger, ftLongWord, ftShortint, ftWord:
              LMethods.Invoke(TValue.From<T>(FParent.DTO), [LField.AsInteger]);
            ftBoolean:
              LMethods.Invoke(TValue.From<T>(FParent.DTO), [LField.AsBoolean]);
            ftFloat, ftCurrency, ftBCD, ftExtended, ftFMTBcd:
              LMethods.Invoke(TValue.From<T>(FParent.DTO), [LField.AsExtended]);
            ftDate, ftTime, ftDateTime, ftTimeStamp:
              LMethods.Invoke(TValue.From<T>(FParent.DTO), [LField.AsDateTime]);
          end;
        end;

end;

destructor TRTTIManager4DTODelphi<T>.Destroy;
begin
  FContext.Free;
  inherited;
end;

class function TRTTIManager4DTODelphi<T>.New(AParent: ICoreDTO4Delphi<T>)
  : IRTTIManager<T>;
begin
  Result := Self.Create(AParent);
end;

end.