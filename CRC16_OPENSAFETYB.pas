unit CRC16_OPENSAFETYB;
//CRC-16 OPENSAFETY-B
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_OPENSAFETYB = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $755B, $EAB6, $9FED, $A037, $D56C, $4A81, $3FDA,
$3535, $406E, $DF83, $AAD8, $9502, $E059, $7FB4, $0AEF,
$6A6A, $1F31, $80DC, $F587, $CA5D, $BF06, $20EB, $55B0,
$5F5F, $2A04, $B5E9, $C0B2, $FF68, $8A33, $15DE, $6085,
$D4D4, $A18F, $3E62, $4B39, $74E3, $01B8, $9E55, $EB0E,
$E1E1, $94BA, $0B57, $7E0C, $41D6, $348D, $AB60, $DE3B,
$BEBE, $CBE5, $5408, $2153, $1E89, $6BD2, $F43F, $8164,
$8B8B, $FED0, $613D, $1466, $2BBC, $5EE7, $C10A, $B451,
$DCF3, $A9A8, $3645, $431E, $7CC4, $099F, $9672, $E329,
$E9C6, $9C9D, $0370, $762B, $49F1, $3CAA, $A347, $D61C,
$B699, $C3C2, $5C2F, $2974, $16AE, $63F5, $FC18, $8943,
$83AC, $F6F7, $691A, $1C41, $239B, $56C0, $C92D, $BC76,
$0827, $7D7C, $E291, $97CA, $A810, $DD4B, $42A6, $37FD,
$3D12, $4849, $D7A4, $A2FF, $9D25, $E87E, $7793, $02C8,
$624D, $1716, $88FB, $FDA0, $C27A, $B721, $28CC, $5D97,
$5778, $2223, $BDCE, $C895, $F74F, $8214, $1DF9, $68A2,
$CCBD, $B9E6, $260B, $5350, $6C8A, $19D1, $863C, $F367,
$F988, $8CD3, $133E, $6665, $59BF, $2CE4, $B309, $C652,
$A6D7, $D38C, $4C61, $393A, $06E0, $73BB, $EC56, $990D,
$93E2, $E6B9, $7954, $0C0F, $33D5, $468E, $D963, $AC38,
$1869, $6D32, $F2DF, $8784, $B85E, $CD05, $52E8, $27B3,
$2D5C, $5807, $C7EA, $B2B1, $8D6B, $F830, $67DD, $1286,
$7203, $0758, $98B5, $EDEE, $D234, $A76F, $3882, $4DD9,
$4736, $326D, $AD80, $D8DB, $E701, $925A, $0DB7, $78EC,
$104E, $6515, $FAF8, $8FA3, $B079, $C522, $5ACF, $2F94,
$257B, $5020, $CFCD, $BA96, $854C, $F017, $6FFA, $1AA1,
$7A24, $0F7F, $9092, $E5C9, $DA13, $AF48, $30A5, $45FE,
$4F11, $3A4A, $A5A7, $D0FC, $EF26, $9A7D, $0590, $70CB,
$C49A, $B1C1, $2E2C, $5B77, $64AD, $11F6, $8E1B, $FB40,
$F1AF, $84F4, $1B19, $6E42, $5198, $24C3, $BB2E, $CE75,
$AEF0, $DBAB, $4446, $311D, $0EC7, $7B9C, $E471, $912A,
$9BC5, $EE9E, $7173, $0428, $3BF2, $4EA9, $D144, $A41F
);

constructor THasherCRC16_OPENSAFETYB.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := '20FE';
end;

procedure THasherCRC16_OPENSAFETYB.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_OPENSAFETYB.Final: String;
begin
  
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 OPENSAFETY-B', THasherCRC16_OPENSAFETYB);

end.
