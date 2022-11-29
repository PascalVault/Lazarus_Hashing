unit CRC6_CDMA2000B;
//CRC-6/CDMA2000-B
//Author: domasz
//Last Update: 2022-11-29
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC6_CDMA2000B = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $1C, $38, $24, $70, $6C, $48, $54, $E0, $FC, $D8, $C4, $90, $8C, $A8, $B4, 
$DC, $C0, $E4, $F8, $AC, $B0, $94, $88, $3C, $20, $04, $18, $4C, $50, $74, $68, 
$A4, $B8, $9C, $80, $D4, $C8, $EC, $F0, $44, $58, $7C, $60, $34, $28, $0C, $10, 
$78, $64, $40, $5C, $08, $14, $30, $2C, $98, $84, $A0, $BC, $E8, $F4, $D0, $CC, 
$54, $48, $6C, $70, $24, $38, $1C, $00, $B4, $A8, $8C, $90, $C4, $D8, $FC, $E0, 
$88, $94, $B0, $AC, $F8, $E4, $C0, $DC, $68, $74, $50, $4C, $18, $04, $20, $3C, 
$F0, $EC, $C8, $D4, $80, $9C, $B8, $A4, $10, $0C, $28, $34, $60, $7C, $58, $44, 
$2C, $30, $14, $08, $5C, $40, $64, $78, $CC, $D0, $F4, $E8, $BC, $A0, $84, $98, 
$A8, $B4, $90, $8C, $D8, $C4, $E0, $FC, $48, $54, $70, $6C, $38, $24, $00, $1C, 
$74, $68, $4C, $50, $04, $18, $3C, $20, $94, $88, $AC, $B0, $E4, $F8, $DC, $C0, 
$0C, $10, $34, $28, $7C, $60, $44, $58, $EC, $F0, $D4, $C8, $9C, $80, $A4, $B8, 
$D0, $CC, $E8, $F4, $A0, $BC, $98, $84, $30, $2C, $08, $14, $40, $5C, $78, $64, 
$FC, $E0, $C4, $D8, $8C, $90, $B4, $A8, $1C, $00, $24, $38, $6C, $70, $54, $48, 
$20, $3C, $18, $04, $50, $4C, $68, $74, $C0, $DC, $F8, $E4, $B0, $AC, $88, $94, 
$58, $44, $60, $7C, $28, $34, $10, $0C, $B8, $A4, $80, $9C, $C8, $D4, $F0, $EC, 
$84, $98, $BC, $A0, $F4, $E8, $CC, $D0, $64, $78, $5C, $40, $14, $08, $2C, $30
);

constructor THasherCRC6_CDMA2000B.Create;
begin
  inherited Create;
  FHash :=  $3F;
  Check := '3B';

  FHash := FHash shl 2;
end;

procedure THasherCRC6_CDMA2000B.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[FHash xor Msg^] ;

    Inc(Msg);
  end;   
end;

function THasherCRC6_CDMA2000B.Final: String;
begin
  FHash := FHash shr 2;

  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-6/CDMA2000-B', THasherCRC6_CDMA2000B);

end.
