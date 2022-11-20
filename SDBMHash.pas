unit SDBMHash;
//SDBM Hash

interface

uses SysUtils, HasherBase, Dialogs;


type THasherSDBMHash = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSDBMHash.Create;
begin
  inherited Create;
  Check := '68A07035';
  FHash := 0;
end;

procedure THasherSDBMHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := Msg^ + (FHash shl 6) + (FHash shl 16) - FHash;

    Inc(Msg);
  end;   
end;

function THasherSDBMHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('SDBM Hash', THasherSDBMHash);

end.
