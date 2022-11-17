unit CRC8_LTE;
//CRC-8 LTE
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC8_LTE = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $9B, $AD, $36, $C1, $5A, $6C, $F7,
$19, $82, $B4, $2F, $D8, $43, $75, $EE,
$32, $A9, $9F, $04, $F3, $68, $5E, $C5,
$2B, $B0, $86, $1D, $EA, $71, $47, $DC,
$64, $FF, $C9, $52, $A5, $3E, $08, $93,
$7D, $E6, $D0, $4B, $BC, $27, $11, $8A,
$56, $CD, $FB, $60, $97, $0C, $3A, $A1,
$4F, $D4, $E2, $79, $8E, $15, $23, $B8,
$C8, $53, $65, $FE, $09, $92, $A4, $3F,
$D1, $4A, $7C, $E7, $10, $8B, $BD, $26,
$FA, $61, $57, $CC, $3B, $A0, $96, $0D,
$E3, $78, $4E, $D5, $22, $B9, $8F, $14,
$AC, $37, $01, $9A, $6D, $F6, $C0, $5B,
$B5, $2E, $18, $83, $74, $EF, $D9, $42,
$9E, $05, $33, $A8, $5F, $C4, $F2, $69,
$87, $1C, $2A, $B1, $46, $DD, $EB, $70,
$0B, $90, $A6, $3D, $CA, $51, $67, $FC,
$12, $89, $BF, $24, $D3, $48, $7E, $E5,
$39, $A2, $94, $0F, $F8, $63, $55, $CE,
$20, $BB, $8D, $16, $E1, $7A, $4C, $D7,
$6F, $F4, $C2, $59, $AE, $35, $03, $98,
$76, $ED, $DB, $40, $B7, $2C, $1A, $81,
$5D, $C6, $F0, $6B, $9C, $07, $31, $AA,
$44, $DF, $E9, $72, $85, $1E, $28, $B3,
$C3, $58, $6E, $F5, $02, $99, $AF, $34,
$DA, $41, $77, $EC, $1B, $80, $B6, $2D,
$F1, $6A, $5C, $C7, $30, $AB, $9D, $06,
$E8, $73, $45, $DE, $29, $B2, $84, $1F,
$A7, $3C, $0A, $91, $66, $FD, $CB, $50,
$BE, $25, $13, $88, $7F, $E4, $D2, $49,
$95, $0E, $38, $A3, $54, $CF, $F9, $62,
$8C, $17, $21, $BA, $4D, $D6, $E0, $7B
);

constructor THasherCRC8_LTE.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := 'EA';
end;

procedure THasherCRC8_LTE.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 8) xor Table[(Msg^ xor FHash) and $FF];	
    Inc(Msg);
  end;   
end;

function THasherCRC8_LTE.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 LTE', THasherCRC8_LTE);

end.
