unit CRC11_umts;
//CRC-11 umts
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC11_umts = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;


implementation

var Table: array[0..255] of Word = (
$0000, $0307, $060E, $0509, $071B, $041C, $0115, $0212, 
$0531, $0636, $033F, $0038, $022A, $012D, $0424, $0723, 
$0165, $0262, $076B, $046C, $067E, $0579, $0070, $0377, 
$0454, $0753, $025A, $015D, $034F, $0048, $0541, $0646, 
$02CA, $01CD, $04C4, $07C3, $05D1, $06D6, $03DF, $00D8, 
$07FB, $04FC, $01F5, $02F2, $00E0, $03E7, $06EE, $05E9, 
$03AF, $00A8, $05A1, $06A6, $04B4, $07B3, $02BA, $01BD, 
$069E, $0599, $0090, $0397, $0185, $0282, $078B, $048C, 
$0594, $0693, $039A, $009D, $028F, $0188, $0481, $0786, 
$00A5, $03A2, $06AB, $05AC, $07BE, $04B9, $01B0, $02B7, 
$04F1, $07F6, $02FF, $01F8, $03EA, $00ED, $05E4, $06E3, 
$01C0, $02C7, $07CE, $04C9, $06DB, $05DC, $00D5, $03D2, 
$075E, $0459, $0150, $0257, $0045, $0342, $064B, $054C, 
$026F, $0168, $0461, $0766, $0574, $0673, $037A, $007D, 
$063B, $053C, $0035, $0332, $0120, $0227, $072E, $0429, 
$030A, $000D, $0504, $0603, $0411, $0716, $021F, $0118, 
$002F, $0328, $0621, $0526, $0734, $0433, $013A, $023D, 
$051E, $0619, $0310, $0017, $0205, $0102, $040B, $070C, 
$014A, $024D, $0744, $0443, $0651, $0556, $005F, $0358, 
$047B, $077C, $0275, $0172, $0360, $0067, $056E, $0669, 
$02E5, $01E2, $04EB, $07EC, $05FE, $06F9, $03F0, $00F7, 
$07D4, $04D3, $01DA, $02DD, $00CF, $03C8, $06C1, $05C6, 
$0380, $0087, $058E, $0689, $049B, $079C, $0295, $0192, 
$06B1, $05B6, $00BF, $03B8, $01AA, $02AD, $07A4, $04A3, 
$05BB, $06BC, $03B5, $00B2, $02A0, $01A7, $04AE, $07A9, 
$008A, $038D, $0684, $0583, $0791, $0496, $019F, $0298, 
$04DE, $07D9, $02D0, $01D7, $03C5, $00C2, $05CB, $06CC, 
$01EF, $02E8, $07E1, $04E6, $06F4, $05F3, $00FA, $03FD, 
$0771, $0476, $017F, $0278, $006A, $036D, $0664, $0563, 
$0240, $0147, $044E, $0749, $055B, $065C, $0355, $0052, 
$0614, $0513, $001A, $031D, $010F, $0208, $0701, $0406, 
$0325, $0022, $052B, $062C, $043E, $0739, $0230, $0137
);

constructor THasherCRC11_umts.Create;
begin
  inherited Create;
  FHash := 0;
  Check := '061';
end;

procedure THasherCRC11_umts.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 3)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC11_umts.Final: String;
begin
  FHash := FHash and $7FF;

  Result := IntToHex(FHash, 3);
end;

initialization
  HasherList.RegisterHasher('CRC-11 umts', THasherCRC11_umts);

end.
