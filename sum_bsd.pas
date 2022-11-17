unit sum_bsd;
//Sum BSD
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSUM_BSD = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSUM_BSD.Create;
begin
  inherited Create;
  FHash :=  0;
  Check := 'D16F';
end;

procedure THasherSUM_BSD.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash shr 1) + ((FHash and 1) shl 15);
    FHash := FHash + Msg^;
    FHash := FHash and $ffff;

    Inc(Msg);
  end;   
end;

function THasherSUM_BSD.Final: String;
begin
  Result := IntToHex(FHash, 4);
end;

initialization
  HasherList.RegisterHasher('SUM BSD', THasherSUM_BSD);

end.
