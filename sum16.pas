unit SUM16;
//SUM16
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM16 = class(THasherbase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM16.Create;
begin
  inherited Create;
  Check := '01DD';
  FHash := 0;
end;

procedure THasherSUM16.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherSUM16.Final: String;
begin
  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('SUM16', THasherSUM16);

end.
