unit DJBHash;
//DJB Hash
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;


type THasherDJBHash = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherDJBHash.Create;
begin
  inherited Create;
  Check := '35CDBB82';
  FHash := 5381;
end;

procedure THasherDJBHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := ((FHash shl 5) + FHash) + Msg^;

    Inc(Msg);
  end;   
end;

function THasherDJBHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('DJB Hash', THasherDJBHash);

end.
