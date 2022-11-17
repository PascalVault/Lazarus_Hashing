unit CRC8_MAXIMDOW;
//CRC-8 MAXIM-DOW
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC8_MAXIMDOW = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $5E, $BC, $E2, $61, $3F, $DD, $83,
$C2, $9C, $7E, $20, $A3, $FD, $1F, $41,
$9D, $C3, $21, $7F, $FC, $A2, $40, $1E,
$5F, $01, $E3, $BD, $3E, $60, $82, $DC,
$23, $7D, $9F, $C1, $42, $1C, $FE, $A0,
$E1, $BF, $5D, $03, $80, $DE, $3C, $62,
$BE, $E0, $02, $5C, $DF, $81, $63, $3D,
$7C, $22, $C0, $9E, $1D, $43, $A1, $FF,
$46, $18, $FA, $A4, $27, $79, $9B, $C5,
$84, $DA, $38, $66, $E5, $BB, $59, $07,
$DB, $85, $67, $39, $BA, $E4, $06, $58,
$19, $47, $A5, $FB, $78, $26, $C4, $9A,
$65, $3B, $D9, $87, $04, $5A, $B8, $E6,
$A7, $F9, $1B, $45, $C6, $98, $7A, $24,
$F8, $A6, $44, $1A, $99, $C7, $25, $7B,
$3A, $64, $86, $D8, $5B, $05, $E7, $B9,
$8C, $D2, $30, $6E, $ED, $B3, $51, $0F,
$4E, $10, $F2, $AC, $2F, $71, $93, $CD,
$11, $4F, $AD, $F3, $70, $2E, $CC, $92,
$D3, $8D, $6F, $31, $B2, $EC, $0E, $50,
$AF, $F1, $13, $4D, $CE, $90, $72, $2C,
$6D, $33, $D1, $8F, $0C, $52, $B0, $EE,
$32, $6C, $8E, $D0, $53, $0D, $EF, $B1,
$F0, $AE, $4C, $12, $91, $CF, $2D, $73,
$CA, $94, $76, $28, $AB, $F5, $17, $49,
$08, $56, $B4, $EA, $69, $37, $D5, $8B,
$57, $09, $EB, $B5, $36, $68, $8A, $D4,
$95, $CB, $29, $77, $F4, $AA, $48, $16,
$E9, $B7, $55, $0B, $88, $D6, $34, $6A,
$2B, $75, $97, $C9, $4A, $14, $F6, $A8,
$74, $2A, $C8, $96, $15, $4B, $A9, $F7,
$B6, $E8, $0A, $54, $D7, $89, $6B, $35
);

constructor THasherCRC8_MAXIMDOW.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := 'A1';
end;

procedure THasherCRC8_MAXIMDOW.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC8_MAXIMDOW.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-8 MAXIM-DOW', THasherCRC8_MAXIMDOW);

end.
