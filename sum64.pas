unit SUM64;
//SUM64
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM64 = class(THasherbase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM64.Create;
begin
  inherited Create;
  Check := '00000000000001DD';
  FHash := 0;
end;

procedure THasherSUM64.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherSUM64.Final: String;
begin
  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('SUM64', THasherSUM64);

end.
