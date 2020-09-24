program ByteConverter;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

//  The following code example declares and initializes an 8-bit unsigned integer
//  and a string. The code then converts each of them to the other's type, respectively.

uses
  CNClrLib.ComponentModel,
  CNClrLib.EnumTypes,
  CNClrLib.Host,
  CNClrLib.Core;

var
  Console: _Console;
  myUint: ClrByte;
  myUStr: ClrString;
  TypeDescriptor : _TypeDescriptor;
begin
  Console := CoConsole.CreateInstance;
  TypeDescriptor := CoTypeDescriptor.CreateInstance;

  myUint := 5;
  myUStr := '2';

  Console.WriteLine_14(TypeDescriptor.GetConverter(myUint).ConvertTo(myUint, TClrAssembly.GetType(tcString)));
  Console.WriteLine_14(TypeDescriptor.GetConverter(myUint).ConvertFrom(myUStr));
end.
