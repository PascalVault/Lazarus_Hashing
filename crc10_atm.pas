unit CRC10_atm;
//CRC-10 ATM
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC10_atm = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $0233, $0255, $0066, $0299, $00AA, $00CC, $02FF, 
$0301, $0132, $0154, $0367, $0198, $03AB, $03CD, $01FE, 
$0031, $0202, $0264, $0057, $02A8, $009B, $00FD, $02CE, 
$0330, $0103, $0165, $0356, $01A9, $039A, $03FC, $01CF, 
$0062, $0251, $0237, $0004, $02FB, $00C8, $00AE, $029D, 
$0363, $0150, $0136, $0305, $01FA, $03C9, $03AF, $019C, 
$0053, $0260, $0206, $0035, $02CA, $00F9, $009F, $02AC, 
$0352, $0161, $0107, $0334, $01CB, $03F8, $039E, $01AD, 
$00C4, $02F7, $0291, $00A2, $025D, $006E, $0008, $023B, 
$03C5, $01F6, $0190, $03A3, $015C, $036F, $0309, $013A, 
$00F5, $02C6, $02A0, $0093, $026C, $005F, $0039, $020A, 
$03F4, $01C7, $01A1, $0392, $016D, $035E, $0338, $010B, 
$00A6, $0295, $02F3, $00C0, $023F, $000C, $006A, $0259, 
$03A7, $0194, $01F2, $03C1, $013E, $030D, $036B, $0158, 
$0097, $02A4, $02C2, $00F1, $020E, $003D, $005B, $0268, 
$0396, $01A5, $01C3, $03F0, $010F, $033C, $035A, $0169, 
$0188, $03BB, $03DD, $01EE, $0311, $0122, $0144, $0377, 
$0289, $00BA, $00DC, $02EF, $0010, $0223, $0245, $0076, 
$01B9, $038A, $03EC, $01DF, $0320, $0113, $0175, $0346, 
$02B8, $008B, $00ED, $02DE, $0021, $0212, $0274, $0047, 
$01EA, $03D9, $03BF, $018C, $0373, $0140, $0126, $0315, 
$02EB, $00D8, $00BE, $028D, $0072, $0241, $0227, $0014, 
$01DB, $03E8, $038E, $01BD, $0342, $0171, $0117, $0324, 
$02DA, $00E9, $008F, $02BC, $0043, $0270, $0216, $0025, 
$014C, $037F, $0319, $012A, $03D5, $01E6, $0180, $03B3, 
$024D, $007E, $0018, $022B, $00D4, $02E7, $0281, $00B2, 
$017D, $034E, $0328, $011B, $03E4, $01D7, $01B1, $0382, 
$027C, $004F, $0029, $021A, $00E5, $02D6, $02B0, $0083, 
$012E, $031D, $037B, $0148, $03B7, $0184, $01E2, $03D1, 
$022F, $001C, $007A, $0249, $00B6, $0285, $02E3, $00D0, 
$011F, $032C, $034A, $0179, $0386, $01B5, $01D3, $03E0, 
$021E, $002D, $004B, $0278, $0087, $02B4, $02D2, $00E1
);

constructor THasherCRC10_atm.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '199';
end;

procedure THasherCRC10_atm.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 2)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC10_atm.Final: String;
begin
  FHash := FHash and $3FF;

  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-10 ATM', THasherCRC10_atm);

end.
