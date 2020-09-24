program LoadAssemblyUsingAssemblyHelper;

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
  oConsole : _Console;
  oAsmHelper : _AssemblyHelper;
  oAssembly : _Assembly;

  procedure DisplayAssemblyInfo(xAssembly : _Assembly);
  begin
    if xAssembly = nil then
      oConsole.WriteLine_14('Assembly cannot be loaded')
    else
    begin
      oConsole.WriteLine_14('Assembly has been loaded');
      oConsole.WriteLine_15('Global Assembly Cache: {0}', xAssembly.GlobalAssemblyCache);
      oConsole.WriteLine_15('Is Fully Trusted:      {0}', xAssembly.IsFullyTrusted);
      oConsole.WriteLine_15('Location:              {0}', xAssembly.Location);
      oConsole.WriteLine_15('Image Runtime Version: {0}', xAssembly.ImageRuntimeVersion);
      oConsole.WriteLine_15('Number of Types:       {0}', xAssembly.GetTypes.Length);
      oConsole.WriteLine;
      oConsole.WriteLine;
    end;
  end;
  
  procedure LoadAssemblyFromFile;
  begin
    oConsole.WriteLine_14('System.Data.dll using Assembly File');
    oAssembly := oAsmHelper.LoadFrom('C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Data.dll');
    DisplayAssemblyInfo(oAssembly);
  end;

  procedure LoadAssemblyByAssemblyName;
  var
    oAssemblyName : _AssemblyName;
  begin
    oConsole.WriteLine_14('Loading System.Data.dll using AssemblyName Properties and methods');
    oAssemblyName := CoAssemblyName.CreateInstance;
    oAssemblyName.Name := 'System.Data';
    oAssemblyName.Version := CoVersion.CreateInstance('2.0.0.0');
    oAssemblyName.CultureInfo := CoCultureInfo.CreateInstance('');
    oAssemblyName.SetPublicKeyToken(TClrArrayHelper.ToByteArray('b77a5c561934e089'));
    oAssembly := oAsmHelper.Load_1(oAssemblyName);
    DisplayAssemblyInfo(oAssembly);
  end;

  procedure LoadAssemblyByAssemblyNameString;
  var
    oAssemblyName : _AssemblyName;
  begin
    oConsole.WriteLine_14('Loading System.Data.dll using AssemblyName with AssemblyString');
    oAssemblyName := CoAssemblyName.CreateInstance('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089');
    oAssembly := oAsmHelper.Load_1(oAssemblyName);
    DisplayAssemblyInfo(oAssembly);
  end;

  procedure LoadAssemblyWithPartialName;
  begin
    oConsole.WriteLine_14('Loading System.Data.dll using Partial Assembly Name');
    oAssembly := oAsmHelper.LoadWithPartialName('System.Data');
    DisplayAssemblyInfo(oAssembly);
  end;

  procedure LoadAssemblyByFilePath;
  begin
    oConsole.WriteLine_14('Loading System.Data.dll using File Path');
    oAssembly := oAsmHelper.LoadFile('C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.Data.dll');
    DisplayAssemblyInfo(oAssembly);
  end;
begin
  oConsole := CoConsole.CreateInstance;
  oAsmHelper := CoAssemblyHelper.CreateInstance;
  oConsole.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  oConsole.WriteLine_14('==================================================');
  oConsole.WriteLine_14('The program demonstrate how to use Static Assembly to Load .Net Assemblies');
  oConsole.WriteLine;

  try
    LoadAssemblyFromFile;
    LoadAssemblyByAssemblyName;
    LoadAssemblyByAssemblyNameString;
    LoadAssemblyWithPartialName;
    LoadAssemblyByFilePath;
  except
    on E:Exception do
      oConsole.WriteLine_15('Exception : {0}', E.Message);
  end;
  oConsole.ReadKey;
end.

