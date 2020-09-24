program COMDispInterface;

{$APPTYPE CONSOLE}
{$R *.res}

uses
{$IF CompilerVersion > 22}
	System.SysUtils,
{$ELSE}
	SysUtils,
{$IFEND}
  CNClrLib.Host, CNClrLib.Core;

(*  Mathematics.Dll Source Code
  namespace Mathematics
  {
      public class Mathematics
      {
          [DispId(0)]
          public int Add(int a, int b)
          {
              return a + b;
          }

          [DispId(1)]
          public int Subtract(int a, int b)
          {
              return a - b;
          }

          [DispId(2)]
          public bool Equal(int a, int b)
          {
              return a == b;
          }
      }
  }
*)

type
  //Corresponding Delphi DispInterface type of Mathematics type in the Mathematics.dll
  _Mathematics = dispinterface
  ['{D77959BD-C7AC-4D65-9980-A88510F776B8}']
    function Add(a, b : Integer) : Integer; dispid 0;
    function Subtract(a, b : Integer) : Integer; dispid 1;
    function Equal(a, b : Integer) : WordBool; dispid 2;
  end;

var
  Console : _Console;
  Mathematics : _Mathematics;


  procedure LoadMathematicAssembly;
  begin
    // If error occurs while executing LoadFrom then
    // Right-Click on the file and select properties, click on the
    // unblock button to allow access.
    TClrAssembly.LoadFrom('Mathematics.dll');
  end;

  procedure CreateMathematicTypeInstance;
  begin
    Mathematics := _Mathematics(TClrDispatchActivator.CreateInstance('Mathematics.Mathematics'));
  end;

  procedure AccessMathematicsObjectMethods;
  begin
    Console.WriteLine_15('Add(30, 50):      {0}', Mathematics.Add(30, 50));
    Console.WriteLine_15('Subtract(30, 50): {0}', Mathematics.Subtract(30, 50));
    Console.WriteLine_15('Equal(30, 50):    {0}', Mathematics.Equal(30, 50));
    Console.WriteLine_15('Equal(50, 50):    {0}', Mathematics.Equal(50, 50));
  end;

begin
  Console := CoConsole.CreateInstance;
  Console.WriteLine_14('Hello! Welcome to .Net Runtime Library for Delphi.');
  Console.WriteLine_14('==================================================');
  Console.WriteLine_14('This program demonstrate how to use COM DispInterface to communicate with .Net library type members');
  Console.WriteLine;
  try
    LoadMathematicAssembly;
    CreateMathematicTypeInstance;
    AccessMathematicsObjectMethods;
  except
    on E: Exception do
      Console.WriteLine_15('Exception: {0}', e.Message);
  end;
  Console.ReadKey;
end.


