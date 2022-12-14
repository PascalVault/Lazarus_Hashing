unit crc30_cdma;
//CRC-30 CDMA
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THashercrc30_cdma = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of LongInt = (
$00000000, $2030B9C7, $2051CA49, $0061738E, $20932D55, $00A39492, $00C2E71C, $20F25EDB, 
$2116E36D, $01265AAA, $01472924, $217790E3, $0185CE38, $21B577FF, $21D40471, $01E4BDB6, 
$221D7F1D, $022DC6DA, $024CB554, $227C0C93, $028E5248, $22BEEB8F, $22DF9801, $02EF21C6, 
$030B9C70, $233B25B7, $235A5639, $036AEFFE, $2398B125, $03A808E2, $03C97B6C, $23F9C2AB, 
$240A47FD, $043AFE3A, $045B8DB4, $246B3473, $04996AA8, $24A9D36F, $24C8A0E1, $04F81926, 
$051CA490, $252C1D57, $254D6ED9, $057DD71E, $258F89C5, $05BF3002, $05DE438C, $25EEFA4B, 
$061738E0, $26278127, $2646F2A9, $06764B6E, $268415B5, $06B4AC72, $06D5DFFC, $26E5663B, 
$2701DB8D, $0731624A, $075011C4, $2760A803, $0792F6D8, $27A24F1F, $27C33C91, $07F38556, 
$2824363D, $08148FFA, $0875FC74, $284545B3, $08B71B68, $2887A2AF, $28E6D121, $08D668E6, 
$0932D550, $29026C97, $29631F19, $0953A6DE, $29A1F805, $099141C2, $09F0324C, $29C08B8B, 
$0A394920, $2A09F0E7, $2A688369, $0A583AAE, $2AAA6475, $0A9ADDB2, $0AFBAE3C, $2ACB17FB, 
$2B2FAA4D, $0B1F138A, $0B7E6004, $2B4ED9C3, $0BBC8718, $2B8C3EDF, $2BED4D51, $0BDDF496, 
$0C2E71C0, $2C1EC807, $2C7FBB89, $0C4F024E, $2CBD5C95, $0C8DE552, $0CEC96DC, $2CDC2F1B, 
$2D3892AD, $0D082B6A, $0D6958E4, $2D59E123, $0DABBFF8, $2D9B063F, $2DFA75B1, $0DCACC76, 
$2E330EDD, $0E03B71A, $0E62C494, $2E527D53, $0EA02388, $2E909A4F, $2EF1E9C1, $0EC15006, 
$0F25EDB0, $2F155477, $2F7427F9, $0F449E3E, $2FB6C0E5, $0F867922, $0FE70AAC, $2FD7B36B, 
$3078D5BD, $10486C7A, $10291FF4, $3019A633, $10EBF8E8, $30DB412F, $30BA32A1, $108A8B66, 
$116E36D0, $315E8F17, $313FFC99, $110F455E, $31FD1B85, $11CDA242, $11ACD1CC, $319C680B, 
$1265AAA0, $32551367, $323460E9, $1204D92E, $32F687F5, $12C63E32, $12A74DBC, $3297F47B, 
$337349CD, $1343F00A, $13228384, $33123A43, $13E06498, $33D0DD5F, $33B1AED1, $13811716, 
$14729240, $34422B87, $34235809, $1413E1CE, $34E1BF15, $14D106D2, $14B0755C, $3480CC9B, 
$3564712D, $1554C8EA, $1535BB64, $350502A3, $15F75C78, $35C7E5BF, $35A69631, $15962FF6, 
$366FED5D, $165F549A, $163E2714, $360E9ED3, $16FCC008, $36CC79CF, $36AD0A41, $169DB386, 
$17790E30, $3749B7F7, $3728C479, $17187DBE, $37EA2365, $17DA9AA2, $17BBE92C, $378B50EB, 
$185CE380, $386C5A47, $380D29C9, $183D900E, $38CFCED5, $18FF7712, $189E049C, $38AEBD5B, 
$394A00ED, $197AB92A, $191BCAA4, $392B7363, $19D92DB8, $39E9947F, $3988E7F1, $19B85E36, 
$3A419C9D, $1A71255A, $1A1056D4, $3A20EF13, $1AD2B1C8, $3AE2080F, $3A837B81, $1AB3C246, 
$1B577FF0, $3B67C637, $3B06B5B9, $1B360C7E, $3BC452A5, $1BF4EB62, $1B9598EC, $3BA5212B, 
$3C56A47D, $1C661DBA, $1C076E34, $3C37D7F3, $1CC58928, $3CF530EF, $3C944361, $1CA4FAA6, 
$1D404710, $3D70FED7, $3D118D59, $1D21349E, $3DD36A45, $1DE3D382, $1D82A00C, $3DB219CB, 
$1E4BDB60, $3E7B62A7, $3E1A1129, $1E2AA8EE, $3ED8F635, $1EE84FF2, $1E893C7C, $3EB985BB, 
$3F5D380D, $1F6D81CA, $1F0CF244, $3F3C4B83, $1FCE1558, $3FFEAC9F, $3F9FDF11, $1FAF66D6
);

constructor THashercrc30_cdma.Create;
begin
  inherited Create;
  FHash := $3fffffff;
  Check := '04C34ABF';
end;

procedure THashercrc30_cdma.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 22)) and $FF];
    Inc(Msg);
  end;   
end;

function THashercrc30_cdma.Final: String;
begin
  FHash := FHash and $3fffffff;
  FHash := FHash xor $3fffffff;
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('CRC-30 CDMA', THashercrc30_cdma);

end.
