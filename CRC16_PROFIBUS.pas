unit CRC16_PROFIBUS;
//CRC-16 PROFIBUS
//Author: domasz
//Version: 0.1 (2022-11-17)
//Licence: MIT  

interface

uses SysUtils, HasherBase;

type THasherCRC16_PROFIBUS = class(THasherBase)
  private
    FHash: Word;
  public
    constructor Create; override;
    procedure Update(Msg: PByte; Length: Integer); override;
    function Final: String; override;
end;

implementation

var Table: array[0..255] of Word = (
$0000, $1DCF, $3B9E, $2651, $773C, $6AF3, $4CA2, $516D,
$EE78, $F3B7, $D5E6, $C829, $9944, $848B, $A2DA, $BF15,
$C13F, $DCF0, $FAA1, $E76E, $B603, $ABCC, $8D9D, $9052,
$2F47, $3288, $14D9, $0916, $587B, $45B4, $63E5, $7E2A,
$9FB1, $827E, $A42F, $B9E0, $E88D, $F542, $D313, $CEDC,
$71C9, $6C06, $4A57, $5798, $06F5, $1B3A, $3D6B, $20A4,
$5E8E, $4341, $6510, $78DF, $29B2, $347D, $122C, $0FE3,
$B0F6, $AD39, $8B68, $96A7, $C7CA, $DA05, $FC54, $E19B,
$22AD, $3F62, $1933, $04FC, $5591, $485E, $6E0F, $73C0,
$CCD5, $D11A, $F74B, $EA84, $BBE9, $A626, $8077, $9DB8,
$E392, $FE5D, $D80C, $C5C3, $94AE, $8961, $AF30, $B2FF,
$0DEA, $1025, $3674, $2BBB, $7AD6, $6719, $4148, $5C87,
$BD1C, $A0D3, $8682, $9B4D, $CA20, $D7EF, $F1BE, $EC71,
$5364, $4EAB, $68FA, $7535, $2458, $3997, $1FC6, $0209,
$7C23, $61EC, $47BD, $5A72, $0B1F, $16D0, $3081, $2D4E,
$925B, $8F94, $A9C5, $B40A, $E567, $F8A8, $DEF9, $C336,
$455A, $5895, $7EC4, $630B, $3266, $2FA9, $09F8, $1437,
$AB22, $B6ED, $90BC, $8D73, $DC1E, $C1D1, $E780, $FA4F,
$8465, $99AA, $BFFB, $A234, $F359, $EE96, $C8C7, $D508,
$6A1D, $77D2, $5183, $4C4C, $1D21, $00EE, $26BF, $3B70,
$DAEB, $C724, $E175, $FCBA, $ADD7, $B018, $9649, $8B86,
$3493, $295C, $0F0D, $12C2, $43AF, $5E60, $7831, $65FE,
$1BD4, $061B, $204A, $3D85, $6CE8, $7127, $5776, $4AB9,
$F5AC, $E863, $CE32, $D3FD, $8290, $9F5F, $B90E, $A4C1,
$67F7, $7A38, $5C69, $41A6, $10CB, $0D04, $2B55, $369A,
$898F, $9440, $B211, $AFDE, $FEB3, $E37C, $C52D, $D8E2,
$A6C8, $BB07, $9D56, $8099, $D1F4, $CC3B, $EA6A, $F7A5,
$48B0, $557F, $732E, $6EE1, $3F8C, $2243, $0412, $19DD,
$F846, $E589, $C3D8, $DE17, $8F7A, $92B5, $B4E4, $A92B,
$163E, $0BF1, $2DA0, $306F, $6102, $7CCD, $5A9C, $4753,
$3979, $24B6, $02E7, $1F28, $4E45, $538A, $75DB, $6814,
$D701, $CACE, $EC9F, $F150, $A03D, $BDF2, $9BA3, $866C
);

constructor THasherCRC16_PROFIBUS.Create;
begin
  inherited Create;
  FHash :=  $FFFF;
  Check := 'A819';
end;

procedure THasherCRC16_PROFIBUS.Update(Msg: PByte; Length: Integer);
var i: Integer;
begin
  for i:=0 to Length-1 do begin    	    
    FHash := (FHash shl 8) xor Table[(Msg^ xor (FHash shr 8)) and $FF];
    Inc(Msg);
  end;   
end;

function THasherCRC16_PROFIBUS.Final: String;
begin
  FHash := FHash xor $FFFF;
  Result := IntToHex(FHash, 4); 
end;

initialization
  HasherList.RegisterHasher('CRC-16 PROFIBUS', THasherCRC16_PROFIBUS);

end.
