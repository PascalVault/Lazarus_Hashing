unit CRC64_go;
//CRC-64 GO
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC64_go = class(THasherBase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of QWord = (
$0000000000000000, $01B0000000000000, $0360000000000000, $02D0000000000000, $06C0000000000000, $0770000000000000, $05A0000000000000, $0410000000000000,
$0D80000000000000, $0C30000000000000, $0EE0000000000000, $0F50000000000000, $0B40000000000000, $0AF0000000000000, $0820000000000000, $0990000000000000,
$1B00000000000000, $1AB0000000000000, $1860000000000000, $19D0000000000000, $1DC0000000000000, $1C70000000000000, $1EA0000000000000, $1F10000000000000,
$1680000000000000, $1730000000000000, $15E0000000000000, $1450000000000000, $1040000000000000, $11F0000000000000, $1320000000000000, $1290000000000000,
$3600000000000000, $37B0000000000000, $3560000000000000, $34D0000000000000, $30C0000000000000, $3170000000000000, $33A0000000000000, $3210000000000000,
$3B80000000000000, $3A30000000000000, $38E0000000000000, $3950000000000000, $3D40000000000000, $3CF0000000000000, $3E20000000000000, $3F90000000000000,
$2D00000000000000, $2CB0000000000000, $2E60000000000000, $2FD0000000000000, $2BC0000000000000, $2A70000000000000, $28A0000000000000, $2910000000000000,
$2080000000000000, $2130000000000000, $23E0000000000000, $2250000000000000, $2640000000000000, $27F0000000000000, $2520000000000000, $2490000000000000,
$6C00000000000000, $6DB0000000000000, $6F60000000000000, $6ED0000000000000, $6AC0000000000000, $6B70000000000000, $69A0000000000000, $6810000000000000,
$6180000000000000, $6030000000000000, $62E0000000000000, $6350000000000000, $6740000000000000, $66F0000000000000, $6420000000000000, $6590000000000000,
$7700000000000000, $76B0000000000000, $7460000000000000, $75D0000000000000, $71C0000000000000, $7070000000000000, $72A0000000000000, $7310000000000000,
$7A80000000000000, $7B30000000000000, $79E0000000000000, $7850000000000000, $7C40000000000000, $7DF0000000000000, $7F20000000000000, $7E90000000000000,
$5A00000000000000, $5BB0000000000000, $5960000000000000, $58D0000000000000, $5CC0000000000000, $5D70000000000000, $5FA0000000000000, $5E10000000000000,
$5780000000000000, $5630000000000000, $54E0000000000000, $5550000000000000, $5140000000000000, $50F0000000000000, $5220000000000000, $5390000000000000,
$4100000000000000, $40B0000000000000, $4260000000000000, $43D0000000000000, $47C0000000000000, $4670000000000000, $44A0000000000000, $4510000000000000,
$4C80000000000000, $4D30000000000000, $4FE0000000000000, $4E50000000000000, $4A40000000000000, $4BF0000000000000, $4920000000000000, $4890000000000000,
$D800000000000000, $D9B0000000000000, $DB60000000000000, $DAD0000000000000, $DEC0000000000000, $DF70000000000000, $DDA0000000000000, $DC10000000000000,
$D580000000000000, $D430000000000000, $D6E0000000000000, $D750000000000000, $D340000000000000, $D2F0000000000000, $D020000000000000, $D190000000000000,
$C300000000000000, $C2B0000000000000, $C060000000000000, $C1D0000000000000, $C5C0000000000000, $C470000000000000, $C6A0000000000000, $C710000000000000,
$CE80000000000000, $CF30000000000000, $CDE0000000000000, $CC50000000000000, $C840000000000000, $C9F0000000000000, $CB20000000000000, $CA90000000000000,
$EE00000000000000, $EFB0000000000000, $ED60000000000000, $ECD0000000000000, $E8C0000000000000, $E970000000000000, $EBA0000000000000, $EA10000000000000,
$E380000000000000, $E230000000000000, $E0E0000000000000, $E150000000000000, $E540000000000000, $E4F0000000000000, $E620000000000000, $E790000000000000,
$F500000000000000, $F4B0000000000000, $F660000000000000, $F7D0000000000000, $F3C0000000000000, $F270000000000000, $F0A0000000000000, $F110000000000000,
$F880000000000000, $F930000000000000, $FBE0000000000000, $FA50000000000000, $FE40000000000000, $FFF0000000000000, $FD20000000000000, $FC90000000000000,
$B400000000000000, $B5B0000000000000, $B760000000000000, $B6D0000000000000, $B2C0000000000000, $B370000000000000, $B1A0000000000000, $B010000000000000,
$B980000000000000, $B830000000000000, $BAE0000000000000, $BB50000000000000, $BF40000000000000, $BEF0000000000000, $BC20000000000000, $BD90000000000000,
$AF00000000000000, $AEB0000000000000, $AC60000000000000, $ADD0000000000000, $A9C0000000000000, $A870000000000000, $AAA0000000000000, $AB10000000000000,
$A280000000000000, $A330000000000000, $A1E0000000000000, $A050000000000000, $A440000000000000, $A5F0000000000000, $A720000000000000, $A690000000000000,
$8200000000000000, $83B0000000000000, $8160000000000000, $80D0000000000000, $84C0000000000000, $8570000000000000, $87A0000000000000, $8610000000000000,
$8F80000000000000, $8E30000000000000, $8CE0000000000000, $8D50000000000000, $8940000000000000, $88F0000000000000, $8A20000000000000, $8B90000000000000,
$9900000000000000, $98B0000000000000, $9A60000000000000, $9BD0000000000000, $9FC0000000000000, $9E70000000000000, $9CA0000000000000, $9D10000000000000,
$9480000000000000, $9530000000000000, $97E0000000000000, $9650000000000000, $9240000000000000, $93F0000000000000, $9120000000000000, $9090000000000000 
);

constructor THasherCRC64_go.Create;
begin
  inherited Create;
  FHash :=  $FFFFFFFFFFFFFFFF;
  Check := 'B90956C775A41001';
end;

procedure THasherCRC64_go.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Index: Cardinal;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shr 8) xor Table[Byte(FHash) xor Msg^];
    Inc(Msg);
  end;   
end;

function THasherCRC64_go.Final: String;
begin
  FHash := FHash xor $FFFFFFFFFFFFFFFF;
  Result := IntToHex(FHash, 16); 
end;

initialization
  HasherList.RegisterHasher('CRC-64 go', THasherCRC64_go);

end.
