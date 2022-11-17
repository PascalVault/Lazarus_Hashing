unit CRC8_OPENSAFETY;
//CRC-8 OPENSAFETY
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC8_OPENSAFETY = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $2F, $5E, $71, $BC, $93, $E2, $CD,
$57, $78, $09, $26, $EB, $C4, $B5, $9A,
$AE, $81, $F0, $DF, $12, $3D, $4C, $63,
$F9, $D6, $A7, $88, $45, $6A, $1B, $34,
$73, $5C, $2D, $02, $CF, $E0, $91, $BE,
$24, $0B, $7A, $55, $98, $B7, $C6, $E9,
$DD, $F2, $83, $AC, $61, $4E, $3F, $10,
$8A, $A5, $D4, $FB, $36, $19, $68, $47,
$E6, $C9, $B8, $97, $5A, $75, $04, $2B,
$B1, $9E, $EF, $C0, $0D, $22, $53, $7C,
$48, $67, $16, $39, $F4, $DB, $AA, $85,
$1F, $30, $41, $6E, $A3, $8C, $FD, $D2,
$95, $BA, $CB, $E4, $29, $06, $77, $58,
$C2, $ED, $9C, $B3, $7E, $51, $20, $0F,
$3B, $14, $65, $4A, $87, $A8, $D9, $F6,
$6C, $43, $32, $1D, $D0, $FF, $8E, $A1,
$E3, $CC, $BD, $92, $5F, $70, $01, $2E,
$B4, $9B, $EA, $C5, $08, $27, $56, $79,
$4D, $62, $13, $3C, $F1, $DE, $AF, $80,
$1A, $35, $44, $6B, $A6, $89, $F8, $D7,
$90, $BF, $CE, $E1, $2C, $03, $72, $5D,
$C7, $E8, $99, $B6, $7B, $54, $25, $0A,
$3E, $11, $60, $4F, $82, $AD, $DC, $F3,
$69, $46, $37, $18, $D5, $FA, $8B, $A4,
$05, $2A, $5B, $74, $B9, $96, $E7, $C8,
$52, $7D, $0C, $23, $EE, $C1, $B0, $9F,
$AB, $84, $F5, $DA, $17, $38, $49, $66,
$FC, $D3, $A2, $8D, $40, $6F, $1E, $31,
$76, $59, $28, $07, $CA, $E5, $94, $BB,
$21, $0E, $7F, $50, $9D, $B2, $C3, $EC,
$D8, $F7, $86, $A9, $64, $4B, $3A, $15,
$8F, $A0, $D1, $FE, $33, $1C, $6D, $42
);

constructor THasherCRC8_OPENSAFETY.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '3E';
end;

procedure THasherCRC8_OPENSAFETY.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 8) xor Table[(Msg^ xor FHash) and $FF];	
    Inc(Msg);
  end;   
end;

function THasherCRC8_OPENSAFETY.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 OPENSAFETY', THasherCRC8_OPENSAFETY);

end.
