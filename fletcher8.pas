unit fletcher8;
//Fletcher-8
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFletcher8 = class(THasherbase)
  private
    FHash, FHash2: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFletcher8.Create;
begin
  inherited Create;
  Check := '0C';
  FHash := 0;
  FHash2 := 0;
end;

procedure THasherFletcher8.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod 15;
    FHash2 := (FHash2 + FHash) mod 15;

    Inc(Msg);
  end;   
end;

function THasherFletcher8.Final: String;
begin
  FHash := (FHash2 shl 4) or FHash;

  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('Fletcher-8', THasherFletcher8);

end.
