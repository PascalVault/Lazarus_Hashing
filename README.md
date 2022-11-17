# Checksum & Hashing library for Lazarus

## Available algorithms

Work in progress...

* Adler8, Adler16, Adler32, Adler64,
* cksum_mpeg2,
* CRC8_AUTOSAR, CRC8_BLUETOOTH,
* CRC16_ARC, CRC16_CDMA2000,
* CRC32_MPEG2, CRC32_JAMCRC,
* CRC64, CRC64_ecma,
* Fletcher8, Fletcher16, Fletcher32, Fletcher64,
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
