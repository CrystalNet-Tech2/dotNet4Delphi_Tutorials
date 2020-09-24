program ArrayList;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
	System.SysUtils,
{$ELSE}
	SysUtils,
{$IFEND}
  CNClrLib.Host, CNClrLib.Core;

var
  Console : _Console;
  AArrayList : _ArrayList;
  I : Integer;
begin
  Console := CoConsole.CreateInstance;
  AArrayList := CoArrayList.CreateInstance;
  AArrayList.Add('Hello');
  AArrayList.Add('World');
  AArrayList.Add('!');

  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program prints out ArrayList values.');
  Console.WriteLine;
  Console.WriteLine_14('Array List');
  Console.WriteLine_15('    Count:    {0}', AArrayList.Count);
  Console.WriteLine_15('    Capacity: {0}', AArrayList.Capacity);
  Console.Write_22('    Values:');
  Console.WriteLine;
  for I := 0 to AArrayList.Count - 1 do begin
    Console.WriteLine_15(chr(9) + '   {0}', AArrayList.Item[I]);
  end;
  Console.ReadKey;
end.
