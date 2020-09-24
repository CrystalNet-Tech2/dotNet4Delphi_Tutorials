program Configuration;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

//  The first example shows a simple console application that reads application settings,
//  adds a new setting, and updates an existing setting.

uses
  System.SysUtils,
  CNClrLib.Host,
  CNClrLib.Core,
  CNClrLib.Collections,
  CNClrLib.Configuration,
  CNClrLib.Enums;

var
  Console: _Console;

procedure ReadAllSettings;
var
  appSettings: _NameValueCollection;
  ConfigManager: _ConfigurationManager;
  I: Integer;
  AKey: string;
begin
  try
    ConfigManager := CoConfigurationManager.CreateInstance;
    appSettings := ConfigManager.AppSettings;
    if appSettings.Count = 0 then
      Console.WriteLine_14('AppSettings is empty.')
    else
    begin
      for I := 0 to appSettings.AllKeys.Length - 1 do
      begin
        AKey := appSettings.AllKeys.GetValue(i);
        Console.WriteLine_17('Key: {0} Value: {1}', AKey, appSettings.Item[AKey]);
      end;
    end;
  except
    Console.WriteLine_14('Error reading app settings');
  end;
end;

procedure ReadSetting(Key: String);
var
  appSettings: _NameValueCollection;
  ConfigManager: _ConfigurationManager;
  result: string;
begin
  try
    ConfigManager := CoConfigurationManager.CreateInstance;
    appSettings := ConfigManager.AppSettings;
    result := appSettings.Item[Key];
    if result = '' then
      result := 'Not Found';

    Console.WriteLine_14(result);
  except
    Console.WriteLine_14('Error reading app settings');
  end;
end;

procedure AddUpdateAppSettings(Key, value: String);
var
  configFile: _Configuration;
  ConfigManager: _ConfigurationManager;
  settings: _KeyValueConfigurationCollection;
begin
  try
    ConfigManager := CoConfigurationManager.CreateInstance;
    configFile := ConfigManager.OpenExeConfiguration(ConfigurationUserLevel_None);
    settings := configFile.AppSettings.Settings;
    if settings[Key] = nil then
      settings.Add_1(key, value)
    else
      settings[Key].Value := value;

    configFile.Save_1(ConfigurationSaveMode_Modified);
    ConfigManager.RefreshSection(configFile.AppSettings.SectionInformation.Name);
  except
    Console.WriteLine_14('Error writing app settings');
  end;
end;

begin
  try
    Console := CoConsole.CreateInstance;
    ReadAllSettings;
    ReadSetting('Setting1');
    ReadSetting('NotValid');
    AddUpdateAppSettings('NewSetting', 'May 7, 2014');
    AddUpdateAppSettings('Setting1', 'May 8, 2014');
    ReadAllSettings;
    Console.ReadLine;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

//The above example assumes your project has an ConfigurationExample.exe.config file as shown below.

//<?xml version="1.0" encoding="utf-8" ?>
//<configuration>
//    <startup>
//        <supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.5" />
//    </startup>
//  <appSettings>
//    <add key="Setting1" value="May 5, 2014"/>
//    <add key="Setting2" value="May 6, 2014"/>
//  </appSettings>
//</configuration>

