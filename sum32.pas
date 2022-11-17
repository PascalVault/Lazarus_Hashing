unit SUM32;
//SUM32
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM32 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM32.Create;
begin
  inherited Create;
  Check := '000001DD';
  FHash := 0;
end;

procedure THasherSUM32.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherSUM32.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('SUM32', THasherSUM32);

end.
