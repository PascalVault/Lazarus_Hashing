unit fletcher64;
//Fletcher-64
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFletcher64 = class(THasherbase)
  private
    FHash, FHash2: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFletcher64.Create;
begin
  inherited Create;
  Check := '00000915000001DD';
  FHash := 0;
  FHash2 := 0;
end;

procedure THasherFletcher64.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod 4294967295;
    FHash2 := (FHash2 + FHash) mod 4294967295;

    Inc(Msg);
  end;   
end;

function THasherFletcher64.Final: String;
begin
  FHash := (FHash2 shl 32) or FHash;

  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('Fletcher-64', THasherFletcher64);

end.
