unit FNV0_24;
//FNV0_24
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV0_24 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV0_24.Create;
begin
  inherited Create;
  Check := 'D70B29';
  FHash := 0;
end;

procedure THasherFNV0_24.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := FHash * $01000193;
    FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV0_24.Final: String;
begin
  FHash := (FHash shr 24) xor (FHash and $FFFFFF);
  Result := IntToHex(FHash, 6);
end;

initialization
  HasherList.RegisterHasher('FNV0-24', THasherFNV0_24);

end.
