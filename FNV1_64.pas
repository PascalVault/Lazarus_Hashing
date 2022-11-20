unit FNV1_64;
//FNV1_64
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV1_64 = class(THasherbase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV1_64.Create;
begin
  inherited Create;
  Check := 'A72FFC362BF916D6';
  FHash := $CBF29CE484222325;
end;

procedure THasherFNV1_64.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $0100000001B3;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV1_64.Final: String;
begin

  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('FNV1-64', THasherFNV1_64);

end.
