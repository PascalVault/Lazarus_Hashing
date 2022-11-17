unit crc15_can;
//CRC-15 CAN
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THashercrc15_can = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $4599, $4EAB, $0B32, $58CF, $1D56, $1664, $53FD,
$7407, $319E, $3AAC, $7F35, $2CC8, $6951, $6263, $27FA,
$2D97, $680E, $633C, $26A5, $7558, $30C1, $3BF3, $7E6A,
$5990, $1C09, $173B, $52A2, $015F, $44C6, $4FF4, $0A6D,
$5B2E, $1EB7, $1585, $501C, $03E1, $4678, $4D4A, $08D3,
$2F29, $6AB0, $6182, $241B, $77E6, $327F, $394D, $7CD4,
$76B9, $3320, $3812, $7D8B, $2E76, $6BEF, $60DD, $2544,
$02BE, $4727, $4C15, $098C, $5A71, $1FE8, $14DA, $5143,
$73C5, $365C, $3D6E, $78F7, $2B0A, $6E93, $65A1, $2038,
$07C2, $425B, $4969, $0CF0, $5F0D, $1A94, $11A6, $543F,
$5E52, $1BCB, $10F9, $5560, $069D, $4304, $4836, $0DAF,
$2A55, $6FCC, $64FE, $2167, $729A, $3703, $3C31, $79A8,
$28EB, $6D72, $6640, $23D9, $7024, $35BD, $3E8F, $7B16,
$5CEC, $1975, $1247, $57DE, $0423, $41BA, $4A88, $0F11,
$057C, $40E5, $4BD7, $0E4E, $5DB3, $182A, $1318, $5681,
$717B, $34E2, $3FD0, $7A49, $29B4, $6C2D, $671F, $2286,
$2213, $678A, $6CB8, $2921, $7ADC, $3F45, $3477, $71EE,
$5614, $138D, $18BF, $5D26, $0EDB, $4B42, $4070, $05E9,
$0F84, $4A1D, $412F, $04B6, $574B, $12D2, $19E0, $5C79,
$7B83, $3E1A, $3528, $70B1, $234C, $66D5, $6DE7, $287E,
$793D, $3CA4, $3796, $720F, $21F2, $646B, $6F59, $2AC0,
$0D3A, $48A3, $4391, $0608, $55F5, $106C, $1B5E, $5EC7,
$54AA, $1133, $1A01, $5F98, $0C65, $49FC, $42CE, $0757,
$20AD, $6534, $6E06, $2B9F, $7862, $3DFB, $36C9, $7350,
$51D6, $144F, $1F7D, $5AE4, $0919, $4C80, $47B2, $022B,
$25D1, $6048, $6B7A, $2EE3, $7D1E, $3887, $33B5, $762C,
$7C41, $39D8, $32EA, $7773, $248E, $6117, $6A25, $2FBC,
$0846, $4DDF, $46ED, $0374, $5089, $1510, $1E22, $5BBB,
$0AF8, $4F61, $4453, $01CA, $5237, $17AE, $1C9C, $5905,
$7EFF, $3B66, $3054, $75CD, $2630, $63A9, $689B, $2D02,
$276F, $62F6, $69C4, $2C5D, $7FA0, $3A39, $310B, $7492,
$5368, $16F1, $1DC3, $585A, $0BA7, $4E3E, $450C, $0095
);

constructor THashercrc15_can.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '059E';
end;

procedure THashercrc15_can.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 7)) and $FF];
    Inc(Msg);
  end;   
end;

function THashercrc15_can.Final: String;
begin
  FHash := FHash and $7FFF;

  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('CRC-15 CAN', THashercrc15_can);

end.
