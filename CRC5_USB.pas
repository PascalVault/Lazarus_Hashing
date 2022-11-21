unit CRC5_USB;
//CRC-5 USB
//Author: domasz
//Last Update: 2022-11-21
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC5_USB = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$01, $0F, $1D, $13, $10, $1E, $0C, $02, 
$0A, $04, $16, $18, $1B, $15, $07, $09, 
$17, $19, $0B, $05, $06, $08, $1A, $14, 
$1C, $12, $00, $0E, $0D, $03, $11, $1F, 
$04, $0A, $18, $16, $15, $1B, $09, $07, 
$0F, $01, $13, $1D, $1E, $10, $02, $0C, 
$12, $1C, $0E, $00, $03, $0D, $1F, $11, 
$19, $17, $05, $0B, $08, $06, $14, $1A, 
$0B, $05, $17, $19, $1A, $14, $06, $08, 
$00, $0E, $1C, $12, $11, $1F, $0D, $03, 
$1D, $13, $01, $0F, $0C, $02, $10, $1E, 
$16, $18, $0A, $04, $07, $09, $1B, $15, 
$0E, $00, $12, $1C, $1F, $11, $03, $0D, 
$05, $0B, $19, $17, $14, $1A, $08, $06, 
$18, $16, $04, $0A, $09, $07, $15, $1B, 
$13, $1D, $0F, $01, $02, $0C, $1E, $10, 
$15, $1B, $09, $07, $04, $0A, $18, $16, 
$1E, $10, $02, $0C, $0F, $01, $13, $1D, 
$03, $0D, $1F, $11, $12, $1C, $0E, $00, 
$08, $06, $14, $1A, $19, $17, $05, $0B, 
$10, $1E, $0C, $02, $01, $0F, $1D, $13, 
$1B, $15, $07, $09, $0A, $04, $16, $18, 
$06, $08, $1A, $14, $17, $19, $0B, $05, 
$0D, $03, $11, $1F, $1C, $12, $00, $0E, 
$1F, $11, $03, $0D, $0E, $00, $12, $1C, 
$14, $1A, $08, $06, $05, $0B, $19, $17, 
$09, $07, $15, $1B, $18, $16, $04, $0A, 
$02, $0C, $1E, $10, $13, $1D, $0F, $01, 
$1A, $14, $06, $08, $0B, $05, $17, $19, 
$11, $1F, $0D, $03, $00, $0E, $1C, $12, 
$0C, $02, $10, $1E, $1D, $13, $01, $0F, 
$07, $09, $1B, $15, $16, $18, $0A, $04
);

constructor THasherCRC5_USB.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '19';
end;

procedure THasherCRC5_USB.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC5_USB.Final: String;
begin
  
  Result := IntToHex(FHash, 2); 
end;

initialization
  HasherList.RegisterHasher('CRC-5 USB', THasherCRC5_USB);

end.
