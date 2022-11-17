unit CRC8_TECH3250;
//CRC-8 TECH-3250
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC8_TECH3250 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $64, $C8, $AC, $E1, $85, $29, $4D,
$B3, $D7, $7B, $1F, $52, $36, $9A, $FE,
$17, $73, $DF, $BB, $F6, $92, $3E, $5A,
$A4, $C0, $6C, $08, $45, $21, $8D, $E9,
$2E, $4A, $E6, $82, $CF, $AB, $07, $63,
$9D, $F9, $55, $31, $7C, $18, $B4, $D0,
$39, $5D, $F1, $95, $D8, $BC, $10, $74,
$8A, $EE, $42, $26, $6B, $0F, $A3, $C7,
$5C, $38, $94, $F0, $BD, $D9, $75, $11,
$EF, $8B, $27, $43, $0E, $6A, $C6, $A2,
$4B, $2F, $83, $E7, $AA, $CE, $62, $06,
$F8, $9C, $30, $54, $19, $7D, $D1, $B5,
$72, $16, $BA, $DE, $93, $F7, $5B, $3F,
$C1, $A5, $09, $6D, $20, $44, $E8, $8C,
$65, $01, $AD, $C9, $84, $E0, $4C, $28,
$D6, $B2, $1E, $7A, $37, $53, $FF, $9B,
$B8, $DC, $70, $14, $59, $3D, $91, $F5,
$0B, $6F, $C3, $A7, $EA, $8E, $22, $46,
$AF, $CB, $67, $03, $4E, $2A, $86, $E2,
$1C, $78, $D4, $B0, $FD, $99, $35, $51,
$96, $F2, $5E, $3A, $77, $13, $BF, $DB,
$25, $41, $ED, $89, $C4, $A0, $0C, $68,
$81, $E5, $49, $2D, $60, $04, $A8, $CC,
$32, $56, $FA, $9E, $D3, $B7, $1B, $7F,
$E4, $80, $2C, $48, $05, $61, $CD, $A9,
$57, $33, $9F, $FB, $B6, $D2, $7E, $1A,
$F3, $97, $3B, $5F, $12, $76, $DA, $BE,
$40, $24, $88, $EC, $A1, $C5, $69, $0D,
$CA, $AE, $02, $66, $2B, $4F, $E3, $87,
$79, $1D, $B1, $D5, $98, $FC, $50, $34,
$DD, $B9, $15, $71, $3C, $58, $F4, $90,
$6E, $0A, $A6, $C2, $8F, $EB, $47, $23
);

constructor THasherCRC8_TECH3250.Create;
begin
  inherited Create;
  FHash :=  $FF;
  Check := '97';
end;

procedure THasherCRC8_TECH3250.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC8_TECH3250.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 TECH-3250', THasherCRC8_TECH3250);

end.
