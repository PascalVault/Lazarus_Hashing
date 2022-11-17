unit CRC8_WCDMA;
//CRC-8 WCDMA
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC8_WCDMA = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $D0, $13, $C3, $26, $F6, $35, $E5,
$4C, $9C, $5F, $8F, $6A, $BA, $79, $A9,
$98, $48, $8B, $5B, $BE, $6E, $AD, $7D,
$D4, $04, $C7, $17, $F2, $22, $E1, $31,
$83, $53, $90, $40, $A5, $75, $B6, $66,
$CF, $1F, $DC, $0C, $E9, $39, $FA, $2A,
$1B, $CB, $08, $D8, $3D, $ED, $2E, $FE,
$57, $87, $44, $94, $71, $A1, $62, $B2,
$B5, $65, $A6, $76, $93, $43, $80, $50,
$F9, $29, $EA, $3A, $DF, $0F, $CC, $1C,
$2D, $FD, $3E, $EE, $0B, $DB, $18, $C8,
$61, $B1, $72, $A2, $47, $97, $54, $84,
$36, $E6, $25, $F5, $10, $C0, $03, $D3,
$7A, $AA, $69, $B9, $5C, $8C, $4F, $9F,
$AE, $7E, $BD, $6D, $88, $58, $9B, $4B,
$E2, $32, $F1, $21, $C4, $14, $D7, $07,
$D9, $09, $CA, $1A, $FF, $2F, $EC, $3C,
$95, $45, $86, $56, $B3, $63, $A0, $70,
$41, $91, $52, $82, $67, $B7, $74, $A4,
$0D, $DD, $1E, $CE, $2B, $FB, $38, $E8,
$5A, $8A, $49, $99, $7C, $AC, $6F, $BF,
$16, $C6, $05, $D5, $30, $E0, $23, $F3,
$C2, $12, $D1, $01, $E4, $34, $F7, $27,
$8E, $5E, $9D, $4D, $A8, $78, $BB, $6B,
$6C, $BC, $7F, $AF, $4A, $9A, $59, $89,
$20, $F0, $33, $E3, $06, $D6, $15, $C5,
$F4, $24, $E7, $37, $D2, $02, $C1, $11,
$B8, $68, $AB, $7B, $9E, $4E, $8D, $5D,
$EF, $3F, $FC, $2C, $C9, $19, $DA, $0A,
$A3, $73, $B0, $60, $85, $55, $96, $46,
$77, $A7, $64, $B4, $51, $81, $42, $92,
$3B, $EB, $28, $F8, $1D, $CD, $0E, $DE
);

constructor THasherCRC8_WCDMA.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '25';
end;

procedure THasherCRC8_WCDMA.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC8_WCDMA.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 WCDMA', THasherCRC8_WCDMA);

end.
