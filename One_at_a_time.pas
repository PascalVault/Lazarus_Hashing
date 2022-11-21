unit One_at_a_time;
//One at a time
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase, Dialogs;


type THasherOneAt = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherOneAt.Create;
begin
  inherited Create;
  Check := 'C66B58C5';
  FHash := 0;
end;

procedure THasherOneAt.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin
    FHash := FHash + Msg^;
    FHash := FHash + (FHash shl 10);
    FHash := FHash xor (FHash shr 6);

    Inc(Msg);
  end;   
end;

function THasherOneAt.Final: String;
begin
  FHash := FHash + (FHash shl 3);
  FHash := FHash xor (FHash shr 11);
  FHash := FHash + (FHash shl 15);
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('One at a time', THasherOneAt);

end.
