unit CRC4_interlaken;
//CRC-4 interlaken
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherCRC4_interlaken = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Byte = (
$60, $50, $00, $30, $A0, $90, $C0, $F0, $D0, $E0, $B0, $80, $10, $20, $70, $40,
$30, $00, $50, $60, $F0, $C0, $90, $A0, $80, $B0, $E0, $D0, $40, $70, $20, $10,
$C0, $F0, $A0, $90, $00, $30, $60, $50, $70, $40, $10, $20, $B0, $80, $D0, $E0,
$90, $A0, $F0, $C0, $50, $60, $30, $00, $20, $10, $40, $70, $E0, $D0, $80, $B0,
$10, $20, $70, $40, $D0, $E0, $B0, $80, $A0, $90, $C0, $F0, $60, $50, $00, $30,
$40, $70, $20, $10, $80, $B0, $E0, $D0, $F0, $C0, $90, $A0, $30, $00, $50, $60,
$B0, $80, $D0, $E0, $70, $40, $10, $20, $00, $30, $60, $50, $C0, $F0, $A0, $90,
$E0, $D0, $80, $B0, $20, $10, $40, $70, $50, $60, $30, $00, $90, $A0, $F0, $C0,
$80, $B0, $E0, $D0, $40, $70, $20, $10, $30, $00, $50, $60, $F0, $C0, $90, $A0,
$D0, $E0, $B0, $80, $10, $20, $70, $40, $60, $50, $00, $30, $A0, $90, $C0, $F0,
$20, $10, $40, $70, $E0, $D0, $80, $B0, $90, $A0, $F0, $C0, $50, $60, $30, $00,
$70, $40, $10, $20, $B0, $80, $D0, $E0, $C0, $F0, $A0, $90, $00, $30, $60, $50,
$F0, $C0, $90, $A0, $30, $00, $50, $60, $40, $70, $20, $10, $80, $B0, $E0, $D0,
$A0, $90, $C0, $F0, $60, $50, $00, $30, $10, $20, $70, $40, $D0, $E0, $B0, $80,
$50, $60, $30, $00, $90, $A0, $F0, $C0, $E0, $D0, $80, $B0, $20, $10, $40, $70,
$00, $30, $60, $50, $C0, $F0, $A0, $90, $B0, $80, $D0, $E0, $70, $40, $10, $20
);

constructor THasherCRC4_interlaken.Create;
var i: Integer;
begin
  inherited Create;
  FHash :=  $00;
  Check := '7';
end;

procedure THasherCRC4_interlaken.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := Table[FHash xor Msg^];

    Inc(Msg);
  end;   
end;

function THasherCRC4_interlaken.Final: String;
begin
  FHash := (FHash shr 4) ;

  Result := IntToHex(FHash, 1);
end;

initialization
  HasherList.RegisterHasher('CRC-4 Interlaken', THasherCRC4_interlaken);


end.
