program DateTimeInfo;

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
  DateTimeFmt : _DateTimeFormatInfo;
  Calender : _Calendar;
  MonthNames : _StringArray;
  I : Integer;
begin
  Console := CoConsole.CreateInstance;
  DateTimeFmt := CoDateTimeFormatInfo.CreateInstance;
  Calender := DateTimeFmt.Calendar;
  MonthNames := DateTimeFmt.MonthNames;

  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program prints out Names of Month and Calender Info.');
  Console.WriteLine;
  Console.WriteLine_14('Names of Month :');
  for I := 0 to MonthNames.Length - 1 do begin
    Console.Write_2('   {0} - {1}', I+1, MonthNames[I]);
    Console.WriteLine;
  end;
  Console.WriteLine;
  Console.WriteLine_14('Calendar Info :');
  Console.WriteLine_17('   {0} - {1}', 'DayOfMonth', Calender.GetDayOfMonth(Now));
  Console.WriteLine_17('   {0} - {1}', 'GetDayOfWeek', Calender.GetDayOfWeek(Now));
  Console.WriteLine_17('   {0} - {1}', 'GetDayOfYear', Calender.GetDayOfYear(Now));
  Console.WriteLine_17('   {0} - {1}', 'GetDaysInMonth', Calender.GetDaysInMonth(2015, 4));
  Console.WriteLine_17('   {0} - {1}', 'GetDaysInYear', Calender.GetDaysInYear(2015));
  Console.WriteLine_17('   {0} - {1}', 'GetMonth', Calender.GetMonth(Now));
  Console.WriteLine_17('   {0} - {1}', 'AddMonths', Calender.AddMonths(Now, 8));
  Console.ReadKey;
end.
