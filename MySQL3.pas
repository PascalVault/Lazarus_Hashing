unit MySQL3;
//MySQL 3 password()
//Author: domasz
//Last Update: 2022-11-22
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherMySQL3 = class(THasherbase)
  private
    FHash, FHash2: Cardinal;
    Add: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherMySQL3.Create;
begin
  inherited Create;
  Check := '0C95234760AE5A28';

  FHash := 1345345333;
  FHash2 := $12345671;
  Add := 7;
end;

procedure THasherMySQL3.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
   for i:=0 to Length-1 do begin
     if Msg^ in [32, 09] then continue;

     FHash := FHash xor ( (((FHash and 63) + Add) * Msg^) + (FHash shl 8) and $FFFFFFFF);
     FHash2 := (FHash2 + ((FHash2 shl 8) xor FHash)) and $FFFFFFFF;
     Add := (Add + Msg^) and $FFFFFFFF;

    Inc(Msg);
  end;   
end;

function THasherMySQL3.Final: String;
begin
  FHash := FHash and $7FFFFFFF;
  FHash2 := FHash2 and $7FFFFFFF;

  Result := IntToHex(FHash, 8) + IntToHex(FHash2, 8);
end;

initialization
  HasherList.RegisterHasher('MySQL 3', THasherMySQL3);

end.
