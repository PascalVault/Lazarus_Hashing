unit FNV1_32;
//FNV1_32
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV1_32 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV1_32.Create;
begin
  inherited Create;
  Check := '24148816';
  FHash := $811C9DC5;
end;

procedure THasherFNV1_32.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $01000193;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV1_32.Final: String;
begin

  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('FNV1-32', THasherFNV1_32);

end.
