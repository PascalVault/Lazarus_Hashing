# Checksum & Hashing library for Lazarus

## Available algorithms

Work in progress...

  CRC-16 ARC, CRC-16 CDMA2000
  CRC-32 MPEG2, CRC-32 JAMCRC

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
