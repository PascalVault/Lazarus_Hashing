unit CRC8_BLUETOOTH;
//CRC-8 BLUETOOTH
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC8_BLUETOOTH = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $6B, $D6, $BD, $67, $0C, $B1, $DA,
$CE, $A5, $18, $73, $A9, $C2, $7F, $14,
$57, $3C, $81, $EA, $30, $5B, $E6, $8D,
$99, $F2, $4F, $24, $FE, $95, $28, $43,
$AE, $C5, $78, $13, $C9, $A2, $1F, $74,
$60, $0B, $B6, $DD, $07, $6C, $D1, $BA,
$F9, $92, $2F, $44, $9E, $F5, $48, $23,
$37, $5C, $E1, $8A, $50, $3B, $86, $ED,
$97, $FC, $41, $2A, $F0, $9B, $26, $4D,
$59, $32, $8F, $E4, $3E, $55, $E8, $83,
$C0, $AB, $16, $7D, $A7, $CC, $71, $1A,
$0E, $65, $D8, $B3, $69, $02, $BF, $D4,
$39, $52, $EF, $84, $5E, $35, $88, $E3,
$F7, $9C, $21, $4A, $90, $FB, $46, $2D,
$6E, $05, $B8, $D3, $09, $62, $DF, $B4,
$A0, $CB, $76, $1D, $C7, $AC, $11, $7A,
$E5, $8E, $33, $58, $82, $E9, $54, $3F,
$2B, $40, $FD, $96, $4C, $27, $9A, $F1,
$B2, $D9, $64, $0F, $D5, $BE, $03, $68,
$7C, $17, $AA, $C1, $1B, $70, $CD, $A6,
$4B, $20, $9D, $F6, $2C, $47, $FA, $91,
$85, $EE, $53, $38, $E2, $89, $34, $5F,
$1C, $77, $CA, $A1, $7B, $10, $AD, $C6,
$D2, $B9, $04, $6F, $B5, $DE, $63, $08,
$72, $19, $A4, $CF, $15, $7E, $C3, $A8,
$BC, $D7, $6A, $01, $DB, $B0, $0D, $66,
$25, $4E, $F3, $98, $42, $29, $94, $FF,
$EB, $80, $3D, $56, $8C, $E7, $5A, $31,
$DC, $B7, $0A, $61, $BB, $D0, $6D, $06,
$12, $79, $C4, $AF, $75, $1E, $A3, $C8,
$8B, $E0, $5D, $36, $EC, $87, $3A, $51,
$45, $2E, $93, $F8, $22, $49, $F4, $9F
);

constructor THasherCRC8_BLUETOOTH.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '26';
end;

  procedure THasherCRC8_BLUETOOTH.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC8_BLUETOOTH.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 BLUETOOTH', THasherCRC8_BLUETOOTH);

end.
