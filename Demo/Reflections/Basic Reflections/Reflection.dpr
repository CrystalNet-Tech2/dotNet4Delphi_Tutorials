program Reflection;

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
  SQLConnection : IDispatch;
  ConnectionString : WideString;

  procedure ReflectionExample;
  var
    m_sqlconnectionType : _Type;
    m_connProperty : _PropertyInfo;
    m_openMethod, m_closeMethod : _MethodInfo;
  begin
    m_sqlconnectionType := TClrAssembly.GetObjectType(SQLConnection);
    m_connProperty := m_sqlconnectionType.GetProperty_6('ConnectionString');
    m_connProperty.SetValue_2(SQLConnection, ConnectionString);

    m_openMethod := m_sqlconnectionType.GetMethod_5('Open');
    m_openMethod.Invoke_2(SQLConnection, nil);
    Console.WriteLine_14('Connection Opened');

    m_closeMethod := m_sqlconnectionType.GetMethod_5('Close');
    m_closeMethod.Invoke_2(SQLConnection, nil);
    Console.WriteLine_14('Connection Closed');
  end;

begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrates how to use reflection to connect to Sql Server.');
  Console.WriteLine;
  try
    TClrAssembly.LoadWithPartialName('System.Data');
    Console.WriteLine_15('The Assembly [{0}] has been loaded.', 'System.Data');
    Console.WriteLine;

    //Create Instance of System.Data.SqlClient.SqlConnection Type
    SQLConnection := TClrDispatchActivator.CreateInstance('System.Data.SqlClient.SqlConnection');

    ConnectionString := 'Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myUsername;Password=myPassword';
    Console.WriteLine_15('Connecting to : {0}', ConnectionString);
    Console.WriteLine;

    ReflectionExample;
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', E.Message);
  end;
  Console.ReadKey;
end.

