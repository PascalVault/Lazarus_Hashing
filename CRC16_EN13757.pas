unit CRC16_EN13757;
//CRC-16 EN-13757
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_EN13757 = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $3D65, $7ACA, $47AF, $F594, $C8F1, $8F5E, $B23B,
$D64D, $EB28, $AC87, $91E2, $23D9, $1EBC, $5913, $6476,
$91FF, $AC9A, $EB35, $D650, $646B, $590E, $1EA1, $23C4,
$47B2, $7AD7, $3D78, $001D, $B226, $8F43, $C8EC, $F589,
$1E9B, $23FE, $6451, $5934, $EB0F, $D66A, $91C5, $ACA0,
$C8D6, $F5B3, $B21C, $8F79, $3D42, $0027, $4788, $7AED,
$8F64, $B201, $F5AE, $C8CB, $7AF0, $4795, $003A, $3D5F,
$5929, $644C, $23E3, $1E86, $ACBD, $91D8, $D677, $EB12,
$3D36, $0053, $47FC, $7A99, $C8A2, $F5C7, $B268, $8F0D,
$EB7B, $D61E, $91B1, $ACD4, $1EEF, $238A, $6425, $5940,
$ACC9, $91AC, $D603, $EB66, $595D, $6438, $2397, $1EF2,
$7A84, $47E1, $004E, $3D2B, $8F10, $B275, $F5DA, $C8BF,
$23AD, $1EC8, $5967, $6402, $D639, $EB5C, $ACF3, $9196,
$F5E0, $C885, $8F2A, $B24F, $0074, $3D11, $7ABE, $47DB,
$B252, $8F37, $C898, $F5FD, $47C6, $7AA3, $3D0C, $0069,
$641F, $597A, $1ED5, $23B0, $918B, $ACEE, $EB41, $D624,
$7A6C, $4709, $00A6, $3DC3, $8FF8, $B29D, $F532, $C857,
$AC21, $9144, $D6EB, $EB8E, $59B5, $64D0, $237F, $1E1A,
$EB93, $D6F6, $9159, $AC3C, $1E07, $2362, $64CD, $59A8,
$3DDE, $00BB, $4714, $7A71, $C84A, $F52F, $B280, $8FE5,
$64F7, $5992, $1E3D, $2358, $9163, $AC06, $EBA9, $D6CC,
$B2BA, $8FDF, $C870, $F515, $472E, $7A4B, $3DE4, $0081,
$F508, $C86D, $8FC2, $B2A7, $009C, $3DF9, $7A56, $4733,
$2345, $1E20, $598F, $64EA, $D6D1, $EBB4, $AC1B, $917E,
$475A, $7A3F, $3D90, $00F5, $B2CE, $8FAB, $C804, $F561,
$9117, $AC72, $EBDD, $D6B8, $6483, $59E6, $1E49, $232C,
$D6A5, $EBC0, $AC6F, $910A, $2331, $1E54, $59FB, $649E,
$00E8, $3D8D, $7A22, $4747, $F57C, $C819, $8FB6, $B2D3,
$59C1, $64A4, $230B, $1E6E, $AC55, $9130, $D69F, $EBFA,
$8F8C, $B2E9, $F546, $C823, $7A18, $477D, $00D2, $3DB7,
$C83E, $F55B, $B2F4, $8F91, $3DAA, $00CF, $4760, $7A05,
$1E73, $2316, $64B9, $59DC, $EBE7, $D682, $912D, $AC48
);

constructor THasherCRC16_EN13757.Create;
begin
  inherited Create;
  FHash :=  $0000;
  Check := 'C2B7';
end;

procedure THasherCRC16_EN13757.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_EN13757.Final: String;
begin
  FHash := FHash xor $FFFF;
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 EN-13757', THasherCRC16_EN13757);

end.
