unit BKDRHash;
//BKDR Hash
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;


type THasherBKDRHash = class(THasherbase)
  private
    FHash: Cardinal;
    Seed: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherBKDRHash.Create;
begin
  inherited Create;
  Seed := 131;
  Check := 'DE43D6D5';
  FHash := 0;
end;

procedure THasherBKDRHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := (FHash * seed) + Msg^;

    Inc(Msg);
  end;   
end;

function THasherBKDRHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('BKDR Hash', THasherBKDRHash);

end.
