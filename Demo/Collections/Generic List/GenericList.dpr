program GenericList;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Host,
  CNClrLib.Core,
  CNClrLib.Collections,
  CNClrLib.TypeNames;

var
  Dinosaurs: _GenericList;
  Console: _Console;
  I: Integer;

begin
  try
    Console := CoConsole.CreateInstance;
    Dinosaurs := CoGenericList.CreateInstance(TClrAssembly.GetType('System.String'));

    Console.WriteLine_15('Capacity: {0}', Dinosaurs.Capacity);
    Dinosaurs.Add('Tyrannosaurus');
    Dinosaurs.Add('Amargasaurus');
    Dinosaurs.Add('Mamenchisaurus');
    Dinosaurs.Add('Deinonychus');
    Dinosaurs.Add('Compsognathus');
    Console.WriteLine();
    for I := 0 to Dinosaurs.Count - 1 do
      Console.WriteLine_14(Dinosaurs[I]);

    Console.WriteLine_15('Capacity: {0}', Dinosaurs.Capacity);
    Console.WriteLine_15('Count: {0}', Dinosaurs.Count);

    Console.WriteLine_15('Contains(''Deinonychus''): {0}', Dinosaurs.Contains('Deinonychus'));

    Console.WriteLine_14('Insert(2, ''Compsognathus'')');
    Dinosaurs.Insert(2, 'Compsognathus');

    Console.WriteLine();
    for I := 0 to Dinosaurs.Count - 1 do
      Console.WriteLine_14(Dinosaurs[I]);

    // Shows accessing the list using the Item property.
    Console.WriteLine_15('dinosaurs[3]: {0}', Dinosaurs[3]);

    Console.WriteLine_14('Remove(''Compsognathus'')');
    Dinosaurs.Remove('Compsognathus');

    Console.WriteLine();
    for I := 0 to Dinosaurs.Count - 1 do
      Console.WriteLine_14(Dinosaurs[I]);

    Dinosaurs.TrimExcess();
    Console.WriteLine_14('TrimExcess()');
    Console.WriteLine_15('Capacity: {0}', Dinosaurs.Capacity);
    Console.WriteLine_15('Count: {0}', Dinosaurs.Count);

    Dinosaurs.Clear();
    Console.WriteLine_14('Clear()');
    Console.WriteLine_15('Capacity: {0}', Dinosaurs.Capacity);
    Console.WriteLine_15('Count: {0}', Dinosaurs.Count);
    Console.ReadKey;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
