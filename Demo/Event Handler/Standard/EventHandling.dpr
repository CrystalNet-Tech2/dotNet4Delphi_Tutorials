program EventHandling;

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
  SQLConnection : TClrObject;
  ConnectionString : WideString;
  
(*
  //C# Delegate of SqlConnection.StateChange event
  
  public delegate void StateChangeEventHandler(object sender, StateChangeEventArgs e);

  public enum ConnectionState
  {
      Closed = 0,
      Open = 1,
      Connecting = 2,
      Executing = 4,
      Fetching = 8,
      Broken = 16,
  }

  public sealed class StateChangeEventArgs
  {
      public ConnectionState CurrentState { get; }
      public ConnectionState OriginalState { get; }
  }
*)

  //Corresponding Delphi Event Handler Callback method
  procedure StateChangeEventHandler(ASender : _ClrObject; StateChangeEventArgs : _ClrEventArgs); stdcall;
  var
    m_eventArgs : _ClrObject;
    m_currentState,
    m_originalState : Integer;

    procedure WriteStateChage(State : Integer);
    begin
      case State of
        0:  Console.Write_22('Closed');
        1:  Console.Write_22('Open');
        2:  Console.Write_22('Connecting');
        4:  Console.Write_22('Executing');
        8:  Console.Write_22('Fetching');
        16: Console.Write_22('Broken');
      end;
      Console.WriteLine;
    end;
  begin
    m_eventArgs :=  CoClrObject.Wrap(StateChangeEventArgs.EventArgs);
    m_currentState := m_eventArgs.GetPropertyValue('CurrentState');
    m_originalState := m_eventArgs.GetPropertyValue('OriginalState');

    Console.Write_22('Current State : ');
    WriteStateChage(m_currentState);

    Console.Write_22('Original State : ');
    WriteStateChage(m_originalState);
  end;

  procedure OpenAndCloseSQLConnection;
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
  Console.WriteLine_14('This program demonstrates how to handle events and callback.');
  Console.WriteLine;
  try
    //Load Assembly
    TClrAssembly.LoadWithPartialName('System.Data');

    //Create Instance of System.Data.SqlClient.SqlConnection Type
    SQLConnection := TClrObject.Create(TClrActivator.ClrCreateInstance('System.Data.SqlClient.SqlConnection'));
    SQLConnection.RegisterEventCallBack('StateChange', @StateChangeEventHandler);
    try
      ConnectionString := 'Data Source=myServerAddress;Initial Catalog=myDataBase;User ID=myUsername;Password=myPassword';
      Console.WriteLine_15('Connecting to : {0}', ConnectionString);
      Console.WriteLine;

      OpenAndCloseSQLConnection;
    finally
      SQLConnection.Free;
    end;
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', E.Message);
  end;
  Console.ReadKey;
end.

