unit PJW32;
//PJW-32, invented by Peter J. Weinberger
//Author: domasz
//Last Update: 2022-11-22
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherPJW32 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherPJW32.Create;
begin
  inherited Create;
  FHash :=  0;
  Check := '067897FC';
end;

procedure THasherPJW32.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Test: Cardinal;
begin
  for i:=0 to Length-1 do begin    	
    FHash := (FHash shl 4) + Msg^;
    Test := FHash and $F0000000;

    if (Test <> 0) then FHash := ((FHash xor (Test shr 28)) and $0FFFFFFF);

    Inc(Msg);
  end;   
end;

function THasherPJW32.Final: String;
begin
  Result := IntToHex(FHash, 8); 
end;

initialization
  HasherList.RegisterHasher('PJW-32', THasherPJW32);

end.
