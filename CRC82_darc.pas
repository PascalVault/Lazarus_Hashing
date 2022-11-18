unit CRC82_darc;
//CRC-82 DARC
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT

//CRC82-DARC algorithm by Mark Adler, published on 17 June 2017, public domain.

interface

uses SysUtils, HasherBase;

type THasherCRC82_darc = class(THasherBase)
  private
    FHash, FHash2: QWord;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

constructor THasherCRC82_darc.Create;
begin
  inherited Create;
  FHash :=  0;
  FHash2 :=  0;
  Check := '09EA83F625023801FD612';
end;

procedure THasherCRC82_darc.Update(Msg: PByte; Length: Integer);
const POLYHIGH = $22080;
const POLYLOW = $8a00a2022200c430;
var i,k: Integer;
    Index: Cardinal;
    CLow, CHigh, Low: QWord;
begin
  CLow := FHash;
  CHigh := FHash2 and $3FFFF;

  for i:=0 to Length-1 do begin
    CLow := CLow xor Msg^;

    for k:=0 to 7 do begin
      Low := CLow and 1;
      CLow := (CLow shr 1) or (CHigh shl 63);
      CHigh := CHigh shr  1;

      if (low <> 0) then begin
         CLow := CLow xor POLYLOW;
         CHigh := CHigh xor POLYHIGH;
       end;
     end;
    Inc(Msg);
  end;

  FHash := CLow;
  FHash2 := CHigh;
end;

function THasherCRC82_darc.Final: String;
begin

  Result := IntToHex(FHash2, 5) + IntToHex(FHash, 16);
end;

initialization
  HasherList.RegisterHasher('CRC-82 DARC', THasherCRC82_darc);

end.
