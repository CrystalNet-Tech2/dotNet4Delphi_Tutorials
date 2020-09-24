program AdvancedEventHandler;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils, System.Variants,
{$ELSE}
  SysUtils, Variants,
{$IFEND }
  CNClrLib.Host, CNClrLib.Core;

type

  TEventHandler = class
  private
    FSQLConnection : TClrObject;
    FConnectionStr : WideString;

    FEventHandler : TClrEventHandler;
    procedure SetOnStateChangeEvent(Value : TClrEventHandler);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadAssembly;
    procedure CreateSQLConnectionTypeInstance;
    procedure EventFired;
    procedure OpenAndCloseSQLConnection;
    property OnStateChangeEvent : TClrEventHandler read FEventHandler write SetOnStateChangeEvent;
  end;
  
var
  Console : _Console;
  EventHandler : TEventHandler;


  { TEventHandler }

  constructor TEventHandler.Create;
  begin
  end;

  destructor TEventHandler.Destroy;
  begin
    FSQLConnection := Nil;
    inherited Destroy;
  end;

  procedure TEventHandler.EventFired;
  begin
    Console.WriteLine_14('State Change Event has been fired');
  end;

  procedure TEventHandler.LoadAssembly;
  begin
    //Load Assembly
    TClrAssembly.LoadWithPartialName('System.Data');
  end;

  procedure TEventHandler.CreateSQLConnectionTypeInstance;
  begin
    //Create Instance of System.Data.SqlClient.SqlConnection Type
    FSQLConnection := TClrObject.Create(TClrDispatchActivator.CreateInstance('System.Data.SqlClient.SqlConnection'));
  end;

  procedure TEventHandler.OpenAndCloseSQLConnection;
  begin
    FConnectionStr := 'Data Source=MyDataSourceName;Initial Catalog=MyDBName;User ID=MyUserName;Password=MyPasswd';

    Console.WriteLine_15('Connecting to SQL Connection using : {0}', FConnectionStr);
    Console.WriteLine;

    FSQLConnection.SetPropertyValue('ConnectionString', FConnectionStr);

    FSQLConnection.InvokeMethod('Open');
    Console.WriteLine_14('Connection Opened');
    Console.WriteLine;

    FSQLConnection.InvokeMethod('Close');
    Console.WriteLine_14('Connection Closed');
  end;

  procedure TEventHandler.SetOnStateChangeEvent(Value: TClrEventHandler);
  begin
    if @FEventHandler <> nil then
      FSQLConnection.UnRegisterEventCallBack('StateChange', @FEventHandler);

    FEventHandler := Value;

    if @FEventHandler <> nil then
      FSQLConnection.RegisterEventCallBack('StateChange', @FEventHandler);
  end;

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

  //Corresponding Delphi Event Handler Caller method
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

begin
  Console := CoConsole.CreateInstance;
  EventHandler := TEventHandler.Create;
  try
    Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
    Console.WriteLine_14('==================================================');
    Console.WriteLine_14('This program demonstrates how to handle events and get '+
                          'Delphi class type which added the event.');
    Console.WriteLine;
    try
      with EventHandler do begin
        LoadAssembly;
        CreateSQLConnectionTypeInstance;
        OnStateChangeEvent := StateChangeEventHandler; 
        OpenAndCloseSQLConnection; 
      end;  
    except
      on E: Exception do
        Console.WriteLine_15('Exception: {0}', E.Message);
    end;  
    Console.ReadKey;
  finally
    FreeAndNil(EventHandler);
  end;
end.

