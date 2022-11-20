unit FNV0_56;
//FNV0_56
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV0_56 = class(THasherbase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV0_56.Create;
begin
  inherited Create;
  Check := 'FB573C21FE6849';
  FHash := 0;
end;

procedure THasherFNV0_56.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $0100000001B3;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV0_56.Final: String;
begin
  FHash := (FHash shr 56) xor (FHash and $ffffffffffffff);
  Result := IntToHex(FHash, 14);
end;

initialization
  HasherList.RegisterHasher('FNV0-56', THasherFNV0_56);

end.
