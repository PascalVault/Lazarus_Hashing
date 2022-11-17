unit CRC8_ROHC;
//CRC-8 ROHC
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC8_ROHC = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $91, $E3, $72, $07, $96, $E4, $75,
$0E, $9F, $ED, $7C, $09, $98, $EA, $7B,
$1C, $8D, $FF, $6E, $1B, $8A, $F8, $69,
$12, $83, $F1, $60, $15, $84, $F6, $67,
$38, $A9, $DB, $4A, $3F, $AE, $DC, $4D,
$36, $A7, $D5, $44, $31, $A0, $D2, $43,
$24, $B5, $C7, $56, $23, $B2, $C0, $51,
$2A, $BB, $C9, $58, $2D, $BC, $CE, $5F,
$70, $E1, $93, $02, $77, $E6, $94, $05,
$7E, $EF, $9D, $0C, $79, $E8, $9A, $0B,
$6C, $FD, $8F, $1E, $6B, $FA, $88, $19,
$62, $F3, $81, $10, $65, $F4, $86, $17,
$48, $D9, $AB, $3A, $4F, $DE, $AC, $3D,
$46, $D7, $A5, $34, $41, $D0, $A2, $33,
$54, $C5, $B7, $26, $53, $C2, $B0, $21,
$5A, $CB, $B9, $28, $5D, $CC, $BE, $2F,
$E0, $71, $03, $92, $E7, $76, $04, $95,
$EE, $7F, $0D, $9C, $E9, $78, $0A, $9B,
$FC, $6D, $1F, $8E, $FB, $6A, $18, $89,
$F2, $63, $11, $80, $F5, $64, $16, $87,
$D8, $49, $3B, $AA, $DF, $4E, $3C, $AD,
$D6, $47, $35, $A4, $D1, $40, $32, $A3,
$C4, $55, $27, $B6, $C3, $52, $20, $B1,
$CA, $5B, $29, $B8, $CD, $5C, $2E, $BF,
$90, $01, $73, $E2, $97, $06, $74, $E5,
$9E, $0F, $7D, $EC, $99, $08, $7A, $EB,
$8C, $1D, $6F, $FE, $8B, $1A, $68, $F9,
$82, $13, $61, $F0, $85, $14, $66, $F7,
$A8, $39, $4B, $DA, $AF, $3E, $4C, $DD,
$A6, $37, $45, $D4, $A1, $30, $42, $D3,
$B4, $25, $57, $C6, $B3, $22, $50, $C1,
$BA, $2B, $59, $C8, $BD, $2C, $5E, $CF
);

constructor THasherCRC8_ROHC.Create;
begin
  inherited Create;
  FHash :=  $FF;
  Check := 'D0';
end;

procedure THasherCRC8_ROHC.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC8_ROHC.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 ROHC', THasherCRC8_ROHC);

end.
