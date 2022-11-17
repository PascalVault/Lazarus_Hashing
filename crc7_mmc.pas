unit crc7_mmc;
//CRC-7 MMC
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC7_MMC = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table : array[0..255] of Byte = (
$00, $09, $12, $1b, $24, $2d, $36, $3f,
$48, $41, $5a, $53, $6c, $65, $7e, $77,
$19, $10, $0b, $02, $3d, $34, $2f, $26,
$51, $58, $43, $4a, $75, $7c, $67, $6e,
$32, $3b, $20, $29, $16, $1f, $04, $0d,
$7a, $73, $68, $61, $5e, $57, $4c, $45,
$2b, $22, $39, $30, $0f, $06, $1d, $14,
$63, $6a, $71, $78, $47, $4e, $55, $5c,
$64, $6d, $76, $7f, $40, $49, $52, $5b,
$2c, $25, $3e, $37, $08, $01, $1a, $13,
$7d, $74, $6f, $66, $59, $50, $4b, $42,
$35, $3c, $27, $2e, $11, $18, $03, $0a,
$56, $5f, $44, $4d, $72, $7b, $60, $69,
$1e, $17, $0c, $05, $3a, $33, $28, $21,
$4f, $46, $5d, $54, $6b, $62, $79, $70,
$07, $0e, $15, $1c, $23, $2a, $31, $38,
$41, $48, $53, $5a, $65, $6c, $77, $7e,
$09, $00, $1b, $12, $2d, $24, $3f, $36,
$58, $51, $4a, $43, $7c, $75, $6e, $67,
$10, $19, $02, $0b, $34, $3d, $26, $2f,
$73, $7a, $61, $68, $57, $5e, $45, $4c,
$3b, $32, $29, $20, $1f, $16, $0d, $04,
$6a, $63, $78, $71, $4e, $47, $5c, $55,
$22, $2b, $30, $39, $06, $0f, $14, $1d,
$25, $2c, $37, $3e, $01, $08, $13, $1a,
$6d, $64, $7f, $76, $49, $40, $5b, $52,
$3c, $35, $2e, $27, $18, $11, $0a, $03,
$74, $7d, $66, $6f, $50, $59, $42, $4b,
$17, $1e, $05, $0c, $33, $3a, $21, $28,
$5f, $56, $4d, $44, $7b, $72, $69, $60,
$0e, $07, $1c, $15, $2a, $23, $38, $31,
$46, $4f, $54, $5d, $62, $6b, $70, $79
);

constructor THasherCRC7_MMC.Create;
begin
  inherited Create;
  FHash :=  0;
  Check := '75';
end;

procedure THasherCRC7_MMC.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[(FHash shl 1) xor Msg^ ] ;

    Inc(Msg);
  end;   
end;

function THasherCRC7_MMC.Final: String;
begin
  
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('CRC-7 MMC', THasherCRC7_MMC);

end.
