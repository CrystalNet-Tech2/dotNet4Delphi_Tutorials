program DataGridViewOnVCLForm;

uses
  Vcl.Forms,
  TestExample in 'C:\Temp\WSDL\TestExample.pas',
  TestExampleConst in 'C:\Temp\WSDL\TestExampleConst.pas',
  TestExampleEnums in 'C:\Temp\WSDL\TestExampleEnums.pas',
  Example in 'Example.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
