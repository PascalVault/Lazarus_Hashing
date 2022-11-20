unit GHash3;
//GHash3
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherGHash3 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherGHash3.Create;
begin
  inherited Create;
  Check := '8DCCB81D';
  FHash := 0;
end;

procedure THasherGHash3.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shl 3) + FHash + Msg^;

    Inc(Msg);
  end;   
end;

function THasherGHash3.Final: String;
begin

  Result := IntToHex(FHash, 8);
end;

initialization
  HasherList.RegisterHasher('GHash3', THasherGHash3);

end.
