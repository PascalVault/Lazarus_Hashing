unit CRC12_dect;
//CRC-12 dect
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC12_dect = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $080F, $0811, $001E, $082D, $0022, $003C, $0833,
$0855, $005A, $0044, $084B, $0078, $0877, $0869, $0066,
$08A5, $00AA, $00B4, $08BB, $0088, $0887, $0899, $0096,
$00F0, $08FF, $08E1, $00EE, $08DD, $00D2, $00CC, $08C3,
$0945, $014A, $0154, $095B, $0168, $0967, $0979, $0176,
$0110, $091F, $0901, $010E, $093D, $0132, $012C, $0923,
$01E0, $09EF, $09F1, $01FE, $09CD, $01C2, $01DC, $09D3,
$09B5, $01BA, $01A4, $09AB, $0198, $0997, $0989, $0186,
$0A85, $028A, $0294, $0A9B, $02A8, $0AA7, $0AB9, $02B6,
$02D0, $0ADF, $0AC1, $02CE, $0AFD, $02F2, $02EC, $0AE3,
$0220, $0A2F, $0A31, $023E, $0A0D, $0202, $021C, $0A13,
$0A75, $027A, $0264, $0A6B, $0258, $0A57, $0A49, $0246,
$03C0, $0BCF, $0BD1, $03DE, $0BED, $03E2, $03FC, $0BF3,
$0B95, $039A, $0384, $0B8B, $03B8, $0BB7, $0BA9, $03A6,
$0B65, $036A, $0374, $0B7B, $0348, $0B47, $0B59, $0356,
$0330, $0B3F, $0B21, $032E, $0B1D, $0312, $030C, $0B03,
$0D05, $050A, $0514, $0D1B, $0528, $0D27, $0D39, $0536,
$0550, $0D5F, $0D41, $054E, $0D7D, $0572, $056C, $0D63,
$05A0, $0DAF, $0DB1, $05BE, $0D8D, $0582, $059C, $0D93,
$0DF5, $05FA, $05E4, $0DEB, $05D8, $0DD7, $0DC9, $05C6,
$0440, $0C4F, $0C51, $045E, $0C6D, $0462, $047C, $0C73,
$0C15, $041A, $0404, $0C0B, $0438, $0C37, $0C29, $0426,
$0CE5, $04EA, $04F4, $0CFB, $04C8, $0CC7, $0CD9, $04D6,
$04B0, $0CBF, $0CA1, $04AE, $0C9D, $0492, $048C, $0C83,
$0780, $0F8F, $0F91, $079E, $0FAD, $07A2, $07BC, $0FB3,
$0FD5, $07DA, $07C4, $0FCB, $07F8, $0FF7, $0FE9, $07E6,
$0F25, $072A, $0734, $0F3B, $0708, $0F07, $0F19, $0716,
$0770, $0F7F, $0F61, $076E, $0F5D, $0752, $074C, $0F43,
$0EC5, $06CA, $06D4, $0EDB, $06E8, $0EE7, $0EF9, $06F6,
$0690, $0E9F, $0E81, $068E, $0EBD, $06B2, $06AC, $0EA3,
$0660, $0E6F, $0E71, $067E, $0E4D, $0642, $065C, $0E53,
$0E35, $063A, $0624, $0E2B, $0618, $0E17, $0E09, $0606
);

constructor THasherCRC12_dect.Create;
begin
  inherited Create;
  FHash := 0;
  Check := 'F5B';
end;

procedure THasherCRC12_dect.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 4)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC12_dect.Final: String;
begin
  FHash := FHash and $FFF;

  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-12 dect', THasherCRC12_dect);

end.
