unit CRC6_DARC;
//CRC-6 DARC
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC6_DARC = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $32, $29, $1B, $1F, $2D, $36, $04, 
$3E, $0C, $17, $25, $21, $13, $08, $3A, 
$31, $03, $18, $2A, $2E, $1C, $07, $35, 
$0F, $3D, $26, $14, $10, $22, $39, $0B, 
$2F, $1D, $06, $34, $30, $02, $19, $2B, 
$11, $23, $38, $0A, $0E, $3C, $27, $15, 
$1E, $2C, $37, $05, $01, $33, $28, $1A, 
$20, $12, $09, $3B, $3F, $0D, $16, $24, 
$13, $21, $3A, $08, $0C, $3E, $25, $17, 
$2D, $1F, $04, $36, $32, $00, $1B, $29, 
$22, $10, $0B, $39, $3D, $0F, $14, $26, 
$1C, $2E, $35, $07, $03, $31, $2A, $18, 
$3C, $0E, $15, $27, $23, $11, $0A, $38, 
$02, $30, $2B, $19, $1D, $2F, $34, $06, 
$0D, $3F, $24, $16, $12, $20, $3B, $09, 
$33, $01, $1A, $28, $2C, $1E, $05, $37, 
$26, $14, $0F, $3D, $39, $0B, $10, $22, 
$18, $2A, $31, $03, $07, $35, $2E, $1C, 
$17, $25, $3E, $0C, $08, $3A, $21, $13, 
$29, $1B, $00, $32, $36, $04, $1F, $2D, 
$09, $3B, $20, $12, $16, $24, $3F, $0D, 
$37, $05, $1E, $2C, $28, $1A, $01, $33, 
$38, $0A, $11, $23, $27, $15, $0E, $3C, 
$06, $34, $2F, $1D, $19, $2B, $30, $02, 
$35, $07, $1C, $2E, $2A, $18, $03, $31, 
$0B, $39, $22, $10, $14, $26, $3D, $0F, 
$04, $36, $2D, $1F, $1B, $29, $32, $00, 
$3A, $08, $13, $21, $25, $17, $0C, $3E, 
$1A, $28, $33, $01, $05, $37, $2C, $1E, 
$24, $16, $0D, $3F, $3B, $09, $12, $20, 
$2B, $19, $02, $30, $34, $06, $1D, $2F, 
$15, $27, $3C, $0E, $0A, $38, $23, $11
);

constructor THasherCRC6_DARC.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '26';
end;

procedure THasherCRC6_DARC.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC6_DARC.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-6 DARC', THasherCRC6_DARC);

end.
