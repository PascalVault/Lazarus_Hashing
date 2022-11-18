unit CRC11_flexray;
//CRC-11 Flexray
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC11_flexray = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $0385, $070A, $048F, $0591, $0614, $029B, $011E, 
$00A7, $0322, $07AD, $0428, $0536, $06B3, $023C, $01B9, 
$014E, $02CB, $0644, $05C1, $04DF, $075A, $03D5, $0050, 
$01E9, $026C, $06E3, $0566, $0478, $07FD, $0372, $00F7, 
$029C, $0119, $0596, $0613, $070D, $0488, $0007, $0382, 
$023B, $01BE, $0531, $06B4, $07AA, $042F, $00A0, $0325, 
$03D2, $0057, $04D8, $075D, $0643, $05C6, $0149, $02CC, 
$0375, $00F0, $047F, $07FA, $06E4, $0561, $01EE, $026B, 
$0538, $06BD, $0232, $01B7, $00A9, $032C, $07A3, $0426, 
$059F, $061A, $0295, $0110, $000E, $038B, $0704, $0481, 
$0476, $07F3, $037C, $00F9, $01E7, $0262, $06ED, $0568, 
$04D1, $0754, $03DB, $005E, $0140, $02C5, $064A, $05CF, 
$07A4, $0421, $00AE, $032B, $0235, $01B0, $053F, $06BA, 
$0703, $0486, $0009, $038C, $0292, $0117, $0598, $061D, 
$06EA, $056F, $01E0, $0265, $037B, $00FE, $0471, $07F4, 
$064D, $05C8, $0147, $02C2, $03DC, $0059, $04D6, $0753, 
$01F5, $0270, $06FF, $057A, $0464, $07E1, $036E, $00EB, 
$0152, $02D7, $0658, $05DD, $04C3, $0746, $03C9, $004C, 
$00BB, $033E, $07B1, $0434, $052A, $06AF, $0220, $01A5, 
$001C, $0399, $0716, $0493, $058D, $0608, $0287, $0102, 
$0369, $00EC, $0463, $07E6, $06F8, $057D, $01F2, $0277, 
$03CE, $004B, $04C4, $0741, $065F, $05DA, $0155, $02D0, 
$0227, $01A2, $052D, $06A8, $07B6, $0433, $00BC, $0339, 
$0280, $0105, $058A, $060F, $0711, $0494, $001B, $039E, 
$04CD, $0748, $03C7, $0042, $015C, $02D9, $0656, $05D3, 
$046A, $07EF, $0360, $00E5, $01FB, $027E, $06F1, $0574, 
$0583, $0606, $0289, $010C, $0012, $0397, $0718, $049D, 
$0524, $06A1, $022E, $01AB, $00B5, $0330, $07BF, $043A, 
$0651, $05D4, $015B, $02DE, $03C0, $0045, $04CA, $074F, 
$06F6, $0573, $01FC, $0279, $0367, $00E2, $046D, $07E8, 
$071F, $049A, $0015, $0390, $028E, $010B, $0584, $0601, 
$07B8, $043D, $00B2, $0337, $0229, $01AC, $0523, $06A6
);

constructor THasherCRC11_flexray.Create;
begin
  inherited Create;
  FHash := $01A;
  Check := '5A3';
end;

procedure THasherCRC11_flexray.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 3)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC11_flexray.Final: String;
begin
  FHash := FHash and $7FF;

  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-11 Flexray', THasherCRC11_flexray);

end.
