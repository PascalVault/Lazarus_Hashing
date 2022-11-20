unit ApHash;
//Ap Hash

interface

uses SysUtils, HasherBase, Dialogs;


type THasherApHash = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherApHash.Create;
begin
  inherited Create;
  Check := 'C0E86BE5';
  FHash := $AAAAAAAA;
end;

procedure THasherApHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  for i:=0 to Length-1 do begin

    if (i and 1) = 0 then Val := ((FHash shl 7) xor (Msg^) * (FHash shr 3))
    else                  Val := (not((FHash shl 11) + (Msg^) xor (FHash shr 5)));

    FHash := FHash xor Val;

    Inc(Msg);
  end;   
end;

function THasherApHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('Ap Hash', THasherApHash);

end.
