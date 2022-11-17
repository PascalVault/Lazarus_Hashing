unit CRC8_GSMB;
//CRC-8 GSM-B
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC8_GSMB = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $49, $92, $DB, $6D, $24, $FF, $B6,
$DA, $93, $48, $01, $B7, $FE, $25, $6C,
$FD, $B4, $6F, $26, $90, $D9, $02, $4B,
$27, $6E, $B5, $FC, $4A, $03, $D8, $91,
$B3, $FA, $21, $68, $DE, $97, $4C, $05,
$69, $20, $FB, $B2, $04, $4D, $96, $DF,
$4E, $07, $DC, $95, $23, $6A, $B1, $F8,
$94, $DD, $06, $4F, $F9, $B0, $6B, $22,
$2F, $66, $BD, $F4, $42, $0B, $D0, $99,
$F5, $BC, $67, $2E, $98, $D1, $0A, $43,
$D2, $9B, $40, $09, $BF, $F6, $2D, $64,
$08, $41, $9A, $D3, $65, $2C, $F7, $BE,
$9C, $D5, $0E, $47, $F1, $B8, $63, $2A,
$46, $0F, $D4, $9D, $2B, $62, $B9, $F0,
$61, $28, $F3, $BA, $0C, $45, $9E, $D7,
$BB, $F2, $29, $60, $D6, $9F, $44, $0D,
$5E, $17, $CC, $85, $33, $7A, $A1, $E8,
$84, $CD, $16, $5F, $E9, $A0, $7B, $32,
$A3, $EA, $31, $78, $CE, $87, $5C, $15,
$79, $30, $EB, $A2, $14, $5D, $86, $CF,
$ED, $A4, $7F, $36, $80, $C9, $12, $5B,
$37, $7E, $A5, $EC, $5A, $13, $C8, $81,
$10, $59, $82, $CB, $7D, $34, $EF, $A6,
$CA, $83, $58, $11, $A7, $EE, $35, $7C,
$71, $38, $E3, $AA, $1C, $55, $8E, $C7,
$AB, $E2, $39, $70, $C6, $8F, $54, $1D,
$8C, $C5, $1E, $57, $E1, $A8, $73, $3A,
$56, $1F, $C4, $8D, $3B, $72, $A9, $E0,
$C2, $8B, $50, $19, $AF, $E6, $3D, $74,
$18, $51, $8A, $C3, $75, $3C, $E7, $AE,
$3F, $76, $AD, $E4, $52, $1B, $C0, $89,
$E5, $AC, $77, $3E, $88, $C1, $1A, $53
);

constructor THasherCRC8_GSMB.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '94';
end;

procedure THasherCRC8_GSMB.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 8) xor Table[(Msg^ xor FHash) and $FF];	
    Inc(Msg);
  end;   
end;

function THasherCRC8_GSMB.Final: String;
begin
  FHash := FHash xor $FF;
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 GSM-B', THasherCRC8_GSMB);

end.
