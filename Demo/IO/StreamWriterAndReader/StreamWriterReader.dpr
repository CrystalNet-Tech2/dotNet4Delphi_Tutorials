program StreamWriterReader;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Core;

var
  Console : _Console;
  StreamWriter : _StreamWriter;
  StreamReader : _StreamReader;
  Line : WideString;

begin
  Console := CoConsole.CreateInstance;

  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrated how to Create, Write and Read from a file.');
  Console.WriteLine;
  try
    StreamWriter := CoStreamWriter.CreateInstance('HelloWorld.txt');
    try
      StreamWriter.WriteLine_12('Hello');
      StreamWriter.WriteLine_12('World');
      StreamWriter.WriteLine_12('l!');
      StreamWriter.Close;
    finally
      StreamWriter.Dispose;
      StreamWriter := nil;
    end;

    // Read and show each line from the file.
    StreamReader := CoStreamReader.CreateInstance('HelloWorld.txt');
    try
      Line := '';
      while not StreamReader.EndOfStream do begin
        Console.WriteLine_14(StreamReader.ReadLine);
      end;
      StreamReader.Close;
    finally
      StreamReader.Dispose;
      StreamReader := nil;
    end;
  except
    on E: Exception do
      Console.WriteLine_15('Exception : {0}', StreamReader.ReadLine);
  end;
  Console.ReadKey;
end.

