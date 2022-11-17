unit CRC16_DNP;
//CRC-16 DNP
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_DNP = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $365E, $6CBC, $5AE2, $D978, $EF26, $B5C4, $839A,
$FF89, $C9D7, $9335, $A56B, $26F1, $10AF, $4A4D, $7C13,
$B26B, $8435, $DED7, $E889, $6B13, $5D4D, $07AF, $31F1,
$4DE2, $7BBC, $215E, $1700, $949A, $A2C4, $F826, $CE78,
$29AF, $1FF1, $4513, $734D, $F0D7, $C689, $9C6B, $AA35,
$D626, $E078, $BA9A, $8CC4, $0F5E, $3900, $63E2, $55BC,
$9BC4, $AD9A, $F778, $C126, $42BC, $74E2, $2E00, $185E,
$644D, $5213, $08F1, $3EAF, $BD35, $8B6B, $D189, $E7D7,
$535E, $6500, $3FE2, $09BC, $8A26, $BC78, $E69A, $D0C4,
$ACD7, $9A89, $C06B, $F635, $75AF, $43F1, $1913, $2F4D,
$E135, $D76B, $8D89, $BBD7, $384D, $0E13, $54F1, $62AF,
$1EBC, $28E2, $7200, $445E, $C7C4, $F19A, $AB78, $9D26,
$7AF1, $4CAF, $164D, $2013, $A389, $95D7, $CF35, $F96B,
$8578, $B326, $E9C4, $DF9A, $5C00, $6A5E, $30BC, $06E2,
$C89A, $FEC4, $A426, $9278, $11E2, $27BC, $7D5E, $4B00,
$3713, $014D, $5BAF, $6DF1, $EE6B, $D835, $82D7, $B489,
$A6BC, $90E2, $CA00, $FC5E, $7FC4, $499A, $1378, $2526,
$5935, $6F6B, $3589, $03D7, $804D, $B613, $ECF1, $DAAF,
$14D7, $2289, $786B, $4E35, $CDAF, $FBF1, $A113, $974D,
$EB5E, $DD00, $87E2, $B1BC, $3226, $0478, $5E9A, $68C4,
$8F13, $B94D, $E3AF, $D5F1, $566B, $6035, $3AD7, $0C89,
$709A, $46C4, $1C26, $2A78, $A9E2, $9FBC, $C55E, $F300,
$3D78, $0B26, $51C4, $679A, $E400, $D25E, $88BC, $BEE2,
$C2F1, $F4AF, $AE4D, $9813, $1B89, $2DD7, $7735, $416B,
$F5E2, $C3BC, $995E, $AF00, $2C9A, $1AC4, $4026, $7678,
$0A6B, $3C35, $66D7, $5089, $D313, $E54D, $BFAF, $89F1,
$4789, $71D7, $2B35, $1D6B, $9EF1, $A8AF, $F24D, $C413,
$B800, $8E5E, $D4BC, $E2E2, $6178, $5726, $0DC4, $3B9A,
$DC4D, $EA13, $B0F1, $86AF, $0535, $336B, $6989, $5FD7,
$23C4, $159A, $4F78, $7926, $FABC, $CCE2, $9600, $A05E,
$6E26, $5878, $029A, $34C4, $B75E, $8100, $DBE2, $EDBC,
$91AF, $A7F1, $FD13, $CB4D, $48D7, $7E89, $246B, $1235
);

constructor THasherCRC16_DNP.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := 'EA82';
end;

procedure THasherCRC16_DNP.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shr 8) xor Table[(FHash xor Msg^) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_DNP.Final: String;
begin
  FHash := FHash xor $FFFF;
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 DNP', THasherCRC16_DNP);

end.
