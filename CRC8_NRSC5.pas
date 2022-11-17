unit CRC8_NRSC5;
//CRC-8 NRSC-5
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC8_NRSC5 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $31, $62, $53, $C4, $F5, $A6, $97,
$B9, $88, $DB, $EA, $7D, $4C, $1F, $2E,
$43, $72, $21, $10, $87, $B6, $E5, $D4,
$FA, $CB, $98, $A9, $3E, $0F, $5C, $6D,
$86, $B7, $E4, $D5, $42, $73, $20, $11,
$3F, $0E, $5D, $6C, $FB, $CA, $99, $A8,
$C5, $F4, $A7, $96, $01, $30, $63, $52,
$7C, $4D, $1E, $2F, $B8, $89, $DA, $EB,
$3D, $0C, $5F, $6E, $F9, $C8, $9B, $AA,
$84, $B5, $E6, $D7, $40, $71, $22, $13,
$7E, $4F, $1C, $2D, $BA, $8B, $D8, $E9,
$C7, $F6, $A5, $94, $03, $32, $61, $50,
$BB, $8A, $D9, $E8, $7F, $4E, $1D, $2C,
$02, $33, $60, $51, $C6, $F7, $A4, $95,
$F8, $C9, $9A, $AB, $3C, $0D, $5E, $6F,
$41, $70, $23, $12, $85, $B4, $E7, $D6,
$7A, $4B, $18, $29, $BE, $8F, $DC, $ED,
$C3, $F2, $A1, $90, $07, $36, $65, $54,
$39, $08, $5B, $6A, $FD, $CC, $9F, $AE,
$80, $B1, $E2, $D3, $44, $75, $26, $17,
$FC, $CD, $9E, $AF, $38, $09, $5A, $6B,
$45, $74, $27, $16, $81, $B0, $E3, $D2,
$BF, $8E, $DD, $EC, $7B, $4A, $19, $28,
$06, $37, $64, $55, $C2, $F3, $A0, $91,
$47, $76, $25, $14, $83, $B2, $E1, $D0,
$FE, $CF, $9C, $AD, $3A, $0B, $58, $69,
$04, $35, $66, $57, $C0, $F1, $A2, $93,
$BD, $8C, $DF, $EE, $79, $48, $1B, $2A,
$C1, $F0, $A3, $92, $05, $34, $67, $56,
$78, $49, $1A, $2B, $BC, $8D, $DE, $EF,
$82, $B3, $E0, $D1, $46, $77, $24, $15,
$3B, $0A, $59, $68, $FF, $CE, $9D, $AC
);

constructor THasherCRC8_NRSC5.Create;
begin
  inherited Create;
  FHash :=  $FF;
  Check := 'F7';
end;

procedure THasherCRC8_NRSC5.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 8) xor Table[(Msg^ xor FHash) and $FF];	
    Inc(Msg);
  end;   
end;

function THasherCRC8_NRSC5.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 NRSC-5', THasherCRC8_NRSC5);

end.
