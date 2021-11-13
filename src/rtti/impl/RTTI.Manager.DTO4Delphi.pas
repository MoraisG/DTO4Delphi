unit RTTI.Manager.DTO4Delphi;

interface

uses Core.Contracts.DTO4Delphi, RTTI.Contracts.DT4Delphi, System.RTTI;

type

  TRTTIManager4DTODelphi<T: IInterface> = class(TInterfacedObject,
    IRTTIManager<T>)
  private
    [weak]
    FParent: IDTO4Delphi<T>;
    FContext: TRttiContext;
  public
    constructor Create(AParent: IDTO4Delphi<T>);
    destructor Destroy; override;
    class function New(AParent: IDTO4Delphi<T>): IRTTIManager<T>;
    function AsInstace: T;
    function Bind: IRTTIManager<T>;
    function DataSetToObject: T;
    function DataSetToList: IRTTIManager<T>;
    function GetClass: TClass;
    function Insert: IRTTIManager<T>;
  end;

implementation

{ TRTTIManager4DTODelphi<T> }

uses
  System.SysUtils,
  Types.Attributes.DTO4Delphi,
  Data.DB,
  Core.Registry.DTO4D,
  Types.Enums.Helpers.DTO4D,
  Types.Exceptions.DTO4Delphi;

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

constructor TRTTIManager4DTODelphi<T>.Create(AParent: IDTO4Delphi<T>);
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
        begin
          if LAttributes is Campo then
          begin
            LField := FParent.Params.GetDataSet.FieldByName
              (Campo(LAttributes).Field);
          end;

          if LAttributes is Setter then
          begin
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
  LRTTIDatabase: IRTTIDataBase<T>;
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
        FParent.Params.SetNameQuery(Query(LAttributes).QuerName);
        LRTTIDatabase := Query(LAttributes).QueryType.Query<T>(FParent);
        LRTTIDatabase.Query;
        Break;
      end;
    end;

    for LMethods in LInterface.GetDeclaredMethods do
      for LAttributes in LMethods.GetAttributes do
      begin
        if LAttributes is Campo then
        begin
          LField := FParent.Params.GetDataSet.FieldByName
            (Campo(LAttributes).Field);
        end;

        if LAttributes is Setter then
        begin
          case LField.DataType of
            ftString, ftWideString, ftWideMemo, ftBlob:
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

function TRTTIManager4DTODelphi<T>.Insert: IRTTIManager<T>;
var
  LType: TRttiType;
  LInstance: TRttiInstanceType;
  LInterface: TRttiInterfaceType;
  LMethods: TRttiMethod;
  LAttributes: TCustomAttribute;
  LField: TField;
begin
  Result := Self;
  LType := FContext.GetType(GetClass);

  LInstance := LType.AsInstance;
  try
    FParent.Params.GetDataSet.Insert;
    for LInterface in LInstance.GetDeclaredImplementedInterfaces do
      for LMethods in LInterface.GetMethods do
        for LAttributes in LMethods.GetAttributes do
        begin

          if LAttributes is Campo then
            LField := FParent.Params.GetDataSet.FieldByName
              (Campo(LAttributes).Field);

          if LAttributes is Getter then
          begin
            case LField.DataType of

              ftString, ftWideString, ftWideMemo, ftBlob:
                LField.AsString :=
                  LMethods.Invoke(TValue.From<T>(FParent.Params.DTO), [])
                  .AsType<String>;

              ftSmallint, ftInteger, ftLongWord, ftShortint, ftWord:
                LField.AsInteger :=
                  LMethods.Invoke(TValue.From<T>(FParent.Params.DTO), [])
                  .AsType<Integer>;

              ftBoolean:
                LField.AsBoolean :=
                  LMethods.Invoke(TValue.From<T>(FParent.Params.DTO), [])
                  .AsType<Boolean>;

              ftFloat, ftCurrency, ftBCD, ftExtended, ftFMTBcd:
                LField.AsFloat :=
                  LMethods.Invoke(TValue.From<T>(FParent.Params.DTO), [])
                  .AsType<Double>;

              ftDate, ftTime, ftDateTime, ftTimeStamp:
                LField.AsDateTime :=
                  LMethods.Invoke(TValue.From<T>(FParent.Params.DTO), [])
                  .AsType<TDateTime>;
            end;
          end;
        end;

    FParent.Params.GetDataSet.Post;
  except
    on E: Exception do
    begin
      raise EExceptionDTODeserialize.Create();
    end;
  end;
end;

class function TRTTIManager4DTODelphi<T>.New(AParent: IDTO4Delphi<T>)
  : IRTTIManager<T>;
begin
  Result := Self.Create(AParent);
end;

end.
