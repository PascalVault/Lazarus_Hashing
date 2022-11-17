unit adler32;
//Adler-32
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherAdler32 = class(THasherbase)
  private
    FHash, FHash2: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherAdler32.Create;
begin
  inherited Create;
  Check := '091E01DE';
  FHash := 1;
  FHash2 := 0;
end;

procedure THasherAdler32.Update(Msg: PByte; Length: Integer);
const MOD_ADLER = 65521;
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod MOD_ADLER;
    FHash2 := (FHash2 + FHash) mod MOD_ADLER;
    Inc(Msg);
  end;   
end;

function THasherAdler32.Final: String;
begin
  FHash := (FHash2 shl 16) or FHash;
  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('Adler-32', THasherAdler32);

end.
