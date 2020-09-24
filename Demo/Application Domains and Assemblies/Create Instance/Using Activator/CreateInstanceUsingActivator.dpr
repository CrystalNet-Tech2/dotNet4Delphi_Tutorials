program CreateInstanceUsingActivator;

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
  Activator : _Activator;

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

  procedure CreateInstanceFromAssemblyString;
  var
    m_sqlConnHnd : _ObjectHandle;
  begin
    m_sqlConnHnd := Activator.CreateInstance_5('System.Data, Version=2.0.0.0, Culture=neutral, ' +
                  'PublicKeyToken=b77a5c561934e089', 'System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnHnd.Unwrap);
  end;

  procedure CreateInstanceFromTypeName;
  var
    m_sqlConnobj : OleVariant;
    m_sqlConType : _Type;
  begin
    TClrAssembly.Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089');
    m_sqlConType := TClrAssembly.GetType('System.Data.SqlClient.SqlConnection', True);
    m_sqlConnobj := Activator.CreateInstance_4(m_sqlConType);
    DisplayObjectTypeInfo(m_sqlConnobj);
  end;

  procedure CreateInstanceFromTypeWithParam;
  var
    m_qlConnHnd : OleVariant;
    m_objArray : _ObjectArray;
    m_sqlConType : _Type;
  begin
    //Create Instance with a parameter
    m_objArray := CoObjectArray.CreateInstance(1);
    m_objArray[0] := 'Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myDomain\myUsername;Password=myPassword;';

    //Assembly has been loaded in CreateInstance2, no need to reload assembly
    m_sqlConType := TClrAssembly.GetType('System.Data.SqlClient.SqlConnection', True);
    m_qlConnHnd := Activator.CreateInstance_2(m_sqlConType,  m_objArray);
    DisplayObjectTypeInfo(m_qlConnHnd);
  end;

  procedure CreateInstanceFromFile;
  var
    m_sqlConnobj : _ObjectHandle;
  begin
    m_sqlConnobj := Activator.CreateInstanceFrom('C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Data.dll',
        'System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnobj.Unwrap);
  end;

begin
  Console := CoConsole.CreateInstance;
  Activator := CoActivator.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('The program demonstrate how to use Activator interface to Create Object Instance');
  Console.WriteLine;
  try
    CreateInstanceFromAssemblyString;
    CreateInstanceFromTypeName;
    CreateInstanceFromTypeWithParam;
    CreateInstanceFromFile;
  except
    on E:Exception do
      Console.WriteLine_15('Exception : {0}', E.Message);
  end;
  Console.ReadKey;
end.

