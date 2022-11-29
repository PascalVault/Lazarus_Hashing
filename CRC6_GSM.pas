unit CRC6_GSM;
//CRC-6/GSM
//Author: domasz
//Last Update: 2022-11-29
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC6_GSM = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $BC, $C4, $78, $34, $88, $F0, $4C, $68, $D4, $AC, $10, $5C, $E0, $98, $24, 
$D0, $6C, $14, $A8, $E4, $58, $20, $9C, $B8, $04, $7C, $C0, $8C, $30, $48, $F4, 
$1C, $A0, $D8, $64, $28, $94, $EC, $50, $74, $C8, $B0, $0C, $40, $FC, $84, $38, 
$CC, $70, $08, $B4, $F8, $44, $3C, $80, $A4, $18, $60, $DC, $90, $2C, $54, $E8, 
$38, $84, $FC, $40, $0C, $B0, $C8, $74, $50, $EC, $94, $28, $64, $D8, $A0, $1C, 
$E8, $54, $2C, $90, $DC, $60, $18, $A4, $80, $3C, $44, $F8, $B4, $08, $70, $CC, 
$24, $98, $E0, $5C, $10, $AC, $D4, $68, $4C, $F0, $88, $34, $78, $C4, $BC, $00, 
$F4, $48, $30, $8C, $C0, $7C, $04, $B8, $9C, $20, $58, $E4, $A8, $14, $6C, $D0, 
$70, $CC, $B4, $08, $44, $F8, $80, $3C, $18, $A4, $DC, $60, $2C, $90, $E8, $54, 
$A0, $1C, $64, $D8, $94, $28, $50, $EC, $C8, $74, $0C, $B0, $FC, $40, $38, $84, 
$6C, $D0, $A8, $14, $58, $E4, $9C, $20, $04, $B8, $C0, $7C, $30, $8C, $F4, $48, 
$BC, $00, $78, $C4, $88, $34, $4C, $F0, $D4, $68, $10, $AC, $E0, $5C, $24, $98, 
$48, $F4, $8C, $30, $7C, $C0, $B8, $04, $20, $9C, $E4, $58, $14, $A8, $D0, $6C, 
$98, $24, $5C, $E0, $AC, $10, $68, $D4, $F0, $4C, $34, $88, $C4, $78, $00, $BC, 
$54, $E8, $90, $2C, $60, $DC, $A4, $18, $3C, $80, $F8, $44, $08, $B4, $CC, $70, 
$84, $38, $40, $FC, $B0, $0C, $74, $C8, $EC, $50, $28, $94, $D8, $64, $1C, $A0
);

constructor THasherCRC6_GSM.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '13';

  FHash := FHash shl 2;
end;

procedure THasherCRC6_GSM.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[FHash xor Msg^] ;

    Inc(Msg);
  end;   
end;

function THasherCRC6_GSM.Final: String;
begin
  FHash := FHash shr 2;
  FHash := FHash xor $3F;

  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-6/GSM', THasherCRC6_GSM);

end.
