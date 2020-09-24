program RijndaelSecurity;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  CNClrLib.EnumTypes,
  CNClrLib.Host,
  CNClrLib.Core;

function EncryptStringToBytes(plainText: string; Key, IV: _ByteArray): _ByteArray;
var
  rijAlg: _RijndaelManaged;
  encryptor: _ICryptoTransform;
  msEncrypt: _MemoryStream;
  csEncrypt: _CryptoStream;
  swEncrypt: _StreamWriter;
begin
  // Check arguments.
  if plainText.Length <= 0 then
    raise Exception.Create('plainText argument is empty');

  if (Key = nil) or (Key.Length <= 0) then
    raise Exception.Create('Key argument is empty or nil');

  if (IV = nil) or (IV.Length <= 0) then
    raise Exception.Create('IV argument is empty or nil');

  // Create an RijndaelManaged object with the specified key and IV.
  rijAlg := CoRijndaelManaged.CreateInstance;
  rijAlg.Key := Key;
  rijAlg.IV := IV;

  // Create a decrytor to perform the stream transform.
  encryptor := rijAlg.CreateEncryptor(rijAlg.Key, rijAlg.IV);

  // Create the streams used for encryption.
  msEncrypt := CoMemoryStream.CreateInstance;
  csEncrypt := CoCryptoStream.CreateInstance(msEncrypt.AsStream, encryptor, csmWrite);

  swEncrypt := coStreamWriter.CreateInstance(csEncrypt.AsStream);
  //Write all data to the stream.
  swEncrypt.Write_3(plainText);
  swEncrypt.Close;

  // Return the encrypted bytes from the memory stream.
  result := msEncrypt.ToArray;
  msEncrypt.Close;
  csEncrypt.Close;
  swEncrypt.Close;
end;

function DecryptStringFromBytes(cipherText, Key, IV: _ByteArray): string;
var
  rijAlg: _RijndaelManaged;
  decryptor: _ICryptoTransform;
  msDecrypt: _MemoryStream;
  csDecrypt: _CryptoStream;
  srDecrypt: _StreamReader;
begin
  // Check arguments.
  if (cipherText = nil) or (cipherText.Length <= 0) then
    raise Exception.Create('cipherText argument is empty or nil');

  if (Key = nil) or (Key.Length <= 0) then
    raise Exception.Create('Key argument is empty or nil');

  if (IV = nil) or (IV.Length <= 0) then
    raise Exception.Create('IV argument is empty or nil');

  // Create an RijndaelManaged object
  // with the specified key and IV.
  rijAlg := CoRijndaelManaged.CreateInstance;
  rijAlg.Key := Key;
  rijAlg.IV := IV;

  // Create a decrytor to perform the stream transform.
  decryptor := rijAlg.CreateDecryptor(rijAlg.Key, rijAlg.IV);

  // Create the streams used for decryption.
  msDecrypt := CoMemoryStream.CreateInstance(cipherText);

  csDecrypt := CoCryptoStream.CreateInstance(msDecrypt.AsStream, decryptor, csmRead);

  srDecrypt := CoStreamReader.CreateInstance(csDecrypt.AsStream);

  // Read the decrypted bytes from the decrypting stream and place them in a string.
  result := srDecrypt.ReadToEnd;

  msDecrypt.Close;
  csDecrypt.Close;
  srDecrypt.Close;
end;


var
  key: Char;
  original,
  roundtrip: string;
  myRijndael: _RijndaelManaged;
  encrypted: _ByteArray;
begin
  try
    original := 'Here is some data to encrypt!';

    // Create a new instance of the RijndaelManaged
    // class.  This generates a new key and initialization
    // vector (IV).
    myRijndael := CoRijndaelManaged.CreateInstance;
    myRijndael.GenerateKey;
    myRijndael.GenerateIV;

    // Encrypt the string to an array of bytes.
    encrypted := EncryptStringToBytes(original, myRijndael.Key, myRijndael.IV);

    // Decrypt the bytes to a string.
    roundtrip := DecryptStringFromBytes(encrypted, myRijndael.Key, myRijndael.IV);

    //Display the original data and the decrypted data.
    Writeln('Original:   %s', original);
    Writeln('Round Trip: %s', roundtrip);

    Writeln('Press any key to continue.....');
    Readln(key);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
