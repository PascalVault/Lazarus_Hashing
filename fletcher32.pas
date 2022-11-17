unit fletcher32;
//Fletcher-32
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFletcher32 = class(THasherbase)
  private
    FHash, FHash2: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFletcher32.Create;
begin
  inherited Create;
  Check := '091501DD';
  FHash := 0;
  FHash2 := 0;
end;

procedure THasherFletcher32.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod 65535;
    FHash2 := (FHash2 + FHash) mod 65535;

    Inc(Msg);
  end;   
end;

function THasherFletcher32.Final: String;
begin
  FHash := (FHash2 shl 16) or FHash;

  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('Fletcher-32', THasherFletcher32);

end.
