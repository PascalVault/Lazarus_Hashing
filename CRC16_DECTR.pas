unit CRC16_DECTR;
//CRC-16 DECT-R
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_DECTR = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $0589, $0B12, $0E9B, $1624, $13AD, $1D36, $18BF,
$2C48, $29C1, $275A, $22D3, $3A6C, $3FE5, $317E, $34F7,
$5890, $5D19, $5382, $560B, $4EB4, $4B3D, $45A6, $402F,
$74D8, $7151, $7FCA, $7A43, $62FC, $6775, $69EE, $6C67,
$B120, $B4A9, $BA32, $BFBB, $A704, $A28D, $AC16, $A99F,
$9D68, $98E1, $967A, $93F3, $8B4C, $8EC5, $805E, $85D7,
$E9B0, $EC39, $E2A2, $E72B, $FF94, $FA1D, $F486, $F10F,
$C5F8, $C071, $CEEA, $CB63, $D3DC, $D655, $D8CE, $DD47,
$67C9, $6240, $6CDB, $6952, $71ED, $7464, $7AFF, $7F76,
$4B81, $4E08, $4093, $451A, $5DA5, $582C, $56B7, $533E,
$3F59, $3AD0, $344B, $31C2, $297D, $2CF4, $226F, $27E6,
$1311, $1698, $1803, $1D8A, $0535, $00BC, $0E27, $0BAE,
$D6E9, $D360, $DDFB, $D872, $C0CD, $C544, $CBDF, $CE56,
$FAA1, $FF28, $F1B3, $F43A, $EC85, $E90C, $E797, $E21E,
$8E79, $8BF0, $856B, $80E2, $985D, $9DD4, $934F, $96C6,
$A231, $A7B8, $A923, $ACAA, $B415, $B19C, $BF07, $BA8E,
$CF92, $CA1B, $C480, $C109, $D9B6, $DC3F, $D2A4, $D72D,
$E3DA, $E653, $E8C8, $ED41, $F5FE, $F077, $FEEC, $FB65,
$9702, $928B, $9C10, $9999, $8126, $84AF, $8A34, $8FBD,
$BB4A, $BEC3, $B058, $B5D1, $AD6E, $A8E7, $A67C, $A3F5,
$7EB2, $7B3B, $75A0, $7029, $6896, $6D1F, $6384, $660D,
$52FA, $5773, $59E8, $5C61, $44DE, $4157, $4FCC, $4A45,
$2622, $23AB, $2D30, $28B9, $3006, $358F, $3B14, $3E9D,
$0A6A, $0FE3, $0178, $04F1, $1C4E, $19C7, $175C, $12D5,
$A85B, $ADD2, $A349, $A6C0, $BE7F, $BBF6, $B56D, $B0E4,
$8413, $819A, $8F01, $8A88, $9237, $97BE, $9925, $9CAC,
$F0CB, $F542, $FBD9, $FE50, $E6EF, $E366, $EDFD, $E874,
$DC83, $D90A, $D791, $D218, $CAA7, $CF2E, $C1B5, $C43C,
$197B, $1CF2, $1269, $17E0, $0F5F, $0AD6, $044D, $01C4,
$3533, $30BA, $3E21, $3BA8, $2317, $269E, $2805, $2D8C,
$41EB, $4462, $4AF9, $4F70, $57CF, $5246, $5CDD, $5954,
$6DA3, $682A, $66B1, $6338, $7B87, $7E0E, $7095, $751C
);

constructor THasherCRC16_DECTR.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := '007E';
end;

procedure THasherCRC16_DECTR.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_DECTR.Final: String;
begin
  FHash := FHash xor $0001;
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 DECT-R', THasherCRC16_DECTR);

end.
