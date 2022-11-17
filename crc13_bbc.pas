unit crc13_bbc;
//CRC-13 BBC
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THashercrc13_bbc = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $1CF5, $051F, $19EA, $0A3E, $16CB, $0F21, $13D4, 
$147C, $0889, $1163, $0D96, $1E42, $02B7, $1B5D, $07A8, 
$140D, $08F8, $1112, $0DE7, $1E33, $02C6, $1B2C, $07D9, 
$0071, $1C84, $056E, $199B, $0A4F, $16BA, $0F50, $13A5, 
$14EF, $081A, $11F0, $0D05, $1ED1, $0224, $1BCE, $073B, 
$0093, $1C66, $058C, $1979, $0AAD, $1658, $0FB2, $1347, 
$00E2, $1C17, $05FD, $1908, $0ADC, $1629, $0FC3, $1336, 
$149E, $086B, $1181, $0D74, $1EA0, $0255, $1BBF, $074A, 
$152B, $09DE, $1034, $0CC1, $1F15, $03E0, $1A0A, $06FF, 
$0157, $1DA2, $0448, $18BD, $0B69, $179C, $0E76, $1283, 
$0126, $1DD3, $0439, $18CC, $0B18, $17ED, $0E07, $12F2, 
$155A, $09AF, $1045, $0CB0, $1F64, $0391, $1A7B, $068E, 
$01C4, $1D31, $04DB, $182E, $0BFA, $170F, $0EE5, $1210, 
$15B8, $094D, $10A7, $0C52, $1F86, $0373, $1A99, $066C, 
$15C9, $093C, $10D6, $0C23, $1FF7, $0302, $1AE8, $061D, 
$01B5, $1D40, $04AA, $185F, $0B8B, $177E, $0E94, $1261, 
$16A3, $0A56, $13BC, $0F49, $1C9D, $0068, $1982, $0577, 
$02DF, $1E2A, $07C0, $1B35, $08E1, $1414, $0DFE, $110B, 
$02AE, $1E5B, $07B1, $1B44, $0890, $1465, $0D8F, $117A, 
$16D2, $0A27, $13CD, $0F38, $1CEC, $0019, $19F3, $0506, 
$024C, $1EB9, $0753, $1BA6, $0872, $1487, $0D6D, $1198, 
$1630, $0AC5, $132F, $0FDA, $1C0E, $00FB, $1911, $05E4, 
$1641, $0AB4, $135E, $0FAB, $1C7F, $008A, $1960, $0595, 
$023D, $1EC8, $0722, $1BD7, $0803, $14F6, $0D1C, $11E9, 
$0388, $1F7D, $0697, $1A62, $09B6, $1543, $0CA9, $105C, 
$17F4, $0B01, $12EB, $0E1E, $1DCA, $013F, $18D5, $0420, 
$1785, $0B70, $129A, $0E6F, $1DBB, $014E, $18A4, $0451, 
$03F9, $1F0C, $06E6, $1A13, $09C7, $1532, $0CD8, $102D, 
$1767, $0B92, $1278, $0E8D, $1D59, $01AC, $1846, $04B3, 
$031B, $1FEE, $0604, $1AF1, $0925, $15D0, $0C3A, $10CF, 
$036A, $1F9F, $0675, $1A80, $0954, $15A1, $0C4B, $10BE, 
$1716, $0BE3, $1209, $0EFC, $1D28, $01DD, $1837, $04C2
);

constructor THashercrc13_bbc.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '04FA';
end;

procedure THashercrc13_bbc.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 5)) and $FF];
    Inc(Msg);
  end;   
end;

function THashercrc13_bbc.Final: String;
begin
  FHash := FHash and $1FFF;

  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('CRC-13 BBC', THashercrc13_bbc);

end.
