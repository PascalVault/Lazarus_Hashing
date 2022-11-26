unit MurmurHash;
//MurmurHash
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherMurmurHash = class(THasherbase)
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

constructor THasherMurmurHash.Create;
begin
  inherited Create;
  Check := 'E9B7BC47';
  FHash := 0;

  M := $c6a4a793;
  R := 16;
end;

procedure THasherMurmurHash.Update(Msg: PByte; Length: Integer);
const Seed = 0;
var i: Integer;
    Tmp: Cardinal;
    Tmp2: array[0..3] of Byte;
begin
  FHash := seed xor (Length * M);

  while Length >= 4 do begin
    //Move(Msg^, Tmp, 4);
    Tmp := PCardinal(Msg)^;

    FHash := FHash + Tmp;
    FHash := FHash * M;
    FHash := FHash xor (FHash shr R); 

    Inc(Msg, 4);
    Dec(Length, 4);
  end;  

  Move(Msg^, Tmp2[0], Length);

  case Length of
    3: FHash := FHash + (Tmp2[2] shl 16);
    2: FHash := FHash + (Tmp2[1] shl 8);
    1: begin
         FHash := FHash + Tmp2[0];
         FHash := FHash * M;
         FHash := FHash xor (FHash shr R);
       end;
  end;

  FHash := FHash * M;
  FHash := FHash xor (FHash shr 10);
  FHash := FHash * M;
  FHash := FHash xor (FHash shr 17);
end;

function THasherMurmurHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('MurmurHash', THasherMurmurHash);

end.
