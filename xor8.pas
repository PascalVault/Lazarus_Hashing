unit XOR8;
//XOR8
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherXOR8 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherXOR8.Create;
begin
  inherited Create;
  Check := '31';
  FHash := 0;
end;

procedure THasherXOR8.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin
    FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherXOR8.Final: String;
begin
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('XOR8', THasherXOR8);

end.
