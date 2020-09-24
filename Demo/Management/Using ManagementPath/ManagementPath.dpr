// This example shows synchronous consumption of events.
// The client is blocked while waiting for events.
program ManagementPath;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Management,
  CNClrLib.Core;

var
  Console: _Console;
  ManagePath: _ManagementPath;
begin
  Console := CoConsole.CreateInstance;
  try

    // Get the WMI class path
    ManagePath := CoManagementPath.CreateInstance('\\ComputerName\root' +
            '\cimv2:Win32_LogicalDisk.DeviceID=''C:''');

    Console.WriteLine_15('IsClass: {0}',  ManagePath.IsClass);
    // Should be False (because it is an instance)

    Console.WriteLine_15('IsInstance: {0}', ManagePath.IsInstance);
    // Should be True

    Console.WriteLine_14('ClassName: ' + ManagePath.ClassName);
    // Should be "Win32_LogicalDisk"

    Console.WriteLine_14('NamespacePath: ' + ManagePath.NamespacePath);
    // Should be "ComputerName\cimv2"

    Console.WriteLine_14('Server: ' + ManagePath.Server);
    // Should be "ComputerName"

    Console.WriteLine_14('Path: ' + ManagePath.Path);
    // Should be "ComputerName\root\cimv2:
    // Win32_LogicalDisk.DeviceId="C:""

    Console.WriteLine_14('RelativePath: ' + ManagePath.RelativePath);
    // Should be "Win32_LogicalDisk.DeviceID="C:""
  except
    on E: Exception do
    begin
      Console.WriteLine_14(E.message);
    end;
  end;
  Console.ReadKey;
end.
