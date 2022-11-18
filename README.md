# Checksum & Hashing library for Lazarus

The goal is the create a library which is modular, fast and portable. There is no platform-specific code, no Assembly, no includes, no conditinal defines. Every algorith has it's own separate file and if you need just one algorithm in your program you can just copy 2 files- the file with the algorithm you need and "HasherBase.pas". Optionally you can copy "Hasher.pas" but that's just a helper class.

## Available algorithms

More soon...

* CRC4_interlaken,
* CRC6_DARC, CRC6_G704,
* crc7_mmc, crc7_umts, 
* CRC8_AUTOSAR, CRC8_BLUETOOTH, CRC8_CDMA2000, CRC8_DARC, CRC8_DVBS2, CRC8_GSMA, CRC8_GSMB, CRC8_HITAG, CRC8_I4321, CRC8_ICODE, CRC8_LTE, CRC8_MAXIMDOW, CRC8_MIFAREMAD, CRC8_NRSC5, CRC8_OPENSAFETY, CRC8_ROHC, CRC8_SAEJ1850, CRC8_SMBUS, CRC8_TECH3250, CRC8_WCDMA,
* crc10_atm, crc10_gsm, crc10_cdma2000,
* crc11_flexray, crc11_umts,
* crc12_gsm, crc12_dect, crc12_cdma2000,
* crc13_bbc,
* crc14_gsm,
* crc15_can, crc15_MPT1327,
* CRC16_ARC, CRC16_CDMA2000, CRC16_CMS, CRC16_DDS110, CRC16_DECTR, CRC16_DECTX, CRC16_DNP, CRC16_EN13757, CRC16_GENIBUS, CRC16_GSM, CRC16_IBM3740, CRC16_IBMSDLC, CRC16_KERMIT, CRC16_LJ1200, CRC16_M17, CRC16_MAXIMDOW, CRC16_MCRF4XX, CRC16_MODBUS, CRC16_NRSC5, CRC16_OPENSAFETYA, CRC16_OPENSAFETYB, CRC16_PROFIBUS, CRC16_SPIFUJITSU, CRC16_T10DIF, CRC16_TELEDISK, CRC16_UMTS, CRC16_USB, CRC16_XMODEM,
* crc17_canfd,
* crc21_canfd,
* CRC24_OS9, CRC24_FLEXRAYA, CRC24_FLEXRAYB, CRC24_INTERLAKEN, CRC24_LTEA, CRC24_LTEB, CRC24_OPENPGP,
* crc30_cdma,
* crc31_philips,
* CRC32_MPEG2, CRC32_JAMCRC,
* CRC40_gsm,
* CRC64, CRC64_ecma, CRC64_go, CRC64_ecma_182, CRC64_xz, CRC64_ms,  
* CRC82_darc,
* Adler8, Adler16, Adler32, Adler64,
* cksum_mpeg2,
* Fletcher8, Fletcher16, Fletcher32, Fletcher64,
* SIZE64, Sum BSD, Sum SYSV,
* SUM8, SUM16, SUM24, SUM32, SUM64,
* XOR8, XOR16, XOR32

## Usage example

    uses Hasher;
  
    var Hasher: THasher;
        Hash: String;
    begin
      try
        Hasher := THasher.Create('CRC-32 JAMCRC');
        Hasher.Update('123456789');
        Hash := Hasher.Final;
        Hasher.Free;
        
        Memo1.Lines.Add( Hash );
      finally
      end; 

## Using classes directly- without THasher

    uses CRC64;
    
    var Hasher: THasherCRC64;
        Hash: String;
        Msg: String;
    begin
      Msg := '123456789';
      Hasher := THasherCRC64.Create;
      Hasher.Update(@Msg[1], Length(Msg));
      Hash := Hasher.Final;
      Hasher.Free;
    
      Memo1.Lines.Add( Hash );
    end;
