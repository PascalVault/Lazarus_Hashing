unit XXHash32;
//XXHash32, based on MIT code in C# by Melnik Alexander
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase, Dialogs;

type THasherXXHash32 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherXXHash32.Create;
begin
  inherited Create;
  Check := '937BAD67';
  FHash := 0;
end;

procedure THasherXXHash32.Update(Msg: PByte; Length: Integer);
const Seed = 0;
      XXH_PRIME32_1 = 2654435761;
      XXH_PRIME32_2 = 2246822519;
      XXH_PRIME32_3 = 3266489917;
      XXH_PRIME32_4 = 668265263;
      XXH_PRIME32_5 = 374761393;
var i: Integer;
    h32: Cardinal;
    Data: array[0..3] of Cardinal;
    Val: array[0..3] of Cardinal;
    j: Integer;
    blocks: PCardinal;
    Tmp: Cardinal;
    TotalBlocks: Integer;
begin
  if Length >= 16 then begin

    TotalBlocks := Length div 16;

    Val[0] := seed + XXH_PRIME32_1 + XXH_PRIME32_2;
    Val[1] := seed + XXH_PRIME32_2;
    Val[2] := seed + 0;
    Val[3] := seed - XXH_PRIME32_1;

    blocks := PCardinal(Msg);

    for i:=0 to TotalBlocks-1 do begin
      for j:=0 to 3 do begin
        Data[j] := blocks^;
        Inc(blocks);
      end;

      // XXH32 round
      for j:=0 to 3 do begin
        Val[j] := Val[j] + (Data[j] * XXH_PRIME32_2);
        Val[j] := (Val[j] shl 13) or (Val[j] shr (32 - 13));
        Val[j] := Val[j] * XXH_PRIME32_1;
      end;

      Inc(Msg, 16);
    end;

    h32 := ((Val[0] shl  1) or (Val[0] shr (32 -  1))) +
           ((Val[1] shl  7) or (Val[1] shr (32 -  7))) +
           ((Val[2] shl 12) or (Val[2] shr (32 - 12))) +
           ((Val[3] shl 18) or (Val[3] shr (32 - 18)));
    end
  else begin
    h32 := seed + XXH_PRIME32_5;
  end;

  h32 := h32 + Length;

  //last bytes
  Length := Length and 15;

  while Length >= 4 do begin
    Tmp := PCardinal(Msg)^;
    h32 := h32 + (Tmp * XXH_PRIME32_3);
    Inc(Msg, 4);

    h32 := ((h32 shl 17) or (h32 shr (32 - 17))) * XXH_PRIME32_4;
    Dec(Length, 4);
  end;

  while Length > 0 do begin
    h32 := h32 + (Msg^ * XXH_PRIME32_5);
    Inc(Msg);

    h32 := ((h32 shl 11) or (h32 shr (32 - 11))) * XXH_PRIME32_1;
    Dec(Length);
  end;

  //finalize
  h32 := h32 xor (h32 shr 15);
  h32 := h32 * XXH_PRIME32_2;
  h32 := h32 xor (h32 shr 13);
  h32 := h32 * XXH_PRIME32_3;
  h32 := h32 xor (h32 shr 16);

  FHash := h32;
end;

function THasherXXHash32.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('XXHash32', THasherXXHash32);

end.
