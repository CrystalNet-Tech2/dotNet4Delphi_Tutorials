// This example shows synchronous consumption of events.
// The client is blocked while waiting for events.
program EventWatcherPolling;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Management,
  CNClrLib.Core;

var
  Console: _Console;
  Query: _WqlEventQuery;
  Watcher: _ManagementEventWatcher;
  ManBaseObject: _ManagementBaseObject;
begin
  Console := CoConsole.CreateInstance;
  try
    // Create event Query to be notified within 1 second of
    // a change in a service
    Query := CoWqlEventQuery.CreateInstance('__InstanceCreationEvent',
                CoTimeSpan.CreateInstance(0,0,1),
                'TargetInstance isa ''Win32_Process''');

    // Initialize an event Watcher and subscribe to events
    // that match this Query
    Watcher := CoManagementEventWatcher.CreateInstance;
    Watcher.Query := Query.AsEventQuery;
    // times out Watcher.WaitForNextEvent in 5 seconds
    Watcher.Options.Timeout := CoTimeSpan.CreateInstance(0,0,5);

    // Block until the next event occurs
    // Note: this can be done in a loop if waiting for
    //        more than one occurrence
    Console.WriteLine_14('Open an application (notepad.exe) to trigger an event.');
    ManBaseObject := Watcher.WaitForNextEvent;

    //Display information from the event
    Console.WriteLine_17('Process {0} has been created, path is: {1}',
        CoManagementBaseObject.Wrap(ManBaseObject['TargetInstance'])['Name'],
        CoManagementBaseObject.Wrap(ManBaseObject['TargetInstance'])['ExecutablePath']);

    //Cancel the subscription
    Watcher.Stop;
  except
    on E: Exception do
    begin
      Console.WriteLine_14(E.message);
    end;
  end;
  Console.ReadKey;
end.
