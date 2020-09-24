program LoadAssemblyUsingAppDomain;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Host, CNClrLib.Core;

var
  Console : _Console;

  procedure DisplayAssemblyInfo(AAssembly : _Assembly);
  begin
    if AAssembly = nil then
      Console.WriteLine_14('Assembly cannot be loaded')
    else
    begin
      Console.WriteLine_14('Assembly has been loaded');
      Console.WriteLine_15('Is Fully Trusted:      {0}', AAssembly.IsFullyTrusted);
      Console.WriteLine_15('Global Assembly Cache: {0}', AAssembly.GlobalAssemblyCache);
      Console.WriteLine_15('Location:              {0}', AAssembly.Location);
      Console.WriteLine_15('Image Runtime Version: {0}', AAssembly.ImageRuntimeVersion);
      Console.WriteLine_15('Number of Types:       {0}', AAssembly.GetTypes.Length);
      Console.WriteLine;
      Console.WriteLine;
    end;
  end;
  
  procedure LoadAssemblyByAssemblyString;
  var
    m_assembly: _Assembly;
  begin
    Console.WriteLine_14('Loading System.Data.dll using Assembly String');

    m_assembly := TClrAppDomain.GetCurrentDomain.Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089');
    DisplayAssemblyInfo(m_assembly);
  end;

  procedure LoadAssemblyByAssemblyName;
  var
    m_assemblyName : _AssemblyName;
    m_assembly : _Assembly;
  begin
    Console.WriteLine_14('Loading System.Data.dll using AssemblyName Properties and methods');

    m_assemblyName := CoAssemblyName.CreateInstance;
    m_assemblyName.Name := 'System.Data';
    m_assemblyName.Version := CoVersion.CreateInstance('2.0.0.0');
    m_assemblyName.CultureInfo := CoCultureInfo.CreateInstance('');
    m_assemblyName.SetPublicKeyToken(TClrArrayHelper.ToByteArray('b77a5c561934e089'));
    m_assembly := TClrAppDomain.GetCurrentDomain.Load(m_assemblyName);
    DisplayAssemblyInfo(m_assembly);
  end;

  procedure LoadAssemblyByAssemblyNameString;
  var
    m_assemblyName : _AssemblyName;
    m_assembly : _Assembly;
  begin
    Console.WriteLine_14('Loading System.Data.dll using AssemblyName with AssemblyString');

    m_assemblyName := CoAssemblyName.CreateInstance('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089');

    m_assembly := TClrAppDomain.GetCurrentDomain.Load(m_assemblyName);
    DisplayAssemblyInfo(m_assembly);
  end;

begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('The program demonstrate how to use AppDomain to Load .Net Assemblies');
  Console.WriteLine;

  try
    LoadAssemblyByAssemblyString;
    LoadAssemblyByAssemblyName;
    LoadAssemblyByAssemblyNameString;
  except
    on E:Exception do
      Console.WriteLine_15('Exception : {0}', E.Message);
  end;
  Console.ReadKey;
end.

