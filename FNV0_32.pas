unit FNV0_32;
//FNV0_32
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV0_32 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV0_32.Create;
begin
  inherited Create;
  Check := 'D8D70BF1';
  FHash := 0;
end;

procedure THasherFNV0_32.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $01000193;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV0_32.Final: String;
begin

  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('FNV0-32', THasherFNV0_32);

end.
