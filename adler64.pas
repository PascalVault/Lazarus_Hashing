unit adler64;
//Adler-64
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherAdler64 = class(THasherbase)
  private
    FHash, FHash2: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherAdler64.Create;
begin
  inherited Create;
  Check := '0000091E000001DE';
  FHash := 1;
  FHash2 := 0;
end;

procedure THasherAdler64.Update(Msg: PByte; Length: Integer);
const MOD_ADLER = 4294967291;
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod MOD_ADLER;
    FHash2 := (FHash2 + FHash) mod MOD_ADLER;
    Inc(Msg);
  end;   
end;

function THasherAdler64.Final: String;
begin
  FHash := (FHash2 shl 32) or FHash;
  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('Adler-64', THasherAdler64);

end.
