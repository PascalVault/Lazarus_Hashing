unit FNV1A_64;
//FNV1A_64
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV1A_64 = class(THasherbase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV1A_64.Create;
begin
  inherited Create;
  Check := '06D5573923C6CDFC';
  FHash := $CBF29CE484222325;
end;

procedure THasherFNV1A_64.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash xor Msg^;
	FHash := FHash * $0100000001B3;

    Inc(Msg);
  end;   
end;

function THasherFNV1A_64.Final: String;
begin

  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('FNV1a-64', THasherFNV1A_64);

end.
