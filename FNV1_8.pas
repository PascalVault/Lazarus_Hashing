unit FNV1_8;
//FNV1_8
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV1_8 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV1_8.Create;
begin
  inherited Create;
  Check := '9E';
  FHash := $811C9DC5;
end;

procedure THasherFNV1_8.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $01000193;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV1_8.Final: String;
begin
  FHash := ((FHash shr 8) xor FHash) and  $ff;
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('FNV1-8', THasherFNV1_8);

end.
