unit Example;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TestExample, TestExampleConst, TestExampleEnums,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  CountryName : string;
  I : TGeoIPService;
  G : TGeoIP;
begin
  try
  CountryName := 'unassigned';
  I := TGeoIPService.Create;
  G := I.GetGeoIP('...insert IP address here...');
  if assigned(G) then
    countryname := G.CountryName;

  Response.Content :=
  '<html>' +
  '<head><title>Web Service Test</title></head>' +
  '<body>Country: ' + CountryName + '</body>' +
  '</html>';
  except
  on E : exception do begin
  Response.Content :=
  '<html>' +
  '<head><title>Web Service Test</title></head>' +
  '<body>Exception: ' + E.ClassName() + ' ' + E.Message + '</body>' +
  '</html>';
  end;
  end;
end;

end.
