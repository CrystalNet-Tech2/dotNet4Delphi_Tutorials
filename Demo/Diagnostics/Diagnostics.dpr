program Diagnostics;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

//  The following example uses Trace to indicate the beginning and the end of a program's execution.
//  The example also uses the Trace.Indent and Trace.Unindent methods to distinguish the tracing output.

uses
  SysUtils,
  CNClrLib.Diagnostics,
  CNClrLib.Core;

var
  Console: _Console;
  Trace: _Trace;
begin
  try
    Console := CoConsole.CreateInstance;

    Trace := CoTrace.CreateInstance;
    Trace.Listeners.Add(CoTextWriterTraceListener.CreateInstance(Console.Out_).AsTraceListener);
    Trace.AutoFlush := true;
    Trace.Indent;
    Trace.WriteLine('Entering Main');
    Console.WriteLine_14('Hello World.');
    Trace.WriteLine('Exiting Main');
    Trace.Unindent;
  except
    on E: Exception do
    begin
      Console.WriteLine_14(E.message);
    end;
  end;
end.

