unit JsHash;
//JsHash
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;


type THasherJsHash = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherJsHash.Create;
begin
  inherited Create;
  Check := '90A4224B';
  FHash := 1315423911;
end;

procedure THasherJsHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    Val := ((FHash shl 5) + Msg^ + (FHash shr 2));

    FHash := FHash xor Val;

    Inc(Msg);
  end;   
end;

function THasherJsHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('Js Hash', THasherJsHash);

end.
