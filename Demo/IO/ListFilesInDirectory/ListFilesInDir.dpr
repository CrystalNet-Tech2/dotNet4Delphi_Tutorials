program ListFilesInDir;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
  System.SysUtils,
{$ELSE}
  SysUtils,
{$IFEND }
  CNClrLib.Core;

var
  Console : _Console;
  DirInfo : _DirectoryInfo;
  FileInfos : _FileInfoArray;
  DirName : WideString;
  I : Integer;
begin
  Console := CoConsole.CreateInstance;

  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program lists all the files in a directory.');
  Console.WriteLine;
  Console.Write_22('Please enter the name of a directory: ');
  DirName := Console.ReadLine;
  try
    DirInfo := CoDirectoryInfo.CreateInstance(DirName);
    try
      FileInfos := DirInfo.GetFiles_2;
      for I := 0 to FileInfos.Length - 1 do begin
        Console.WriteLine_17('{0}, {1}', FileInfos[I].Name, FileInfos[I].Length);
      end;
    finally
      FileInfos := nil;
      DirInfo := nil;
    end;
  except
    on E: Exception do
      Console.WriteLine_15('Exception : {0}', E.Message);
  end;
  Console.ReadKey;
end.
