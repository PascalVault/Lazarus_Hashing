unit CRC6_CDMA2000A;
//CRC-6/CDMA2000-A
//Author: domasz
//Last Update: 2022-11-29
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC6_CDMA2000A = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $9C, $A4, $38, $D4, $48, $70, $EC, $34, $A8, $90, $0C, $E0, $7C, $44, $D8,
$68, $F4, $CC, $50, $BC, $20, $18, $84, $5C, $C0, $F8, $64, $88, $14, $2C, $B0,
$D0, $4C, $74, $E8, $04, $98, $A0, $3C, $E4, $78, $40, $DC, $30, $AC, $94, $08,
$B8, $24, $1C, $80, $6C, $F0, $C8, $54, $8C, $10, $28, $B4, $58, $C4, $FC, $60,
$3C, $A0, $98, $04, $E8, $74, $4C, $D0, $08, $94, $AC, $30, $DC, $40, $78, $E4,
$54, $C8, $F0, $6C, $80, $1C, $24, $B8, $60, $FC, $C4, $58, $B4, $28, $10, $8C,
$EC, $70, $48, $D4, $38, $A4, $9C, $00, $D8, $44, $7C, $E0, $0C, $90, $A8, $34,
$84, $18, $20, $BC, $50, $CC, $F4, $68, $B0, $2C, $14, $88, $64, $F8, $C0, $5C,
$78, $E4, $DC, $40, $AC, $30, $08, $94, $4C, $D0, $E8, $74, $98, $04, $3C, $A0,
$10, $8C, $B4, $28, $C4, $58, $60, $FC, $24, $B8, $80, $1C, $F0, $6C, $54, $C8,
$A8, $34, $0C, $90, $7C, $E0, $D8, $44, $9C, $00, $38, $A4, $48, $D4, $EC, $70,
$C0, $5C, $64, $F8, $14, $88, $B0, $2C, $F4, $68, $50, $CC, $20, $BC, $84, $18,
$44, $D8, $E0, $7C, $90, $0C, $34, $A8, $70, $EC, $D4, $48, $A4, $38, $00, $9C,
$2C, $B0, $88, $14, $F8, $64, $5C, $C0, $18, $84, $BC, $20, $CC, $50, $68, $F4,
$94, $08, $30, $AC, $40, $DC, $E4, $78, $A0, $3C, $04, $98, $74, $E8, $D0, $4C,
$FC, $60, $58, $C4, $28, $B4, $8C, $10, $C8, $54, $6C, $F0, $1C, $80, $B8, $24
);

constructor THasherCRC6_CDMA2000A.Create;
begin
  inherited Create;
  FHash :=  $3F;
  Check := '0D';

  FHash := FHash shl 2;
end;

procedure THasherCRC6_CDMA2000A.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[FHash xor Msg^] ;

    Inc(Msg);
  end;   
end;

function THasherCRC6_CDMA2000A.Final: String;
begin
  FHash := FHash shr 2;

  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-6/CDMA2000-A', THasherCRC6_CDMA2000A);

end.
