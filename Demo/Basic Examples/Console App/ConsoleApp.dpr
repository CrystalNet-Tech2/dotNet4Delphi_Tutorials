program ConsoleApp;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
	System.SysUtils,
{$ELSE}
	SysUtils,
{$IFEND}
  CNClrLib.Core;

var
  Console : _Console;
begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('The program displays the string Hello World!');
  Console.WriteLine;
  Console.WriteLine_14('Hello World!');
  Console.WriteLine_14('Press any key to exit.');
  Console.ReadKey;
end.
