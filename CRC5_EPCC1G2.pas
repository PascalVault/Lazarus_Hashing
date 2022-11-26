unit CRC5_EPCC1G2;
//CRC-5 EPC-C1G2
//Author: domasz
//Last Update: 2022-11-22
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC5_EPCC1G2 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$15, $1C, $07, $0E, $18, $11, $0A, $03, 
$0F, $06, $1D, $14, $02, $0B, $10, $19, 
$08, $01, $1A, $13, $05, $0C, $17, $1E, 
$12, $1B, $00, $09, $1F, $16, $0D, $04, 
$06, $0F, $14, $1D, $0B, $02, $19, $10, 
$1C, $15, $0E, $07, $11, $18, $03, $0A, 
$1B, $12, $09, $00, $16, $1F, $04, $0D, 
$01, $08, $13, $1A, $0C, $05, $1E, $17, 
$1A, $13, $08, $01, $17, $1E, $05, $0C, 
$00, $09, $12, $1B, $0D, $04, $1F, $16, 
$07, $0E, $15, $1C, $0A, $03, $18, $11, 
$1D, $14, $0F, $06, $10, $19, $02, $0B, 
$09, $00, $1B, $12, $04, $0D, $16, $1F, 
$13, $1A, $01, $08, $1E, $17, $0C, $05, 
$14, $1D, $06, $0F, $19, $10, $0B, $02, 
$0E, $07, $1C, $15, $03, $0A, $11, $18, 
$0B, $02, $19, $10, $06, $0F, $14, $1D, 
$11, $18, $03, $0A, $1C, $15, $0E, $07, 
$16, $1F, $04, $0D, $1B, $12, $09, $00, 
$0C, $05, $1E, $17, $01, $08, $13, $1A, 
$18, $11, $0A, $03, $15, $1C, $07, $0E, 
$02, $0B, $10, $19, $0F, $06, $1D, $14, 
$05, $0C, $17, $1E, $08, $01, $1A, $13, 
$1F, $16, $0D, $04, $12, $1B, $00, $09, 
$04, $0D, $16, $1F, $09, $00, $1B, $12, 
$1E, $17, $0C, $05, $13, $1A, $01, $08, 
$19, $10, $0B, $02, $14, $1D, $06, $0F, 
$03, $0A, $11, $18, $0E, $07, $1C, $15, 
$17, $1E, $05, $0C, $1A, $13, $08, $01, 
$0D, $04, $1F, $16, $00, $09, $12, $1B, 
$0A, $03, $18, $11, $07, $0E, $15, $1C, 
$10, $19, $02, $0B, $1D, $14, $0F, $06
);

constructor THasherCRC5_EPCC1G2.Create;
var i: Integer;
begin
  inherited Create;
  FHash :=  $09;
  Check := '00';
end;

procedure THasherCRC5_EPCC1G2.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := Table[(FHash shl 3) xor Msg^ ] ;

    Inc(Msg);
  end;   
end;

function THasherCRC5_EPCC1G2.Final: String;
begin
  FHash := (FHash shr 3) ;
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('CRC-5 EPC-C1G2', THasherCRC5_EPCC1G2);

end.
