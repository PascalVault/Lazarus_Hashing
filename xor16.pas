unit XOR16;
//XOR16
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherXOR16 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherXOR16.Create;
begin
  inherited Create;
  Check := '0839';
  FHash := 0;
end;

procedure THasherXOR16.Update(Msg: PByte; Length: Integer);
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

function THasherXOR16.Final: String;
begin
  FHash := (FHash and $FFFF) xor (FHash shr 16);

  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('XOR16', THasherXOR16);

end.
