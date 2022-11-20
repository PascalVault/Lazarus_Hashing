unit FNV0_64;
//FNV0_64
//Author: domasz
//Last Update: 2022-11-20
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherFNV0_64 = class(THasherbase)
  private
    FHash: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherFNV0_64.Create;
begin
  inherited Create;
  Check := 'B8FB573C21FE68F1';
  FHash := 0;
end;

procedure THasherFNV0_64.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
	FHash := FHash * $0100000001B3;
	FHash := FHash xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherFNV0_64.Final: String;
begin

  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('FNV0-64', THasherFNV0_64);

end.
