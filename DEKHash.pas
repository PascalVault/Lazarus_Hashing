unit DEKHash;
//DEK Hash

interface

uses SysUtils, HasherBase, Dialogs;


type THasherDEKHash = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherDEKHash.Create;
begin
  inherited Create;
  Check := 'AB4ACBA5';
  FHash := 0;
end;

procedure THasherDEKHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
    Val: Cardinal;
begin
  FHash := Length;

  for i:=0 to Length-1 do begin
    FHash := ((FHash shl 5) xor (FHash shr 27)) xor Msg^;

    Inc(Msg);
  end;   
end;

function THasherDEKHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('DEK Hash', THasherDEKHash);

end.
