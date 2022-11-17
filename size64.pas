unit SIZE64;
//SIZE64
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

interface

uses SysUtils, HasherBase;

type THasherSIZE64 = class(THasherbase)
  private
    FHash: Cardinal;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherSIZE64.Create;
begin
  inherited Create;
  Check := '0000000000000009';
  FHash := 0;
end;

procedure THasherSIZE64.Update(Msg: PByte; Length: Integer);
begin
  FHash := FHash + Length;
end;

function THasherSIZE64.Final: String;
begin
  Result := IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('SIZE64', THasherSIZE64);

end.
