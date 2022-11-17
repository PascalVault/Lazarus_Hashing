unit XOR32;
//XOR32
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherXOR32 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherXOR32.Create;
begin
  inherited Create;
  Check := '0C04043D';
  FHash := 0;
end;

procedure THasherXOR32.Update(Msg: PByte; Length: Integer);
var i: Integer;
    L: Byte;
begin
  L := 0;
  for i:=0 to Length-1 do begin
    FHash := FHash xor (Msg^ shl L);

    Inc(L, 8);
    if L = 32 then L := 0;

    Inc(Msg);
  end;   
end;

function THasherXOR32.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('XOR32', THasherXOR32);

end.
