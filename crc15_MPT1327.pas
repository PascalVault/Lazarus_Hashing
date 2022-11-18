unit CRC15_MPT1327;
//CRC-15 MPT1327
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC15_MPT1327 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $6815, $383F, $502A, $707E, $186B, $4841, $2054, 
$08E9, $60FC, $30D6, $58C3, $7897, $1082, $40A8, $28BD, 
$11D2, $79C7, $29ED, $41F8, $61AC, $09B9, $5993, $3186, 
$193B, $712E, $2104, $4911, $6945, $0150, $517A, $396F, 
$23A4, $4BB1, $1B9B, $738E, $53DA, $3BCF, $6BE5, $03F0, 
$2B4D, $4358, $1372, $7B67, $5B33, $3326, $630C, $0B19, 
$3276, $5A63, $0A49, $625C, $4208, $2A1D, $7A37, $1222, 
$3A9F, $528A, $02A0, $6AB5, $4AE1, $22F4, $72DE, $1ACB, 
$4748, $2F5D, $7F77, $1762, $3736, $5F23, $0F09, $671C, 
$4FA1, $27B4, $779E, $1F8B, $3FDF, $57CA, $07E0, $6FF5, 
$569A, $3E8F, $6EA5, $06B0, $26E4, $4EF1, $1EDB, $76CE, 
$5E73, $3666, $664C, $0E59, $2E0D, $4618, $1632, $7E27, 
$64EC, $0CF9, $5CD3, $34C6, $1492, $7C87, $2CAD, $44B8, 
$6C05, $0410, $543A, $3C2F, $1C7B, $746E, $2444, $4C51, 
$753E, $1D2B, $4D01, $2514, $0540, $6D55, $3D7F, $556A, 
$7DD7, $15C2, $45E8, $2DFD, $0DA9, $65BC, $3596, $5D83, 
$6685, $0E90, $5EBA, $36AF, $16FB, $7EEE, $2EC4, $46D1, 
$6E6C, $0679, $5653, $3E46, $1E12, $7607, $262D, $4E38, 
$7757, $1F42, $4F68, $277D, $0729, $6F3C, $3F16, $5703, 
$7FBE, $17AB, $4781, $2F94, $0FC0, $67D5, $37FF, $5FEA, 
$4521, $2D34, $7D1E, $150B, $355F, $5D4A, $0D60, $6575, 
$4DC8, $25DD, $75F7, $1DE2, $3DB6, $55A3, $0589, $6D9C, 
$54F3, $3CE6, $6CCC, $04D9, $248D, $4C98, $1CB2, $74A7, 
$5C1A, $340F, $6425, $0C30, $2C64, $4471, $145B, $7C4E, 
$21CD, $49D8, $19F2, $71E7, $51B3, $39A6, $698C, $0199, 
$2924, $4131, $111B, $790E, $595A, $314F, $6165, $0970, 
$301F, $580A, $0820, $6035, $4061, $2874, $785E, $104B, 
$38F6, $50E3, $00C9, $68DC, $4888, $209D, $70B7, $18A2, 
$0269, $6A7C, $3A56, $5243, $7217, $1A02, $4A28, $223D, 
$0A80, $6295, $32BF, $5AAA, $7AFE, $12EB, $42C1, $2AD4, 
$13BB, $7BAE, $2B84, $4391, $63C5, $0BD0, $5BFA, $33EF, 
$1B52, $7347, $236D, $4B78, $6B2C, $0339, $5313, $3B06
);

constructor THasherCRC15_MPT1327.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '2566';
end;

procedure THasherCRC15_MPT1327.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 7)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC15_MPT1327.Final: String;
begin
  FHash := FHash and $7FFF;
  FHash := FHash xor 1;
  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('CRC-15 MPT1327', THasherCRC15_MPT1327);

end.
