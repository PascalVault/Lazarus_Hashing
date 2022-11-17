unit fletcher16;
//Fletcher-16
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase, Dialogs;

type THasherFletcher16 = class(THasherbase)
  private
    FHash, FHash2: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFletcher16.Create;
begin
  inherited Create;
  Check := '1EDE';
  FHash := 0;
  FHash2 := 0;
end;

procedure THasherFletcher16.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash + Msg^) mod 255;
    FHash2 := (FHash2 + FHash) mod 255;

    Inc(Msg);
  end;   
end;

function THasherFletcher16.Final: String;
begin
  FHash := (FHash2 shl 8) or FHash;

  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('Fletcher-16', THasherFletcher16);

end.
