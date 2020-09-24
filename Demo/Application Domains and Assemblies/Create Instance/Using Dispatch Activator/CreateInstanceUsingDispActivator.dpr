program CreateInstanceUsingDispActivator;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils, System.Variants,
{$ELSE}
  SysUtils, Variants,
{$IFEND }
  CNClrLib.Host, CNClrLib.Core;

var
  Console : _Console;
  Activator : TClrDispatchActivator;

  procedure DisplayObjectTypeInfo(AObject : OleVariant);
  var
    m_type : _Type;
  begin
    if VarIsEmpty(AObject) or VarIsClear(AObject) then
      Console.WriteLine_14('object has not been instantiated')
    else begin
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

  procedure CreateInstanceFromTypeName;
  var
    m_sqlConnobj : OleVariant;
  begin
    TClrAssembly.Load('System.Data, Version=2.0.0.0, Culture=neutral, '+
      'PublicKeyToken=b77a5c561934e089');
    m_sqlConnobj := Activator.CreateInstance('System.Data.SqlClient.SqlConnection');
    DisplayObjectTypeInfo(m_sqlConnobj);
  end;

  procedure CreateInstanceFromTypeWithParam;
  var
    m_sqlConnHnd : OleVariant;
    m_objectArray : _ObjectArray;
  begin
    //Create Instance with a parameter
    m_objectArray := CoObjectArray.CreateInstance(1);
    m_objectArray[0] := 'Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myDomain\myUsername;Password=myPassword;';
    m_sqlConnHnd := Activator.CreateInstance('System.Data.SqlClient.SqlConnection', m_objectArray);
    DisplayObjectTypeInfo(m_sqlConnHnd);
  end;

begin
  Console := CoConsole.CreateInstance;
  Activator := TClrDispatchActivator.Create;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('The program demonstrate how to use Dispatch Activator interface to Create Object Instance');
  Console.WriteLine;
  try
    CreateInstanceFromTypeName;
    CreateInstanceFromTypeWithParam;
  except
    on E:Exception do
      Console.WriteLine_15('Exception : {0}', E.Message);
  end;
  Console.ReadKey;
end.

