unit adler8;
//Adler-8
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherAdler8 = class(THasherbase)
  private
    FHash, FHash2: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherAdler8.Create;
begin
  inherited Create;
  Check := '7A';
  FHash := 1;
  FHash2 := 0;
end;

procedure THasherAdler8.Update(Msg: PByte; Length: Integer);
const MOD_ADLER = 13;
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod MOD_ADLER;
    FHash2 := (FHash2 + FHash) mod MOD_ADLER;
    Inc(Msg);
  end;   
end;

function THasherAdler8.Final: String;
begin
  FHash := (FHash2 shl 4) or FHash;
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('Adler-8', THasherAdler8);

end.
