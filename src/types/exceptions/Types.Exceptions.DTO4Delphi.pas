unit Types.Exceptions.DTO4Delphi;

interface

uses
  System.SysUtils;

type
  EExceptionDTODeserialize = class(Exception)
  private
    FMessage: string;
  public
    constructor Create(const Msg: string); overload;
    constructor Create; overload;
    function ToString: string; override;
    property Message: string read FMessage write FMessage;
  end;

implementation

{ EExceptionDTODeserialize }

constructor EExceptionDTODeserialize.Create(const Msg: string);
begin
  Message := Msg;
end;

constructor EExceptionDTODeserialize.Create;
begin
  Message := ToString;
end;

function EExceptionDTODeserialize.ToString: string;
begin
  Result := 'There was a problem inserting the object into the DataSet';
end;

end.
