unit adler16;
//Adler-16
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherAdler16 = class(THasherbase)
  private
    FHash, FHash2: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherAdler16.Create;
begin
  inherited Create;
  Check := '4BE3';
  FHash := 1;
  FHash2 := 0;
end;

procedure THasherAdler16.Update(Msg: PByte; Length: Integer);
const MOD_ADLER = 251;
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod MOD_ADLER;
    FHash2 := (FHash2 + FHash) mod MOD_ADLER;
    Inc(Msg);
  end;   
end;

function THasherAdler16.Final: String;
begin
  FHash := (FHash2 shl 8) or FHash;
  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('Adler-16', THasherAdler16);

end.
