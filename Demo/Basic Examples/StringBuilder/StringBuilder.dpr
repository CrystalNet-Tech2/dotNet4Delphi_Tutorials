program StringBuilder;

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
  AStringBuilder : _StringBuilder;
begin
  Console := CoConsole.CreateInstance;
  AStringBuilder := CoStringBuilder.CreateInstance;
  AStringBuilder.Append_2('Hello');
  AStringBuilder.Append_2('World');
  AStringBuilder.Append_2('!');

  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program prints out StringBuilder values.');
  Console.WriteLine;
  Console.WriteLine_14('AStringBuilder');
  Console.WriteLine_15('    Count:    {0}', AStringBuilder.Length);
  Console.WriteLine_15('    Capacity: {0}', AStringBuilder.Capacity);
  Console.WriteLine_15('    Values:   {0}', AStringBuilder.ToString);
  Console.ReadKey;
end.
