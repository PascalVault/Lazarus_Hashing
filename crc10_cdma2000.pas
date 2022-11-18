unit CRC10_cdma2000;
//CRC-10 cdma2000
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC10_cdma2000 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $03D9, $006B, $03B2, $00D6, $030F, $00BD, $0364, 
$01AC, $0275, $01C7, $021E, $017A, $02A3, $0111, $02C8, 
$0358, $0081, $0333, $00EA, $038E, $0057, $03E5, $003C, 
$02F4, $012D, $029F, $0146, $0222, $01FB, $0249, $0190, 
$0169, $02B0, $0102, $02DB, $01BF, $0266, $01D4, $020D, 
$00C5, $031C, $00AE, $0377, $0013, $03CA, $0078, $03A1, 
$0231, $01E8, $025A, $0183, $02E7, $013E, $028C, $0155, 
$039D, $0044, $03F6, $002F, $034B, $0092, $0320, $00F9, 
$02D2, $010B, $02B9, $0160, $0204, $01DD, $026F, $01B6, 
$037E, $00A7, $0315, $00CC, $03A8, $0071, $03C3, $001A, 
$018A, $0253, $01E1, $0238, $015C, $0285, $0137, $02EE, 
$0026, $03FF, $004D, $0394, $00F0, $0329, $009B, $0342, 
$03BB, $0062, $03D0, $0009, $036D, $00B4, $0306, $00DF, 
$0217, $01CE, $027C, $01A5, $02C1, $0118, $02AA, $0173, 
$00E3, $033A, $0088, $0351, $0035, $03EC, $005E, $0387, 
$014F, $0296, $0124, $02FD, $0199, $0240, $01F2, $022B, 
$027D, $01A4, $0216, $01CF, $02AB, $0172, $02C0, $0119, 
$03D1, $0008, $03BA, $0063, $0307, $00DE, $036C, $00B5, 
$0125, $02FC, $014E, $0297, $01F3, $022A, $0198, $0241, 
$0089, $0350, $00E2, $033B, $005F, $0386, $0034, $03ED, 
$0314, $00CD, $037F, $00A6, $03C2, $001B, $03A9, $0070, 
$02B8, $0161, $02D3, $010A, $026E, $01B7, $0205, $01DC, 
$004C, $0395, $0027, $03FE, $009A, $0343, $00F1, $0328, 
$01E0, $0239, $018B, $0252, $0136, $02EF, $015D, $0284, 
$00AF, $0376, $00C4, $031D, $0079, $03A0, $0012, $03CB, 
$0103, $02DA, $0168, $02B1, $01D5, $020C, $01BE, $0267, 
$03F7, $002E, $039C, $0045, $0321, $00F8, $034A, $0093, 
$025B, $0182, $0230, $01E9, $028D, $0154, $02E6, $013F, 
$01C6, $021F, $01AD, $0274, $0110, $02C9, $017B, $02A2, 
$006A, $03B3, $0001, $03D8, $00BC, $0365, $00D7, $030E, 
$029E, $0147, $02F5, $012C, $0248, $0191, $0223, $01FA, 
$0332, $00EB, $0359, $0080, $03E4, $003D, $038F, $0056
);

constructor THasherCRC10_cdma2000.Create;
begin
  inherited Create;
  FHash := $3FF;
  Check := '233';
end;

procedure THasherCRC10_cdma2000.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 2)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC10_cdma2000.Final: String;
begin
  FHash := FHash and $3FF;

  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-10 cdma2000', THasherCRC10_cdma2000);

end.
