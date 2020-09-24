program UsingClrObject;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
	System.SysUtils, System.Variants,
{$ELSE}
	SysUtils, Variants,
{$IFEND}
  CNClrLib.Host, CNClrLib.Enums, CNClrLib.Core;

var
  Console : _Console;
  SQLConnection : IDispatch;
  ConnectionString : WideString;

  procedure CreateClrObjectUsingWrap;
  var
    m_SQLConnection : _ClrObject;
  begin
    Console.WriteLine_14('Wrap the connection object to ClrObject Interface');
    m_SQLConnection := CoClrObject.Wrap(SQLConnection);
    m_SQLConnection.SetPropertyValue('ConnectionString', ConnectionString);

    m_SQLConnection.InvokeMethod('Open');
    Console.WriteLine_14('Connection Opened');
      
    m_SQLConnection.InvokeMethod('Close');
    Console.WriteLine_14('Connection Closed');
    Console.WriteLine;
  end;  

  procedure CreateClrObjectUsingTClrObjectClass;
  var
    m_SQLConnection : TClrObject;
  begin
    Console.WriteLine_14('Using CreateInstance to create CrystalNet Object');
    m_SQLConnection := TClrObject.Create(SQLConnection);
    try
//      m_SQLConnection.OwnsObject := False;
      m_SQLConnection.SetPropertyValue('ConnectionString', ConnectionString);

      m_SQLConnection.InvokeMethod('Open');
      Console.WriteLine_14('Connection Opened');
      
      m_SQLConnection.InvokeMethod('Close');
      Console.WriteLine_14('Connection Closed');
      Console.WriteLine;
    finally
      m_SQLConnection.Free;
    end;
  end;  

begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrates how to use ClrObject interface reflection to connect to Sql Server.');
  Console.WriteLine;
  try
    TClrAssembly.LoadWithPartialName('System.Data');

    Console.WriteLine_15('The Assembly [{0}] has been loaded.', 'System.Data');
    Console.WriteLine;

    //Create Instance of System.Data.SqlClient.SqlConnection Type
    SQLConnection := TClrDispatchActivator.CreateInstance('System.Data.SqlClient.SqlConnection');

    ConnectionString := 'Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myUsername;Password=myPassword;';
    Console.WriteLine_15('Connecting to : {0}', ConnectionString);
    Console.WriteLine;

    CreateClrObjectUsingWrap;
    CreateClrObjectUsingTClrObjectClass;
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', E.Message);
  end;
  Console.ReadKey;
end.

