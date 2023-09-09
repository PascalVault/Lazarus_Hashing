unit MD2;
//MD-2
//Author: domasz
//Last Update: 2023-09-09
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherMD2 = class(THasherbase)
  private
    FTotalSize: Int64;
    checksum: array[0..15] of Byte;
    work: array[0..47] of Byte;
    procedure Process(buf: array of Byte);
    procedure Last(Msg: PByte; Length: Integer);
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

const SBOX: array[0..255] of Byte = (
$29, $2E, $43, $C9, $A2, $D8, $7C, $01, $3D, $36, $54, $A1,
$EC, $F0, $06, $13, $62, $A7, $05, $F3, $C0, $C7, $73, $8C,
$98, $93, $2B, $D9, $BC, $4C, $82, $CA, $1E, $9B, $57, $3C,
$FD, $D4, $E0, $16, $67, $42, $6F, $18, $8A, $17, $E5, $12,
$BE, $4E, $C4, $D6, $DA, $9E, $DE, $49, $A0, $FB, $F5, $8E,
$BB, $2F, $EE, $7A, $A9, $68, $79, $91, $15, $B2, $07, $3F,
$94, $C2, $10, $89, $0B, $22, $5F, $21, $80, $7F, $5D, $9A,
$5A, $90, $32, $27, $35, $3E, $CC, $E7, $BF, $F7, $97, $03,
$FF, $19, $30, $B3, $48, $A5, $B5, $D1, $D7, $5E, $92, $2A,
$AC, $56, $AA, $C6, $4F, $B8, $38, $D2, $96, $A4, $7D, $B6,
$76, $FC, $6B, $E2, $9C, $74, $04, $F1, $45, $9D, $70, $59,
$64, $71, $87, $20, $86, $5B, $CF, $65, $E6, $2D, $A8, $02,
$1B, $60, $25, $AD, $AE, $B0, $B9, $F6, $1C, $46, $61, $69,
$34, $40, $7E, $0F, $55, $47, $A3, $23, $DD, $51, $AF, $3A,
$C3, $5C, $F9, $CE, $BA, $C5, $EA, $26, $2C, $53, $0D, $6E,
$85, $28, $84, $09, $D3, $DF, $CD, $F4, $41, $81, $4D, $52,
$6A, $DC, $37, $C8, $6C, $C1, $AB, $FA, $24, $E1, $7B, $08,
$0C, $BD, $B1, $4A, $78, $88, $95, $8B, $E3, $63, $E8, $6D,
$E9, $CB, $D5, $FE, $3B, $00, $1D, $39, $F2, $EF, $B7, $0E,
$66, $58, $D0, $E4, $A6, $77, $72, $F8, $EB, $75, $4B, $0A,
$31, $44, $50, $B4, $8F, $ED, $1F, $1A, $DB, $99, $8D, $33,
$9F, $11, $83, $14);

constructor THasherMD2.Create;
var i: Integer;
begin
  inherited Create;

  Check := '12BD4EFDD922B5C8C7B773F26EF4E35F';

  for i:= 0 to 15 do begin
    checksum[i] := 0;

    work[(i * 3)    ] := 0;
    work[(i * 3) + 1] := 0;
    work[(i * 3) + 2] := 0;
  end;
end;

procedure THasherMD2.Update(Msg: PByte; Length: Integer);
var i: Integer;
    buf: array[0..15] of Byte;
begin
  Inc(FTotalSize, Length);
  i := 0;

  while i < Length do begin
    if Length - i > 15 then begin
      Move(Msg^, buf[0], 16);
      Inc(Msg, 16);

      Process(buf);
    end
    else Last(Msg, Length);

    Inc(i, 16);
  end;
end;

procedure THasherMD2.Last(Msg: PByte; Length: Integer);
var j: Integer;
    buf: array[0..15] of Byte;
    Left: Integer;
    Size: Integer;
begin
  Size := Length mod 16;

  FillChar(Buf, 16, 0);
  Move(Msg^, Buf[0], Size);
  Inc(Msg, Size);

  Left := 16 - (Length mod 16);

  for j:=0 to Left-1 do begin
    Buf[Size+j] := Left;
  end;

  Process(Buf);
end;

procedure THasherMD2.Process(buf: array of Byte);
var j,k: Integer;
    T: Byte;
    l: Byte;
    b: Byte;
begin
  l := checksum[15];
  for k:=0 to 15 do begin
    b := buf[k];

    work[16 + k] := b;
    work[(16 shl 1) + k] := (work[k] xor b);
    l := (checksum[k] xor SBOX[(b xor l) and $FF]);
    checksum[k] := l;
  end;

  t := 0;
  for k:=0 to 17 do begin
    for j:=0 to 47 do begin
      t := (work[j] xor SBOX[t]);
      work[j] := t;
    end;

   t := (t + k);
  end;
end;

function THasherMD2.Final: String;
var Res: array[0..15] of Byte;
    t: Byte;
    i,j: Integer;
    b: Byte;
    Msg: array[0..15] of Byte;
begin
  if FTotalSize mod 16 = 0 then begin
    FillChar(Msg, 16, 16);
    Last(@Msg[0], 16);
  end;

  for i:=0 to 15 do begin
    b := checksum[i];
    work[16 + i] := b;
    work[(16 shl 1) + i] := (work[i] xor b);
  end;

  t := 0;
  for i:=0 to 17 do begin
    for j:=0 to 47 do begin
      t := (work[j] xor SBOX[t]); work[j] := t;
    end;

    t := t + i;
  end;

  for i:=0 to 15 do Res[i] := work[i];

  Result := '';
  for i:=0 to 15 do Result := Result + IntToHex(Res[i], 2);
end;

initialization
  HasherList.RegisterHasher('MD-2', THasherMD2);

end.
