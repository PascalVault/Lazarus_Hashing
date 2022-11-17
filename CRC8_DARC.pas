unit CRC8_DARC;
//CRC-8 DARC
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC8_DARC = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $72, $E4, $96, $F1, $83, $15, $67,
$DB, $A9, $3F, $4D, $2A, $58, $CE, $BC,
$8F, $FD, $6B, $19, $7E, $0C, $9A, $E8,
$54, $26, $B0, $C2, $A5, $D7, $41, $33,
$27, $55, $C3, $B1, $D6, $A4, $32, $40,
$FC, $8E, $18, $6A, $0D, $7F, $E9, $9B,
$A8, $DA, $4C, $3E, $59, $2B, $BD, $CF,
$73, $01, $97, $E5, $82, $F0, $66, $14,
$4E, $3C, $AA, $D8, $BF, $CD, $5B, $29,
$95, $E7, $71, $03, $64, $16, $80, $F2,
$C1, $B3, $25, $57, $30, $42, $D4, $A6,
$1A, $68, $FE, $8C, $EB, $99, $0F, $7D,
$69, $1B, $8D, $FF, $98, $EA, $7C, $0E,
$B2, $C0, $56, $24, $43, $31, $A7, $D5,
$E6, $94, $02, $70, $17, $65, $F3, $81,
$3D, $4F, $D9, $AB, $CC, $BE, $28, $5A,
$9C, $EE, $78, $0A, $6D, $1F, $89, $FB,
$47, $35, $A3, $D1, $B6, $C4, $52, $20,
$13, $61, $F7, $85, $E2, $90, $06, $74,
$C8, $BA, $2C, $5E, $39, $4B, $DD, $AF,
$BB, $C9, $5F, $2D, $4A, $38, $AE, $DC,
$60, $12, $84, $F6, $91, $E3, $75, $07,
$34, $46, $D0, $A2, $C5, $B7, $21, $53,
$EF, $9D, $0B, $79, $1E, $6C, $FA, $88,
$D2, $A0, $36, $44, $23, $51, $C7, $B5,
$09, $7B, $ED, $9F, $F8, $8A, $1C, $6E,
$5D, $2F, $B9, $CB, $AC, $DE, $48, $3A,
$86, $F4, $62, $10, $77, $05, $93, $E1,
$F5, $87, $11, $63, $04, $76, $E0, $92,
$2E, $5C, $CA, $B8, $DF, $AD, $3B, $49,
$7A, $08, $9E, $EC, $8B, $F9, $6F, $1D,
$A1, $D3, $45, $37, $50, $22, $B4, $C6
);

constructor THasherCRC8_DARC.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '15';
end;

procedure THasherCRC8_DARC.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC8_DARC.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 DARC', THasherCRC8_DARC);

end.
