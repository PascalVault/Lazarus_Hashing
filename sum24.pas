unit SUM24;
//SUM24
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM24 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM24.Create;
begin
  inherited Create;
  Check := '0001DD';
  FHash := 0;
end;

procedure THasherSUM24.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherSUM24.Final: String;
begin
  FHash := FHash and $FFFFFF;
  Result := IntToHex(FHash, 6);
end;

initialization
  HasherList.RegisterHasher('SUM24', THasherSUM24);

end.
