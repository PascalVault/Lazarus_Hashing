unit CRC10_gsm;
//CRC-10 gsm
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC10_gsm = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $0175, $02EA, $039F, $00A1, $01D4, $024B, $033E, 
$0142, $0037, $03A8, $02DD, $01E3, $0096, $0309, $027C, 
$0284, $03F1, $006E, $011B, $0225, $0350, $00CF, $01BA, 
$03C6, $02B3, $012C, $0059, $0367, $0212, $018D, $00F8, 
$007D, $0108, $0297, $03E2, $00DC, $01A9, $0236, $0343, 
$013F, $004A, $03D5, $02A0, $019E, $00EB, $0374, $0201, 
$02F9, $038C, $0013, $0166, $0258, $032D, $00B2, $01C7, 
$03BB, $02CE, $0151, $0024, $031A, $026F, $01F0, $0085, 
$00FA, $018F, $0210, $0365, $005B, $012E, $02B1, $03C4, 
$01B8, $00CD, $0352, $0227, $0119, $006C, $03F3, $0286, 
$027E, $030B, $0094, $01E1, $02DF, $03AA, $0035, $0140, 
$033C, $0249, $01D6, $00A3, $039D, $02E8, $0177, $0002, 
$0087, $01F2, $026D, $0318, $0026, $0153, $02CC, $03B9, 
$01C5, $00B0, $032F, $025A, $0164, $0011, $038E, $02FB, 
$0203, $0376, $00E9, $019C, $02A2, $03D7, $0048, $013D, 
$0341, $0234, $01AB, $00DE, $03E0, $0295, $010A, $007F, 
$01F4, $0081, $031E, $026B, $0155, $0020, $03BF, $02CA, 
$00B6, $01C3, $025C, $0329, $0017, $0162, $02FD, $0388, 
$0370, $0205, $019A, $00EF, $03D1, $02A4, $013B, $004E, 
$0232, $0347, $00D8, $01AD, $0293, $03E6, $0079, $010C, 
$0189, $00FC, $0363, $0216, $0128, $005D, $03C2, $02B7, 
$00CB, $01BE, $0221, $0354, $006A, $011F, $0280, $03F5, 
$030D, $0278, $01E7, $0092, $03AC, $02D9, $0146, $0033, 
$024F, $033A, $00A5, $01D0, $02EE, $039B, $0004, $0171, 
$010E, $007B, $03E4, $0291, $01AF, $00DA, $0345, $0230, 
$004C, $0139, $02A6, $03D3, $00ED, $0198, $0207, $0372, 
$038A, $02FF, $0160, $0015, $032B, $025E, $01C1, $00B4, 
$02C8, $03BD, $0022, $0157, $0269, $031C, $0083, $01F6, 
$0173, $0006, $0399, $02EC, $01D2, $00A7, $0338, $024D, 
$0031, $0144, $02DB, $03AE, $0090, $01E5, $027A, $030F, 
$03F7, $0282, $011D, $0068, $0356, $0223, $01BC, $00C9, 
$02B5, $03C0, $005F, $012A, $0214, $0361, $00FE, $018B
);

constructor THasherCRC10_gsm.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '12A';
end;

procedure THasherCRC10_gsm.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 2)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC10_gsm.Final: String;
begin
  FHash := FHash and $3FF;
  FHash := FHash xor $3FF;
  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-10 gsm', THasherCRC10_gsm);

end.
