unit CRC5_G704;
//CRC-5 G-704
//Author: domasz
//Last Update: 2022-11-21
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC5_G704 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $07, $0E, $09, $1C, $1B, $12, $15, 
$13, $14, $1D, $1A, $0F, $08, $01, $06, 
$0D, $0A, $03, $04, $11, $16, $1F, $18, 
$1E, $19, $10, $17, $02, $05, $0C, $0B, 
$1A, $1D, $14, $13, $06, $01, $08, $0F, 
$09, $0E, $07, $00, $15, $12, $1B, $1C, 
$17, $10, $19, $1E, $0B, $0C, $05, $02, 
$04, $03, $0A, $0D, $18, $1F, $16, $11, 
$1F, $18, $11, $16, $03, $04, $0D, $0A, 
$0C, $0B, $02, $05, $10, $17, $1E, $19, 
$12, $15, $1C, $1B, $0E, $09, $00, $07, 
$01, $06, $0F, $08, $1D, $1A, $13, $14, 
$05, $02, $0B, $0C, $19, $1E, $17, $10, 
$16, $11, $18, $1F, $0A, $0D, $04, $03, 
$08, $0F, $06, $01, $14, $13, $1A, $1D, 
$1B, $1C, $15, $12, $07, $00, $09, $0E, 
$15, $12, $1B, $1C, $09, $0E, $07, $00, 
$06, $01, $08, $0F, $1A, $1D, $14, $13, 
$18, $1F, $16, $11, $04, $03, $0A, $0D, 
$0B, $0C, $05, $02, $17, $10, $19, $1E, 
$0F, $08, $01, $06, $13, $14, $1D, $1A, 
$1C, $1B, $12, $15, $00, $07, $0E, $09, 
$02, $05, $0C, $0B, $1E, $19, $10, $17, 
$11, $16, $1F, $18, $0D, $0A, $03, $04, 
$0A, $0D, $04, $03, $16, $11, $18, $1F, 
$19, $1E, $17, $10, $05, $02, $0B, $0C, 
$07, $00, $09, $0E, $1B, $1C, $15, $12, 
$14, $13, $1A, $1D, $08, $0F, $06, $01, 
$10, $17, $1E, $19, $0C, $0B, $02, $05, 
$03, $04, $0D, $0A, $1F, $18, $11, $16, 
$1D, $1A, $13, $14, $01, $06, $0F, $08, 
$0E, $09, $00, $07, $12, $15, $1C, $1B
);

constructor THasherCRC5_G704.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '07';
end;

procedure THasherCRC5_G704.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC5_G704.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-5 G-704', THasherCRC5_G704);

end.
