unit CRC4_G704;
//CRC-4 G-704
//Author: domasz
//Last Update: 2022-11-21
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC4_G704 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$00, $07, $0E, $09, $05, $02, $0B, $0C, 
$0A, $0D, $04, $03, $0F, $08, $01, $06, 
$0D, $0A, $03, $04, $08, $0F, $06, $01, 
$07, $00, $09, $0E, $02, $05, $0C, $0B, 
$03, $04, $0D, $0A, $06, $01, $08, $0F, 
$09, $0E, $07, $00, $0C, $0B, $02, $05, 
$0E, $09, $00, $07, $0B, $0C, $05, $02, 
$04, $03, $0A, $0D, $01, $06, $0F, $08, 
$06, $01, $08, $0F, $03, $04, $0D, $0A, 
$0C, $0B, $02, $05, $09, $0E, $07, $00, 
$0B, $0C, $05, $02, $0E, $09, $00, $07, 
$01, $06, $0F, $08, $04, $03, $0A, $0D, 
$05, $02, $0B, $0C, $00, $07, $0E, $09, 
$0F, $08, $01, $06, $0A, $0D, $04, $03, 
$08, $0F, $06, $01, $0D, $0A, $03, $04, 
$02, $05, $0C, $0B, $07, $00, $09, $0E, 
$0C, $0B, $02, $05, $09, $0E, $07, $00, 
$06, $01, $08, $0F, $03, $04, $0D, $0A, 
$01, $06, $0F, $08, $04, $03, $0A, $0D, 
$0B, $0C, $05, $02, $0E, $09, $00, $07, 
$0F, $08, $01, $06, $0A, $0D, $04, $03, 
$05, $02, $0B, $0C, $00, $07, $0E, $09, 
$02, $05, $0C, $0B, $07, $00, $09, $0E, 
$08, $0F, $06, $01, $0D, $0A, $03, $04, 
$0A, $0D, $04, $03, $0F, $08, $01, $06, 
$00, $07, $0E, $09, $05, $02, $0B, $0C, 
$07, $00, $09, $0E, $02, $05, $0C, $0B, 
$0D, $0A, $03, $04, $08, $0F, $06, $01, 
$09, $0E, $07, $00, $0C, $0B, $02, $05, 
$03, $04, $0D, $0A, $06, $01, $08, $0F, 
$04, $03, $0A, $0D, $01, $06, $0F, $08, 
$0E, $09, $00, $07, $0B, $0C, $05, $02
);

constructor THasherCRC4_G704.Create;
begin
  inherited Create;
  FHash :=  $00;
  Check := '7';
end;

procedure THasherCRC4_G704.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC4_G704.Final: String;
begin
  
  Result := IntToHex(FHash, 1); 
end;

initialization
  HasherList.RegisterHasher('CRC-4 G-704', THasherCRC4_G704);

end.
