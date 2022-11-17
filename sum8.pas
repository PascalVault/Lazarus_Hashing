unit SUM8;
//SUM8
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM8 = class(THasherbase)
  private
    FHash: Byte;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM8.Create;
begin
  inherited Create;
  Check := 'DD';
  FHash := 0;
end;

procedure THasherSUM8.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherSUM8.Final: String;
begin
  Result := IntToHex(FHash, 2);
end;

initialization
  HasherList.RegisterHasher('SUM8', THasherSUM8);

end.
