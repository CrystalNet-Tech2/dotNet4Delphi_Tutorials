program GenericDictionary;

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
  CNClrLib.Collections;

var
  OpenWith: _GenericDictionary;
  OpenWithEnumerator: _GenericDictionary_Enumerator;
  ValueCollection: _GenericDictionary_ValueCollection;
  ValueCollEnumerator: _GenericValueCollection_Enumerator;
  keyCollection: _GenericDictionary_KeyCollection;
  keyCollEnumerator: _GenericKeyCollection_Enumerator;
  Console: _Console;
  Value: OleVariant;
begin
  try
    Console := CoConsole.CreateInstance;

    // Create a new dictionary of strings, with string keys.
    OpenWith := CoGenericDictionary.CreateInstance(TClrAssembly.GetType('System.String'),
      TClrAssembly.GetType('System.String'));

    // Add some elements to the dictionary. There are no
    // duplicate keys, but some of the values are duplicates.
    OpenWith.Add('txt', 'notepad.exe');
    OpenWith.Add('bmp', 'paint.exe');
    OpenWith.Add('dib', 'paint.exe');
    OpenWith.Add('rtf', 'wordpad.exe');

    // The Add method throws an exception if the new key is
    // already in the dictionary.
    try
      OpenWith.Add('txt', 'winword.exe');
    except //(ArgumentException)
      Console.WriteLine_14('An element with Key = ''txt'' already exists.');
    end;

    // The Item property is another name for the indexer, so you
    // can omit its name when accessing elements.
    Console.WriteLine_15('For key = ''rtf'', value = {0}.', OpenWith['rtf']);

    // The indexer can be used to change the value associated
    // with a key.
    OpenWith['rtf'] := 'winword.exe';
    Console.WriteLine_15('For key = ''rtf'', value = {0}.', OpenWith['rtf']);

    // If a key does not exist, setting the indexer for that key
    // adds a new key/value pair.
    OpenWith['doc'] := 'winword.exe';

    // The indexer throws an exception if the requested key is
    // not in the dictionary.
    try
      Console.WriteLine_15('For key = ''tif'', value = {0}.', OpenWith['tif']);
    except //(KeyNotFoundException)
      Console.WriteLine_14('Key = ''tif'' is not found.');
    end;

    // When a program often has to try keys that turn out not to
    // be in the dictionary, TryGetValue can be a more efficient
    // way to retrieve values.
    if (OpenWith.TryGetValue('tif', Value)) then
      Console.WriteLine_15('For key = ''tif'', value = {0}.', Value)
    else
      Console.WriteLine_14('Key = ''tif'' is not found.');

    // ContainsKey can be used to test keys before inserting them.
    if (not OpenWith.ContainsKey('ht')) then
    begin
      OpenWith.Add('ht', 'hypertrm.exe');
      Console.WriteLine_15('Value added for key = ''ht'': {0}', OpenWith['ht']);
    end;

    // When you use when loop to enumerate dictionary elements from GetEnumerator,
    // the elements are retrieved as KeyValuePair objects.
    Console.WriteLine();
    OpenWithEnumerator := OpenWith.GetEnumerator;
    while OpenWithEnumerator.MoveNext do
      Console.WriteLine_17('Key = {0}, Value = {1}', OpenWithEnumerator.Current.Key, OpenWithEnumerator.Current.Value);

    // To get the values alone, use the Values property.
    ValueCollection := OpenWith.Values;
    ValueCollEnumerator := ValueCollection.GetEnumerator;

    // The elements of the ValueCollection are strongly typed
    // with the type that was specified for dictionary values.
    Console.WriteLine();
    while ValueCollEnumerator.MoveNext do
      Console.WriteLine_15('Value = {0}', ValueCollEnumerator.Current);

    // To get the keys alone, use the Keys property.
    keyCollection := OpenWith.Keys;
    keyCollEnumerator := keyCollection.GetEnumerator;

    // The elements of the KeyCollection are strongly typed
    // with the type that was specified for dictionary keys.
    Console.WriteLine();
    while keyCollEnumerator.MoveNext do
      Console.WriteLine_15('Key = {0}', keyCollEnumerator.Current);

    // Use the Remove method to remove a key/value pair.
    Console.WriteLine_14('Remove(''doc'')');
    OpenWith.Remove('doc');

    if (not OpenWith.ContainsKey('doc')) then
      Console.WriteLine_14('Key ''doc'' is not found.');

    Console.ReadKey;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
