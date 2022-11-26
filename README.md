# Checksum & Hashing library for Lazarus

The goal is the create a library which is modular, fast and portable. There is no platform-specific code, no Assembly, no includes, no conditinal defines. Every algorith has it's own separate file and if you need just one algorithm in your program you can just copy 2 files- the file with the algorithm you need and "HasherBase.pas". Optionally you can copy "Hasher.pas" but that's just a helper class.

## Available algorithms

More soon...

* CRC-4 interlaken,
* CRC-6 DARC, CRC-6 G704,
* CRC-7 mmc, CRC-7 umts, 
* CRC-8 AUTOSAR, CRC-8 BLUETOOTH, CRC-8 CDMA2000, CRC-8 DARC, CRC-8 DVBS2, CRC-8 GSMA, CRC-8 GSMB, CRC-8 HITAG, CRC-8 I4321, CRC-8 ICODE, CRC-8 LTE, CRC-8 MAXIMDOW, CRC-8 MIFAREMAD, CRC-8 NRSC5, CRC-8 OPENSAFETY, CRC-8 ROHC, CRC-8 SAEJ1850, CRC-8 SMBUS, CRC-8 TECH3250, CRC-8 WCDMA,
* CRC-10 atm, CRC-10 gsm, CRC-10 cdma2000,
* CRC-11 flexray, CRC-11 umts,
* CRC-12 gsm, CRC-12 dect, CRC-12 cdma2000,
* CRC-13 bbc,
* CRC-14 gsm,
* CRC-15 can, CRC-15 MPT1327,
* CRC-16 ARC, CRC-16 CDMA2000, CRC-16 CMS, CRC-16 DDS110, CRC-16 DECTR, CRC-16 DECTX, CRC-16 DNP, CRC-16 EN13757, CRC-16 GENIBUS, CRC-16 GSM, CRC-16 IBM3740, CRC-16 IBMSDLC, CRC-16 KERMIT, CRC-16 LJ1200, CRC-16 M17, CRC-16 MAXIMDOW, CRC-16 MCRF4XX, CRC-16 MODBUS, CRC-16 NRSC5, CRC-16 OPENSAFETYA, CRC-16 OPENSAFETYB, CRC-16 PROFIBUS, CRC-16 SPIFUJITSU, CRC-16 T10DIF, CR-C16 TELEDISK, CRC-16 UMTS, CRC-16 USB, CRC-16 XMODEM,
* CRC-17 canfd,
* CRC-21 canfd,
* CRC-24 OS9, CRC-24 FLEXRAYA, CRC-24 FLEXRAYB, CRC-24 INTERLAKEN, CRC-24 LTEA, CRC-24 LTEB, CRC-24 OPENPGP,
* CRC-30 cdma,
* CRC-31 philips,
* CRC-32 MPEG2, CRC32 JAMCRC,
* CRC-40 gsm,
* CRC-64, CRC-64 ecma, CRC-64 go, CRC-64 ecma 182, CRC-64 xz, CRC-64 ms,  
* CRC-82 darc,
* Adler8, Adler16, Adler32, Adler64,
* cksum mpeg2,
* Fletcher8, Fletcher16, Fletcher32, Fletcher64,
* SIZE64, Sum BSD, Sum SYSV,
* SUM8, SUM16, SUM24, SUM32, SUM64,
* XOR8, XOR16, XOR32
* xxHash32
* MurmurHash, MurmurHash2, MurmurHash2a, MurmurHash3

## Usage examples
hashing a String

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

hashing a Stream

    uses Hasher;
  
    var Hasher: THasher;
        Hash: String;
        Msg: TMemoryStream;
    begin
      try
        Msg := TMemoryStream.Create;
        Hasher := THasher.Create('CRC-32 JAMCRC');
        Hasher.Update(Msg);
        Hash := Hasher.Final;
        Hasher.Free;
        
        Memo1.Lines.Add( Hash );
      finally
        Msg.Free;
      end; 

hashing a file    

     uses Hasher;

    var Hasher: THasher;
        Hash: String;
    begin
      try       
        Hasher := THasher.Create('CRC-32 JAMCRC');
        Hasher.UpdateFile('directory/file.exe');
        Hash := Hasher.Final;
        Hasher.Free;
        
        Memo1.Lines.Add( Hash );
      finally
      end; 
      

## Using classes directly- without THasher

hashing a String

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
    
hashing an Array   

    uses CRC64;

    var Hasher: THasherCRC64;
        Hash: String;
        Msg: array of Byte;
        Len: Integer;
    begin
      SetLength(Msg, Len);
      Hasher := THasherCRC64.Create;
      Hasher.Update(@Msg[0], Len);
      Hash := Hasher.Final;
      Hasher.Free;
    
      Memo1.Lines.Add( Hash );
    end;
