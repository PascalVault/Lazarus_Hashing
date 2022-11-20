unit RsHash;
//RsHash

interface

uses SysUtils, HasherBase, Dialogs;


type THasherRsHash = class(THasherbase)
  private
    FHash: Cardinal;
    A,B: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherRsHash.Create;
begin
  inherited Create;
  Check := '704952E9';
  FHash := 0;
  B := 378551;
  A := 63689;
end;

procedure THasherRsHash.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin
    FHash := FHash * A + Msg^;
    A := A * B;

    Inc(Msg);
  end;   
end;

function THasherRsHash.Final: String;
begin
  Result := IntToHex(FHash, 8);
end;


initialization
  HasherList.RegisterHasher('Rs Hash', THasherRsHash);

end.
