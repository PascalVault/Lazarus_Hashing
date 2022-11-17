unit CRC16_OPENSAFETYA;
//CRC-16 OPENSAFETY-A
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_OPENSAFETYA = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $5935, $B26A, $EB5F, $3DE1, $64D4, $8F8B, $D6BE,
$7BC2, $22F7, $C9A8, $909D, $4623, $1F16, $F449, $AD7C,
$F784, $AEB1, $45EE, $1CDB, $CA65, $9350, $780F, $213A,
$8C46, $D573, $3E2C, $6719, $B1A7, $E892, $03CD, $5AF8,
$B63D, $EF08, $0457, $5D62, $8BDC, $D2E9, $39B6, $6083,
$CDFF, $94CA, $7F95, $26A0, $F01E, $A92B, $4274, $1B41,
$41B9, $188C, $F3D3, $AAE6, $7C58, $256D, $CE32, $9707,
$3A7B, $634E, $8811, $D124, $079A, $5EAF, $B5F0, $ECC5,
$354F, $6C7A, $8725, $DE10, $08AE, $519B, $BAC4, $E3F1,
$4E8D, $17B8, $FCE7, $A5D2, $736C, $2A59, $C106, $9833,
$C2CB, $9BFE, $70A1, $2994, $FF2A, $A61F, $4D40, $1475,
$B909, $E03C, $0B63, $5256, $84E8, $DDDD, $3682, $6FB7,
$8372, $DA47, $3118, $682D, $BE93, $E7A6, $0CF9, $55CC,
$F8B0, $A185, $4ADA, $13EF, $C551, $9C64, $773B, $2E0E,
$74F6, $2DC3, $C69C, $9FA9, $4917, $1022, $FB7D, $A248,
$0F34, $5601, $BD5E, $E46B, $32D5, $6BE0, $80BF, $D98A,
$6A9E, $33AB, $D8F4, $81C1, $577F, $0E4A, $E515, $BC20,
$115C, $4869, $A336, $FA03, $2CBD, $7588, $9ED7, $C7E2,
$9D1A, $C42F, $2F70, $7645, $A0FB, $F9CE, $1291, $4BA4,
$E6D8, $BFED, $54B2, $0D87, $DB39, $820C, $6953, $3066,
$DCA3, $8596, $6EC9, $37FC, $E142, $B877, $5328, $0A1D,
$A761, $FE54, $150B, $4C3E, $9A80, $C3B5, $28EA, $71DF,
$2B27, $7212, $994D, $C078, $16C6, $4FF3, $A4AC, $FD99,
$50E5, $09D0, $E28F, $BBBA, $6D04, $3431, $DF6E, $865B,
$5FD1, $06E4, $EDBB, $B48E, $6230, $3B05, $D05A, $896F,
$2413, $7D26, $9679, $CF4C, $19F2, $40C7, $AB98, $F2AD,
$A855, $F160, $1A3F, $430A, $95B4, $CC81, $27DE, $7EEB,
$D397, $8AA2, $61FD, $38C8, $EE76, $B743, $5C1C, $0529,
$E9EC, $B0D9, $5B86, $02B3, $D40D, $8D38, $6667, $3F52,
$922E, $CB1B, $2044, $7971, $AFCF, $F6FA, $1DA5, $4490,
$1E68, $475D, $AC02, $F537, $2389, $7ABC, $91E3, $C8D6,
$65AA, $3C9F, $D7C0, $8EF5, $584B, $017E, $EA21, $B314
);

constructor THasherCRC16_OPENSAFETYA.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := '5D38';
end;

procedure THasherCRC16_OPENSAFETYA.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_OPENSAFETYA.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 OPENSAFETY-A', THasherCRC16_OPENSAFETYA);

end.
