unit Hasher;
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, Classes, Bufstream, HasherBase,

  Adler8, Adler16, Adler32, Adler64,
  cksum_mpeg2,
  CRC8_AUTOSAR, CRC8_BLUETOOTH,
  CRC16_ARC, CRC16_CDMA2000,
  CRC32_MPEG2, CRC32_JAMCRC,
  CRC64, CRC64_ecma,
  Fletcher8, Fletcher16, Fletcher32, Fletcher64,
  SUM8, SUM16, SUM24, SUM32, SUM64,
  XOR8, XOR16, XOR32;

type
 THasher = class
  private
    FAlgo: THasherBase;
  public
    constructor Create(Algo: String);
    destructor Destroy; override;
    function Final: String;
    procedure Update(Stream: TStream); overload;
    procedure Update(Str: AnsiString); overload;
    procedure Update(Msg: PByte; Length: Integer); overload;
    procedure UpdateFile(Filename: TFilename);
end;

implementation

procedure THasher.Update(Stream: TStream);
var Length: Integer;
    Buffer: array of Byte;
begin
  SetLength(Buffer, 4096);

  try
  while Stream.Position < Stream.Size do begin
    Length := Stream.Read(Buffer[0], 4096);
	
    FAlgo.Update(@Buffer[0], Length);
  end;
  except
  end;
end;

procedure THasher.Update(Str: AnsiString);
begin
  FAlgo.Update(@Str[1], Length(Str));
end;

procedure THasher.UpdateFile(Filename: TFilename);
var F: TBufferedFileStream;
begin
  F := TBufferedFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try
    Self.Update(F);
  finally  
    F.Free;
  end;
end;

procedure THasher.Update(Msg: PByte; Length: Integer);
begin
  FAlgo.Update(Msg, Length);
end;

constructor THasher.Create(Algo: String);
var AClass: THasherClass;
    Res: Boolean;
begin
  inherited Create;

  Res := HasherList.FindClass(Algo, AClass);

  if not Res then raise exception.create('Invalid algorithm');

  FAlgo := AClass.Create;
end;

destructor THasher.Destroy;
begin
  FAlgo.Free;
  inherited;
end;

function THasher.Final: String;
begin
  Result := FAlgo.Final;
end;

end.
