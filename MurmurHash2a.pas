unit MurmurHash2a;
//MurmurHash2a
//Author: domasz
//Last Update: 2022-11-22
//Licence: MIT

interface

uses SysUtils, HasherBase, Dialogs;

type THasherMurmurHash2a = class(THasherbase)
  private
    FHash: Cardinal;
    M: Cardinal;
    R: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherMurmurHash2a.Create;
begin
  inherited Create;
  Check := '72D40B4C';
  FHash := 0;
  M := $5bd1e995;
  R := 24;
end;

procedure THasherMurmurHash2a.Update(Msg: PByte; Length: Integer);
procedure mmix(var h,k: Cardinal);
begin
  k := k * m;
  k := k xor (k shr r);
  k := k * m;
  h := h * m;
  h := h xor k;
end;

const Seed = 0;
var i: Integer;
    T,K,L: Cardinal;
    Tmp: array[0..3] of Byte;
    Tmp2: Cardinal;
begin
  L := Length;

  FHash := Seed;
  K := 0;

  while Length >= 4 do begin
    Move(Msg^, Tmp2, 4);

    mmix(FHash, Tmp2);

    Inc(Msg, 4);
    Dec(Length, 4);
  end;  

  Move(Msg^, Tmp[0], Length);

  T := 0;

  case Length of
    3: T := T xor (Tmp[2] shl 16);
    2: T := T xor (Tmp[1] shl 8);
    1: T := T xor (Tmp[0]);
  end;

  mmix(FHash, T);
  mmix(FHash, L);

  FHash := FHash xor (FHash shr 13);
  FHash := FHash * M;
  FHash := FHash xor (FHash shr 15);
end;

function THasherMurmurHash2a.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('MurmurHash2a', THasherMurmurHash2a);

end.
