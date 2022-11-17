unit CRC16_NRSC5;
//CRC-16 NRSC-5
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_NRSC5 = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $35A4, $6B48, $5EEC, $D690, $E334, $BDD8, $887C,
$0D01, $38A5, $6649, $53ED, $DB91, $EE35, $B0D9, $857D,
$1A02, $2FA6, $714A, $44EE, $CC92, $F936, $A7DA, $927E,
$1703, $22A7, $7C4B, $49EF, $C193, $F437, $AADB, $9F7F,
$3404, $01A0, $5F4C, $6AE8, $E294, $D730, $89DC, $BC78,
$3905, $0CA1, $524D, $67E9, $EF95, $DA31, $84DD, $B179,
$2E06, $1BA2, $454E, $70EA, $F896, $CD32, $93DE, $A67A,
$2307, $16A3, $484F, $7DEB, $F597, $C033, $9EDF, $AB7B,
$6808, $5DAC, $0340, $36E4, $BE98, $8B3C, $D5D0, $E074,
$6509, $50AD, $0E41, $3BE5, $B399, $863D, $D8D1, $ED75,
$720A, $47AE, $1942, $2CE6, $A49A, $913E, $CFD2, $FA76,
$7F0B, $4AAF, $1443, $21E7, $A99B, $9C3F, $C2D3, $F777,
$5C0C, $69A8, $3744, $02E0, $8A9C, $BF38, $E1D4, $D470,
$510D, $64A9, $3A45, $0FE1, $879D, $B239, $ECD5, $D971,
$460E, $73AA, $2D46, $18E2, $909E, $A53A, $FBD6, $CE72,
$4B0F, $7EAB, $2047, $15E3, $9D9F, $A83B, $F6D7, $C373,
$D010, $E5B4, $BB58, $8EFC, $0680, $3324, $6DC8, $586C,
$DD11, $E8B5, $B659, $83FD, $0B81, $3E25, $60C9, $556D,
$CA12, $FFB6, $A15A, $94FE, $1C82, $2926, $77CA, $426E,
$C713, $F2B7, $AC5B, $99FF, $1183, $2427, $7ACB, $4F6F,
$E414, $D1B0, $8F5C, $BAF8, $3284, $0720, $59CC, $6C68,
$E915, $DCB1, $825D, $B7F9, $3F85, $0A21, $54CD, $6169,
$FE16, $CBB2, $955E, $A0FA, $2886, $1D22, $43CE, $766A,
$F317, $C6B3, $985F, $ADFB, $2587, $1023, $4ECF, $7B6B,
$B818, $8DBC, $D350, $E6F4, $6E88, $5B2C, $05C0, $3064,
$B519, $80BD, $DE51, $EBF5, $6389, $562D, $08C1, $3D65,
$A21A, $97BE, $C952, $FCF6, $748A, $412E, $1FC2, $2A66,
$AF1B, $9ABF, $C453, $F1F7, $798B, $4C2F, $12C3, $2767,
$8C1C, $B9B8, $E754, $D2F0, $5A8C, $6F28, $31C4, $0460,
$811D, $B4B9, $EA55, $DFF1, $578D, $6229, $3CC5, $0961,
$961E, $A3BA, $FD56, $C8F2, $408E, $752A, $2BC6, $1E62,
$9B1F, $AEBB, $F057, $C5F3, $4D8F, $782B, $26C7, $1363
);

constructor THasherCRC16_NRSC5.Create;
begin
  inherited Create;
  FHash :=  $FFFF;
  Check := 'A066';
end;

procedure THasherCRC16_NRSC5.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shr 8) xor Table[(FHash xor Msg^) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_NRSC5.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 NRSC-5', THasherCRC16_NRSC5);

end.
