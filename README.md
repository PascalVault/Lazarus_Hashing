# Checksum & Hashing library for Lazarus

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
