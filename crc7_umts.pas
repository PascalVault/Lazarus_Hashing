unit crc7_umts;
//CRC-7 UMTS
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC7_UMTS = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table : array[0..255] of Byte = (
$00, $45, $4F, $0A, $5B, $1E, $14, $51, 
$73, $36, $3C, $79, $28, $6D, $67, $22, 
$23, $66, $6C, $29, $78, $3D, $37, $72, 
$50, $15, $1F, $5A, $0B, $4E, $44, $01, 
$46, $03, $09, $4C, $1D, $58, $52, $17, 
$35, $70, $7A, $3F, $6E, $2B, $21, $64, 
$65, $20, $2A, $6F, $3E, $7B, $71, $34, 
$16, $53, $59, $1C, $4D, $08, $02, $47, 
$49, $0C, $06, $43, $12, $57, $5D, $18, 
$3A, $7F, $75, $30, $61, $24, $2E, $6B, 
$6A, $2F, $25, $60, $31, $74, $7E, $3B, 
$19, $5C, $56, $13, $42, $07, $0D, $48, 
$0F, $4A, $40, $05, $54, $11, $1B, $5E, 
$7C, $39, $33, $76, $27, $62, $68, $2D, 
$2C, $69, $63, $26, $77, $32, $38, $7D, 
$5F, $1A, $10, $55, $04, $41, $4B, $0E, 
$57, $12, $18, $5D, $0C, $49, $43, $06, 
$24, $61, $6B, $2E, $7F, $3A, $30, $75, 
$74, $31, $3B, $7E, $2F, $6A, $60, $25, 
$07, $42, $48, $0D, $5C, $19, $13, $56, 
$11, $54, $5E, $1B, $4A, $0F, $05, $40, 
$62, $27, $2D, $68, $39, $7C, $76, $33, 
$32, $77, $7D, $38, $69, $2C, $26, $63, 
$41, $04, $0E, $4B, $1A, $5F, $55, $10, 
$1E, $5B, $51, $14, $45, $00, $0A, $4F, 
$6D, $28, $22, $67, $36, $73, $79, $3C, 
$3D, $78, $72, $37, $66, $23, $29, $6C, 
$4E, $0B, $01, $44, $15, $50, $5A, $1F, 
$58, $1D, $17, $52, $03, $46, $4C, $09, 
$2B, $6E, $64, $21, $70, $35, $3F, $7A, 
$7B, $3E, $34, $71, $20, $65, $6F, $2A, 
$08, $4D, $47, $02, $53, $16, $1C, $59
);

constructor THasherCRC7_UMTS.Create;
begin
  inherited Create;
  FHash :=  0;
  Check := '61';
end;

procedure THasherCRC7_UMTS.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[(FHash shl 1) xor Msg^ ] ;

    Inc(Msg);
  end;   
end;

function THasherCRC7_UMTS.Final: String;
begin
  
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('CRC-7 UMTS', THasherCRC7_UMTS);

end.
