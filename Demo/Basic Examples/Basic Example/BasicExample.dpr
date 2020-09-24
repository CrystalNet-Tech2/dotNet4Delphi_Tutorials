program BasicExample;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
	System.SysUtils,
{$ELSE}
	SysUtils,
{$IFEND}
  CNClrLib.Host, CNClrLib.Enums, CNClrLib.Core;

var
  Console : _Console;

  procedure MathClass;
  var
    m_math : _Math;
  begin
    m_math := CoMath.CreateInstance;
    Console.WriteLine_14('Using Math Class Methods/Properties..');
    Console.WriteLine_15('Exp(50):              {0}', m_math.Exp(50));
    Console.WriteLine_15('PI:                   {0}', m_math.PI);
    Console.WriteLine_15('Cos(50):              {0}', m_math.Cos(50));
    Console.WriteLine_15('Log(50):              {0}', m_math.Log(50));
    Console.WriteLine_15('Pow(50, 3):           {0}', m_math.Pow(50, 3));
    Console.WriteLine_15('Round(234.094833, 2): {0}', m_math.Round_1(234.094833, 2));
    Console.WriteLine_15('Truncate(234.094833): {0}', m_math.Truncate_1(234.094833));
    Console.WriteLine_15('Sqrt(16):             {0}', m_math.Sqrt(16));
    Console.WriteLine;
    Console.WriteLine;
  end;

  procedure RandomClass;
  var
    m_random : _Random;
  begin
    m_random := CoRandom.CreateInstance;
    Console.WriteLine_14('Using Random Class Methods/Properties..');
    Console.WriteLine_15('Next Value: {0}', m_random.Next);
    Console.WriteLine_15('NextDouble: {0}', m_random.NextDouble);
    Console.WriteLine_15('Next(2000): {0}', m_random.Next_2(2000));
    Console.WriteLine;
    Console.WriteLine;
  end;

  procedure GuidClass;
  var
    m_guid : _GuidHelper;
  begin
    m_guid := CoGuidHelper.CreateInstance;
    Console.WriteLine_14('Using Guid Class Methods/Properties..');
    Console.WriteLine_15('Empty Guid: {0}', m_guid.Empty.ToString);
    Console.WriteLine_15('NewGuid:    {0}', m_guid.NewGuid.ToString);
    Console.WriteLine_15('GetGuid:    {0}', m_guid.GetGuid_1('93D96D05-6506-47F0-BBA6-75B70B9E27D7').ToString);
    Console.WriteLine;
    Console.WriteLine;
  end;

  procedure EnvironmentClass;
  var
    m_environment : _Environment;
  begin
    m_environment := CoEnvironment.CreateInstance;
    Console.WriteLine_14('Using Environment Class Methods/Properties..');
    Console.WriteLine_15('CommandLine:            {0}', m_environment.CommandLine);
    Console.WriteLine_15('CurrentDirectory:       {0}', m_environment.CurrentDirectory);
    Console.WriteLine_15('ExitCode:               {0}', m_environment.ExitCode);
    Console.WriteLine_15('Is64BitOperatingSystem: {0}', m_environment.Is64BitOperatingSystem);
    Console.WriteLine_15('Is64BitProcess:         {0}', m_environment.Is64BitProcess);
    Console.WriteLine_15('MachineName:            {0}', m_environment.MachineName);
    Console.WriteLine_15('OSVersion:              {0}', m_environment.OSVersion);
    Console.WriteLine_15('ProcessorCount:         {0}', m_environment.ProcessorCount);
    Console.WriteLine_15('StackTrace:             {0}', m_environment.StackTrace);
    Console.WriteLine_15('SystemDirectory:        {0}', m_environment.SystemDirectory);
    Console.WriteLine_15('SystemPageSize:         {0}', m_environment.SystemPageSize);
    Console.WriteLine_15('UserName:               {0}', m_environment.UserName);
    Console.WriteLine_15('GetFolderPath:          {0}', m_environment.GetFolderPath(SpecialFolder_MyDocuments));
    Console.WriteLine_15('WorkingSet:             {0}', m_environment.WorkingSet);
    Console.WriteLine;
    Console.WriteLine;
  end;

  procedure FileInfoClass;
  var
    m_fileInfo : _FileInfo;
  begin
    m_fileInfo := CoFileInfo.CreateInstance('sqlnet.log');
    Console.WriteLine_14('Using FileInfo Class Methods/Properties..');
    Console.WriteLine_15('Name:              {0}', m_fileInfo.Name);
    Console.WriteLine_15('DirectoryName:     {0}', m_fileInfo.DirectoryName);
    Console.WriteLine_15('IsReadOnly:        {0}', m_fileInfo.IsReadOnly);
    Console.WriteLine_15('Exists:            {0}', m_fileInfo.Exists);
    Console.WriteLine_15('FullName:          {0}', m_fileInfo.FullName);
    Console.WriteLine_15('Extension:         {0}', m_fileInfo.Extension);
    Console.WriteLine_15('CreationTime:      {0}', m_fileInfo.CreationTime);
    Console.WriteLine_15('CreationTimeUtc:   {0}', m_fileInfo.CreationTimeUtc);
    Console.WriteLine_15('LastAccessTime:    {0}', m_fileInfo.LastAccessTime);
    Console.WriteLine_15('LastAccessTimeUtc: {0}', m_fileInfo.LastAccessTimeUtc);
    Console.WriteLine_15('LastWriteTime:     {0}', m_fileInfo.LastWriteTime);
    Console.WriteLine_15('LastWriteTimeUtc:  {0}', m_fileInfo.LastWriteTimeUtc);
    Console.WriteLine_15('Length:            {0}', m_fileInfo.Length);
    Console.WriteLine_15('ReadLine:          {0}', m_fileInfo.OpenText.ReadToEnd);
    Console.WriteLine;
    Console.WriteLine;
  end;
  
begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrate how to use basic .Net framework classes in Delphi');
  Console.WriteLine;
  try
    MathClass;
    RandomClass;
    GuidClass;
    EnvironmentClass;
    FileInfoClass;
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', e.Message);
  end;
  Console.ReadKey;
end.

