program SampleDTO4D;

{$R *.dres}

uses
  Vcl.Forms,
  Main in 'view\Main.pas' {Form1},
  DTO.Contracts.Samples in 'dto\DTO.Contracts.Samples.pas',
  DTO.Pessoa in 'dto\impl\DTO.Pessoa.pas',
  DTO.Empresa in 'dto\impl\DTO.Empresa.pas',
  DTO.Industrias in 'dto\DTO.Industrias.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
