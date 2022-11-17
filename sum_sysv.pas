unit SUM_SYSV;
//SUM SYSV
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM_SYSV = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM_SYSV.Create;
begin
  inherited Create;
  Check := '01DD';
  FHash := 0;
end;

procedure THasherSUM_SYSV.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherSUM_SYSV.Final: String;
var Val: Cardinal;
begin
  Val := FHash mod 65536 + (FHash mod 4294967296) div 65536;
  FHash := (Val mod 65536) + Val div 65536;

  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('SUM SYSV', THasherSUM_SYSV);

end.
