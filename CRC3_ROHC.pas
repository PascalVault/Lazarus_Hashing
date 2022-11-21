unit CRC3_ROHC;
//CRC-3 ROHC
//Author: domasz
//Last Update: 2022-11-21
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC3_ROHC = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$05, $03, $04, $02, $07, $01, $06, $00, 
$01, $07, $00, $06, $03, $05, $02, $04, 
$00, $06, $01, $07, $02, $04, $03, $05, 
$04, $02, $05, $03, $06, $00, $07, $01, 
$02, $04, $03, $05, $00, $06, $01, $07, 
$06, $00, $07, $01, $04, $02, $05, $03, 
$07, $01, $06, $00, $05, $03, $04, $02, 
$03, $05, $02, $04, $01, $07, $00, $06, 
$06, $00, $07, $01, $04, $02, $05, $03, 
$02, $04, $03, $05, $00, $06, $01, $07, 
$03, $05, $02, $04, $01, $07, $00, $06, 
$07, $01, $06, $00, $05, $03, $04, $02, 
$01, $07, $00, $06, $03, $05, $02, $04, 
$05, $03, $04, $02, $07, $01, $06, $00, 
$04, $02, $05, $03, $06, $00, $07, $01, 
$00, $06, $01, $07, $02, $04, $03, $05, 
$03, $05, $02, $04, $01, $07, $00, $06, 
$07, $01, $06, $00, $05, $03, $04, $02, 
$06, $00, $07, $01, $04, $02, $05, $03, 
$02, $04, $03, $05, $00, $06, $01, $07, 
$04, $02, $05, $03, $06, $00, $07, $01, 
$00, $06, $01, $07, $02, $04, $03, $05, 
$01, $07, $00, $06, $03, $05, $02, $04, 
$05, $03, $04, $02, $07, $01, $06, $00, 
$00, $06, $01, $07, $02, $04, $03, $05, 
$04, $02, $05, $03, $06, $00, $07, $01, 
$05, $03, $04, $02, $07, $01, $06, $00, 
$01, $07, $00, $06, $03, $05, $02, $04, 
$07, $01, $06, $00, $05, $03, $04, $02, 
$03, $05, $02, $04, $01, $07, $00, $06, 
$02, $04, $03, $05, $00, $06, $01, $07, 
$06, $00, $07, $01, $04, $02, $05, $03
);

constructor THasherCRC3_ROHC.Create;
begin
  inherited Create;
  FHash :=  7;
  Check := '7';
end;

procedure THasherCRC3_ROHC.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	
    FHash := Table[($FF and (FHash xor Msg^))];		
    Inc(Msg);
  end;   
end;

function THasherCRC3_ROHC.Final: String;
begin
  
  Result := IntToHex(FHash, 1); 
end;

initialization
  HasherList.RegisterHasher('CRC-3 ROHC', THasherCRC3_ROHC);

end.
