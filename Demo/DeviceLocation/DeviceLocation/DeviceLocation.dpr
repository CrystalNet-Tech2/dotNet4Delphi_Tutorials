program DeviceLocation;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

//The following example shows how to handle StatusChanged events and print out the current GeoPositionStatus.

uses
  SysUtils,
  CNClrLib.EnumArrays,
  CNClrLib.EnumTypes,
  CNClrLib.Device,
  CNClrLib.Host,
  CNClrLib.Host.Helper,
  CNClrLib.Host.Utils,
  CNClrLib.Core;

var
  Console: _Console;

  // Event Handler in C# looks like this:
  // static void DoStatusChanged(object sender, GeoPositionStatusChangedEventArgs e)
  procedure DoStatusChanged(ASender: _ClrObject; AEventArgs: _ClrEventArgs); stdcall;
  var
    e: _GeoPositionStatusChangedEventArgs;
    ageoPositionStatus: TGeoPositionStatus;
  begin
    //Convert EventArgs value to GeoPositionStatusChangedEventArgs
    e := CoGeoPositionStatusChangedEventArgs.Wrap(AEventArgs.EventArgs);

    //Convert the status as TOleEnum to a delphi readable enumration type defined in CNClrLib.EnumTypes
    ageoPositionStatus := TGeoPositionStatus(OleEnumToOrd(GeoPositionStatusValues, e.Status));
    case ageoPositionStatus of
      gpsInitializing: Console.WriteLine_14('Working on location fix');
      gpsReady:        Console.WriteLine_14('Have location');
      gpsNoData:       Console.WriteLine_14('No data');
      gpsDisabled:     Console.WriteLine_14('Disabled');
    end;
  end;

  procedure ShowStatusUpdates;
  var
    watcher: _GeoCoordinateWatcher;
    eventHandler: TClrEventHandler;
  begin
    watcher := CoGeoCoordinateWatcher.CreateInstance;
    watcher.Start;

    eventHandler := DoStatusChanged;
    watcher.Add_StatusChanged(TClrIntPtrHelper.Zero, TClrConvert.ToManagedPointer(@eventHandler));

    Console.WriteLine_14('Enter any key to quit.');
    Console.ReadLine;
  end;

begin
  try
    Console := CoConsole.CreateInstance;
    ShowStatusUpdates;
  except
    on E: Exception do
    begin
      Console.WriteLine_14(E.message);
    end;
  end;
end.
