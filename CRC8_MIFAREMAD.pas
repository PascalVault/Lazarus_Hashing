unit CRC8_MIFAREMAD;
//CRC-8 MIFARE-MAD
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC8_MIFAREMAD = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $1D, $3A, $27, $74, $69, $4E, $53,
$E8, $F5, $D2, $CF, $9C, $81, $A6, $BB,
$CD, $D0, $F7, $EA, $B9, $A4, $83, $9E,
$25, $38, $1F, $02, $51, $4C, $6B, $76,
$87, $9A, $BD, $A0, $F3, $EE, $C9, $D4,
$6F, $72, $55, $48, $1B, $06, $21, $3C,
$4A, $57, $70, $6D, $3E, $23, $04, $19,
$A2, $BF, $98, $85, $D6, $CB, $EC, $F1,
$13, $0E, $29, $34, $67, $7A, $5D, $40,
$FB, $E6, $C1, $DC, $8F, $92, $B5, $A8,
$DE, $C3, $E4, $F9, $AA, $B7, $90, $8D,
$36, $2B, $0C, $11, $42, $5F, $78, $65,
$94, $89, $AE, $B3, $E0, $FD, $DA, $C7,
$7C, $61, $46, $5B, $08, $15, $32, $2F,
$59, $44, $63, $7E, $2D, $30, $17, $0A,
$B1, $AC, $8B, $96, $C5, $D8, $FF, $E2,
$26, $3B, $1C, $01, $52, $4F, $68, $75,
$CE, $D3, $F4, $E9, $BA, $A7, $80, $9D,
$EB, $F6, $D1, $CC, $9F, $82, $A5, $B8,
$03, $1E, $39, $24, $77, $6A, $4D, $50,
$A1, $BC, $9B, $86, $D5, $C8, $EF, $F2,
$49, $54, $73, $6E, $3D, $20, $07, $1A,
$6C, $71, $56, $4B, $18, $05, $22, $3F,
$84, $99, $BE, $A3, $F0, $ED, $CA, $D7,
$35, $28, $0F, $12, $41, $5C, $7B, $66,
$DD, $C0, $E7, $FA, $A9, $B4, $93, $8E,
$F8, $E5, $C2, $DF, $8C, $91, $B6, $AB,
$10, $0D, $2A, $37, $64, $79, $5E, $43,
$B2, $AF, $88, $95, $C6, $DB, $FC, $E1,
$5A, $47, $60, $7D, $2E, $33, $14, $09,
$7F, $62, $45, $58, $0B, $16, $31, $2C,
$97, $8A, $AD, $B0, $E3, $FE, $D9, $C4
);

constructor THasherCRC8_MIFAREMAD.Create;
begin
  inherited Create;
  FHash :=  $C7;
  Check := '99';
end;

procedure THasherCRC8_MIFAREMAD.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 8) xor Table[(Msg^ xor FHash) and $FF];	
    Inc(Msg);
  end;   
end;

function THasherCRC8_MIFAREMAD.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 MIFARE-MAD', THasherCRC8_MIFAREMAD);

end.
