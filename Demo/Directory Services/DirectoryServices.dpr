program DirectoryServices;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.DirectoryServices,
  CNClrLib.Core;

var
  Console: _Console;
  Entry: _DirectoryEntry;
  DirSearcher: _DirectorySearcher;
  ObjectCollection: OleVariant;
  SearchResult: _SearchResultCollection;
  KeyEnumerator: _IEnumerator;
  key: string;
  I, J: Integer;

begin
  try
    Console := CoConsole.CreateInstance;
    Entry := CoDirectoryEntry.CreateInstance('LDAP://MCBcorp, DC=com');
    Console.WriteLine_14('Name = ' + Entry.Name);
    Console.WriteLine_14('Path = ' + Entry.Path);
    Console.WriteLine_14('SchemaClassName = ' + Entry.SchemaClassName);
    Console.WriteLine_14('Properties:');
    Console.WriteLine_14('=====================================');

    KeyEnumerator := Entry.Properties.PropertyNames.AsIEnumerable.GetEnumerator;
    while KeyEnumerator.MoveNext do
    begin
      key := KeyEnumerator.Current;
      Console.WriteLine_14(Chr(9) + key + ' = ');

      for J := 0 to Entry.Properties[key].Count - 1 do
      begin
        ObjectCollection := Entry.Properties[key][J];
        Console.WriteLine_15(#13#10 + #13#10 + '{0}', ObjectCollection);
      end;
      Console.WriteLine_14('===================================');
    end;

    DirSearcher := CoDirectorySearcher.CreateInstance(Entry);
    DirSearcher.Filter := '(objectClass=*)';
    Console.WriteLine_14('Active Directory Information');
    Console.WriteLine_14('=====================================');

    SearchResult := DirSearcher.FindAll;
    for I := 0 to SearchResult.Count - 1 do
    begin
      Console.WriteLine_14(SearchResult[I].GetDirectoryEntry.Name);
      Console.WriteLine_14(SearchResult[I].GetDirectoryEntry.Path);
      Console.WriteLine_14(SearchResult[I].GetDirectoryEntry.NativeGuid);
      Console.WriteLine_14('===================================');
    end;
  except
    on E: Exception do
    begin
      Console.WriteLine_14(E.message);
    end;
  end;
  Console.ReadKey;
end.
