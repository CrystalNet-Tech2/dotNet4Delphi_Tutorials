program CultureInfoConverter;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

// The following code example converts a variable of type CultureInfo to a string,
// and vice versa. First it constructs a CultureInfo variable using the Greek culture
// (represented by "el") and converts it to the string "Greek". Then it converts the
// string "Russian" to the CultureInfo representation "ru".

uses
  CNClrLib.ComponentModel,
  CNClrLib.EnumTypes,
  CNClrLib.Host,
  CNClrLib.Core;

var
  Console: _Console;
  myCulture: _CultureInfo;
  myCString: ClrString;
  TypeDescriptor : _TypeDescriptor;
begin
  Console := CoConsole.CreateInstance;

  // The sample first constructs a CultureInfo variable using the Greek culture - 'el'.
  myCulture := CoCultureInfo.CreateInstance('el');
  myCString := 'Russian';

  TypeDescriptor := CoTypeDescriptor.CreateInstance;

  Console.WriteLine_14(TypeDescriptor.GetConverter(myCulture).ConvertTo(myCulture, TClrAssembly.GetType(tcString)));
  // The following line will output 'ru' based on the string being converted.
  Console.WriteLine_14(TypeDescriptor.GetConverter(myCulture).ConvertFrom(myCString));
end.
