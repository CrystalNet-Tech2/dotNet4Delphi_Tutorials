program XML;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  CNClrLib.Xml,
  CNClrLib.Core;

var
  NameTable: _NameTable;
  Book, Price: Variant;
  Settings: _XmlReaderSettings;
  Reader: _XmlReader;
  ReaderHelper: _XmlReaderHelper;
  ObjectHelper: _ObjectHelper;
begin
  NameTable := CoNameTable.CreateInstance;

  Book := NameTable.Add('Book');
  Price := NameTable.Add('Price');

  // Create the Reader.
  Settings := CoXmlReaderSettings.CreateInstance;
  Settings.NameTable := NameTable.AsXmlNameTable;

  ReaderHelper := CoXmlReaderHelper.CreateInstance;
  Reader := ReaderHelper.Create_1('books.xml', Settings);

  Reader.MoveToContent;
  Reader.ReadToDescendant('Book');

  ObjectHelper := CoObjectHelper.CreateInstance;
  if ObjectHelper.ReferenceEquals(Book, Reader.Name) then
  begin
    // Do additional processing.
  end;
end.
