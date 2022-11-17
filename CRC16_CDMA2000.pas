unit CRC16_CDMA2000;
//CRC-16 CDMA2000
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC16_CDMA2000 = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $C867, $58A9, $90CE, $B152, $7935, $E9FB, $219C,
$AAC3, $62A4, $F26A, $3A0D, $1B91, $D3F6, $4338, $8B5F,
$9DE1, $5586, $C548, $0D2F, $2CB3, $E4D4, $741A, $BC7D,
$3722, $FF45, $6F8B, $A7EC, $8670, $4E17, $DED9, $16BE,
$F3A5, $3BC2, $AB0C, $636B, $42F7, $8A90, $1A5E, $D239,
$5966, $9101, $01CF, $C9A8, $E834, $2053, $B09D, $78FA,
$6E44, $A623, $36ED, $FE8A, $DF16, $1771, $87BF, $4FD8,
$C487, $0CE0, $9C2E, $5449, $75D5, $BDB2, $2D7C, $E51B,
$2F2D, $E74A, $7784, $BFE3, $9E7F, $5618, $C6D6, $0EB1,
$85EE, $4D89, $DD47, $1520, $34BC, $FCDB, $6C15, $A472,
$B2CC, $7AAB, $EA65, $2202, $039E, $CBF9, $5B37, $9350,
$180F, $D068, $40A6, $88C1, $A95D, $613A, $F1F4, $3993,
$DC88, $14EF, $8421, $4C46, $6DDA, $A5BD, $3573, $FD14,
$764B, $BE2C, $2EE2, $E685, $C719, $0F7E, $9FB0, $57D7,
$4169, $890E, $19C0, $D1A7, $F03B, $385C, $A892, $60F5,
$EBAA, $23CD, $B303, $7B64, $5AF8, $929F, $0251, $CA36,
$5E5A, $963D, $06F3, $CE94, $EF08, $276F, $B7A1, $7FC6,
$F499, $3CFE, $AC30, $6457, $45CB, $8DAC, $1D62, $D505,
$C3BB, $0BDC, $9B12, $5375, $72E9, $BA8E, $2A40, $E227,
$6978, $A11F, $31D1, $F9B6, $D82A, $104D, $8083, $48E4,
$ADFF, $6598, $F556, $3D31, $1CAD, $D4CA, $4404, $8C63,
$073C, $CF5B, $5F95, $97F2, $B66E, $7E09, $EEC7, $26A0,
$301E, $F879, $68B7, $A0D0, $814C, $492B, $D9E5, $1182,
$9ADD, $52BA, $C274, $0A13, $2B8F, $E3E8, $7326, $BB41,
$7177, $B910, $29DE, $E1B9, $C025, $0842, $988C, $50EB,
$DBB4, $13D3, $831D, $4B7A, $6AE6, $A281, $324F, $FA28,
$EC96, $24F1, $B43F, $7C58, $5DC4, $95A3, $056D, $CD0A,
$4655, $8E32, $1EFC, $D69B, $F707, $3F60, $AFAE, $67C9,
$82D2, $4AB5, $DA7B, $121C, $3380, $FBE7, $6B29, $A34E,
$2811, $E076, $70B8, $B8DF, $9943, $5124, $C1EA, $098D,
$1F33, $D754, $479A, $8FFD, $AE61, $6606, $F6C8, $3EAF,
$B5F0, $7D97, $ED59, $253E, $04A2, $CCC5, $5C0B, $946C
);

constructor THasherCRC16_CDMA2000.Create;
begin
  inherited Create;
  FHash :=  $FFFF;
  Check := '4C06';
end;

procedure THasherCRC16_CDMA2000.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[((FHash shr 8) xor Msg^) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_CDMA2000.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 CDMA2000', THasherCRC16_CDMA2000);

end.
