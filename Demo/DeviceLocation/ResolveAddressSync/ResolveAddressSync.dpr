program ResolveAddressSync;

{$WARN SYMBOL_PLATFORM OFF}
{$APPTYPE CONSOLE}
{$R *.res}

uses
  SysUtils,
  CNClrLib.EnumTypes,
  CNClrLib.Device,
  CNClrLib.Core;

var
  Console: _Console;

  procedure ResolveAddressSyncA;
  var
    watcher: _GeoCoordinateWatcher;
    resolver: _CivicAddressResolver;
    location: _GeoCoordinate;
    timespan: _TimeSpanHelper;
    address: _CivicAddress;
  begin
    watcher := CoGeoCoordinateWatcher.CreateInstance(gpaHigh);
    watcher.MovementThreshold := 1.0; // set to one meter

    timespan := CoTimeSpanHelper.CreateInstance;
    watcher.TryStart(false, timespan.FromMilliseconds(1000));

    resolver := CoCivicAddressResolver.CreateInstance;
    location := CoGeoCoordinate.Wrap(watcher.Position.Location);

    if location.IsUnknown = False then
    begin
       address := resolver.ResolveAddress(location);
      if not address.IsUnknown then
      begin
        Console.WriteLine_17('Country: {0}, Zip: {1}',
                address.CountryRegion,
                address.PostalCode);
      end
    end
    else
    begin
      Console.WriteLine_14('Address unknown.');
    end;
  end;

begin
  try
    Console := CoConsole.CreateInstance;
    ResolveAddressSyncA;
  except
    on E: Exception do
    begin
      Console.WriteLine_14(E.message);
    end;
  end;
end.
