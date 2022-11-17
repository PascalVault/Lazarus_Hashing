unit crc14_gsm;
//CRC-14 GSM
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THashercrc14_gsm = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $202D, $2077, $005A, $20C3, $00EE, $00B4, $2099, 
$21AB, $0186, $01DC, $21F1, $0168, $2145, $211F, $0132, 
$237B, $0356, $030C, $2321, $03B8, $2395, $23CF, $03E2, 
$02D0, $22FD, $22A7, $028A, $2213, $023E, $0264, $2249, 
$26DB, $06F6, $06AC, $2681, $0618, $2635, $266F, $0642, 
$0770, $275D, $2707, $072A, $27B3, $079E, $07C4, $27E9, 
$05A0, $258D, $25D7, $05FA, $2563, $054E, $0514, $2539, 
$240B, $0426, $047C, $2451, $04C8, $24E5, $24BF, $0492, 
$2D9B, $0DB6, $0DEC, $2DC1, $0D58, $2D75, $2D2F, $0D02, 
$0C30, $2C1D, $2C47, $0C6A, $2CF3, $0CDE, $0C84, $2CA9, 
$0EE0, $2ECD, $2E97, $0EBA, $2E23, $0E0E, $0E54, $2E79, 
$2F4B, $0F66, $0F3C, $2F11, $0F88, $2FA5, $2FFF, $0FD2, 
$0B40, $2B6D, $2B37, $0B1A, $2B83, $0BAE, $0BF4, $2BD9, 
$2AEB, $0AC6, $0A9C, $2AB1, $0A28, $2A05, $2A5F, $0A72, 
$283B, $0816, $084C, $2861, $08F8, $28D5, $288F, $08A2, 
$0990, $29BD, $29E7, $09CA, $2953, $097E, $0924, $2909, 
$3B1B, $1B36, $1B6C, $3B41, $1BD8, $3BF5, $3BAF, $1B82, 
$1AB0, $3A9D, $3AC7, $1AEA, $3A73, $1A5E, $1A04, $3A29, 
$1860, $384D, $3817, $183A, $38A3, $188E, $18D4, $38F9, 
$39CB, $19E6, $19BC, $3991, $1908, $3925, $397F, $1952, 
$1DC0, $3DED, $3DB7, $1D9A, $3D03, $1D2E, $1D74, $3D59, 
$3C6B, $1C46, $1C1C, $3C31, $1CA8, $3C85, $3CDF, $1CF2, 
$3EBB, $1E96, $1ECC, $3EE1, $1E78, $3E55, $3E0F, $1E22, 
$1F10, $3F3D, $3F67, $1F4A, $3FD3, $1FFE, $1FA4, $3F89, 
$1680, $36AD, $36F7, $16DA, $3643, $166E, $1634, $3619, 
$372B, $1706, $175C, $3771, $17E8, $37C5, $379F, $17B2, 
$35FB, $15D6, $158C, $35A1, $1538, $3515, $354F, $1562, 
$1450, $347D, $3427, $140A, $3493, $14BE, $14E4, $34C9, 
$305B, $1076, $102C, $3001, $1098, $30B5, $30EF, $10C2, 
$11F0, $31DD, $3187, $11AA, $3133, $111E, $1144, $3169, 
$1320, $330D, $3357, $137A, $33E3, $13CE, $1394, $33B9, 
$328B, $12A6, $12FC, $32D1, $1248, $3265, $323F, $1212
);

constructor THashercrc14_gsm.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '30AE';
end;

procedure THashercrc14_gsm.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 6)) and $FF];
    Inc(Msg);
  end;   
end;

function THashercrc14_gsm.Final: String;
begin
  FHash := FHash and $3FFF;
  FHash := FHash xor $3FFF;
  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('CRC-14 GSM', THashercrc14_gsm);

end.
