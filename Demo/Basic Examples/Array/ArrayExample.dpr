program ArrayExample;

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
  oConsole : _Console;


  procedure PrintArrayByTypeName;
  var
    x : Integer;
    oArray : _Array;
  begin
    oConsole.WriteLine;
    oArray := CoArray.CreateInstance('System.Double', 6);
    oArray.SetValue(900, 0);
    oArray.SetValue(800, 1);
    oArray.SetValue(700, 2);
    oArray.SetValue(600, 3);
    oArray.SetValue(500, 4);
    oArray.SetValue(400, 5);

    oConsole.WriteLine_14('Double Array');
    oConsole.WriteLine_15('    Count:    {0}', oArray.Length);
    oConsole.WriteLine_15('    Rank:     {0}', oArray.Rank);
    oConsole.WriteLine_14('    Values:');

    for x := 0 to oArray.Length - 1 do begin
      oConsole.WriteLine_15(Chr(9)+' {0}', oArray[x]);
    end;
  end;

  procedure PrintArrayByType;
  var
    x : Integer;
    oArray : _Array;
    oType : _Type;
  begin
    oConsole.WriteLine;
    oType := TClrAssembly.GetType('System.Double', True);
    oArray := CoArray.CreateInstance(oType, 6);
    oArray.SetValue(900, 0);
    oArray.SetValue(800, 1);
    oArray.SetValue(700, 2);
    oArray.SetValue(600, 3);
    oArray.SetValue(500, 4);
    oArray.SetValue(400, 5);

    oConsole.WriteLine_14('Double Array');
    oConsole.WriteLine_15('    Count:    {0}', oArray.Length);
    oConsole.WriteLine_15('    Rank:     {0}', oArray.Rank);
    oConsole.WriteLine_14('    Values:');

    for x := 0 to oArray.Length - 1 do begin
      oConsole.WriteLine_15(Chr(9)+' {0}', oArray[x]);
    end;
  end;

  procedure PrintArrayByObjectType;
  var
    x : Integer;
    oArray : _Array;
  begin
    oConsole.WriteLine;
    oArray := CoArray.CreateInstance('System.Object', 6);
    oArray.SetValue(900, 0);
    oArray.SetValue(800, 1);
    oArray.SetValue(700, 2);
    oArray.SetValue(600, 3);
    oArray.SetValue(500, 4);
    oArray.SetValue(400, 5);

    oConsole.WriteLine_14('Object Array');
    oConsole.WriteLine_15('    Count:    {0}', oArray.Length);
    oConsole.WriteLine_15('    Rank:     {0}', oArray.Rank);
    oConsole.WriteLine_14('    Values:');

    for x := 0 to oArray.Length - 1 do begin
      oConsole.WriteLine_15(Chr(9)+' {0}', oArray[x]);
    end;
  end;

  procedure PrintObjectArray;
  var
    x : Integer;
    oArray : _ObjectArray;
  begin
    oConsole.WriteLine;
    oArray := CoObjectArray.CreateInstance(6);
    oArray.SetValue(900, 0);
    oArray.SetValue(800, 1);
    oArray.SetValue(700, 2);
    oArray.SetValue(600, 3);
    oArray.SetValue(500, 4);
    oArray.SetValue(400, 5);

    oConsole.WriteLine_14('Object Array');
    oConsole.WriteLine_15('    Count:    {0}', oArray.Length);
    oConsole.WriteLine_15('    Rank:     {0}', oArray.Rank);
    oConsole.WriteLine_14('    Values:');

    for x := 0 to oArray.Length - 1 do begin
      oConsole.WriteLine_15(Chr(9)+' {0}', oArray[x]);
    end;
  end;

  procedure PrintDoubleArray;
  var
    x : Integer;
    oArray : _DoubleArray;
  begin
    oConsole.WriteLine;
    oArray := CoDoubleArray.CreateInstance(6);
    oArray.SetValue(900, 0);
    oArray.SetValue(800, 1);
    oArray.SetValue(700, 2);
    oArray.SetValue(600, 3);
    oArray.SetValue(500, 4);
    oArray.SetValue(400, 5);

    oConsole.WriteLine_14('Double Array');
    oConsole.WriteLine_15('    Count:    {0}', oArray.Length);
    oConsole.WriteLine_15('    Rank:     {0}', oArray.Rank);
    oConsole.WriteLine_14('    Values:');

    for x := 0 to oArray.Length - 1 do begin
      oConsole.WriteLine_15(Chr(9)+' {0}', oArray[x]);
    end;
  end;

begin
  oConsole := CoConsole.CreateInstance;
  oConsole.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  oConsole.WriteLine_14('==================================================');
  oConsole.WriteLine_14('This program prints out Array values.');
  oConsole.WriteLine;

  PrintArrayByTypeName;
  PrintArrayByType;
  PrintArrayByObjectType;
  PrintObjectArray;
  PrintDoubleArray;

  oConsole.ReadKey;
end.
