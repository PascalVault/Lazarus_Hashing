unit SHA512;
//SHA-512 (SHA-2)
//Author: domasz
//Last Update: 2022-11-27
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSHA512 = class(THasherbase)
  private
    FTotalSize: Int64;
    FHash: array[0..7] of QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

const K: array[0..79] of QWord = (
$428A2F98D728AE22, $7137449123EF65CD, $B5C0FBCFEC4D3B2F, $E9B5DBA58189DBBC,
$3956C25BF348B538, $59F111F1B605D019, $923F82A4AF194F9B, $AB1C5ED5DA6D8118,
$D807AA98A3030242, $12835B0145706FBE, $243185BE4EE4B28C, $550C7DC3D5FFB4E2,
$72BE5D74F27B896F, $80DEB1FE3B1696B1, $9BDC06A725C71235, $C19BF174CF692694,
$E49B69C19EF14AD2, $EFBE4786384F25E3, $0FC19DC68B8CD5B5, $240CA1CC77AC9C65,
$2DE92C6F592B0275, $4A7484AA6EA6E483, $5CB0A9DCBD41FBD4, $76F988DA831153B5,
$983E5152EE66DFAB, $A831C66D2DB43210, $B00327C898FB213F, $BF597FC7BEEF0EE4,
$C6E00BF33DA88FC2, $D5A79147930AA725, $06CA6351E003826F, $142929670A0E6E70,
$27B70A8546D22FFC, $2E1B21385C26C926, $4D2C6DFC5AC42AED, $53380D139D95B3DF,
$650A73548BAF63DE, $766A0ABB3C77B2A8, $81C2C92E47EDAEE6, $92722C851482353B,
$A2BFE8A14CF10364, $A81A664BBC423001, $C24B8B70D0F89791, $C76C51A30654BE30,
$D192E819D6EF5218, $D69906245565A910, $F40E35855771202A, $106AA07032BBD1B8,
$19A4C116B8D2D0C8, $1E376C085141AB53, $2748774CDF8EEB99, $34B0BCB5E19B48A8,
$391C0CB3C5C95A63, $4ED8AA4AE3418ACB, $5B9CCA4F7763E373, $682E6FF3D6B2B8A3,
$748F82EE5DEFB2FC, $78A5636F43172F60, $84C87814A1F0AB72, $8CC702081A6439EC,
$90BEFFFA23631E28, $A4506CEBDE82BDE9, $BEF9A3F7B2C67915, $C67178F2E372532B,
$CA273ECEEA26619C, $D186B8C721C0C207, $EADA7DD6CDE0EB1E, $F57D4F7FEE6ED178,
$06F067AA72176FBA, $0A637DC5A2C898A6, $113F9804BEF90DAE, $1B710B35131C471B,
$28DB77F523047D84, $32CAAB7B40C72493, $3C9EBE0A15C9BEBC, $431D67C49C100D4C,
$4CC5D4BECB3E42B6, $597F299CFC657E2A, $5FCB6FAB3AD6FAEC, $6C44198C4A475817
);

constructor THasherSHA512.Create;
begin
  inherited Create;
  FTotalSize := 0;

  Check := 'D9E6762DD1C8EAF6D61B3C6192FC408D4D6D5F1176D0C29169BC24E71C3F274A' +
           'D27FCD5811B313D681F7E55EC02D73D499C95455B6B5BB503ACF574FBA8FFE85';

  FHash[0] := QWord($6A09E667F3BCC908);
  FHash[1] := QWord($BB67AE8584CAA73B);
  FHash[2] := QWord($3C6EF372FE94F82B);
  FHash[3] := QWord($A54FF53A5F1D36F1);
  FHash[4] := QWord($510E527FADE682D1);
  FHash[5] := QWord($9B05688C2B3E6C1F);
  FHash[6] := QWord($1F83D9ABFB41BD6B);
  FHash[7] := QWord($5BE0CD19137E2179);
end;

procedure THasherSHA512.Update(Msg: PByte; Length: Integer);
var i: Integer;
    A,B,C,D,E,F,G,H: QWord;
    w: array[0..79] of QWord;
    buf: array[0..127] of Byte;
    Left: Integer;
    Bits: QWord;
    s0, s1: QWord;
    r: Integer;
    j: Integer;
    T, T2: QWord;
begin
  Inc(FTotalSize, Length);

  i := 0;

  while i <= Length do begin

    if Length - i > 127 then begin
      Move(Msg^, buf[0], 128);
      Inc(Msg, 128);
    end
    else begin
      Left := Length mod 128;

      FillChar(buf, 128, 0);
      Move(Msg^, buf[0], Left);

      Buf[Left] := $80;

      Bits := FTotalSize shl 3;

      Buf[64+56] := bits shr 56;
      buf[64+57] := bits shr 48;
      buf[64+58] := bits shr 40;
      buf[64+59] := bits shr 32;
      buf[64+60] := bits shr 24;
      buf[64+61] := bits shr 16;
      buf[64+62] := bits shr 8;
      buf[64+63] := bits;
    end;

    a := FHash[0];
    b := FHash[1];
    c := FHash[2];
    d := FHash[3];
    e := FHash[4];
    f := FHash[5];
    g := FHash[6];
    h := FHash[7];

    Move(buf[0], w[0], 128);
    for j:=0 to 15 do w[j] := SwapEndian(w[j]);

    for r:=16 to 79 do begin
      T  := w[r - 2];
      T2 := w[r - 15];

      s0 := RorQWord(T, 19) xor RorQWord(T, 61) xor (T shr 6);
      s1 := RorQWord(T2, 1) xor RorQWord(T2, 8) xor (T2 shr 7);

      w[r] := s0 + w[r - 7] + s1 + w[r - 16];
    end;

    //main loop
    for r:=0 to 79 do begin
      T  := H + (RorQWord(E, 14) xor RorQWord(E, 18) xor RorQWord(E, 41)) +
            ((E and F) xor ((not E) and G)) +
            k[r] + w[r];

      T2 := (RorQWord(A, 28) xor RorQWord(A, 34) xor RorQWord(A, 39) )+
            ((A and B) xor (A and C) xor (B and C));

      H  := G;
      G  := F;
      F  := E;
      E  := D + T;
      D  := C;
      C  := B;
      B  := A;
      A  := T + T2;
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

    Inc(i, 128);
  end;
end;

function THasherSHA512.Final: String;
begin
  Result := IntToHex(FHash[0], 16) + IntToHex(FHash[1], 16) + IntToHex(FHash[2], 16) +
            IntToHex(FHash[3], 16) + IntToHex(FHash[4], 16) + IntToHex(FHash[5], 16) +
            IntToHex(FHash[6], 16) + IntToHex(FHash[7], 16);
end;

initialization
  HasherList.RegisterHasher('SHA-512', THasherSHA512);

end.
