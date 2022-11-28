unit SHA224;
//SHA-224 (SHA-2)
//Author: domasz
//Last Update: 2022-11-28
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSHA224 = class(THasherbase)
  private
    FTotalSize: Int64;
    FHash: array[0..7] of Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

const K: array[0..63] of Cardinal = (
$428a2f98, $71374491, $b5c0fbcf, $e9b5dba5, $3956c25b, $59f111f1, $923f82a4, $ab1c5ed5,
$d807aa98, $12835b01, $243185be, $550c7dc3, $72be5d74, $80deb1fe, $9bdc06a7, $c19bf174,
$e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc, $2de92c6f, $4a7484aa, $5cb0a9dc, $76f988da,
$983e5152, $a831c66d, $b00327c8, $bf597fc7, $c6e00bf3, $d5a79147, $06ca6351, $14292967,
$27b70a85, $2e1b2138, $4d2c6dfc, $53380d13, $650a7354, $766a0abb, $81c2c92e, $92722c85,
$a2bfe8a1, $a81a664b, $c24b8b70, $c76c51a3, $d192e819, $d6990624, $f40e3585, $106aa070,
$19a4c116, $1e376c08, $2748774c, $34b0bcb5, $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
$748f82ee, $78a5636f, $84c87814, $8cc70208, $90befffa, $a4506ceb, $bef9a3f7, $c67178f2
);

constructor THasherSHA224.Create;
begin
  inherited Create;
  FTotalSize := 0;

  Check := '9B3E61BF29F17C75572FAE2E86E17809A4513D07C8A18152ACF34521';

  FHash[0] := $c1059ed8;
  FHash[1] := $367cd507;
  FHash[2] := $3070dd17;
  FHash[3] := $f70e5939; 
  FHash[4] := $ffc00b31;
  FHash[5] := $68581511; 
  FHash[6] := $64f98fa7; 
  FHash[7] := $befa4fa4;
end;

procedure THasherSHA224.Update(Msg: PByte; Length: Integer);
var i: Integer;
    j: Integer;
    A,B,C,D,E,F,G,H: Cardinal;
    w: array[0..79] of Cardinal;
    buf: array[0..63] of Byte;
    Left: Integer;
    Bits: QWord;
    s0, s1: Cardinal;
    ch, t1, t2, maj: Cardinal;
begin
  Inc(FTotalSize, Length);

  j := 0;

  while j <= Length do begin

    if Length - j > 63 then begin
      Move(Msg^, buf[0], 64);
      Inc(Msg, 64);
    end
    else begin
      Left := Length mod 64;

      FillChar(buf, 64, 0);
      Move(Msg^, buf[0], Left);

      Buf[Left] := $80;

      Bits := FTotalSize shl 3;

      Buf[56] := bits shr 56;
      buf[57] := bits shr 48;
      buf[58] := bits shr 40;
      buf[59] := bits shr 32;
      buf[60] := bits shr 24;
      buf[61] := bits shr 16;
      buf[62] := bits shr 8;
      buf[63] := bits;
    end;

    Move(buf[0], w[0], 64);
    for i:=0 to 15 do w[i] := SwapEndian(w[i]);

    for  i:=16 to 63 do begin
      s0 := RorDWord(w[i-15], 7) xor  RorDWord(w[i-15], 18) xor  (w[i-15] shr 3);
      s1 := RorDWord(w[i-2], 17) xor  RorDWord(w[i-2], 19) xor  (w[i-2] shr  10);
      w[i] := w[i-16] +  s0 +  w[i-7] +  s1;
    end;

    a := FHash[0];
    b := FHash[1];
    c := FHash[2];
    d := FHash[3];
    e := FHash[4];
    f := FHash[5];
    g := FHash[6];
    h := FHash[7];

    //main loop
    for i:=0 to 63 do begin
      s1 := RorDWord(e, 6) xor RorDWord(e, 11) xor RorDWord(e, 25);

      ch := (e and f) xor ((not e) and g);
      t1 := h + s1 + ch + k[i] + w[i];

      s0 := RorDWord(a, 2) xor RorDWord(a, 13) xor RorDWord(a, 22);
      maj := (a and b) xor (a and c) xor (b and c);
      t2 := s0 + maj;

      h := g;
      g := f;
      f := e;
      e := d + t1;
      d := c;
      c := b;
      b := a;
      a := t1 + t2;
    end;

    //finalize
    FHash[0] := FHash[0] + a;
    FHash[1] := FHash[1] + b;
    FHash[2] := FHash[2] + c;
    FHash[3] := FHash[3] + d;
    FHash[4] := FHash[4] + e;
    FHash[5] := FHash[5] + f;
    FHash[6] := FHash[6] + g;
    FHash[7] := FHash[7] + h;

    Inc(j, 64);
  end;
end;

function THasherSHA224.Final: String;
begin
  Result := IntToHex(FHash[0], 8) + IntToHex(FHash[1], 8) + IntToHex(FHash[2], 8) +
            IntToHex(FHash[3], 8) + IntToHex(FHash[4], 8) + IntToHex(FHash[5], 8) +
            IntToHex(FHash[6], 8);
end;

initialization
  HasherList.RegisterHasher('SHA-224', THasherSHA224);

end.
