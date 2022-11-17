unit CRC8_DVBS2;
//CRC-8 DVB-S2
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC8_DVBS2 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $D5, $7F, $AA, $FE, $2B, $81, $54,
$29, $FC, $56, $83, $D7, $02, $A8, $7D,
$52, $87, $2D, $F8, $AC, $79, $D3, $06,
$7B, $AE, $04, $D1, $85, $50, $FA, $2F,
$A4, $71, $DB, $0E, $5A, $8F, $25, $F0,
$8D, $58, $F2, $27, $73, $A6, $0C, $D9,
$F6, $23, $89, $5C, $08, $DD, $77, $A2,
$DF, $0A, $A0, $75, $21, $F4, $5E, $8B,
$9D, $48, $E2, $37, $63, $B6, $1C, $C9,
$B4, $61, $CB, $1E, $4A, $9F, $35, $E0,
$CF, $1A, $B0, $65, $31, $E4, $4E, $9B,
$E6, $33, $99, $4C, $18, $CD, $67, $B2,
$39, $EC, $46, $93, $C7, $12, $B8, $6D,
$10, $C5, $6F, $BA, $EE, $3B, $91, $44,
$6B, $BE, $14, $C1, $95, $40, $EA, $3F,
$42, $97, $3D, $E8, $BC, $69, $C3, $16,
$EF, $3A, $90, $45, $11, $C4, $6E, $BB,
$C6, $13, $B9, $6C, $38, $ED, $47, $92,
$BD, $68, $C2, $17, $43, $96, $3C, $E9,
$94, $41, $EB, $3E, $6A, $BF, $15, $C0,
$4B, $9E, $34, $E1, $B5, $60, $CA, $1F,
$62, $B7, $1D, $C8, $9C, $49, $E3, $36,
$19, $CC, $66, $B3, $E7, $32, $98, $4D,
$30, $E5, $4F, $9A, $CE, $1B, $B1, $64,
$72, $A7, $0D, $D8, $8C, $59, $F3, $26,
$5B, $8E, $24, $F1, $A5, $70, $DA, $0F,
$20, $F5, $5F, $8A, $DE, $0B, $A1, $74,
$09, $DC, $76, $A3, $F7, $22, $88, $5D,
$D6, $03, $A9, $7C, $28, $FD, $57, $82,
$FF, $2A, $80, $55, $01, $D4, $7E, $AB,
$84, $51, $FB, $2E, $7A, $AF, $05, $D0,
$AD, $78, $D2, $07, $53, $86, $2C, $F9
);

constructor THasherCRC8_DVBS2.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := 'BC';
end;

procedure THasherCRC8_DVBS2.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 8) xor Table[(Msg^ xor FHash) and $FF];	
    Inc(Msg);
  end;   
end;

function THasherCRC8_DVBS2.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 DVB-S2', THasherCRC8_DVBS2);

end.
