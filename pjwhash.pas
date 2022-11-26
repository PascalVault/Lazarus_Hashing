unit PJWHash;
//PJWHash (book)
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;


type THasherPJWHash = class(THasherbase)
  private
    FHash: Cardinal;
    Test: Cardinal;
    BitsInUnsignedInt, ThreeQuarters, OneEighth, HighBits: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherPJWHash.Create;
begin
  inherited Create;
  Check := '0678AEE9';
  FHash := 0;

  BitsInUnsignedInt := 32;
  ThreeQuarters     := (BitsInUnsignedInt  * 3) div 4;
  OneEighth         := BitsInUnsignedInt div 8;
  HighBits          := $FFFFFFFF shl (BitsInUnsignedInt - OneEighth);
end;

procedure THasherPJWHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := (FHash shl OneEighth) + Msg^;
    Test := FHash and HighBits;

    if test <> 0 then FHash := (FHash xor (test shr ThreeQuarters)) and (not HighBits);

    Inc(Msg);
  end;   
end;

function THasherPJWHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('PJW Hash', THasherPJWHash);

end.
