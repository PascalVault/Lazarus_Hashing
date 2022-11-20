unit GHash5;
//GHash5
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherGHash5 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherGHash5.Create;
begin
  inherited Create;
  Check := '43B130DD';
  FHash := 0;
end;

procedure THasherGHash5.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 5) + FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherGHash5.Final: String;
begin

  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('GHash5', THasherGHash5);

end.
