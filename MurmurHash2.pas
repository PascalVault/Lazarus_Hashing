unit MurmurHash2;
//MurmurHash2
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase, Dialogs;


type THasherMurmurHash2 = class(THasherbase)
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

constructor THasherMurmurHash2.Create;
begin
  inherited Create;
  Check := 'DCCB0167';
  FHash := 0;
  M := $5bd1e995;
  R := 24;
end;

procedure THasherMurmurHash2.Update(Msg: PByte; Length: Integer);
const Seed = 0;
var i: Integer;
    K: Cardinal;
    Tmp: array[0..3] of Byte;
begin
  FHash := Seed xor Length;
  K := 0;

  while Length >= 4 do begin
    //Move(Msg^, Tmp[0], 4);
    Tmp2 := PCardinal(Msg)^;

    K  := Tmp[0];
    K := K or (Tmp[1] shl 8);
    K := K or (Tmp[2] shl 16);
    K := K or (Tmp[3] shl 24);

    K := K * m;
    K := K xor (k shr r);
    K := K * m;

    FHash := FHash * M;
    FHash := FHash xor K;

    Inc(Msg, 4);
    Dec(Length, 4);
  end;  

  Move(Msg^, Tmp[0], Length);

  case Length of
    3: FHash := FHash xor (Tmp[2] shl 16);
    2: FHash := FHash xor (Tmp[1] shl 8);
    1: begin
         FHash := FHash xor Tmp[0];
         FHash := FHash * M;
       end;
  end;

  FHash := FHash xor (FHash shr 13);
  FHash := FHash * M;
  FHash := FHash xor (FHash shr 15);
end;

function THasherMurmurHash2.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('MurmurHash2', THasherMurmurHash2);

end.
