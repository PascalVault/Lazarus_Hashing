unit FNV1_16;
//FNV1_16
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV1_16 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV1_16.Create;
begin
  inherited Create;
  Check := 'AC02';
  FHash := $811C9DC5;
end;

procedure THasherFNV1_16.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $01000193;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV1_16.Final: String;
begin
  FHash := (FHash shr 16) xor (FHash and $ffff);
  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('FNV1-16', THasherFNV1_16);

end.
