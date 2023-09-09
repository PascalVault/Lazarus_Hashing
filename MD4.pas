unit MD4;
//MD-4
//Author: domasz
//Last Update: 2023-09-09
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherMD4 = class(THasherbase)
  private
    FTotalSize: Int64;
    Value: array[0..3] of Cardinal;
    procedure Process(X: array of Cardinal);
    procedure Last(Msg: PByte; Length: Integer);
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherMD4.Create;
begin
  inherited Create;
  FTotalSize := 0;

  Check := '2AE523785D0CAF4D2FB557C12016185C';

  value[0] := $67452301;
  value[1] := $EFCDAB89;
  value[2] := $98BADCFE;
  value[3] := $10325476;
end;

procedure THasherMD4.Update(Msg: PByte; Length: Integer);
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

procedure THasherMD4.Last(Msg: PByte; Length: Integer);
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

procedure THasherMD4.Process(X: array of Cardinal);
var i: Integer;
    A,B,C,D: Cardinal;
begin
    for i:=0 to 15 do begin
    //  X[i] := (buf[i*4]) or (buf[i*4 +1]) shl 8 or (buf[i*4 +2]) shl 16 or (buf[i*4 +3]) shl 24;
    end;

    A := value[0];
    B := value[1];
    C := value[2];
    D := value[3];

    A += ((B and C) or ((not B) and D)) + X[0];
    A := RolDword(A, 3);
    D += ((A and B) or ((not A) and C)) + X[1];
    D := RolDword(D, 7);
    C += ((D and A) or ((not D) and B)) + X[2];
    C := RolDword(C, 11);
    B += ((C and D) or ((not C) and A)) + X[3];
    B := RolDword(B, 19);
    A += ((B and C) or ((not B) and D)) + X[4];
    A := RolDword(A, 3);
    D += ((A and B) or ((not A) and C)) + X[5];
    D := RolDword(D, 7);
    C += ((D and A) or ((not D) and B)) + X[6];
    C := RolDword(C, 11);
    B += ((C and D) or ((not C) and A)) + X[7];
    B := RolDword(B, 19);
    A += ((B and C) or ((not B) and D)) + X[8];
    A := RolDword(A, 3);
    D += ((A and B) or ((not A) and C)) + X[9];
    D := RolDword(D, 7);
    C += ((D and A) or ((not D) and B)) + X[10];
    C := RolDword(C, 11);
    B += ((C and D) or ((not C) and A)) + X[11];
    B := RolDword(B, 19);
    A += ((B and C) or ((not B) and D)) + X[12];
    A := RolDword(A, 3);
    D += ((A and B) or ((not A) and C)) + X[13];
    D := RolDword(D, 7);
    C += ((D and A) or ((not D) and B)) + X[14];
    C := RolDword(C, 11);
    B += ((C and D) or ((not C) and A)) + X[15];
    B := RolDword(B, 19);

    A += ((B and (C or D)) or (C and D)) + X[0] + $5A827999;
    A := RolDword(A, 3);
    D += ((A and (B or C)) or (B and C)) + X[4] + $5A827999;
    D := RolDword(D, 5);
    C += ((D and (A or B)) or (A and B)) + X[8] + $5A827999;
    C := RolDword(C, 9);
    B += ((C and (D or A)) or (D and A)) + X[12] + $5A827999;
    B := RolDword(B, 13);
    A += ((B and (C or D)) or (C and D)) + X[1] + $5A827999;
    A := RolDword(A, 3);
    D += ((A and (B or C)) or (B and C)) + X[5] + $5A827999;
    D := RolDword(D, 5);
    C += ((D and (A or B)) or (A and B)) + X[9] + $5A827999;
    C := RolDword(C, 9);
    B += ((C and (D or A)) or (D and A)) + X[13] + $5A827999;
    B := RolDword(B, 13);
    A += ((B and (C or D)) or (C and D)) + X[2] + $5A827999;
    A := RolDword(A, 3);
    D += ((A and (B or C)) or (B and C)) + X[6] + $5A827999;
    D := RolDword(D, 5);
    C += ((D and (A or B)) or (A and B)) + X[10] + $5A827999;
    C := RolDword(C, 9);
    B += ((C and (D or A)) or (D and A)) + X[14] + $5A827999;
    B := RolDword(B, 13);
    A += ((B and (C or D)) or (C and D)) + X[3] + $5A827999;
    A := RolDword(A, 3);
    D += ((A and (B or C)) or (B and C)) + X[7] + $5A827999;
    D := RolDword(D, 5);
    C += ((D and (A or B)) or (A and B)) + X[11] + $5A827999;
    C := RolDword(C, 9);
    B += ((C and (D or A)) or (D and A)) + X[15] + $5A827999;
    B := RolDword(B, 13);

    A += (B xor C xor D) + X[0] + $6ED9EBA1;
    A := RolDword(A, 3);
    D += (A xor B xor C) + X[8] + $6ED9EBA1;
    D := RolDword(D, 9);
    C += (D xor A xor B) + X[4] + $6ED9EBA1;
    C := RolDword(C, 11);
    B += (C xor D xor A) + X[12] + $6ED9EBA1;
    B := RolDword(B, 15);
    A += (B xor C xor D) + X[2] + $6ED9EBA1;
    A := RolDword(A, 3);
    D += (A xor B xor C) + X[10] + $6ED9EBA1;
    D := RolDword(D, 9);
    C += (D xor A xor B) + X[6] + $6ED9EBA1;
    C := RolDword(C, 11);
    B += (C xor D xor A) + X[14] + $6ED9EBA1;
    B := RolDword(B, 15);
    A += (B xor C xor D) + X[1] + $6ED9EBA1;
    A := RolDword(A, 3);
    D += (A xor B xor C) + X[9] + $6ED9EBA1;
    D := RolDword(D, 9);
    C += (D xor A xor B) + X[5] + $6ED9EBA1;
    C := RolDword(C, 11);
    B += (C xor D xor A) + X[13] + $6ED9EBA1;
    B := RolDword(B, 15);
    A += (B xor C xor D) + X[3] + $6ED9EBA1;
    A := RolDword(A, 3);
    D += (A xor B xor C) + X[11] + $6ED9EBA1;
    D := RolDword(D, 9);
    C += (D xor A xor B) + X[7] + $6ED9EBA1;
    C := RolDword(C, 11);
    B += (C xor D xor A) + X[15] + $6ED9EBA1;
    B := RolDword(B, 15);

    value[0] := value[0] + A;
    value[1] := value[1] + B;
    value[2] := value[2] + C;
    value[3] := value[3] + D;
end;

function THasherMD4.Final: String;
var Msg: array[0..63] of Byte;
begin
  if FTotalSize mod 64 = 0 then begin
    FillChar(Msg, 64, 0);
    Last(@Msg[0], 64);
  end;

  Value[0] := SwapEndian(Value[0]);
  Value[1] := SwapEndian(Value[1]);
  Value[2] := SwapEndian(Value[2]);
  Value[3] := SwapEndian(Value[3]);

  Result := IntToHex(Value[0], 8) + IntToHex(Value[1], 8) + IntToHex(Value[2], 8) +
            IntToHex(Value[3], 8);
end;

initialization
  HasherList.RegisterHasher('MD-4', THasherMD4);

end.
