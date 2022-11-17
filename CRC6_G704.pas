unit CRC6_G704;
//CRC-6 G-704
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC6_G704 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $14, $28, $3C, $31, $25, $19, $0D, 
$03, $17, $2B, $3F, $32, $26, $1A, $0E, 
$06, $12, $2E, $3A, $37, $23, $1F, $0B, 
$05, $11, $2D, $39, $34, $20, $1C, $08, 
$0C, $18, $24, $30, $3D, $29, $15, $01, 
$0F, $1B, $27, $33, $3E, $2A, $16, $02, 
$0A, $1E, $22, $36, $3B, $2F, $13, $07, 
$09, $1D, $21, $35, $38, $2C, $10, $04, 
$18, $0C, $30, $24, $29, $3D, $01, $15, 
$1B, $0F, $33, $27, $2A, $3E, $02, $16, 
$1E, $0A, $36, $22, $2F, $3B, $07, $13, 
$1D, $09, $35, $21, $2C, $38, $04, $10, 
$14, $00, $3C, $28, $25, $31, $0D, $19, 
$17, $03, $3F, $2B, $26, $32, $0E, $1A, 
$12, $06, $3A, $2E, $23, $37, $0B, $1F, 
$11, $05, $39, $2D, $20, $34, $08, $1C, 
$30, $24, $18, $0C, $01, $15, $29, $3D, 
$33, $27, $1B, $0F, $02, $16, $2A, $3E, 
$36, $22, $1E, $0A, $07, $13, $2F, $3B, 
$35, $21, $1D, $09, $04, $10, $2C, $38, 
$3C, $28, $14, $00, $0D, $19, $25, $31, 
$3F, $2B, $17, $03, $0E, $1A, $26, $32, 
$3A, $2E, $12, $06, $0B, $1F, $23, $37, 
$39, $2D, $11, $05, $08, $1C, $20, $34, 
$28, $3C, $00, $14, $19, $0D, $31, $25, 
$2B, $3F, $03, $17, $1A, $0E, $32, $26, 
$2E, $3A, $06, $12, $1F, $0B, $37, $23, 
$2D, $39, $05, $11, $1C, $08, $34, $20, 
$24, $30, $0C, $18, $15, $01, $3D, $29, 
$27, $33, $0F, $1B, $16, $02, $3E, $2A, 
$22, $36, $0A, $1E, $13, $07, $3B, $2F, 
$21, $35, $09, $1D, $10, $04, $38, $2C
);

constructor THasherCRC6_G704.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '06';
end;

procedure THasherCRC6_G704.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC6_G704.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-6 G-704', THasherCRC6_G704);

end.
