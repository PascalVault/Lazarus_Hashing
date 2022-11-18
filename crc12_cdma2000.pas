unit CRC12_cdma2000;
//CRC-12 cdma2000
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC12_cdma2000 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
 $0000, $0F13, $0135, $0E26, $026A, $0D79, $035F, $0C4C,
$04D4, $0BC7, $05E1, $0AF2, $06BE, $09AD, $078B, $0898,
$09A8, $06BB, $089D, $078E, $0BC2, $04D1, $0AF7, $05E4,
$0D7C, $026F, $0C49, $035A, $0F16, $0005, $0E23, $0130,
$0C43, $0350, $0D76, $0265, $0E29, $013A, $0F1C, $000F,
$0897, $0784, $09A2, $06B1, $0AFD, $05EE, $0BC8, $04DB,
$05EB, $0AF8, $04DE, $0BCD, $0781, $0892, $06B4, $09A7,
$013F, $0E2C, $000A, $0F19, $0355, $0C46, $0260, $0D73,
$0795, $0886, $06A0, $09B3, $05FF, $0AEC, $04CA, $0BD9,
$0341, $0C52, $0274, $0D67, $012B, $0E38, $001E, $0F0D,
$0E3D, $012E, $0F08, $001B, $0C57, $0344, $0D62, $0271,
$0AE9, $05FA, $0BDC, $04CF, $0883, $0790, $09B6, $06A5,
$0BD6, $04C5, $0AE3, $05F0, $09BC, $06AF, $0889, $079A,
$0F02, $0011, $0E37, $0124, $0D68, $027B, $0C5D, $034E,
$027E, $0D6D, $034B, $0C58, $0014, $0F07, $0121, $0E32,
$06AA, $09B9, $079F, $088C, $04C0, $0BD3, $05F5, $0AE6,
$0F2A, $0039, $0E1F, $010C, $0D40, $0253, $0C75, $0366,
$0BFE, $04ED, $0ACB, $05D8, $0994, $0687, $08A1, $07B2,
$0682, $0991, $07B7, $08A4, $04E8, $0BFB, $05DD, $0ACE,
$0256, $0D45, $0363, $0C70, $003C, $0F2F, $0109, $0E1A,
$0369, $0C7A, $025C, $0D4F, $0103, $0E10, $0036, $0F25,
$07BD, $08AE, $0688, $099B, $05D7, $0AC4, $04E2, $0BF1,
$0AC1, $05D2, $0BF4, $04E7, $08AB, $07B8, $099E, $068D,
$0E15, $0106, $0F20, $0033, $0C7F, $036C, $0D4A, $0259,
$08BF, $07AC, $098A, $0699, $0AD5, $05C6, $0BE0, $04F3,
$0C6B, $0378, $0D5E, $024D, $0E01, $0112, $0F34, $0027,
$0117, $0E04, $0022, $0F31, $037D, $0C6E, $0248, $0D5B,
$05C3, $0AD0, $04F6, $0BE5, $07A9, $08BA, $069C, $098F,
$04FC, $0BEF, $05C9, $0ADA, $0696, $0985, $07A3, $08B0,
$0028, $0F3B, $011D, $0E0E, $0242, $0D51, $0377, $0C64,
$0D54, $0247, $0C61, $0372, $0F3E, $002D, $0E0B, $0118,
$0980, $0693, $08B5, $07A6, $0BEA, $04F9, $0ADF, $05CC
);

constructor THasherCRC12_cdma2000.Create;
begin
  inherited Create;
  FHash := $fff;
  Check := 'D4D';
end;

procedure THasherCRC12_cdma2000.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 4)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC12_cdma2000.Final: String;
begin
  FHash := FHash and $FFF;

  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-12 cdma2000', THasherCRC12_cdma2000);

end.
