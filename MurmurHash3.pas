unit MurmurHash3;
//MurmurHash3, based on public domain code by Austin Appleby
//MurmurHash3_x86_32 variant
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherMurmurHash3 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherMurmurHash3.Create;
begin
  inherited Create;
  Check := 'B4FEF382';
  FHash := 0;
end;

procedure THasherMurmurHash3.Update(Msg: PByte; Length: Integer);
function fmix32(h: Cardinal): Cardinal; inline;
begin
  h := h xor (h shr 16);
  h := h * $85ebca6b;
  h := h xor (h shr 13);
  h := h * $c2b2ae35;
  h := h xor (h shr 16);

  Result := h;
end;

const Seed = 0;
     c1: Cardinal = $cc9e2d51;
     c2: Cardinal = $1b873593;
var BlockCount: Integer;
    Hash: Cardinal;
    Data: Cardinal;
    blocks: PCardinal;
    FinalBytes: array[0..3] of Byte;
    BytesLeft: Integer;
    i: Integer;
begin
  BlockCount := Length div 4;
  Hash := seed;

  blocks := PCardinal(Msg);

  for i:=0 to BlockCount-1 do begin
    Data := blocks^;
    Inc(blocks);

    Data := Data * c1;
    Data := RolDWord(Data,15);
    Data := Data * c2;
    
    Hash := Hash xor Data;
    Hash := RolDWord(Hash,13); 
    Hash := Hash*5 + $e6546b64;
  end;

  //final bytes
  BytesLeft := Length - (BlockCount*4);

  Inc(Msg, BlockCount*4);
  FillChar(FinalBytes, 4, 0);
  Move(Msg^, FinalBytes[0], BytesLeft);

  Data := 0;

  if BytesLeft = 3 then Data := Data xor (FinalBytes[2] shl 16);

  if BytesLeft >=2 then Data := Data xor (FinalBytes[1] shl  8);

  if BytesLeft >=1 then Data := Data xor (FinalBytes[0]       );

  if BytesLeft > 0 then begin
         Data := Data * c1; 
         Data := RolDWord(Data,15); 
         Data := Data * c2; 
         Hash := Hash xor Data;
       end;

  Hash := Hash xor Length;
  Hash := fmix32(Hash);

  FHash := Hash;
end;

function THasherMurmurHash3.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('MurmurHash3', THasherMurmurHash3);

end.
