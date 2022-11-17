unit crc12_gsm;
//CRC-12 GSM
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THashercrc12_gsm = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $0D31, $0753, $0A62, $0EA6, $0397, $09F5, $04C4, 
$007D, $0D4C, $072E, $0A1F, $0EDB, $03EA, $0988, $04B9, 
$00FA, $0DCB, $07A9, $0A98, $0E5C, $036D, $090F, $043E, 
$0087, $0DB6, $07D4, $0AE5, $0E21, $0310, $0972, $0443, 
$01F4, $0CC5, $06A7, $0B96, $0F52, $0263, $0801, $0530, 
$0189, $0CB8, $06DA, $0BEB, $0F2F, $021E, $087C, $054D, 
$010E, $0C3F, $065D, $0B6C, $0FA8, $0299, $08FB, $05CA, 
$0173, $0C42, $0620, $0B11, $0FD5, $02E4, $0886, $05B7, 
$03E8, $0ED9, $04BB, $098A, $0D4E, $007F, $0A1D, $072C, 
$0395, $0EA4, $04C6, $09F7, $0D33, $0002, $0A60, $0751, 
$0312, $0E23, $0441, $0970, $0DB4, $0085, $0AE7, $07D6, 
$036F, $0E5E, $043C, $090D, $0DC9, $00F8, $0A9A, $07AB, 
$021C, $0F2D, $054F, $087E, $0CBA, $018B, $0BE9, $06D8, 
$0261, $0F50, $0532, $0803, $0CC7, $01F6, $0B94, $06A5, 
$02E6, $0FD7, $05B5, $0884, $0C40, $0171, $0B13, $0622, 
$029B, $0FAA, $05C8, $08F9, $0C3D, $010C, $0B6E, $065F, 
$07D0, $0AE1, $0083, $0DB2, $0976, $0447, $0E25, $0314, 
$07AD, $0A9C, $00FE, $0DCF, $090B, $043A, $0E58, $0369, 
$072A, $0A1B, $0079, $0D48, $098C, $04BD, $0EDF, $03EE, 
$0757, $0A66, $0004, $0D35, $09F1, $04C0, $0EA2, $0393, 
$0624, $0B15, $0177, $0C46, $0882, $05B3, $0FD1, $02E0, 
$0659, $0B68, $010A, $0C3B, $08FF, $05CE, $0FAC, $029D, 
$06DE, $0BEF, $018D, $0CBC, $0878, $0549, $0F2B, $021A, 
$06A3, $0B92, $01F0, $0CC1, $0805, $0534, $0F56, $0267, 
$0438, $0909, $036B, $0E5A, $0A9E, $07AF, $0DCD, $00FC, 
$0445, $0974, $0316, $0E27, $0AE3, $07D2, $0DB0, $0081, 
$04C2, $09F3, $0391, $0EA0, $0A64, $0755, $0D37, $0006, 
$04BF, $098E, $03EC, $0EDD, $0A19, $0728, $0D4A, $007B, 
$05CC, $08FD, $029F, $0FAE, $0B6A, $065B, $0C39, $0108, 
$05B1, $0880, $02E2, $0FD3, $0B17, $0626, $0C44, $0175, 
$0536, $0807, $0265, $0F54, $0B90, $06A1, $0CC3, $01F2, 
$054B, $087A, $0218, $0F29, $0BED, $06DC, $0CBE, $018F
);

constructor THashercrc12_gsm.Create;
begin
  inherited Create;
  FHash := 0;
  Check := 'B34';
end;

procedure THashercrc12_gsm.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 4)) and $FF];
    Inc(Msg);
  end;   
end;

function THashercrc12_gsm.Final: String;
begin
  FHash := FHash and $FFF;
  FHash := FHash xor $FFF;
  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-12 GSM', THashercrc12_gsm);

end.
