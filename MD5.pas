unit MD5;
//MD-5
//Author: domasz
//Last Update: 2023-09-09
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherMD5 = class(THasherbase)
  private
    FHash: array[0..3] of Cardinal;
    FTotalSize: Int64;
    procedure Process(X: array of Cardinal);
    procedure Last(Msg: PByte; Length: Integer);
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

const K: array[0..63] of Cardinal = (
$d76aa478, $e8c7b756, $242070db, $c1bdceee,
$f57c0faf, $4787c62a, $a8304613, $fd469501,
$698098d8, $8b44f7af, $ffff5bb1, $895cd7be,
$6b901122, $fd987193, $a679438e, $49b40821,
$f61e2562, $c040b340, $265e5a51, $e9b6c7aa,
$d62f105d, $02441453, $d8a1e681, $e7d3fbc8,
$21e1cde6, $c33707d6, $f4d50d87, $455a14ed,
$a9e3e905, $fcefa3f8, $676f02d9, $8d2a4c8a,
$fffa3942, $8771f681, $6d9d6122, $fde5380c,
$a4beea44, $4bdecfa9, $f6bb4b60, $bebfbc70,
$289b7ec6, $eaa127fa, $d4ef3085, $04881d05,
$d9d4d039, $e6db99e5, $1fa27cf8, $c4ac5665,
$f4292244, $432aff97, $ab9423a7, $fc93a039,
$655b59c3, $8f0ccc92, $ffeff47d, $85845dd1,
$6fa87e4f, $fe2ce6e0, $a3014314, $4e0811a1,
$f7537e82, $bd3af235, $2ad7d2bb, $eb86d391
);
S: array[0..63] of Byte = (
7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21
);

constructor THasherMD5.Create;
begin
  inherited Create;
  FTotalSize := 0;

  Check := '25F9E794323B453885F5181F1B624D0B';

  FHash[0] := $67452301;
  FHash[1] := $EFCDAB89;
  FHash[2] := $98BADCFE;
  FHash[3] := $10325476;
end;

procedure THasherMD5.Update(Msg: PByte; Length: Integer);
var i: Integer;
    X: array[0..15] of Cardinal;
begin
  Inc(FTotalSize, Length);
  i := 0;

  while i < Length do begin
    if Length - i > 63 then begin
      Move(Msg^, X[0], 64);
      Inc(Msg, 64);

      Process(X);
    end
    else Last(Msg, Length);

    Inc(i, 64);
  end;
end;

procedure THasherMD5.Last(Msg: PByte; Length: Integer);
var buf: array[0..63] of Byte;
    Left: Integer;
    Bits: QWord;
    X: array[0..15] of Cardinal;
begin
  Left := Length mod 64;

  FillChar(Buf, 64, 0);
  Move(Msg^, buf[0], Left);

  Buf[Left] := $80;

  Bits := FTotalSize shl 3;

  buf[56] := bits;
  buf[57] := bits shr 8;
  buf[58] := bits shr 16;
  buf[59] := bits shr 24;
  buf[60] := bits shr 32;
  buf[61] := bits shr 40;
  buf[62] := bits shr 48;
  Buf[63] := bits shr 56;

  Move(buf[0], X[0], 64);
  Process(X);
end;

procedure THasherMD5.Process(X: array of Cardinal);
var j: Integer;
    A,B,C,D,F,G: Cardinal;
begin
  A := FHash[0];
  B := FHash[1];
  C := FHash[2];
  D := FHash[3];

  for j:=0 to 63 do begin

    if j <= 15 then begin
        F := (B and C) or ((not B) and D);
        g := j;
    end
    else if j <= 31 then begin
        F := (D and B) or ((not D) and C);
        g := (5*j + 1) mod 16;
    end
    else if j <= 47 then begin
        F := B xor C xor D;
        g := (3*j + 5) mod 16;
    end
    else if j <= 63 then begin
        F := C xor (B or (not D));
        g := (7*j) mod 16;
    end;

    F := F + A + K[j] + X[g];
    A := D;
    D := C;
    C := B;
    B := B + RolDWord(F, s[j]);
  end;

  FHash[0] := FHash[0] + A;
  FHash[1] := FHash[1] + B;
  FHash[2] := FHash[2] + C;
  FHash[3] := FHash[3] + D;
end;

function THasherMD5.Final: String;
var Msg: array[0..63] of Byte;
begin
  if FTotalSize mod 64 = 0 then begin
    FillChar(Msg, 64, 0);
    Last(@Msg[0], 64);
  end;

  FHash[0] := SwapEndian(FHash[0]);
  FHash[1] := SwapEndian(FHash[1]);
  FHash[2] := SwapEndian(FHash[2]);
  FHash[3] := SwapEndian(FHash[3]);

  Result := IntToHex(FHash[0], 8) + IntToHex(FHash[1], 8) + IntToHex(FHash[2], 8) +
            IntToHex(FHash[3], 8);
end;

initialization
  HasherList.RegisterHasher('MD-5', THasherMD5);

end.
