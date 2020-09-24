program CreateInstanceUsingAppDomain;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
	System.SysUtils, System.Variants,
{$ELSE}
	SysUtils, Variants,
{$IFEND}
  CNClrLib.Host, CNClrLib.Core;

var
  Console : _Console;

  procedure DisplayObjectTypeInfo(AObject : OleVariant);
  var
    m_type : _Type;
  begin
    if VarIsEmpty(AObject) or VarIsClear(AObject) then
      Console.WriteLine_14('object has not been instantiated')
    else
    begin
      m_type := TClrAssembly.GetObjectType(AObject);
      Console.WriteLine_14('object has been instantiated');
      Console.WriteLine_15('Assembly FullName:     {0}', m_type.Assembly.FullName);
      Console.WriteLine_15('FullName:              {0}', m_type.FullName);
      Console.WriteLine_15('GUID:                  {0}', m_type.GUID.ToString);
      Console.WriteLine_15('ToString:              {0}', m_type.ToString);
      Console.WriteLine;
      Console.WriteLine;
    end;
  end;

  procedure CreateInstanceAndWrapFromAssemblyString;
  var
    m_sqlConnHnd : _ObjectHandle;
  begin
    m_sqlConnHnd := TClrAppDomain.GetCurrentDomain.CreateInstance(
        'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089',
        'System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnHnd.Unwrap);
  end;

  procedure CreateInstanceAndUnwrapFromAssemblyString;
  var
    m_sqlConnobj : OleVariant;
  begin
    m_sqlConnobj := TClrAppDomain.GetCurrentDomain.DefaultInterface.CreateInstanceAndUnwrap(
        'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089',
        'System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnobj);
  end;

  procedure CreateInstanceFromFile;
  var
    m_sqlConnHnd : _ObjectHandle;
  begin
    m_sqlConnHnd := TClrAppDomain.GetCurrentDomain.CreateInstanceFrom(
        'C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Data.dll',
        'System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnHnd.Unwrap);
  end;

  procedure CreateInstanceFromAndUnwrapFromFile;
  var
    m_sqlConnobj : OleVariant;
  begin
    m_sqlConnobj := TClrAppDomain.GetCurrentDomain.DefaultInterface.CreateInstanceFromAndUnwrap(
        'C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Data.dll',
        'System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnobj);
  end;

begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('The program demonstrate how to use AppDomain interface to Create .Net Object Instance');
  Console.WriteLine;
  try
    CreateInstanceAndWrapFromAssemblyString;
    CreateInstanceAndUnwrapFromAssemblyString;
    CreateInstanceFromFile;
    CreateInstanceFromAndUnwrapFromFile;
  except
    on E:Exception do
      Console.WriteLine_15('Exception : {0}', E.Message);
  end;
  Console.ReadKey;
end.

