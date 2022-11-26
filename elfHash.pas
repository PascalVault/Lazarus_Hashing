unit ElfHash;
//Elf Hash
//Author: domasz
//Last Update: 2022-11-26
//Licence: MIT

interface

uses SysUtils, HasherBase;


type THasherElfHash = class(THasherbase)
  private
    FHash: Cardinal;
    X: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherElfHash.Create;
begin
  inherited Create;
  Check := '0678AEE9';
  FHash := 0;
  X := 0;
end;

procedure THasherElfHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    FHash := (FHash shl 4) + Msg^;
    Val := FHash and $F0000000;

    if Val <> 0 then begin
       FHash := FHash xor (Val shr 24);
       X := Val;
     end;

    FHash := FHash and not(X);

    Inc(Msg);
  end;   
end;

function THasherElfHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('Elf Hash', THasherElfHash);

end.
