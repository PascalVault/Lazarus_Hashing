unit Hasher;
//Author: domasz
//Version: 0.2 (2022-11-26)
//Licence: MIT

interface

uses SysUtils, Classes, Bufstream, HasherBase, Dialogs,

  CRC4_interlaken,

  CRC6_DARC, CRC6_G704,

  crc7_mmc, crc7_umts,

  CRC8_AUTOSAR, CRC8_BLUETOOTH, CRC8_CDMA2000, CRC8_DARC, CRC8_DVBS2, CRC8_GSMA,
  CRC8_GSMB, CRC8_HITAG, CRC8_I4321, CRC8_ICODE, CRC8_LTE, CRC8_MAXIMDOW,
  CRC8_MIFAREMAD, CRC8_NRSC5, CRC8_OPENSAFETY, CRC8_ROHC, CRC8_SAEJ1850,
  CRC8_SMBUS, CRC8_TECH3250, CRC8_WCDMA,

  CRC16_ARC, CRC16_CDMA2000, CRC16_CMS, CRC16_DDS110, CRC16_DECTR, CRC16_DECTX,
  CRC16_DNP, CRC16_EN13757, CRC16_GENIBUS, CRC16_GSM, CRC16_IBM3740, CRC16_IBMSDLC,
  CRC16_KERMIT, CRC16_LJ1200, CRC16_M17, CRC16_MAXIMDOW,
  CRC16_MCRF4XX, CRC16_MODBUS, CRC16_NRSC5, CRC16_OPENSAFETYA, CRC16_OPENSAFETYB,
  CRC16_PROFIBUS, CRC16_SPIFUJITSU, CRC16_T10DIF, CRC16_TELEDISK,
  CRC16_UMTS, CRC16_USB, CRC16_XMODEM,

  CRC24_OS9, CRC24_FLEXRAYA, CRC24_FLEXRAYB, CRC24_INTERLAKEN, CRC24_LTEA,
  CRC24_LTEB, CRC24_OPENPGP,

  CRC5_EPCC1G2, CRC5_G704,CRC5_USB, CRC4_G704,CRC3_ROHC, CRC24_BLE,

  PJW32,
  MurmurHash,
  MurmurHash2,
  MurmurHash2a,
  MurmurHash3,
  MySQL3,
  CARP,

  xxHash32,
  SHA1, SHA0,


  CRC16_TMS37157, CRC16_ISOIEC1444, CRC16_RIELLO,
  CRC14_DARC,

  crc10_atm, crc10_gsm, crc10_cdma2000,
  crc11_flexray, crc11_umts,
  crc12_gsm, crc12_dect, crc12_cdma2000,
  crc13_bbc,
  crc14_gsm,
  crc15_can, crc15_MPT1327,
  crc17_canfd,
  crc21_canfd,
  crc30_cdma,
  crc31_philips,
  CRC40_gsm,
  CRC82_darc,

  One_at_a_time,

  CRC32_MPEG2, CRC32_JAMCRC, CRC32_AIXM, CRC32_AUTOSAR, CRC32_BASE91D, CRC32_BZIP2,
  CRC32_CDROMEDC, CRC32_CKSUM, CRC32_ISCSI, CRC32_ISOHDLC, CRC32_MEF, CRC32_XFER,

  CRC64, CRC64_ecma, CRC64_go, CRC64_ecma_182, CRC64_xz, CRC64_ms,

  FNV0_64, FNV1_64, FNV1A_64,
  FNV0_32, FNV1_32, FNV1a_32,
  FNV0_8, FNV0_16, FNV0_24,

  FNV1a_8, FNV1a_16, FNV1_8, FNV1_16,
  FNV1A_56, FNV0_56, FNV1_56,

  aphash, BKDRHash, DEKHash, DJBHash, elfHash, jshash, pjwhash, rshash, SDBMHash,

  GHash3, GHash5,

  Adler8, Adler16, Adler32, Adler64,
  cksum_mpeg2,
  Fletcher8, Fletcher16, Fletcher32, Fletcher64,
  SUM8, SUM16, SUM24, SUM32, SUM64,
  SIZE64, SUM_BSD, SUM_SYSV,
  XOR8, XOR16, XOR32;

type

 { THasher }

 THasher = class
  private
    FAlgo: THasherBase;
    FClass: THasherClass;
  public
    constructor Create(Algo: String);
    destructor Destroy; override;
    function Final: String;
    procedure Update(Stream: TStream); overload;
    procedure Update(Str: AnsiString); overload;
    procedure Update(Msg: PByte; Length: Integer); overload;
    procedure UpdateFile(Filename: TFilename);
    function SelfCheck: Boolean;
end;

implementation

procedure THasher.Update(Stream: TStream);
var Length: Integer;
    Buffer: array of Byte;
begin
  SetLength(Buffer, 4096);

  try
  repeat
    Length := Stream.Read(Buffer[0], 4096);

    if Length <=0 then break;
	
    FAlgo.Update(@Buffer[0], Length);
  until false;
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

function THasher.SelfCheck: Boolean;
const Test: array[0..9] of AnsiChar = '123456789';
var Algo: THasherBase;
    Res: String;
begin
  Result := False;
  Algo := FClass.Create;
  try
    Algo.Update(@Test[0], 9);
    Res := Algo.Final;

    if Algo.Check = Res then Result := True;
  finally
    Algo.Free;
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

  FClass := AClass;
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
