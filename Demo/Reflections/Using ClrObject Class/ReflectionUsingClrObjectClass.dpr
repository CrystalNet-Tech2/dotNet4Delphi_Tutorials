program ReflectionUsingClrObjectClass;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Host, CNClrLib.Core;

var
  Console : _Console;
  SQLConnection : TClrObject;
  ConnectionString : WideString;

  procedure ReflectionExample;
  begin
    SQLConnection.SetPropertyValue('ConnectionString', ConnectionString);

    SQLConnection.InvokeMethod('Open');
    Console.WriteLine_14('Connection Opened');

    SQLConnection.InvokeMethod('Close');
    Console.WriteLine_14('Connection Closed');
  end;

begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrates how to use ClrObject Class to connect to Sql Server.');
  Console.WriteLine;
  try
    TClrAssembly.LoadWithPartialName('System.Data');
    Console.WriteLine_15('The Assembly [{0}] has been loaded.', 'System.Data');
    Console.WriteLine;

    //Create Instance of System.Data.SqlClient.SqlConnection Type
    SQLConnection := TClrObject.Create(TClrDispatchActivator.CreateInstance('System.Data.SqlClient.SqlConnection'));
    try
      ConnectionString := 'Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myUsername;Password=myPassword';
      Console.WriteLine_15('Connecting to : {0}', ConnectionString);
      Console.WriteLine;

      ReflectionExample;
    finally
      SQLConnection.Free;
    end;
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', E.Message);
  end;
  Console.ReadKey;
end.

